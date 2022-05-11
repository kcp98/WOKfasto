(* A register allocator for MIPS. *)

module RegAlloc

(* registerAlloc takes a list of MIPS instructions, a set of
   registers that are live at the end of the code, three register
   numbers:
     1) The lowest allocatable register (typically 2).
     2) The highest caller-saves register.
     3) The highest allocatable register (typically 25).
   and the number of already spilled variables.  This should be 0 in the initial
   call unless some variables are forced to spill before register allocation.
   Registers up to (and including) the highest caller-saves
   register are assumed to be caller-saves. Those above are assumed to
   be callee-saves.

   registerAlloc returns:
   a modified instruction list where null moves have been removed,
   a set of the variables that are live at entry,
   plus a number indicating the highest used register number.

   The latter can be used for deciding which callee-saves registers
   need to be saved.

   Limitations:

    - Works for a single procedure body only.

    - Assumes all JALs eventually return to the next instruction and
      preserve callee-saves registers when doing so.

    - Does caller-saves preservation only by allocating variables that
      are live across procedure calls to callee-saves registers and
      variables not live across call preferably to caller-saves.

    - Can only remove null moves if they are implemented by ORI (rx,ry,"0").
      Use the pseudo-instruction MOVE (rx,ry) for this.

*)

open Mips

exception MyError of string

exception Not_colourable of string

let spilledVars : Set<string> ref = ref (Set.empty)

let rec destRegs (lst : Instruction list) : Set<reg> =
  match lst with
    | [] -> Set.empty
    | (i::ilist) -> Set.union (destReg i) (destRegs ilist)


(* variables and registers that can be overwritten *)
and destReg (i : Instruction) : Set<reg> =
  match i with
  | LA (rt,v)      -> Set.singleton rt
  | LUI (rt,v)     -> Set.singleton rt
  | ADD (rd,rs,rt) -> Set.singleton rd
  | ADDI (rd,rs,v) -> Set.singleton rd
  | SUB (rd,rs,rt) -> Set.singleton rd
  | MUL (rd,rs,rt) -> Set.singleton rd
  | DIV (rd,rs,rt) -> Set.singleton rd
  | AND (rd,rs,rt) -> Set.singleton rd
  | ANDI (rd,rs,v) -> Set.singleton rd
  | OR (rd,rs,rt)  -> Set.singleton rd
  | ORI (rd,rs,v)  -> Set.singleton rd
  | XOR (rd,rs,rt) -> Set.singleton rd
  | XORI (rd,rs,v) -> Set.singleton rd
  | SLL (rd,rt,v)  -> Set.singleton rd
  | SRA (rd,rt,v)  -> Set.singleton rd
  | SLT (rd,rs,rt) -> Set.singleton rd
  | SLTI (rd,rs,v) -> Set.singleton rd
  | JAL (lab,argRegs) -> Set.add (RN 31) (Set.ofList argRegs)
  | LW (rd,rs,v)   -> Set.singleton rd
  | LB (rd,rs,v)   -> Set.singleton rd
  | SYSCALL        -> Set.singleton (RN 2) (* return value is in $2 *)
  | _ -> Set.empty

(* variables and register that can be read by i *)
let usedRegs (i : Instruction) : Set<reg> =
  match i with
  | ADD (rd,rs,rt) -> Set.ofList [rs;rt]
  | ADDI (rd,rs,v) -> Set.singleton rs
  | SUB (rd,rs,rt) -> Set.ofList [rs;rt]
  | MUL (rd,rs,rt) -> Set.ofList [rs;rt]
  | DIV (rd,rs,rt) -> Set.ofList [rs;rt]
  | AND (rd,rs,rt) -> Set.ofList [rs;rt]
  | ANDI (rd,rs,v) -> Set.singleton rs
  | OR (rd,rs,rt) -> Set.ofList [rs;rt]
  | ORI (rd,rs,v) -> Set.singleton rs
  | XOR (rd,rs,rt) -> Set.ofList [rs;rt]
  | XORI (rd,rs,v) -> Set.singleton rs
  | SLL (rd,rt,v) -> Set.singleton rt
  | SRA (rd,rt,v) -> Set.singleton rt
  | SLT (rd,rs,rt) -> Set.ofList [rs;rt]
  | SLTI (rd,rs,v) -> Set.singleton rs
  | BEQ (rs,rt,v) -> Set.ofList [rs;rt]
  | BNE (rs,rt,v) -> Set.ofList [rs;rt]
  | BGEZ (rs,v) -> Set.singleton rs
  | J lab -> Set.empty
  | JAL (lab,argRegs) -> Set.ofList argRegs
                (* argRegs are argument registers *)
  | JR (r,resRegs) -> Set.ofList (r::resRegs)
                (* r is jump register,
                   resRegs are registers required to be live *)
  | LW (rd,rs,v) -> Set.singleton rs
  | SW (rd,rs,v) -> Set.ofList [rs;rd]
  | LB (rd,rs,v) -> Set.singleton rs
  | SB (rd,rs,v) -> Set.ofList [rs;rd]
  | SYSCALL -> Set.ofList [RN 2; RN 4; RN 5]
                (* $2 is control register and $4, $5 are arguments *)
  | _ -> Set.empty


let live_step ilist llist liveAtEnd =
  let rec scan (is : Instruction list) =
    match is with
      | [] -> []
      | (i::is) ->
          let ls1 = scan is
          if   List.isEmpty ls1
          then [instruct i liveAtEnd]
          else (instruct i (List.head ls1)) :: ls1

   (* live variables and registers *)
  and instruct (i : Instruction) (live : Set<reg>) : Set<reg> =
    match i with
      | BEQ (rs,rt,v) -> Set.union (Set.ofList [rs;rt]) (Set.union live (live_at v))
      | BNE (rs,rt,v) -> Set.union (Set.ofList [rs;rt]) (Set.union live (live_at v))
      | BGEZ (rs,v)   -> Set.union (Set.singleton rs)   (Set.union live (live_at v))
      | J lab -> live_at lab
      | JR (r,resRegs) -> Set.ofList (r::resRegs)
              (* r is jump register, resRegs are registers required to be live *)
      | _ -> Set.union (usedRegs i) (Set.difference live (destReg i))

  and live_at lab : Set<reg> = search ilist llist lab

  and search a1 a2 a3 : Set<reg> =
    match (a1, a2, a3) with
      | ([], [], lab) -> Set.empty
      | (LABEL k :: is, l::ls, lab) ->
          if k = lab then l else search is ls lab
      | (_::is, _::ls, lab) -> search is ls lab
      | (a, b, l) -> raise (MyError "should not happen in RegAlloc.live_step.search!")

  let res = scan ilist
  res

let rec iterate_live ilist llist liveAtEnd =
  let  llist1 = live_step ilist llist liveAtEnd
  if   llist1 = llist
  then llist
  else iterate_live ilist llist1 liveAtEnd

let rec init_list = function
  | []      -> []
  | (i::is) -> Set.empty :: init_list is

(* live_regs finds for each instruction those symbolic register names *)
(* that are live at entry to this instruction *)

let live_regs ilist liveAtEnd =
      iterate_live ilist (init_list ilist) liveAtEnd

let rec regs lst (rs : Set<reg>) : Set<reg> =
  match lst with
    | [] -> rs
    | (l :: llist) -> Set.union l (regs llist rs)

let numerical r =
  match r with
    | RN _ -> true
    | RS _ -> false

let filterSymbolic rs = Set.filter (fun a -> not (numerical a)) rs

let rec findRegs llist = filterSymbolic (regs llist Set.empty)

(* conflicts ilist llist callerSaves r *)
(* finds those variables that interferere with r *)
(* in instructions ilist with live-out specified by llist *)
(* callerSaves are the caller-saves registers *)

let rec conflicts = function
  | ([], [], callerSaves, RN r) -> Set.remove (RN r) callerSaves
                (* all numerical interfere with all other caller-saves *)
  | ([], [], callerSaves, RS _) -> Set.empty
  | (ORI (rd,rs,0) :: ilist, l :: llist, callerSaves, r) ->
      if r=rd  (* if destination *)
      then Set.union (Set.remove rs (Set.remove r l)) (* interfere with live except rs *)
                     (conflicts (ilist, llist, callerSaves, r))
      else if r=rs  (* if source, no interference *)
      then conflicts (ilist, llist, callerSaves, r)
      else if Set.contains r l (* otherwise, live interfere with rd *)
      then Set.add rd (conflicts (ilist, llist, callerSaves, r))
      else conflicts (ilist, llist, callerSaves, r)
  | (JAL (f,argRegs) :: ilist, l :: llist, callerSaves, r) ->
      if (Set.contains r l)  (* live vars interfere with caller-saves regs *)
      then Set.union (Set.remove r callerSaves)
                     (conflicts (ilist, llist, callerSaves, r))
      else if Set.contains r callerSaves
      then Set.union (Set.remove r l)
                     (conflicts (ilist, llist, callerSaves, r))
      else conflicts (ilist, llist, callerSaves, r)
  | (i :: ilist, l :: llist, callerSaves, r) ->
      if (Set.contains r (destReg i)) (* destination register *)
      then Set.union (Set.remove r l)   (* conflicts with other live vars *)
                     (conflicts (ilist, llist, callerSaves, r))
      else if Set.contains r l        (* all live vars *)
      then Set.union (destReg i)    (* conflict with destination *)
                     (conflicts (ilist, llist, callerSaves, r))
      else conflicts (ilist, llist, callerSaves, r)
  | _ -> raise (MyError "conflicts used at undefined instance")



(* Interference graph is represented as a list of registers *)
(* each paired with a list of the registers with which it conflicts *)

let graph ilist llist callerSaves =
  let rs = Set.union callerSaves (findRegs llist) |> Set.toList
  List.zip rs (List.map (fun r -> conflicts (ilist, ((List.tail llist)@[Set.empty]), callerSaves, r)) rs)




(* finds move-related registers *)

let rec findMoves ilist llist =
  let rs = findRegs llist |> Set.toList
  List.zip rs (List.map (fun r -> findMoves1 r ilist) rs)

and findMoves1 r = function
  | [] -> Set.empty
  | (ORI (rd,rs,0) :: ilist) ->
      Set.union  ( if   rd=r then Set.singleton rs
                   elif rs=r then Set.singleton rd
                   else Set.empty)
                 (findMoves1 r ilist)
  | (i::ilist) -> findMoves1 r ilist



(* sorts by number of conflicts, but with numeric registers last *)

let be4 (a, ac) (b, bc) =
    match (a, b) with
      | (RN i, RN j) -> i <= j
      | (RN _, RS _) -> false
      | (RS _, RN _) -> true
      | (RS sa, RS sb) ->
         match (Set.contains sa (!spilledVars), Set.contains sb (!spilledVars)) with
           | (false, false) -> Set.count ac <= Set.count bc
           | (true , false) -> false
           | (false, true ) -> true
           | (true , true ) -> Set.count ac <= Set.count bc

let rec sortByOrder = function
  | [] -> []
  | (g : (reg * Set<'b>) list) ->
     let rec split = function
       | [] -> ([],[])
       | (a::g) ->
         let (l, g1) = ascending a g []
         let (g2,g3) = split g1
         (rev2 l g3, g2)
     and ascending a g l =
       match g with
         | [] -> (a::l,[])
         | (b::g1) ->
               if be4 a b
               then ascending b g1 (a::l)
               else (a::l,g)
     and rev2 g l2 =
       match g with
         | [] -> l2
         | (a::l1) -> rev2 l1 (a::l2)

     let rec merge = function
        | ([], l2) -> l2
        | (l1, []) -> l1
        | (a::r1, b::r2) ->
               if be4 a b
               then a :: merge (r1, b::r2)
               else b :: merge (a::r1, r2)

     let (g1,g2) = split g
     if   List.isEmpty g1 then g2
     elif List.isEmpty g2 then g1
     else merge (sortByOrder g1, sortByOrder g2)



(* n-colour graph using Briggs' algorithm *)

let rec colourGraph g rmin rmax moveRelated =
  select (simplify (sortByOrder g) [])
         (mList rmin rmax) moveRelated []

and simplify h l =
    match h with
      | [] -> l
      | (r,c) :: g ->
        simplify (sortByOrder (removeNode r g)) ((r,c)::l)

and removeNode r = function
    | [] -> []
    | ((r1,c)::g) ->
      (r1,Set.remove r c) :: removeNode r g

and select rcl regs moveRelated sl =
    match rcl with
      | [] -> sl
      | ((r,c)::l) ->
        let rnum =
            if numerical r then r
            else let possible = NotIn c sl regs
                 let related  = lookUp2 r moveRelated
                 let related2 = Set.map (fun r -> lookUp r sl) related
                 let mPossible= Set.intersect possible related2
                 if Set.isEmpty possible then raise (Not_colourable (ppReg r))
                 elif Set.isEmpty mPossible then Set.minElement possible //hd possible
                 else Set.minElement mPossible //hd mPossible
        select l regs moveRelated ((r,rnum)::sl)

and NotIn rcs sl regs : Set<reg> =
    Set.fold (fun acc r -> Set.remove (lookUp r sl) acc) regs rcs

and lookUp r = function
    | [] -> RN 0
    | ((r1,n)::sl) ->
      if numerical r then r
      else if r=r1 then n else lookUp r sl

and lookUp2 r = function
    | [] -> Set.empty
    | ((r1,ms)::sl) -> if r=r1 then ms else lookUp2 r sl

and mList m n : Set<reg> =
  if m > n then Set.empty
  else Set.add (RN m) (mList (m+1) n)


let rec filterNullMoves ilist allocs =
    match ilist with
      | [] -> []

      | (ORI (rd,rs,0) :: ilist_tl) ->
        let rd1 = lookUp rd allocs
        let rs1 = lookUp rs allocs
        if rd1 = rs1 || rd1 = RN 0
        then COMMENT ("\tori\t"+ ppReg rd+","+ ppReg rs+",0")
             :: filterNullMoves ilist_tl allocs
        else ORI (rd,rs,0) :: filterNullMoves ilist_tl allocs

      | (i :: ilist_tl) ->
        i :: filterNullMoves ilist_tl allocs

and printList = function
  | []        -> ""
  | (r :: rs) -> r+" "+ printList rs

let rec printGraph = function
  | []            -> []
  | ((r,rs) :: g) ->
     [COMMENT ("interferes: "+r+" with "+printList rs)]
     @ printGraph g

let renameReg allocs inst =
    let renTo inst1 = [inst1; COMMENT ("was:" + ppMips inst)]
    match inst with
    | LA (rt,l) ->
        renTo (LA (lookUp rt allocs, l))
    | LUI (rt,v) ->
        renTo (LUI (lookUp rt allocs, v))
    | ADD (rd,rs,rt) ->
        renTo (ADD (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | ADDI (rd,rs,v) ->
        renTo (ADDI (lookUp rd allocs, lookUp rs allocs, v))
    | SUB (rd,rs,rt) ->
        renTo (SUB (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | MUL (rd,rs,rt) ->
        renTo (MUL (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | DIV (rd,rs,rt) ->
        renTo (DIV (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | AND (rd,rs,rt) ->
        renTo (AND (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | ANDI (rd,rs,v) ->
        renTo (ANDI (lookUp rd allocs, lookUp rs allocs, v))
    | OR (rd,rs,rt) ->
        renTo (OR (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | ORI (rd,rs,v) ->
        renTo (ORI (lookUp rd allocs, lookUp rs allocs, v))
    | XOR (rd,rs,rt) ->
        renTo (XOR (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | XORI (rd,rs,v) ->
        renTo (XORI (lookUp rd allocs, lookUp rs allocs, v))
    | SLL (rd,rt,v) ->
        renTo (SLL (lookUp rd allocs, lookUp rt allocs, v))
    | SRA (rd,rt,v) ->
        renTo (SRA (lookUp rd allocs, lookUp rt allocs, v))
    | SLT (rd,rs,rt) ->
        renTo (SLT (lookUp rd allocs, lookUp rs allocs, lookUp rt allocs))
    | SLTI (rd,rs,v) ->
        renTo (SLTI (lookUp rd allocs, lookUp rs allocs, v))
    | BEQ (rs,rt,l) ->
        renTo (BEQ (lookUp rs allocs, lookUp rt allocs, l))
    | BGEZ(rs,l) ->
        renTo (BGEZ(lookUp rs allocs, l))
    | BNE (rs,rt,l) ->
        renTo (BNE (lookUp rs allocs, lookUp rt allocs, l))
    | JAL (lab,argRegs) ->
        [JAL (lab, List.map (fun r -> lookUp r allocs) argRegs);
         COMMENT ("was:" + ppMips inst +
                    ", " + String.concat " " (List.map ppReg argRegs))]
    | JR (r, resRegs) ->
        [JR (lookUp r allocs, List.map (fun r -> lookUp r allocs) resRegs);
         COMMENT ("was:" + ppMips inst +
                    ", " + String.concat " " (List.map ppReg resRegs))]
    | LW (rd,rs,v) ->
        renTo (LW (lookUp rd allocs, lookUp rs allocs, v))
    | SW (rd,rs,v) ->
        renTo (SW (lookUp rd allocs, lookUp rs allocs, v))
    | LB (rd,rs,v) ->
        renTo (LB (lookUp rd allocs, lookUp rs allocs, v))
    | SB (rd,rs,v) ->
        renTo (SB (lookUp rd allocs, lookUp rs allocs, v))
    | _ -> [inst]

let spill1 i r offset =
  let d = destReg i
  let u = usedRegs i
  let hdlst = if   Set.contains r u
              then [Mips.LW (r, RN 29, offset)]
              else []
  let tllst = if   Set.contains r d
              then [Mips.SW (r, RN 29, offset)]
              else []
  hdlst @ [i] @ tllst

let rec spill ilist r offset =
    match ilist with
      | []      -> []
      | (i::is) -> spill1 i r offset @ spill is r offset

let rec maxreg lst m =
    match lst with
      | [] -> m
      | ((r,RN n)::rs) -> maxreg rs (if m < n then n else m)
      | ((_,RS _)::rs) -> raise (MyError "maxreg of non-numeric register")

(* arguments:
   ilist is list of MIPS instructions
   liveAtEnd is a set of variables that are live at the end of ilist
   rmin is first allocable register (caller-saves)
   callerMax is highest caller-saves register
   rmax is highest allocable register
   spilled is number of registers spilled so far -- should be 0 initially
*)
let rec registerAlloc (ilist : Mips.Instruction list)
                      (liveAtEnd : Set<reg>)
                      (rmin : int)
                      (callerMax : int)
                      (rmax : int)
                      (spilled : int)
                    : (Mips.Instruction list * Set<reg> * int * int) =
  try
    let llist = live_regs ilist liveAtEnd
    let callerSaves = mList rmin callerMax
    let iGraph = graph ilist llist callerSaves
    let moveRelated = findMoves ilist llist
    let allocs = colourGraph iGraph rmin rmax moveRelated
    let deadRegs = Set.difference (filterSymbolic (destRegs ilist))
                                  ( (List.map (fun (x,_) -> x) allocs) |> Set.ofList )
    let allocs1 = allocs @ (List.map (fun r -> (r, RN 0)) (Set.toList deadRegs))
    let ilist1 = filterNullMoves ilist allocs1
    let ilist2 = List.concat (List.map (renameReg allocs1) ilist1)
    (ilist2, List.head llist, maxreg allocs 0, spilled)
  with
    | (Not_colourable sr) ->
        printfn "%s spilled\n" sr
        spilledVars := Set.add sr (!spilledVars)
        let offset = (4*spilled)
        let ilist' = spill ilist (RS sr) offset
        let ilist'' = [Mips.SW (RS sr, RN 29,offset)]
                        @ ilist' @
                        (if Set.contains (RS sr) liveAtEnd
                         then [Mips.LW (RS sr, RN 29, offset)]
                         else [])
        registerAlloc ilist'' liveAtEnd rmin callerMax rmax (spilled + 1)

