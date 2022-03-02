# regz

regz is a Zig code generator for microcontrollers. Vendors often publish files
that have the details of special function registers, for ARM this is called a
"System View Description" (SVD), and this tool outputs a single file for you to
start interacting with the hardware:

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
used with [microzig](https://github.com/ZigEmbeddedGroup/microzig) 

One can get the required SVD file from your vendor, or another good place is
[posborne/cmsis-svd](https://github.com/posborne/cmsis-svd/tree/master/data),
it's a python based SVD parser and they have a large number of files available.

## Building

regz targets zig master.

```
git clone --recursive https://github.com/ZigEmbeddedGroup/regz.git
zig build
```

## Using regz to generate code

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

### How about AVR?

Atmel/Microchip publishes their register definitions for AVRs in ATDF, it is
not implemented, but we do plan on supporting it. There are tools like
[Rahix/atdf2svd](https://github.com/Rahix/atdf2svd) if you really can't wait to
get your hands dirty.

### What about MSP430?

TI does have another type of XML-based register schema, it is also
unimplemented but planned for support.

### Okay but I want [some other architecture/format]

The main idea is to target what LLVM can target, however Zig's C backend in
underway so it's likely more exotic architectures could be reached in the
future. If you know of any others we should look into, please make an issue!

## Roadmap

- SVD: mostly implemented and usable for mosts MCUs, but a few finishing touches in order to suss out any bugs:
    - [ ] nested clusters
    - [ ] order generated exactly as defined in schema
    - [ ] finalize derivation of different components
    - [ ] comprehensive suite of tests
    - [ ] RISC-V interrupt table generation
- [ ] ATDF: Atmel's register schema format
- [ ] insert name of Texus Insturment's register schema format for MSP430
