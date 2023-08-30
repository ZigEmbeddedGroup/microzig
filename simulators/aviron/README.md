# AViRon

AVR simulator in Zig.

> DISCLAIMER: This is work in project and can currently emulate a good amount of the AVR instruction set
>             without cycle counting.

## Development

### Repo Architecture

```sh
.
├── doc                 # Documents for Aviron or AVR 
├── samples             # Source of examples that can be run on the simulator
├── src                 # Source code
│   ├── lib             # - Aviron emulator
│   ├── libtestsuite    # - Source code of the testsuite library
│   └── shared          # - Shared code between the tools, generated code and simulator
├── testsuite           # Contains the test suite of Aviron
│   ├── instructions    # - Tests for single instructions
│   ├── lib             # - Tests for the libtestsuie  
│   ├── simulator       # - Tests for the simulator per se 
│   └── testrunner      # - Tests for the test runner (conditions, checks, ...)
├── testsuite.avr-gcc   # Contains code for the test suite that cannot be built with LLVM right now
│   └── instructions
└── tools               # Code for tooling we need during development, but not for deployment
```

### Tests

Run the test suite by invoking

```sh-session
[~/projects/aviron]$ zig build test
[~/projects/aviron]$ 
```

The `test` step will recursively scan the folder `testsuite` for files of the following types:

- *compile* `.S`
- *compile* `.c`
- *compile* `.cpp`
- *compile* `.zig`
- *load* `.bin`
- *load* `.elf`

File extensions marked *compile* will be compiled or assembled with the Zig compiler, then executed with the test runner. Those files allow embedding a JSON configuration via Zig file documentation comments:

```zig
//! {
//!   "stdout": "hello",
//!   "stderr": "world"
//! }
const testsuite = @import("testsuite");

export fn _start() callconv(.C) noreturn {
    testsuite.write(.stdout, "hello");
    testsuite.write(.stderr, "world");
    testsuite.exit(0);
}
```

For files marked as *load*, another companion file `.bin.json` or similar contains the configuration for this test.

The [JSON schema](src/testconfig.zig) allows description of how the file is built and the test runner is executed. It also contains a set of pre- and postconditions that can be used to set up the CPU and validate it after the program exits.

If you're not sure if your code compiled correctly, you can use the `debug-testsuite` build step to inspect the generated files:

```sh-session
[~/projects/aviron]$ zig build debug-testsuite
[~/projects/aviron]$ tree zig-out/
zig-out/
├── bin
│   └── aviron-test-runner
└── testsuite
    ├── instructions
    │   ├── cbi.elf
    │   ├── in-stdio.elf
        ├── ...
    │   ├── out-stdout.elf
    │   └── sbi.elf
    ├── lib
    │   └── write-chan.elf
    └── simulator
        ├── scratch-reg0.elf
        ├── scratch-reg1.elf
        ├── ...
        ├── scratch-rege.elf
        └── scratch-regf.elf
```

You can then disassemble those files with either `llvm-objdump` or `avr-objdump`:

```sh-session
[~/projects/aviron]$ llvm-objdump -d zig-out/testsuite/instructions/out-exit-0.elf 

zig-out/testsuite/instructions/out-exit-0.elf:  file format elf32-avr

Disassembly of section .text:

00000000 <_start>:
       0: 00 27         clr     r16
       2: 00 b9         out     0x0, r16
       
[~/projects/aviron]$ avr-objdump -d zig-out/testsuite/instructions/out-exit-0.elf 

zig-out/testsuite/instructions/out-exit-0.elf:     file format elf32-avr

Disassembly of section .text:

00000000 <_start>:
   0:   00 27           eor     r16, r16
   2:   00 b9           out     0x00, r16       ; 0

[~/projects/aviron]$ 
```

The test runner is located at [src/testrunner.zig](src/testrunner.zig) and behaves similar to the main `aviron` executable, but introduces a good amount of checks we can use to inspect and validate the simulation.

### Updating AVR-GCC tests

To prevent a hard dependency on the `avr-gcc` toolchain, we vendor the binaries for all tests defined in the folder `testsuite.avr-gcc`. To update the files, you need to invoke the `update-testsuite` build step:

```sh-session
[~/projects/aviron]$ zig build update-testsuite
[~/projects/aviron]$ 
```

After that, `zig build test` will run the regenerated tests.

**NOTE:** The build will not detect changed files, so you have no guarantee that running `zig build update-testsuite test` will actually do the right thing. If you're working on the test suite, just use `zig build update-testsuite && zig build test` for this.

## Links

- https://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf
- http://www.avr-asm-tutorial.net/avr_en/micro_beginner/instructions.html
- https://github.com/dwelch67/avriss/blob/master/opcodes.txt
- https://microchipdeveloper.com/8avr:status
