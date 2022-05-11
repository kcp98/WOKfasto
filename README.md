# The Fasto Compiler (v1.1, 2022-05)

This is the compiler for the Fasto programming language.
The first work was done by the teachers of the course IPS at DIKU.
Our study group `WOK` will finish the job.

This is the compiler for the Fasto programming language. The source
code resides in the `Fasto` directory.

Note that you need the .NET 6.0 SDK (*not* a Mono-based F#) installed
on your machine, with the `dotnet` executable in your search path.
Additionally, you should have `bash` to execute the various test
scripts, and the Java Runtime Environment (full SDK not needed) to run
the MARS simulator.

To build the compiler, run `make` (or just `dotnet build Fasto`).

To interpret, compile, or optimize a Fasto program, run `bin/fasto.sh`.

To execute a compiled program (in MIPS assembly), run `bin/mars.sh`.

To compile and immediately execute a Fasto program, run `bin/compilerun.sh`.

To run all tests from the `tests` directory (or some other), run
`bin/runtests.sh`. Use `-i` to run in interpreted mode, and `-o` to
turn on the optimizations in the compiler.
