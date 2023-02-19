# regz

[![Build status](https://badge.buildkite.com/c56a26cdbd9262c17f84c26c81a587696d84aef891e84cdc90.svg)](https://buildkite.com/zig-embedded-group/regz)

regz is a Zig code generator for microcontrollers. Vendors often publish files
that have the details of special function registers, for ARM this is called a
"System View Description" (SVD), for AVR the format is called ATDF. This tool
outputs a single file for you to start interacting with the hardware:

```zig
const regs = @import("nrf52.zig").registers;

pub fn main() void {
    regs.P0.PIN_CNF[17].modify(.{
        .DIR = 1,
        .INPUT = 1,
        .PULL = 0,
        .DRIVE = 0,
        .SENSE = 0,
    });
    regs.P0.OUT.modify(.{ .PIN17 = 1 });
}
```

NOTE: just including that file is not enough to run code on a microcontroller,
this is a fairly low-level tool and it is intended that the generated code be
used with something like [microzig](https://github.com/ZigEmbeddedGroup/microzig).

One can get SVD files from your vendor, or another good place is
[posborne/cmsis-svd](https://github.com/posborne/cmsis-svd/tree/master/data),
it's a python based SVD parser and they have a large number of files available.

For ATDF you need to unzip the appropriate atpack from the
[registry](https://packs.download.microchip.com).

## Building

regz targets zig master.

```
git clone --recursive https://github.com/ZigEmbeddedGroup/regz.git
cd regz
zig build
```

## Using regz to generate code

Files provided may be either SVD or ATDF.

Provide path on command line:
```
regz <path-to-svd> > my-chip.zig
```

Provide schema via stdin, must specify the schema type:
```
cat my-file.svd | regz --schema svd > my-chip.zig
```

### Does this work for RISC-V?

It seems that manufacturers are using SVD to represent registers on their
RISC-V based products despite it being an ARM standard. At best regz will
generate the register definitions without an interrupt table (for now), if you
run into problems issues will be warmly welcomed!

### What about MSP430?

TI does have another type of XML-based register schema, it is also
unimplemented but planned for support.

### Okay but I want [some other architecture/format]

The main idea is to target what LLVM can target, however Zig's C backend in
underway so it's likely more exotic architectures could be reached in the
future. If you know of any others we should look into, please make an issue!

## Roadmap

- SVD: mostly implemented and usable for mosts MCUs, but a few finishing touches in order to suss out any bugs:
    - [x] nested clusters
    - [ ] order generated exactly as defined in schema
    - [ ] finalize derivation of different components
    - [ ] comprehensive suite of tests
    - [ ] RISC-V interrupt table generation
- [x] ATDF: AVR's register schema format
- [ ] insert name of Texus Insturment's register schema format for MSP430

