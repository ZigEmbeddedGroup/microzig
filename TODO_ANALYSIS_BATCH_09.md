# TODO Analysis - Batch 09

**Batch Range**: Items 259-283  
**Directory Focus**: port/raspberrypi/rp2xxx  
**Total Items**: 25

---

### TODO #259: Find a way to allow this to be "null" as it's not explicitly required

**Location**: `port/raspberrypi/rp2xxx/src/hal/clocks/common.zig:11`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
/// TODO: Find a way to allow this to be "null" as it's not explicitly required as long
```

**Code Context**:
```zig
/// Clock Configuration
///
/// This configuration is used to setup the RP2040/RP2350 chip's clocks.
///
/// The RP2040/RP2350 uses a 12 MHz external crystal oscillator (xtal) by default.
/// This can be configured to a different frequency by setting the `xtal_freq` field.
/// IMPORTANT: If you are using a custom board with a different xtal frequency, you must
///             explicitly configure this field to match your hardware, otherwise the chip
///             will not operate correctly.
///
/// TODO: Find a way to allow this to be "null" as it's not explicitly required as long
///       as either sys_clk or some of the other clocks derive from the PLL and use xtal
///       as the reference.
pub const ClockConfiguration = struct {
    xtal_freq: u32,
```

**Analysis**:

- **Purpose**: Allow xtal frequency to be optional when not directly used
- **Why Incomplete**: Design decision needed - optional fields vs explicit configuration for safety
- **Complexity**: Medium
- **Related Items**: PLL configuration, clock source selection

**Recommendation**: Consider making xtal_freq optional only when no clocks derive from it, or require explicit configuration for safety

---

### TODO #260: Currently we don't support non-integer division

**Location**: `port/raspberrypi/rp2xxx/src/hal/clocks/common.zig:64`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
/// TODO: Currently we don't support non-integer division to avoid any
```

**Code Context**:
```zig
    /// Set the clock divider for a clock generator.
    ///
    /// The clock divider is used to divide the clock source frequency to generate the
    /// output frequency. The divider is specified as a fixed-point number with 16 bits
    /// of integer and 8 bits of fraction.
    ///
    /// The output frequency is calculated as: `output_freq = source_freq / divider`
    ///
    /// TODO: Currently we don't support non-integer division to avoid any
    ///       potential clock jitter issues. We may add support for fractional dividers
    ///       in the future if there is a need for it.
    ///
    /// # Arguments
    /// * `generator` - The clock generator to set the divider for
```

**Analysis**:

- **Purpose**: Add support for fractional clock dividers for finer frequency control
- **Why Incomplete**: Concerns about clock jitter and stability
- **Complexity**: Medium
- **Related Items**: Clock stability, frequency precision requirements

**Recommendation**: Research clock jitter implications with fractional dividers; add as opt-in feature with documentation about trade-offs

---

### TODO #261: Currently leave all fractional bits 0

**Location**: `port/raspberrypi/rp2xxx/src/hal/clocks/common.zig:183`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: Currently leave all fractional bits 0 to only support integer divisors
```

**Code Context**:
```zig
    const div_int = div_value;
    const div_frac = 0;

    // Write the divider value to the clock generator's DIV register
    // The DIV register is a 32-bit register with the following layout:
    //   [31:8] - Integer part of the divider
    //   [7:0]  - Fractional part of the divider (1/256ths)
    //
    // TODO: Currently leave all fractional bits 0 to only support integer divisors
    //       to avoid any potential clock jitter issues.
    const div_reg_value = (@as(u32, div_int) << 8) | (@as(u32, div_frac) << 0);

    switch (generator) {
        .gpout0 => hw.clocks.GPOUT0_DIV.raw = div_reg_value,
```

**Analysis**:

- **Purpose**: Implement fractional clock division support
- **Why Incomplete**: Same as #260 - clock jitter concerns
- **Complexity**: Low (implementation is straightforward once decision is made)
- **Related Items**: TODO #260, #256

**Recommendation**: Implement together with TODO #260 as part of fractional divider feature

---

### TODO #262: should use `compatibility.arch` but for some reason it breaks the code

**Location**: `port/raspberrypi/rp2xxx/src/hal/clocks/common.zig:223`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: should use `compatibility.arch` but for some reason it breaks the code.
```

**Code Context**:
```zig
fn get_hw_clocks() type {
    // TODO: should use `compatibility.arch` but for some reason it breaks the code.
    return switch (cpu.arch) {
        .RP2040 => @import("rp2040.zig").hw.clocks,
        .RP2350 => @import("rp2350.zig").hw.clocks,
        else => @compileError("Unsupported chip"),
    };
}

fn get_hw_pll() type {
    return switch (cpu.arch) {
```

**Analysis**:

- **Purpose**: Use proper compatibility.arch instead of direct cpu.arch
- **Why Incomplete**: Bug or initialization order issue with compatibility.arch
- **Complexity**: Low
- **Related Items**: Architecture detection system

**Recommendation**: Debug the issue with compatibility.arch - likely a comptime evaluation order problem

---

### TODO #263: consider fixed-point

**Location**: `port/raspberrypi/rp2xxx/src/hal/adc.zig:164`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: consider fixed-point
```

**Code Context**:
```zig
    /// Read the temperature from the internal temperature sensor.
    ///
    /// Returns the temperature in degrees Celsius as a floating-point value.
    ///
    /// The RP2040/RP2350 has an internal temperature sensor that can be read using
    /// the ADC. The temperature is calculated using the following formula:
    ///
    ///     T = 27 - (ADC_voltage - 0.706) / 0.001721
    ///
    /// Where ADC_voltage is the voltage read from the ADC in volts.
    ///
    // TODO: consider fixed-point
    pub fn read_temperature(self: *Self) !f32 {
        const adc_value = try self.read_raw();
```

**Analysis**:

- **Purpose**: Use fixed-point arithmetic instead of floating-point for temperature calculation
- **Why Incomplete**: Floating-point is simpler and performance not critical
- **Complexity**: Low
- **Related Items**: Performance optimization, embedded best practices

**Recommendation**: Profile to determine if FP is a bottleneck; implement fixed-point version if needed for no-FPU targets

---

### TODO #264: what happens when DMA and IRQ are enabled?

**Location**: `port/raspberrypi/rp2xxx/src/hal/adc.zig:273`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: what happens when DMA and IRQ are enabled?
```

**Code Context**:
```zig
    /// Enable DMA requests for the ADC.
    ///
    /// When enabled, the ADC will generate DMA requests when new conversion results are available.
    /// This allows the ADC to automatically transfer data to memory without CPU intervention.
    ///
    /// Note: DMA must be configured separately to handle these requests.
    ///
    // TODO: what happens when DMA and IRQ are enabled?
    pub fn enable_dma(self: *Self) void {
        _ = self;
        hw.adc.FCS.modify(.{ .DREQ_EN = 1 });
    }

    /// Disable DMA requests for the ADC.
```

**Analysis**:

- **Purpose**: Determine and document behavior when both DMA and IRQ are enabled
- **Why Incomplete**: Edge case not tested or documented
- **Complexity**: Medium  
**Related Items**: DMA configuration, interrupt handling

**Recommendation**: Test the behavior with both enabled; document priority/interaction in comments

---

### TODO #265: do we need to acknowledge an ADC interrupt?

**Location**: `port/raspberrypi/rp2xxx/src/hal/adc.zig:310`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: do we need to acknowledge an ADC interrupt?
```

**Code Context**:
```zig
    /// Enable ADC interrupts.
    ///
    /// When enabled, the ADC will generate interrupts when new conversion results are available
    /// (if FIFOEN is set) or when the FIFO reaches a certain level.
    ///
    /// Note: The interrupt handler must be configured separately.
    ///
    // TODO: do we need to acknowledge an ADC interrupt?
    pub fn enable_interrupt(self: *Self) void {
        _ = self;
        hw.adc.INTE.modify(.{ .FIFO = 1 });
    }
```

**Analysis**:

- **Purpose**: Determine if ADC interrupts require explicit acknowledgment
- **Why Incomplete**: Hardware behavior unclear from datasheet
- **Complexity**: Low
- **Related Items**: Interrupt handling patterns

**Recommendation**: Consult RP2040 datasheet section on ADC interrupts; test interrupt behavior

---

### TODO #266: check if this works

**Location**: `port/raspberrypi/rp2xxx/src/hal/adc.zig:314`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: check if this works
```

**Code Context**:
```zig
    /// Disable ADC interrupts.
    pub fn disable_interrupt(self: *Self) void {
        _ = self;
        // TODO: check if this works
        hw.adc.INTE.modify(.{ .FIFO = 0 });
    }
};

// ADC input channel selection
pub const Channel = enum(u3) {
```

**Analysis**:

- **Purpose**: Verify that interrupt disable function works correctly
- **Why Incomplete**: Function implemented but not tested
- **Complexity**: Low
- **Related Items**: Testing coverage

**Recommendation**: Add unit test to verify interrupt enable/disable functionality

---

### TODO #267: disable SIO interrupts

**Location**: `port/raspberrypi/rp2xxx/src/hal/multicore.zig:73`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: disable SIO interrupts
```

**Code Context**:
```zig
    const stack_bottom = @intFromPtr(stack_pointer) - @as(usize, STACK_SIZE);
    const stack_top = @intFromPtr(stack_pointer);

    // TODO: disable SIO interrupts
    launch_core1_raw(stack_bottom, stack_top, vector_table);
}

/// Launch core 1 using raw stack pointer values.
///
/// This is a low-level function that sets up core 1 with the given stack
/// pointers and vector table. Most users should use `launch_core1` instead.
///
// TODO: protect stack using MPU
fn launch_core1_raw(stack_bottom: usize, stack_top: usize, vector_table: usize) void {
```

**Analysis**:

- **Purpose**: Disable SIO (Single-cycle IO) interrupts during core launch
- **Why Incomplete**: Interrupt management not fully implemented
- **Complexity**: Low
- **Related Items**: Multicore interrupt safety

**Recommendation**: Add SIO interrupt disable/enable around critical multicore initialization sections

---

### TODO #268: protect stack using MPU

**Location**: `port/raspberrypi/rp2xxx/src/hal/multicore.zig:79`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: protect stack using MPU
```

**Code Context**:
```zig
    launch_core1_raw(stack_bottom, stack_top, vector_table);
}

/// Launch core 1 using raw stack pointer values.
///
/// This is a low-level function that sets up core 1 with the given stack
/// pointers and vector table. Most users should use `launch_core1` instead.
///
// TODO: protect stack using MPU
fn launch_core1_raw(stack_bottom: usize, stack_top: usize, vector_table: usize) void {
    // TODO: flush cache?

    const cmd_sequence = [_]u32{
        0,
        0,
```

**Analysis**:

- **Purpose**: Use Memory Protection Unit to protect stack memory
- **Why Incomplete**: Advanced safety feature; adds complexity
- **Complexity**: Medium
- **Related Items**: Stack overflow protection, MPU configuration

**Recommendation**: Implement as opt-in feature for production systems requiring enhanced safety

---

### TODO #269: protect stack using MPU

**Location**: `port/raspberrypi/rp2xxx/src/hal/multicore.zig:98`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: protect stack using MPU
```

**Code Context**:
```zig
pub fn reset_core1() void {
    const vector_table = @intFromPtr(microzig.cpu.startup_logic.vector_table);
    const stack = @intFromPtr(&core1_stack) + core1_stack.len;

    // TODO: protect stack using MPU
    launch_core1_raw(stack - STACK_SIZE, stack, vector_table);
}

fn wrapper() callconv(.C) noreturn {
    const entry = @as(*const fn () void, @ptrFromInt(core1_stack_ptr.load(.seq_cst)));
    entry();
```

**Analysis**:

- **Purpose**: Use MPU to protect stack on core reset
- **Why Incomplete**: Duplicate of TODO #268 for different context
- **Complexity**: Medium
- **Related Items**: TODO #268, MPU configuration

**Recommendation**: Implement together with TODO #268 as part of MPU stack protection feature

---

### TODO #270: Will potentially be modified in a future DMA overhaul

**Location**: `port/raspberrypi/rp2xxx/src/hal/uart.zig:325`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: Will potentially be modified in a future DMA overhaul
```

**Code Context**:
```zig
        .data_bits = config.data_bits.get_register_value(),
        .stop_bits = config.stop_bits.get_register_value(),
        .parity_enable = config.parity.get_parity_enable(),
        .parity_select = config.parity.get_parity_select(),
    });
}

// TODO: Will potentially be modified in a future DMA overhaul
pub fn get_dreq(uart: UART) hw.dma.Dreq {
    return switch (uart) {
        .uart0 => .uart0_tx,
        .uart1 => .uart1_tx,
    };
}
```

**Analysis**:

- **Purpose**: Note that DMA request function may change with DMA refactor
- **Why Incomplete**: Waiting for broader DMA system redesign
- **Complexity**: Low (marker TODO)
- **Related Items**: DMA subsystem refactoring

**Recommendation**: Keep as reminder until DMA overhaul complete; update API as needed

---

### TODO #271: add sanity checks, e.g., offset + count < flash size

**Location**: `port/raspberrypi/rp2xxx/src/hal/flash.zig:95`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: add sanity checks, e.g., offset + count < flash size
```

**Code Context**:
```zig
/// This is a blocking call. It will call `asm volatile("" ::: "memory");` at the
/// end to ensure the cache is synced.
///
/// Due to the implementation, the flash can be erased / written within the flash
/// address range 0x100000 .. 0x200000 only. This range clears the XIP and SSI caches.
/// Under the hood, this uses the _rom_flash_range_erase() function in the bootrom
/// v1, or the flash_range_erase() function in bootrom v2.
///
// TODO: add sanity checks, e.g., offset + count < flash size
pub fn range_erase(offset: u32, count: u32) void {
    // Note that a whole number of sectors must be erased at a time.
    assert(offset % SECTOR_SIZE == 0);
    assert(count % SECTOR_SIZE == 0);
```

**Analysis**:

- **Purpose**: Add bounds checking for flash erase operations
- **Why Incomplete**: Safety checks deferred for faster implementation
- **Complexity**: Low
- **Related Items**: Flash memory safety

**Recommendation**: Add assertions to validate offset and count are within valid flash range

---

### TODO #272: add sanity checks, e.g., offset + count < flash size

**Location**: `port/raspberrypi/rp2xxx/src/hal/flash.zig:119`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: add sanity checks, e.g., offset + count < flash size
```

**Code Context**:
```zig
/// Note that a whole number of pages must be written at a time. Additionally,
/// data must be 256-byte aligned.
///
/// Due to the implementation, the flash can be programmed within the flash
/// address range 0x100000 .. 0x200000 only. This range clears the XIP and SSI caches.
/// Under the hood, this uses the _rom_flash_range_program() function in the bootrom
/// v1, or the flash_range_program() function in bootrom v2.
///
// TODO: add sanity checks, e.g., offset + count < flash size
pub fn range_program(offset: u32, data: []const u8) void {
    assert(offset % PAGE_SIZE == 0);
    assert(data.len % PAGE_SIZE == 0);
```

**Analysis**:

- **Purpose**: Add bounds checking for flash programming operations
- **Why Incomplete**: Duplicate of TODO #271 for programming vs erase
- **Complexity**: Low
- **Related Items**: TODO #271, flash memory safety

**Recommendation**: Implement together with TODO #271 as part of flash safety improvements

---

### TODO #273: (empty TODO marker)

**Location**: `port/raspberrypi/rp2xxx/src/hal/dma.zig:120`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO:
```

**Code Context**:
```zig
    pub const Ring = enum(u1) {
        read = 0,
        write = 1,
    };
};

/// The DMA hardware has 12 channels on RP2040 and 16 channels on RP2350.
// TODO:
// - [ ] configure read and write
// - [ ] trigger
// - [ ] abort
// - [ ] busy
pub const Channel = enum(u4) {
```

**Analysis**:

- **Purpose**: Complete DMA channel API with listed features
- **Why Incomplete**: DMA implementation in progress; features not yet implemented
- **Complexity**: Medium
- **Related Items**: DMA subsystem

**Recommendation**: Implement remaining DMA channel operations: configure read/write, trigger, abort, busy status

---

### TODO #274: maybe support copying the table to ram as well?

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:16`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: maybe support copying the table to ram as well?
```

**Code Context**:
```zig
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

const rom = peripherals.ROM;
const rom_table_lookup_fn = rom.table_lookup;

// We take the extrme stance of not worrying about the boot rom version, we
// load the function table from the rom and are good from there.
// TODO: maybe support copying the table to ram as well?
const vtable = rom_table_lookup_fn(0xFFFF_FF13, 0x0000_0013);

// Helps lookup the ROM functions, it's setup in the runtime and will panic if
// not in the ROM table.
inline fn rom_table_lookup(c1: u8, c2: u8) u16 {
```

**Analysis**:

- **Purpose**: Optionally copy ROM function table to RAM for faster access
- **Why Incomplete**: Optimization not needed; adds complexity
- **Complexity**: Medium
- **Related Items**: ROM function performance, memory layout

**Recommendation**: Profile ROM access; implement if significant performance bottleneck found

---

### TODO #275: Is the signature correct?

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:64`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
    reset_to_usb_boot(0, 0);
    unreachable;
}

/// Resets the RP2040 and uses the watchdog facility to re-start in BOOTSEL mode
///
// TODO: Is the signature correct?
fn reset_to_usb_boot(gpio_activity_pin_mask: u32, disable_interface_mask: u32) void {
    const table_code = rom_table_lookup('U', 'B');
    const func: *const fn (u32, u32) callconv(.C) void = @ptrFromInt(rom_func_lookup(table_code));
    func(gpio_activity_pin_mask, disable_interface_mask);
}
```

**Analysis**:

- **Purpose**: Verify ROM function signature matches hardware implementation
- **Why Incomplete**: Documentation unclear or unchecked
- **Complexity**: Low
- **Related Items**: ROM API correctness

**Recommendation**: Test function with various parameters; verify against SDK documentation

---

### TODO #276: Is the signature correct?

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:66`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
/// Resets the RP2040 and uses the watchdog facility to re-start in BOOTSEL mode
///
// TODO: Is the signature correct?
fn reset_to_usb_boot(gpio_activity_pin_mask: u32, disable_interface_mask: u32) void {
    const table_code = rom_table_lookup('U', 'B');
    const func: *const fn (u32, u32) callconv(.C) void = @ptrFromInt(rom_func_lookup(table_code));
    func(gpio_activity_pin_mask, disable_interface_mask);
}

/// Supports a single 32-bit integer output for debugging
// TODO: Is the signature correct?
fn debug_trampoline() void {
    const table_code = rom_table_lookup('D', 'T');
```

**Analysis**:

- **Purpose**: Verify debug trampoline ROM function signature
- **Why Incomplete**: Duplicate of TODO #275 for different function
- **Complexity**: Low
- **Related Items**: TODO #275, ROM API correctness

**Recommendation**: Test and verify both functions together; document findings

---

### TODO #277: Is the signature correct?

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:195`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
//     return @intCast(@as(i64, value_a) * @as(i64, value_b) >> 32);
// }

// Fast Bit counting / manipulation
/// Returns the number of consecutive high order 0 bits of value. If value is zero, returns 32.
// TODO: Is the signature correct?
pub fn clz32(value: u32) u32 {
    const table_code = rom_table_lookup('L', 'Z');
    const func: *const fn (u32) callconv(.C) u32 = @ptrFromInt(rom_func_lookup(table_code));
    return @call(.always_inline, func, .{value});
}
```

**Analysis**:

- **Purpose**: Verify clz32 (count leading zeros) ROM function signature
- **Why Incomplete**: Same pattern as other ROM function signature checks
- **Complexity**: Low
- **Related Items**: TODO #275, #276, ROM API correctness

**Recommendation**: Test bit counting functions; verify signatures are correct

---

### TODO #278: Is the signature correct?

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:197`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
// Fast Bit counting / manipulation
/// Returns the number of consecutive high order 0 bits of value. If value is zero, returns 32.
// TODO: Is the signature correct?
pub fn clz32(value: u32) u32 {
    const table_code = rom_table_lookup('L', 'Z');
    const func: *const fn (u32) callconv(.C) u32 = @ptrFromInt(rom_func_lookup(table_code));
    return @call(.always_inline, func, .{value});
}

/// Returns the number of consecutive low order 0 bits of value. If value is zero, returns 32.
// TODO: Is the signature correct?
pub fn ctz32(value: u32) u32 {
    const table_code = rom_table_lookup('T', 'Z');
```

**Analysis**:

- **Purpose**: Verify ctz32 (count trailing zeros) ROM function signature
- **Why Incomplete**: Same pattern as other ROM function signature checks
- **Complexity**: Low
- **Related Items**: TODO #275-277, ROM API correctness

**Recommendation**: Test all bit manipulation ROM functions together; document correct signatures

---

### TODO #279: Could move the check into read/write and remove this struct

**Location**: `port/raspberrypi/rp2xxx/src/hal/i2c.zig:286`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: Could move the check into read/write and remove this struct
```

**Code Context**:
```zig
    };
}

/// This is a wrapper around the transfer function that adds an extra check to make
/// sure that start_write_then_read doesn't try to write and read at the same time.
/// Just make this read and write_then_read when the TODO is done.
// TODO: Could move the check into read/write and remove this struct
pub const ReadMode = struct {
    i2c: I2C,

    pub fn read(self: ReadMode, dst: []u8) !void {
        try transfer(self.i2c, &.{}, dst, true);
    }
```

**Analysis**:

- **Purpose**: Refactor I2C API to eliminate wrapper struct
- **Why Incomplete**: Current design works but could be simpler
- **Complexity**: Low
- **Related Items**: API design, code organization

**Recommendation**: Move validation into read/write functions; simplify API by removing wrapper

---

### TODO #280: Could there be an abort while waiting for the STOP

**Location**: `port/raspberrypi/rp2xxx/src/hal/i2c.zig:339`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
//     TODO Could there be an abort while waiting for the STOP
```

**Code Context**:
```zig
    //      Ignoring errors might not be such a good idea...
    //
    //     The linux driver does things differently (waits for abort bit to
    //     clear before reading abort reason). Figure out what this is all
    //     about
    //
    //     TODO Could there be an abort while waiting for the STOP
    //          condition to clear? With 10s of tight loops for each
    //          check, that would cause a hang. Why is there a timeout
    //          of 10s set in the Pico SDK? That seems excessively long.
    //     https://github.com/raspberrypi/pico-sdk/blob/2e6142b15b8a75c1227dd3edbe839193b2bf9041/src/rp2_common/hardware_i2c/i2c.c#L85
    //     There are examples of missing stop conditions https://github.com/raspberrypi/pico-sdk/issues/1031
```

**Analysis**:

- **Purpose**: Handle potential I2C abort during STOP condition
- **Why Incomplete**: Edge case error handling not fully addressed
- **Complexity**: Medium
- **Related Items**: I2C error handling, timeout handling

**Recommendation**: Add abort detection during STOP wait with proper timeout; study Pico SDK behavior

---

### TODO #281: RP2350 SDK masks this with a ROM function

**Location**: `port/raspberrypi/rp2xxx/src/hal/watchdog.zig:179`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
/// TODO: RP2350 SDK masks this with a ROM function:
```

**Code Context**:
```zig
    var scratch = std.mem.zeroes([8]u32);
    scratch[watchdog_hw.ScratchIndex.scratch4.ordinal] = std.mem.zeroes(u32);
    scratch[watchdog_hw.ScratchIndex.scratch5.ordinal] = saved_partition;
    scratch[watchdog_hw.ScratchIndex.scratch6.ordinal] = saved_permissions;
    scratch[watchdog_hw.ScratchIndex.scratch7.ordinal] = xor_ram ^ WATCHDOG_NON_REBOOT_MAGIC;

    /// TODO: RP2350 SDK masks this with a ROM function:
    ///       `rom_func_lookup(ROM_FUNC_SAVE_CURRENT_PARTITION_AND_PERMISSIONS_FOR_REBOOT`
    /// We'll just use it directly since it's not required (it's a workaround
    /// for something)
    if (compatibility.has_field(chip_peripherals.WATCHDOG, "WDSEL")) {
        watchdog_hw.WDSEL.write_raw(0);
    }
```

**Analysis**:

- **Purpose**: Use RP2350 ROM function for register masking
- **Why Incomplete**: Chip-specific optimization not implemented
- **Complexity**: Low
- **Related Items**: RP2350 compatibility, ROM functions

**Recommendation**: Add chip detection and use RP2350 ROM function when available for better compatibility

---

### TODO #282: CYW43 top level struct just for testing purpose (please redesign)

**Location**: `port/raspberrypi/rp2xxx/src/hal/drivers.zig:478`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: CYW43 top level struct just for testing purpose (please redesign)
```

**Code Context**:
```zig
        try ctx.bus_init();
        try runner.init(&ctx);
        try runner.setupWifi();

        return CYW43{
            .runner = runner,
        };
    }
};

// TODO: CYW43 top level struct just for testing purpose (please redesign)
pub const CYW43 = struct {
    runner: runners.SpiRunner,

    pub fn ioctl(self: *CYW43, cmd: sdpcm.CDC_Command, iface: u32, request: []const u8, response: []u8) !usize {
        return try self.runner.cdc_ioctl(cmd, iface, request, response);
    }
};
```

**Analysis**:

- **Purpose**: Redesign CYW43 wireless driver top-level API
- **Why Incomplete**: Current implementation is prototype/test quality
- **Complexity**: High
- **Related Items**: CYW43 wireless driver architecture

**Recommendation**: Design proper driver API with configuration management, error handling, and clear separation of concerns

---

### TODO #283: ensure only one instance of an input function exists

**Location**: `port/raspberrypi/rp2xxx/src/hal/pins.zig:875`  
**Author**: Matt Knight (2024-09-15)  
**Commit**: 89c4d580 - "port/raspberrypi: migrate to new build system"

**Original Comment**:
```
// TODO: ensure only one instance of an input function exists
```

**Code Context**:
```zig
            // @compileLog("configure pin", pin.name, "as", func.name, "with drive", drive);

            setFunction(pin, func);
            setDrive(pin, drive);
            setSchmitt(pin, schmitt);
            setSlew(pin, slew);

            if (func.isInput()) {
                setInputEnabled(pin, true);
                // TODO: ensure only one instance of an input function exists
            }

            if (func.direction() == .out) {
                setOutput(pin);
```

**Analysis**:

- **Purpose**: Prevent multiple GPIO pins from using same input function
- **Why Incomplete**: Validation not implemented
- **Complexity**: Low
- **Related Items**: Pin configuration validation, compile-time checks

**Recommendation**: Add compile-time or runtime check to prevent duplicate input function assignments

---
