(* Code generator for Fasto *)

module CodeGen

(*
    compile : TypedProg -> Mips.Instruction list

    (* for debugging *)
    compileExp : TypedExp
              -> SymTab<Mips.reg>
              -> Mips.reg
              -> Mips.Instruction list
*)

open AbSyn

exception MyError of string * Position

type VarTable = SymTab.SymTab<Mips.reg>

(* Name generator for labels and temporary symbolic registers *)
(* Example usage: val tmp = newName "tmp"  (* might produce _tmp_5_ *) *)

let mutable counter = 0

let newName base_name =
    counter <- counter + 1
    "_" + base_name + "_" + string counter + "_"

let newReg reg_name = Mips.RS (newName reg_name)

let newLab lab_name = newName lab_name

(* Table storing all string literals, with labels given to them *)
let stringTable : ((Mips.addr*string) list) ref = ref []
(* could also contain "\n", ",", "Index out of bounds in line ", but the
   format is a bit different (length and dummy pointer come first) *)

(* Building a string in the heap, including initialisation code *)
let buildString  ( label : Mips.addr
                 , str   : string
                 ) : (Mips.Instruction list * Mips.Instruction list) =
    let data = [ Mips.ALIGN 2     (* means: word-align *)
               ; Mips.LABEL label (* pointer *)
               ; Mips.SPACE 4     (* sizeof(Int) *)
               ; Mips.ASCIIZ str]
    let initR = Mips.RS (label + "_init")
    let addrR = Mips.RS (label + "_addr")
    let initcode = [ Mips.LA(addrR, label)
                   ; Mips.LI(initR, String.length str)
                   ; Mips.SW(initR, addrR, 0) ]
    (initcode, data)

(* Link register *)
let RA = Mips.RN 31
(* Register for stack pointer *)
let SP = Mips.RN 29
(* Register for heap pointer *)
let HP = Mips.RN 28
(* Constant-zero register *)
let RZ = Mips.RN 0

(* General scratch-pad registers *)
let RN2 = Mips.RN 2
let RN4 = Mips.RN 4
let RN5 = Mips.RN 5
let RN6 = Mips.RN 6

(* Suggested register division *)
let minReg = 2       (* lowest usable register *)
let maxCaller = 15   (* highest caller-saves register *)
let maxReg = 25      (* highest allocatable register *)

(* Syscall numbers for MARS, to be put in $2 *)
let sysPrintInt =     1  (* print integer in $4 *)
let sysPrintString =  4  (* print NUL-terminated string starting at $4 *)
let sysReadInt =      5  (* read integer into $2 *)
let sysExit =        10  (* terminate execution *)
let sysPrintChar =   11  (* print character in $4 *)
let sysReadChar =    12  (* read character into $2 *)

(* Determine the size of an element in an array based on its type *)
type ElemSize = ESByte | ESWord

let getElemSize (tp : Type) : ElemSize =
    match tp with
      | Char  -> ESByte
      | Bool  -> ESByte
      | _     -> ESWord

let elemSizeToInt (elmsz : ElemSize) : int =
    match elmsz with
      | ESByte -> 1
      | ESWord -> 4

(* Pick the correct instruction from the element size. *)
let mipsLoad elem_size = match elem_size with
                            | ESByte -> Mips.LB
                            | ESWord -> Mips.LW

let mipsStore elem_size = match elem_size with
                            | ESByte -> Mips.SB
                            | ESWord -> Mips.SW

(* generates the code to check that the array index is within bounds *)
let checkBounds  ( arr_beg : Mips.reg
                 , ind_reg : Mips.reg
                 , (line : int, c : int)
                 ) : Mips.Instruction list =
    let size_reg = newReg "size_reg"
    let tmp_reg  = newReg "tmp_reg"
    let err_lab  = newLab "error_lab"
    let safe_lab = newLab "safe_lab"
    [ Mips.LW(size_reg, arr_beg, 0)
    ; Mips.BGEZ(ind_reg, safe_lab)  (* check that ind_reg >= 0 *)
    ; Mips.LABEL(err_lab)
    ; Mips.LI(RN5, line)
    ; Mips.LA(RN6, "_Msg_IllegalIndex_")
    ; Mips.J "_RuntimeError_"
    ; Mips.LABEL(safe_lab)
    ; Mips.SUB(tmp_reg, ind_reg, size_reg)
    ; Mips.BGEZ(tmp_reg, err_lab)   (* check that ind_reg < -size_reg *)
    ]

(* dynalloc(size_reg, place, ty) generates code for allocating arrays of heap
   memory by incrementing the HP register (heap pointer) by a number of words.
   The arguments for this function are as follows:

     size_reg: contains the logical array size (number of array elements)
     place: will contain the address of new allocation (old HP)
     ty: char/bool elements take 1 byte, int elements take 4 bytes
 *)
let dynalloc (size_reg : Mips.reg,
              place    : Mips.reg,
              ty       : Type     )
            : Mips.Instruction list =
    let tmp_reg = newReg "tmp"

    (* Use old HP as allocation address. *)
    let code1 = [ Mips.MOVE (place, HP) ]

    (* For char/bool: Align address to 4-byte boundary by rounding up. *)
    (*                (By adding 3 and rounding down using SRA/SLL.) *)
    (* For int and arrays: Multiply logical size by 4, no alignment. *)
    let code2 =
        match getElemSize ty with
          | ESByte ->  [ Mips.ADDI(tmp_reg, size_reg, 3)
                       ; Mips.SRA (tmp_reg, tmp_reg, 2)
                       ; Mips.SLL (tmp_reg, tmp_reg, 2) ]
          | ESWord -> [ Mips.SLL (tmp_reg, size_reg, 2) ]

    (* Make space for array size (+4). Increase HP. *)
    (* Save size of allocation in header. *)
    let code3 =
        [ Mips.ADDI (tmp_reg, tmp_reg, 4)
        ; Mips.ADD (HP, HP, tmp_reg)
        ; Mips.SW (size_reg, place, 0) ]

    code1 @ code2 @ code3

(* Pushing arguments on the stack: *)
(* For each register 'r' in 'rs', copy them to registers from
'firstReg' and counting up. Return the full code and the next unused
register (firstReg + num_args).  *)
let applyRegs  ( fid  : Mips.addr
               , args : Mips.reg list
               , place: Mips.reg
               , pos  : Position )
             : Mips.Instruction list =
    let regs_num = List.length args
    let caller_regs = List.map (fun n -> Mips.RN (n + minReg)) [0..regs_num-1]
                   // List.tabulate (regs_num, fun n -> n + minReg)
        (* zipWith Mips.MOVE =
           zipWith (fun (regDest, regSrc) -> Mips.MOVE (regDest, regSrc)) *)
    let move_code = List.map Mips.MOVE (List.zip caller_regs args)
    if regs_num > maxCaller - minReg
    then raise (MyError("Number of arguments passed to " + fid +
                        " exceeds number of caller registers", pos))
    else move_code @ [ Mips.JAL(fid,caller_regs); Mips.MOVE(place, RN2) ]


(* Compile 'e' under bindings 'vtable', putting the result in register 'place'. *)
let rec compileExp  (e      : TypedExp)
                    (vtable : VarTable)
                    (place  : Mips.reg)
                  : Mips.Instruction list =
  match e with
  | Constant (IntVal n, pos) ->
      if n < 0 then
          compileExp (Negate (Constant (IntVal (-n), pos), pos)) vtable place
      else if n < 32768 then
          [ Mips.LI (place, n) ]
      else
        [ Mips.LUI (place, n / 65536)
        ; Mips.ORI (place, place, n % 65536) ]
  | Constant (BoolVal p, _) ->
      (* TODO project task 1: represent `true`/`false` values as `1`/`0` *)
      failwith "Unimplemented code generation of boolean constants"
  | Constant (CharVal c, pos) -> [ Mips.LI (place, int c) ]

  (* Create/return a label here, collect all string literals of the program
     (in stringTable), and create them in the data section before the heap
     (Mips.ASCIIZ) *)
  | StringLit (strLit, pos) ->
    (* Convert string literal into label; only use valid characters. *)
    let normalChars0 = //String.filter System.Char.IsLetterOrDigit strLit
            String.map (fun c -> if System.Char.IsLetterOrDigit c then c else 'a') strLit
    let normalChars  = normalChars0 + "__str__"
    let label = newLab (normalChars.Substring (0, 7))
    let ()    = stringTable := (label, strLit)::(!stringTable)
    [ Mips.LA (place, label)
    ; Mips.COMMENT (label + ": string \"" + toCString strLit + "\"") ]

  | Constant (ArrayVal (vs, tp), pos) ->
    (* Create corresponding ArrayLit expression to re-use code. *)
    let arraylit = ArrayLit (List.map (fun v -> Constant (v, pos)) vs, tp, pos)
    compileExp arraylit vtable place

  | ArrayLit (elems, tp, pos) ->
    let elem_size = getElemSize tp
    let size_reg  = newReg "size_reg"
    let addr_reg  = newReg "addr_reg"
    let tmp_reg   = newReg "tmp_reg"

    (* Store size of literal in size_reg, dynamically allocate that. *)
    (* Let addr_reg contain the address for the first array element. *)
    let header  = [ Mips.LI (size_reg, List.length elems) ]  @
                  dynalloc (size_reg, place, tp) @
                  [ Mips.ADDI (addr_reg, place, 4) ]

    let compileElem elem_exp =
            let elem_code = compileExp elem_exp vtable tmp_reg
            elem_code @
            [ mipsStore elem_size (tmp_reg, addr_reg, 0)
            ; Mips.ADDI (addr_reg, addr_reg, elemSizeToInt elem_size) ]

    let elems_code = List.concat (List.map compileElem elems)
    header @ elems_code

  | Var (vname, pos) ->
      match SymTab.lookup vname vtable with
        | None          -> raise (MyError ("Name " + vname + " not found", pos))
        | Some reg_name -> [Mips.MOVE (place, reg_name)]

  | Plus (e1, e2, pos) ->
      let t1 = newReg "plus_L"
      let t2 = newReg "plus_R"
      let code1 = compileExp e1 vtable t1
      let code2 = compileExp e2 vtable t2
      code1 @ code2 @ [Mips.ADD (place,t1,t2)]

  | Minus (e1, e2, pos) ->
      let t1 = newReg "minus_L"
      let t2 = newReg "minus_R"
      let code1 = compileExp e1 vtable t1
      let code2 = compileExp e2 vtable t2
      code1 @ code2 @ [Mips.SUB (place,t1,t2)]

  (* TODO project task 1:
     Look in `AbSyn.fs` for the expression constructors `Times`, ...
     `Times` is very similar to `Plus`/`Minus`.
     For `Divide`, you may ignore division by zero for a quick first
     version, but remember to come back and clean it up later.
     `Not` and `Negate` are simpler; you can use `Mips.XORI` for `Not`
  *)
  | Times (_, _, _) ->
      failwith "Unimplemented code generation of multiplication"

  | Divide (_, _, _) ->
      failwith "Unimplemented code generation of division"

  | Not (_, _) ->
      failwith "Unimplemented code generation of not"

  | Negate (_, _) ->
      failwith "Unimplemented code generation of negate"

  | Let (dec, e1, pos) ->
      let (code1, vtable1) = compileDec dec vtable
      let code2 = compileExp e1 vtable1 place
      code1 @ code2

  | If (e1, e2, e3, pos) ->
      let thenLabel = newLab "then"
      let elseLabel = newLab "else"
      let endLabel = newLab "endif"
      let code1 = compileCond e1 vtable thenLabel elseLabel
      let code2 = compileExp e2 vtable place
      let code3 = compileExp e3 vtable place
      code1 @ [Mips.LABEL thenLabel] @ code2  @
        [ Mips.J endLabel; Mips.LABEL elseLabel ] @
        code3 @ [Mips.LABEL endLabel]

  (* special case for length *)
  | Apply ("length", [arr], pos) ->
      let arr_addr = newReg "len_arr"
      let code1    = compileExp arr vtable arr_addr
      code1 @ [ Mips.LW(place,arr_addr, 0) ]
  | Apply (f, args, pos) ->
      (* Convention: args in regs (2..15), result in reg 2 *)
      let compileArg arg =
            let arg_reg = newReg "arg"
            (arg_reg, compileExp arg vtable arg_reg)
      let (arg_regs, argcode) = List.unzip (List.map compileArg args)
      let applyCode = applyRegs(f, arg_regs, place, pos)
      List.concat argcode @  (* Evaluate args *)
                  applyCode  (* Jump to function and store result in place *)

  (* dirty I/O. Read and Write: supported for basic types: Int, Char,
     Bool via system calls. Write of an Array(Chars) is also
     supported. The others are the user's responsibility.
  *)
  | Read(tp, pos) ->
      match tp with
        | Int  -> [ Mips.JAL ("getint", [RN2])
                  ; Mips.MOVE(place, RN2)
                  ]
        | Char -> [ Mips.JAL ("getchar", [RN2])
                  ; Mips.MOVE(place, RN2)
                  ]
        | Bool ->
          (* Note: the following inputs booleans as integers, with 0
             interpreted as false and everything else as true. This
             differs from the interpreter! *)
          let tl = newLab "true_lab"
          let fl = newLab "false_lab"
          let ml = newLab "merge_lab"
          let v  = newReg "bool_var"
          [ Mips.JAL ("getint", [RN2])
          ; Mips.MOVE(v, RN2)
          ; Mips.BEQ (v, RZ,fl)
          ; Mips.J tl
          ; Mips.LABEL fl
          ; Mips.MOVE(place, RZ)
          ; Mips.J ml
          ; Mips.LABEL tl
          ; Mips.LI (place, 1)
          ; Mips.J ml
          ; Mips.LABEL ml
          ]
        | _ -> raise (MyError("Read on an incompatible type: " + ppType tp, pos))

  | Write(e, tp, pos) ->
    let tmp = newReg "tmp"
    let codeexp = compileExp e vtable tmp @ [ Mips.MOVE (place, tmp) ]
    match tp with
      | Int  -> codeexp @ [ Mips.MOVE(RN2,place); Mips.JAL("putint", [RN2]) ]
      | Char -> codeexp @ [ Mips.MOVE(RN2,place); Mips.JAL("putchar",[RN2]) ]
      | Bool ->
          let tlab = newLab "wBoolF"
          codeexp @
           [ Mips.LA (RN2, "_true")
           ; Mips.BNE (place, RZ, tlab)
           ; Mips.LA (RN2, "_false")
           ; Mips.LABEL tlab
           ; Mips.JAL ("putstring", [RN2])
           ]

      | Array Char ->
           codeexp @ [ Mips.MOVE (RN2, tmp)
                     ; Mips.JAL("putstring", [RN2]) ]
      | _ -> raise (MyError("Write on an incompatible type: " + ppType tp, pos))

  (* Comparison checking, later similar code for And and Or. *)
  | Equal (e1, e2, pos) ->
      let t1 = newReg "eq_L"
      let t2 = newReg "eq_R"
      let code1 = compileExp e1 vtable t1
      let code2 = compileExp e2 vtable t2
      let falseLabel = newLab "false"
      code1 @ code2 @
       [ Mips.LI (place, 0)
       ; Mips.BNE (t1,t2,falseLabel)
       ; Mips.LI (place, 1)
       ; Mips.LABEL falseLabel
       ]

  | Less (e1, e2, pos) ->
      let t1 = newReg "lt_L"
      let t2 = newReg "lt_R"
      let code1 = compileExp e1 vtable t1
      let code2 = compileExp e2 vtable t2
      code1 @ code2 @ [Mips.SLT (place,t1,t2)]

  (* TODO project task 1:
        Look in `AbSyn.fs` for the expression constructors of `And` and `Or`.
        The implementation of `And` and `Or` is more complicated than `Plus`
        because you need to ensure the short-circuit semantics, e.g.,
        in `e1 || e2` if the execution of `e1` will evaluate to `true` then
        the code of `e2` must not be executed. Similarly for `And` (&&).
  *)
  | And (_, _, _) ->
      failwith "Unimplemented code generation of &&"

  | Or (_, _, _) ->
      failwith "Unimplemented code generation of ||"

  (* Indexing:
     1. generate code to compute the index
     2. check index within bounds
     3. add the start address with the index
     4. get the element at that address
   *)
  | Index (arr_name, i_exp, ty, pos) ->
      let ind_reg  = newReg "arr_ind"
      let ind_code = compileExp i_exp vtable ind_reg
      let arr_reg  = newReg "arr_reg"

      (* Let arr_reg be the start of the data segment *)
      let arr_beg =
            match SymTab.lookup arr_name vtable with
              | None -> raise (MyError ("Name " + arr_name + " not found", pos))
              | Some reg_name -> reg_name
      let init_code = [ Mips.ADDI(arr_reg, arr_beg, 4) ]

      (* code to check bounds *)
      let check_code = checkBounds(arr_beg, ind_reg, pos)

      (* for INT/ARRAY: ind *= 4 else ind is unchanged *)
      (* array_var += index; place = *array_var *)
      let load_code =
         match getElemSize ty with
           | ESByte ->  [ Mips.ADD(arr_reg, arr_reg, ind_reg)
                        ; Mips.LB(place, arr_reg, 0) ]
           | ESWord ->  [ Mips.SLL(ind_reg, ind_reg, 2)
                        ; Mips.ADD(arr_reg, arr_reg, ind_reg)
                        ; Mips.LW(place, arr_reg, 0) ]
      ind_code @ init_code @ check_code @ load_code

  (* Second-Order Array Combinators (SOACs):
     iota, map, reduce
  *)
  | Iota (n_exp, (line, _)) ->
      let size_reg = newReg "size_reg"
      let n_code = compileExp n_exp vtable size_reg
      (* size_reg is now the integer n. *)

      (* Check that array size N >= 0:
         if N >= 0 then jumpto safe_lab
         jumpto "_IllegalArrSizeError_"
         safe_lab: ...
      *)
      let safe_lab = newLab "safe_lab"
      let checksize = [ Mips.BGEZ (size_reg, safe_lab)
                      ; Mips.LI (RN5, line)
                      ; Mips.LA (RN6, "_Msg_IllegalArraySize_")
                      ; Mips.J "_RuntimeError_"
                      ; Mips.LABEL (safe_lab)
                      ]

      let addr_reg = newReg "addr_reg"
      let i_reg = newReg "i_reg"
      let init_regs = [ Mips.ADDI (addr_reg, place, 4)
                      ; Mips.MOVE (i_reg, RZ) ]
      (* addr_reg is now the position of the first array element. *)

      (* Run a loop.  Keep jumping back to loop_beg until it is not the
         case that i_reg < size_reg, and then jump to loop_end. *)
      let loop_beg = newLab "loop_beg"
      let loop_end = newLab "loop_end"
      let tmp_reg = newReg "tmp_reg"
      let loop_header = [ Mips.LABEL (loop_beg)
                        ; Mips.SUB (tmp_reg, i_reg, size_reg)
                        ; Mips.BGEZ (tmp_reg, loop_end)
                        ]
      (* iota is just 'arr[i] = i'.  arr[i] is addr_reg. *)
      let loop_iota   = [ Mips.SW (i_reg, addr_reg, 0) ]
      let loop_footer = [ Mips.ADDI (addr_reg, addr_reg, 4)
                        ; Mips.ADDI (i_reg, i_reg, 1)
                        ; Mips.J loop_beg
                        ; Mips.LABEL loop_end
                        ]
      n_code
       @ checksize
       @ dynalloc (size_reg, place, Int)
       @ init_regs
       @ loop_header
       @ loop_iota
       @ loop_footer

  | Map (farg, arr_exp, elem_type, ret_type, pos) ->
      let size_reg = newReg "size_reg" (* size of input/output array *)
      let arr_reg  = newReg "arr_reg" (* address of array *)
      let elem_reg = newReg "elem_reg" (* address of single element *)
      let res_reg = newReg "res_reg"
      let arr_code = compileExp arr_exp vtable arr_reg

      let get_size = [ Mips.LW (size_reg, arr_reg, 0) ]

      let addr_reg = newReg "addr_reg" (* address of element in new array *)
      let i_reg = newReg "i_reg"
      let init_regs = [ Mips.ADDI (addr_reg, place, 4)
                      ; Mips.MOVE (i_reg, RZ)
                      ; Mips.ADDI (elem_reg, arr_reg, 4)
                      ]
      let loop_beg = newLab "loop_beg"
      let loop_end = newLab "loop_end"
      let tmp_reg = newReg "tmp_reg"
      let loop_header = [ Mips.LABEL (loop_beg)
                        ; Mips.SUB (tmp_reg, i_reg, size_reg)
                        ; Mips.BGEZ (tmp_reg, loop_end) ]
      (* map is 'arr[i] = f(old_arr[i])'. *)
      let src_size = getElemSize elem_type
      let dst_size = getElemSize ret_type
      let loop_map =
             [ mipsLoad src_size (res_reg, elem_reg, 0)
             ; Mips.ADDI(elem_reg, elem_reg, elemSizeToInt src_size)
             ]
             @ applyFunArg(farg, [res_reg], vtable, res_reg, pos)
             @
             [ mipsStore dst_size (res_reg, addr_reg, 0)
             ; Mips.ADDI (addr_reg, addr_reg, elemSizeToInt dst_size)
             ]

      let loop_footer =
              [ Mips.ADDI (i_reg, i_reg, 1)
              ; Mips.J loop_beg
              ; Mips.LABEL loop_end
              ]
      arr_code
       @ get_size
       @ dynalloc (size_reg, place, ret_type)
       @ init_regs
       @ loop_header
       @ loop_map
       @ loop_footer

  (* reduce(f, acc, {x1, x2, ...xn}) = f(f(f(acc,x1),x2),...xn) *)
  | Reduce (binop, acc_exp, arr_exp, tp, pos) ->
      let arr_reg  = newReg "arr_reg"   (* address of array *)
      let size_reg = newReg "size_reg"  (* size of input array *)
      let i_reg    = newReg "ind_var"   (* loop counter *)
      let tmp_reg  = newReg "tmp_reg"   (* several purposes *)
      let loop_beg = newLab "loop_beg"
      let loop_end = newLab "loop_end"

      let arr_code = compileExp arr_exp vtable arr_reg
      let header1 = [ Mips.LW(size_reg, arr_reg, 0) ]

      (* Compile initial value into place (will be updated below) *)
      let acc_code = compileExp acc_exp vtable place

      (* Set arr_reg to address of first element instead. *)
      (* Set i_reg to 0. While i < size_reg, loop. *)
      let loop_code =
              [ Mips.ADDI(arr_reg, arr_reg, 4)
              ; Mips.MOVE(i_reg, RZ)
              ; Mips.LABEL(loop_beg)
              ; Mips.SUB(tmp_reg, i_reg, size_reg)
              ; Mips.BGEZ(tmp_reg, loop_end)
              ]
      (* Load arr[i] into tmp_reg *)
      let elem_size = getElemSize tp
      let load_code =
        [ mipsLoad elem_size (tmp_reg, arr_reg, 0)
        ; Mips.ADDI (arr_reg, arr_reg, elemSizeToInt elem_size)
        ]
      (* place := binop(place, tmp_reg) *)
      let apply_code =
            applyFunArg(binop, [place; tmp_reg], vtable, place, pos)

      arr_code @ header1 @ acc_code @ loop_code @ load_code @ apply_code @
         [ Mips.ADDI(i_reg, i_reg, 1)
         ; Mips.J loop_beg
         ; Mips.LABEL loop_end
         ]

  (* TODO project task 2:
        `replicate (n, a)`
        `filter (f, arr)`
        `scan (f, ne, arr)`
     Look in `AbSyn.fs` for the shape of expression constructors
        `Replicate`, `Filter`, `Scan`.
     General Hint: write down on a piece of paper the C-like pseudocode
        for implementing them, then translate that to Mips pseudocode.
     To allocate heap space for an array you may use `dynalloc` defined
        above. For example, if `sz_reg` is a register containing an integer `n`,
        and `ret_type` is the element-type of the to-be-allocated array, then
        `dynalloc (sz_reg, arr_reg, ret_type)` will alocate enough space for
        an n-element array of element-type `ret_type` (including the first
        word that holds the length, and the necessary allignment padding), and
        will place in register `arr_reg` the start address of the new array.
        Since you need to allocate space for the result arrays of `Replicate`,
        `Map` and `Scan`, then `arr_reg` should probably be `place` ...

     `replicate(n,a)`: You should allocate a new (result) array, and execute a
        loop of count `n`, in which you store the value hold into the register
        corresponding to `a` into each memory location corresponding to an
        element of the result array.
        If `n` is less than `0` then remember to terminate the program with
        an error -- see implementation of `iota`.
  *)
  | Replicate (_, _, _, _) ->
      failwith "Unimplemented code generation of replicate"

  (* TODO project task 2: see also the comment to replicate.
     (a) `filter(f, arr)`:  has some similarity with the implementation of map.
     (b) Use `applyFunArg` to call `f(a)` in a loop, for every element `a` of `arr`.
     (c) If `f(a)` succeeds (result in the `true` value) then (and only then):
          - set the next element of the result array to `a`, and
          - increment a counter (initialized before the loop)
     (d) It is useful to maintain two array iterators: one for the input array `arr`
         and one for the result array. (The latter increases slower because
         some of the elements of the input array are skipped because they fail
         under the predicate).
     (e) The last step (after the loop writing the elments of the result array)
         is to update the logical size of the result array to the value of the
         counter computed in step (c). You do this of course with a
         `Mips.SW(counter_reg, place, 0)` instruction.
  *)
  | Filter (_, _, _, _) ->
      failwith "Unimplemented code generation of filter"

  (* TODO project task 2: see also the comment to replicate.
     `scan(f, ne, arr)`: you can inspire yourself from the implementation of
        `reduce`, but in the case of `scan` you will need to also maintain
        an iterator through the result array, and write the accumulator in
        the current location of the result iterator at every iteration of
        the loop.
  *)
  | Scan (_, _, _, _, _) ->
      failwith "Unimplemented code generation of scan"

and applyFunArg ( ff     : TypedFunArg
                , args   : Mips.reg list
                , vtable : VarTable
                , place  : Mips.reg
                , pos    : Position
                ) : Mips.Instruction list =
  match ff with
    | FunName s ->
          let tmp_reg = newReg "tmp_reg"
          applyRegs(s, args, tmp_reg, pos) @ [Mips.MOVE(place, tmp_reg)]

    | Lambda (_, parms, body, lampos) ->
          let rec bindParams parms args vtable' =
              match (parms, args) with
                | (Param (pname,_)::parms', arg::args') ->
                      bindParams parms' args' (SymTab.bind pname arg vtable')
                | _ -> vtable'
          let vtable' = bindParams parms args vtable
          let t = newReg "fun_arg_res"
          compileExp body vtable' t @ [ Mips.MOVE(place, t) ]

(* compile condition *)
and compileCond  (c      : TypedExp)
                 (vtable : VarTable)
                 (tlab   : Mips.addr)
                 (flab   : Mips.addr)
               : Mips.Instruction list =
  let t1 = newReg "cond"
  let code1 = compileExp c vtable t1
  code1 @ [Mips.BNE (t1, RZ, tlab); Mips.J flab]

(* compile let declaration *)
and compileDec  (dec : TypedDec)
                (vtable : VarTable)
              : (Mips.Instruction list * VarTable) =
      let (Dec (s,e,pos)) = dec
      let t = newReg "letBind"
      let code = compileExp e vtable t
      let new_vtable = SymTab.bind s t vtable
      (code, new_vtable)

(* code for saving and restoring callee-saves registers *)
let rec stackSave (currentReg  : int)
                  (maxReg      : int)
                  (savecode    : Mips.Instruction list)
                  (restorecode : Mips.Instruction list)
                  (offset      : int)
                : (Mips.Instruction list * Mips.Instruction list * int) =
    if currentReg > maxReg
    then (savecode, restorecode, offset)  (* done *)
    else stackSave (currentReg+1)
                   maxReg
                   (Mips.SW (Mips.RN currentReg, SP, offset)
                    :: savecode) (* save register *)
                   (Mips.LW (Mips.RN currentReg, SP, offset)
                    :: restorecode) (* restore register *)
                   (offset-4) (* adjust offset *)

(* add function arguments to symbol table *)
and getArgs  (parms   : Param list)
             (vtable  : VarTable)
             (nextReg : int)
           : (Mips.Instruction list * VarTable) =
  match parms with
    | [] -> ([], vtable)
    | (Param (v,_)::vs) ->
       if nextReg > maxCaller
       then raise (MyError ("Passing too many arguments!", (0,0)))
       else let vname = newReg ("param_" + v)
            let vtable1 = SymTab.bind v vname vtable (*   (v,vname)::vtable   *)
            let (code2,vtable2) = getArgs vs vtable1 (nextReg + 1)
            ([Mips.MOVE (vname, Mips.RN nextReg)] @ code2, vtable2)

(* compile function declaration *)
and compileFun (fundec : TypedFunDec) : Mips.Prog =
    let (FunDec (fname, resty, args, exp, (line,col))) = fundec
    (* make a vtable from bound formal parameters,
         then evaluate expression in this context, return it *)
    (* arguments passed in registers, "move" into local vars. *)
    let (argcode, vtable_local) = getArgs args (SymTab.empty ()) minReg
    (* return value in register 2 *)
    let rtmp = newReg (fname + "res")
    let returncode  = [Mips.MOVE (RN2,rtmp)] (* move return val to R2 *)
    let body = compileExp exp vtable_local rtmp (* target expr *)
    let (body1, _, maxr, spilled) =
            RegAlloc.registerAlloc   (* call register allocator *)
                       (argcode @ body @ returncode)
                       (Set.singleton (RN2)) 2 maxCaller maxReg 0
    let (savecode, restorecode, offset) = (* save/restore callee-saves *)
            stackSave (maxCaller+1) maxr [] [] (-8 + (-4 * spilled))
    [Mips.COMMENT ("Function " + fname);
     Mips.LABEL fname;       (* function label *)
     Mips.SW (RA, SP, -4)]   (* save return address *)
  @ savecode                 (* save callee-saves registers *)
  @ [Mips.ADDI (SP,SP,offset)]   (* SP adjustment *)
  @ body1                    (* code for function body *)
  @ [Mips.ADDI (SP,SP,-offset)]  (* move SP up *)
  @ restorecode              (* restore callee-saves registers *)
  @ [Mips.LW (RA, SP, -4);   (* restore return addr *)
     Mips.JR (RA, [])]       (* return *)


(* compile program *)
let compile (funs : TypedProg) : Mips.Instruction list =
  let () = stringTable := [("_true","true"); ("_false","false")]
  let funsCode = List.concat (List.map compileFun funs)
  let (stringinit_sym, stringdata) =
      List.unzip (List.map buildString (!stringTable))
  let (stringinit,_,_,_) =
        match stringinit_sym with
            | [] -> ([],Set.empty,0,0)
            | _ -> RegAlloc.registerAlloc (* call register allocator *)
                     (List.concat stringinit_sym)
                     (Set.singleton (RN2)) 2 maxCaller maxReg 0
  let mips_prog =
      [Mips.TEXT "0x00400000";
       Mips.GLOBL "main"]
      (* initialisation: heap pointer and string pointers *)
    @ (Mips.LA (HP, "_heap_"):: stringinit)
      (* jump to main (and stop after returning) *)
    @ [Mips.JAL ("main",[])]
    @ (* stop code *)
      [Mips.LABEL "_stop_";
       Mips.LI (RN2, sysExit);
       Mips.SYSCALL]
    @ (* code for functions *)
      funsCode
      (* pre-defined ord: char -> int and chr: int -> char *)
    @ [Mips.LABEL "ord"; (* char returned unmodified, interpreted as int *)
       Mips.JR (RA,[]);
       Mips.LABEL "chr"; (* int values are truncated to 8 bit (ASCII), *)
       Mips.ANDI (RN2, RN2, 255);
       Mips.JR (RA,[])]
      (* built-in read and write functions *)
    @ [Mips.LABEL "putint";     (* putint function *)
       Mips.ADDI(SP,SP,-8);
       Mips.SW (RN2,SP,0);      (* save used registers *)
       Mips.SW (RN4,SP,4);
       Mips.MOVE (RN4, RN2);   (* convention: number to be written in r2 *)
       Mips.LI (RN2, sysPrintInt);
       Mips.SYSCALL;
       Mips.LI (RN2, sysPrintString);
       Mips.LA(RN4,"_space_");
       Mips.SYSCALL;            (* write CR *)
       Mips.LW (RN2,SP,0);      (* reload used registers *)
       Mips.LW (RN4,SP,4);
       Mips.ADDI(SP,SP,8);
       Mips.JR (RA,[]);

       Mips.LABEL "getint";     (* getint function *)
       Mips.LI (RN2,sysReadInt);
       Mips.SYSCALL;
       Mips.JR (RA,[])]
    @ (* putchar *)
      [ Mips.LABEL "putchar";
        Mips.ADDI(SP,SP,-8);     (* make space for 2 registers on the stack *)
        Mips.SW (RN2,SP,0);      (* save registers $2 and $4 to stack *)
        Mips.SW (RN4,SP,4);
        Mips.MOVE (RN4, RN2);     (* put char in $4 for syscall to work on *)
        Mips.LI(RN2, sysPrintChar);
        Mips.SYSCALL;
        Mips.LI (RN2, sysPrintString);
        Mips.LA(RN4,"_space_");  (* the string we'll write is a space *)
        Mips.SYSCALL;
        Mips.LW (RN2,SP,0);      (* reload registers $2 and $4 from stack *)
        Mips.LW (RN4,SP,4);
        Mips.ADDI(SP,SP,8);      (* free stack space again *)
        Mips.JR (RA,[])
      ]
    @ (* getchar *)
      [ Mips.LABEL "getchar";
        Mips.ADDI(SP,SP,-8);     (* make space for 2 registers on the stack *)
        Mips.SW (RN4,SP,0);      (* save registers $4 and $5 to stack *)
        Mips.SW (RN5,SP,4);
        Mips.LI(RN2, sysReadChar);
        Mips.SYSCALL;
        Mips.MOVE(RN5,RN2);      (* temporarily move the result in reg $5*)
        Mips.LI (RN2, sysPrintString);
        Mips.LA(RN4,"_cr_");
        Mips.SYSCALL;            (* write CR *)
        Mips.MOVE(RN2, RN5);     (* put the result back in $2*)
        Mips.LW (RN4, SP, 0);    (* restore registers *)
        Mips.LW (RN5, SP, 4);
        Mips.ADDI(SP,SP,8);      (* free stack space again *)
        Mips.JR (RA,[])
      ]
    @ (* putstring *)
      [ Mips.LABEL "putstring";
        Mips.ADDI(SP,  SP, -16);     (* make space on stack for registers *)
        Mips.SW  (RN2, SP, 0);       (* save registers $2,$4,$5,$6 to stack *)
        Mips.SW  (RN4, SP, 4);
        Mips.SW  (RN5, SP, 8);
        Mips.SW  (RN6, SP, 12);
        Mips.LW  (RN4, RN2, 0);      (* $4 := size($2)    *)
        Mips.ADDI(RN5, RN2, 4);      (* $5 := $2 + 4      *)
        Mips.ADD (RN6, RN5, RN4);    (* $6 := $5 + $4     *)
        Mips.LI  (RN2, sysPrintChar);
        Mips.LABEL "putstring_begin";
        Mips.SUB (RN4, RN5, RN6);         (* while ($5 < $6) { *)
        Mips.BGEZ(RN4, "putstring_done"); (*                   *)
          Mips.LB(RN4, RN5, 0);           (*   $4 := M[$5]     *)
          Mips.SYSCALL;                   (*   putchar($4)     *)
          Mips.ADDI(RN5, RN5, 1);         (*   $5 := $5 + 1    *)
          Mips.J "putstring_begin";       (* }                 *)
        Mips.LABEL "putstring_done";
        Mips.LW (RN2, SP, 0);        (* restore registers $2,$4,$5,$6 *)
        Mips.LW (RN4, SP, 4);
        Mips.LW (RN5, SP, 8);
        Mips.LW (RN6, SP, 12);
        Mips.ADDI(SP, SP, 16);       (* free stack space again *)
        Mips.JR (RA,[])
      ]
    @ (* Fixed code for reporting runtime errors.
         expects source line number in $5, pointer to error message in $6 *)
      [Mips.LABEL "_RuntimeError_";
       Mips.LA (RN4, "_ErrMsg_");
       Mips.LI (RN2, sysPrintString); Mips.SYSCALL;
       Mips.MOVE (RN4, RN5);
       Mips.LI (RN2, sysPrintInt); Mips.SYSCALL;
       Mips.LA (RN4, "_colon_space_");
       Mips.LI (RN2, sysPrintString); Mips.SYSCALL;
       Mips.MOVE (RN4, RN6);
       Mips.LI (RN2, sysPrintString); Mips.SYSCALL;
       Mips.LA (RN4, "_cr_");
       Mips.LI (RN2, sysPrintString); Mips.SYSCALL;
       Mips.J "_stop_"]
    @
       [Mips.DATA "";
        Mips.COMMENT "Fixed strings for I/O";
        Mips.LABEL "_ErrMsg_";
        Mips.ASCIIZ "Runtime error at line ";
        Mips.LABEL "_colon_space_";
        Mips.ASCIIZ ": ";
        Mips.LABEL "_cr_";
        Mips.ASCIIZ "\n";
        Mips.LABEL "_space_";
        Mips.ASCIIZ " "]
    @
       [Mips.COMMENT "Message strings for specific errors";
        Mips.LABEL "_Msg_IllegalArraySize_";
        Mips.ASCIIZ "negative array size";
        Mips.LABEL "_Msg_IllegalIndex_";
        Mips.ASCIIZ "array index out of bounds"
        Mips.LABEL "_Msg_DivZero_";
        Mips.ASCIIZ "division by zero"
       ]
    @ (* String literals *)
       (Mips.COMMENT "String Literals" ::
        List.concat stringdata)
      (* Heap (to allocate arrays in, word-aligned) *)
    @ [Mips.ALIGN 2;
        Mips.LABEL "_heap_";
        Mips.SPACE 100000]
  mips_prog
