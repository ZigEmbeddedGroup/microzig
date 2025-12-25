# TODO Analysis - Batch 17: [port]

**Batch Info**: Items 401-425 from TODO_INVENTORY.json

---

### TODO #401: Verbose exception handler

**Location**: `modules/riscv32-common/src/riscv32_common.zig:46`  
**Author**: Tudor Andrei Dicu (2025-04-27)  
**Commit**: 45ce6d556 - "RISCV32 common module (#503)"

**Original Comment**:
```
// TODO: Verbose exception handler
```

**Code Context**:
```zig
pub const interrupt = struct {
    pub fn globally_enabled() bool {
        return csr.mstatus.read().mie == 1;
    }

    pub fn enable_interrupts() void {
        csr.mstatus.set(.{ .mie = 1 });
    }

    pub fn disable_interrupts() void {
        csr.mstatus.clear(.{ .mie = 1 });
    }

    pub const core = utilities.interrupt.CoreImpl(CoreInterrupt);
};

// TODO: Verbose exception handler

pub fn nop() void {
    asm volatile ("nop");
}
```

**Analysis**:

- **Purpose**: Add a verbose exception handler for RISC-V 32-bit systems that provides detailed debugging information when exceptions occur
- **Why Incomplete**: This was part of the initial RISC-V common module implementation. The basic exception handling infrastructure was prioritized, but detailed exception reporting was deferred
- **Complexity**: Medium
- **Related Items**: Part of the broader RISC-V support infrastructure

**Recommendation**: Implement a verbose exception handler that prints exception type, register state, and stack trace information to aid in debugging RISC-V applications

---

### TODO #402: Supervisor level CSRs

**Location**: `modules/riscv32-common/src/riscv32_common.zig:130`  
**Author**: Tudor Andrei Dicu (2025-04-27)  
**Commit**: 45ce6d556 - "RISCV32 common module (#503)"

**Original Comment**:
```
// TODO: supervisor level csrs
```

**Code Context**:
```zig
pub const cycleh = Csr(0xC80, u32);
pub const timeh = Csr(0xC81, u32);
pub const instreth = Csr(0xC82, u32);
// ... more user-level CSRs ...

// TODO: supervisor level csrs

pub const mvendorid = Csr(0xF11, u32);
pub const marchid = Csr(0xF12, u32);
// ... machine-level CSRs ...
```

**Analysis**:

- **Purpose**: Add Control and Status Register (CSR) definitions for supervisor-level RISC-V operations
- **Why Incomplete**: The initial implementation focused on machine-level and user-level CSRs. Supervisor-level CSRs are needed for more advanced OS-level functionality
- **Complexity**: Low
- **Related Items**: Part of the RISC-V CSR infrastructure

**Recommendation**: Add supervisor-level CSR definitions (sstatus, sie, stvec, sscratch, sepc, scause, stval, sip, satp, etc.) following the RISC-V specification

---

### TODO #403: RTT example reference

**Location**: `modules/rtt/README.md:79`  
**Author**: Grazfather (2025-09-26)  
**Commit**: 9bfebda3a - "Update RTT to new std.Io interfaces (#675)"

**Original Comment**:
```
See the [example](../../examples/raspberrypi/rp2xxx/src/rtt_log.zig) for more information on using
```

**Code Context**:
```markdown
- `fn reader(comptime channel_number: usize, buf: []u8) Reader` returns a struct that implements the
  `std.Io.Reader` interface for a specific down channel. See implementation and doc comments for
  more information on choosing a buffer.

See the [example](../../examples/raspberrypi/rp2xxx/src/rtt_log.zig) for more information on using
this package.

## TODO:
- Support for CPUs with caches (cache alignment + cache access considerations) to mirror the
```

**Analysis**:

- **Purpose**: This is actually a documentation reference, not a TODO item - it's pointing to an example file
- **Why Incomplete**: This appears to be misclassified as a TODO when it's actually documentation
- **Complexity**: N/A
- **Related Items**: RTT documentation

**Recommendation**: This should be reclassified as documentation rather than a TODO item

---

### TODO #404: RTT TODO section

**Location**: `modules/rtt/README.md:82`  
**Author**: haydenridd (2025-06-30)  
**Commit**: d45563968 - "Added RTT (#612)"

**Original Comment**:
```
## TODO:
```

**Code Context**:
```markdown
See the [example](../../examples/raspberrypi/rp2xxx/src/rtt_log.zig) for more information on using
this package.

## TODO:
- Support for CPUs with caches (cache alignment + cache access considerations) to mirror the
  `SEGGER_RTT_CPU_CACHE_LINE_SIZE` and `SEGGER_RTT_UNCACHED_OFF` macros in original Segger source
- Support for virtual terminals supported by RTT viewer
- Support for ANSI terminal color escape codes supported by RTT viewer
- Compile time option for returning a `WriteError` from `Writer` when attempting to write a full RTT
  buffer
```

**Analysis**:

- **Purpose**: This is a section header for the TODO list in RTT documentation
- **Why Incomplete**: This is documentation structure, not an actual TODO item
- **Complexity**: N/A
- **Related Items**: RTT documentation structure

**Recommendation**: This should be reclassified as documentation structure rather than a TODO item

---

### TODO #405: RTT WriteError build option

**Location**: `modules/rtt/src/rtt.zig:236`  
**Author**: haydenridd (2025-09-23)  
**Commit**: 1f9e1cf2e - "Update RTT to new std.Io interfaces (#675)"

**Original Comment**:
```
/// TODO: build.zig option that allows users to opt-in to returning WriteError on full RTT buffer?
```

**Code Context**:
```zig
/// Implements drain for the Io.Writer interface. Note that this will drop data if it can't all fit
/// in the RTT Up channel buffer. This is to prevent constantly returning a WriteError when a debug
/// probe isn't connected.
///
/// TODO: build.zig option that allows users to opt-in to returning WriteError on full RTT buffer?
fn drain(io_w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
    const up: *Self = @as(*Writer, @alignCast(@fieldParentPtr("interface", io_w))).up_channel;

    const buffered = io_w.buffered();
    if (buffered.len > 0) {
        up.write_allow_dropped_data(buffered);
        _ = io_w.consumeAll();
    }
```

**Analysis**:

- **Purpose**: Add a build-time configuration option to control RTT Writer behavior when the buffer is full
- **Why Incomplete**: The current implementation silently drops data to prevent errors when no debug probe is connected. Some users might prefer explicit error handling
- **Complexity**: Medium
- **Related Items**: RTT Writer interface, build system configuration

**Recommendation**: Add a build.zig option to configure RTT Writer error behavior, allowing users to choose between silent data dropping and explicit WriteError returns

---

### TODO #406: RTT channel mode relevance

**Location**: `modules/rtt/src/rtt.zig:318`  
**Author**: haydenridd (2025-06-30)  
**Commit**: d45563968 - "Added RTT (#612)"

**Original Comment**:
```
/// TODO: Does the channel's mode actually matter here?
```

**Code Context**:
```zig
/// Reads up to a number of bytes from probe non-blocking. Reading less than the requested number of bytes
/// is not an error.
///
/// TODO: Does the channel's mode actually matter here?
pub fn read_available(self: *Self, bytes: []u8) usize {
    exclusive_access.lock_fn(exclusive_access.context);
    defer exclusive_access.unlock_fn(exclusive_access.context);

    // The probe can change self.write_offset via memory modification at any time,
    // so must perform a volatile read on this value.
    const write_offset = @as(*volatile usize, @ptrCast(&self.write_offset)).*;
```

**Analysis**:

- **Purpose**: Clarify whether RTT channel modes (NoBlockSkip, NoBlockTrim, BlockIfFull) should affect read operations
- **Why Incomplete**: The RTT specification and behavior for read operations with different channel modes needs clarification
- **Complexity**: Low
- **Related Items**: RTT channel mode implementation

**Recommendation**: Research RTT specification to determine if channel modes affect read operations and implement appropriate behavior or document why modes don't apply to reads

---

### TODO #407: ESP32-C3 memory protection alignment

**Location**: `port/espressif/esp/ld/esp32_c3/image_boot_sections.ld:51`  
**Author**: Tudor Andrei Dicu (2025-06-18)  
**Commit**: dd8544d09 - "Linker script generation update (#588)"

**Original Comment**:
```
/* TODO: in the case of memory protection there should be some alignment
 * and offset done here (NOLOAD) */
```

**Code Context**:
```ld
.ram.text :
{
    KEEP(*(.ram_text))

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
} > IRAM

.ram_data_dummy (NOLOAD) :
{
    . = ALIGN(ALIGNOF(.ram.text)) + SIZEOF(.ram.text);
} > DRAM
```

**Analysis**:

- **Purpose**: Add proper memory alignment and offset handling for ESP32-C3 memory protection features
- **Why Incomplete**: Memory protection features require specific alignment constraints that weren't implemented in the initial linker script
- **Complexity**: Medium
- **Related Items**: ESP32-C3 memory protection, linker script generation

**Recommendation**: Research ESP32-C3 memory protection requirements and implement appropriate alignment and offset handling in the linker script

---

### TODO #408: ESP32-C3 ROM function hack

**Location**: `port/espressif/esp/ld/esp32_c3/rom_functions.ld:411`  
**Author**: Tudor Andrei Dicu (2025-05-19)  
**Commit**: a59b5c4e4 - "esp: join cpu and add rom functions (#552)"

**Original Comment**:
```
r_lld_init_start_hack = 0x400011a4;
```

**Code Context**:
```ld
/* ble functions rename */
r_lld_init_start_hack = 0x400011a4;

/* ble functions disable */
/*
r_lld_adv_frm_isr_eco = 0x40001d00;
r_lld_res_list_clear = 0x40004638;
```

**Analysis**:

- **Purpose**: This appears to be a temporary workaround for a Bluetooth Low Energy function in the ESP32-C3 ROM
- **Why Incomplete**: The "hack" suffix suggests this is a temporary solution that needs proper implementation
- **Complexity**: Medium
- **Related Items**: ESP32-C3 Bluetooth functionality, ROM function mapping

**Recommendation**: Investigate the proper implementation for this BLE function and replace the hack with a proper solution

---

### TODO #409: ESP32-C3 better exception handler

**Location**: `port/espressif/esp/src/cpus/esp_riscv.zig:365`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: make a better default exception handler
```

**Code Context**:
```zig
fn _vector_table() align(256) linksection(".ram_text") callconv(.naked) void {
    comptime {
        // TODO: make a better default exception handler
        @export(
            microzig.options.interrupts.Exception orelse &unhandled,
            .{ .name = "_exception_handler" },
        );

        for (std.meta.fieldNames(Interrupt)) |field_name| {
            @export(
                @field(microzig.options.interrupts, field_name) orelse &unhandled,
                .{ .name = std.fmt.comptimePrint("_{s}_handler", .{field_name}) },
            );
        }
```

**Analysis**:

- **Purpose**: Improve the default exception handler for ESP32-C3 RISC-V CPU to provide better debugging information
- **Why Incomplete**: The current unhandled exception handler is basic and was implemented as part of the initial ESP32-C3 interrupt system. A more comprehensive handler was planned but deferred
- **Complexity**: Medium
- **Related Items**: ESP32-C3 interrupt handling, RISC-V exception handling

**Recommendation**: Enhance the default exception handler to provide detailed register dumps, stack traces, and ESP32-C3-specific debugging information

---

### TODO #410: ESP32-C3 HAL watchdog disable

**Location**: `port/espressif/esp/src/hal.zig:50`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: disable watchdogs in a more elegant way (with a hal).
```

**Code Context**:
```zig
pub fn init() void {
    // TODO: disable watchdogs in a more elegant way (with a hal).
    microzig.chip.peripherals.RTC_CNTL.WDTCONFIG0.modify(.{ .WDT_EN = 0 });
    microzig.chip.peripherals.TIMG0.WDTCONFIG0.modify(.{ .WDT_EN = 0 });
    microzig.chip.peripherals.TIMG1.WDTCONFIG0.modify(.{ .WDT_FLASHBOOT_MOD_EN = 0 });
}
```

**Analysis**:

- **Purpose**: Replace direct register manipulation with a proper HAL interface for watchdog management
- **Why Incomplete**: The initial implementation used direct register access for simplicity. A proper HAL abstraction was planned for better code organization
- **Complexity**: Low
- **Related Items**: ESP32-C3 HAL design, watchdog timer management

**Recommendation**: Create a watchdog HAL module with proper enable/disable/configure functions and replace the direct register manipulation

---

### TODO #411: ESP32-C3 clock source support

**Location**: `port/espressif/esp/src/hal/clocks/esp32_c3.zig:33`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: add support for rc_fast_clk source
```

**Code Context**:
```zig
pub const ClockConfig = struct {
    sys: SysClockConfig,
    apb: ApbClockConfig,
    
    // TODO: add support for rc_fast_clk source
    
    pub fn apply(self: ClockConfig) void {
        self.sys.apply();
        self.apb.apply();
    }
};
```

**Analysis**:

- **Purpose**: Add support for the RC fast clock source in ESP32-C3 clock configuration
- **Why Incomplete**: Initial clock implementation focused on the most common clock sources. RC fast clock support was deferred
- **Complexity**: Medium
- **Related Items**: ESP32-C3 clock system, power management

**Recommendation**: Implement RC fast clock source configuration including frequency calculation and switching logic

---

### TODO #412: ESP32-C3 SPI HAL writev_then_readv

**Location**: `port/espressif/esp/src/hal/drivers.zig:197`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: When writev_then_readv_blocking is implemented in the HAL, use that.
```

**Code Context**:
```zig
pub fn writev_then_readv_blocking(self: *Self, write_buffers: []const []const u8, read_buffers: [][]u8) !void {
    // TODO: When writev_then_readv_blocking is implemented in the HAL, use that.
    for (write_buffers) |buffer| {
        try self.write_blocking(buffer);
    }
    for (read_buffers) |buffer| {
        try self.read_blocking(buffer);
    }
}
```

**Analysis**:

- **Purpose**: Replace the current sequential write/read implementation with a proper HAL function that can optimize the combined operation
- **Why Incomplete**: The SPI HAL was implemented with basic read/write functions. The combined operation was implemented as a workaround
- **Complexity**: Medium
- **Related Items**: ESP32-C3 SPI HAL, SPI driver optimization

**Recommendation**: Implement a proper writev_then_readv_blocking function in the SPI HAL that can optimize the combined write/read operation

---

### TODO #413: ESP32-C3 GPIO matrix bypass

**Location**: `port/espressif/esp/src/hal/gpio.zig:292`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: bypass gpio matrix
```

**Code Context**:
```zig
pub fn set_as_input(self: Pin, pull: Pull) void {
    self.set_pull(pull);
    self.iomux_reg().modify(.{ .FUN_IE = 1 });
    
    // TODO: bypass gpio matrix
    self.connect_input_to_peripheral(0x30, false);
}
```

**Analysis**:

- **Purpose**: Implement GPIO matrix bypass for direct pin connections to improve performance
- **Why Incomplete**: The initial GPIO implementation used the GPIO matrix for all connections. Direct bypass was planned for optimization
- **Complexity**: Medium
- **Related Items**: ESP32-C3 GPIO system, performance optimization

**Recommendation**: Implement GPIO matrix bypass functionality for direct pin-to-peripheral connections where applicable

---

### TODO #414: ESP32-C3 GPIO matrix bypass (output)

**Location**: `port/espressif/esp/src/hal/gpio.zig:309`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: bypass gpio matrix
```

**Code Context**:
```zig
pub fn set_as_output(self: Pin) void {
    self.iomux_reg().modify(.{ .FUN_IE = 0 });
    
    // TODO: bypass gpio matrix
    self.connect_output_to_peripheral(0x80, false, false);
}
```

**Analysis**:

- **Purpose**: Implement GPIO matrix bypass for output pins
- **Why Incomplete**: Same as input bypass - planned optimization not yet implemented
- **Complexity**: Medium
- **Related Items**: ESP32-C3 GPIO system, performance optimization

**Recommendation**: Implement GPIO matrix bypass for output pins to complement the input bypass functionality

---

### TODO #415: ESP32-C3 I2C clock frequency

**Location**: `port/espressif/esp/src/hal/i2c.zig:12`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: How and why. Is this xtal? That clock is 40_000_000 according to the hal
```

**Code Context**:
```zig
const I2C_CLK_FREQ_HZ = 80_000_000;

// TODO: How and why. Is this xtal? That clock is 40_000_000 according to the hal
```

**Analysis**:

- **Purpose**: Clarify and correct the I2C clock frequency value for ESP32-C3
- **Why Incomplete**: There's uncertainty about the correct clock frequency value and its source
- **Complexity**: Low
- **Related Items**: ESP32-C3 clock system, I2C timing

**Recommendation**: Research the ESP32-C3 documentation to determine the correct I2C clock frequency and its source, then update the constant accordingly

---

### TODO #416: ESP32-C3 I2C timeout handling

**Location**: `port/espressif/esp/src/hal/i2c.zig:170`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: Take timeout as extra arg and handle saturation?
```

**Code Context**:
```zig
fn set_timeout(self: *Self, timeout_cycles: u32) void {
    // TODO: Take timeout as extra arg and handle saturation?
    self.i2c.TO.write(.{ .TIME_OUT_REG = timeout_cycles });
}
```

**Analysis**:

- **Purpose**: Improve I2C timeout handling with proper parameter validation and saturation handling
- **Why Incomplete**: Basic timeout functionality was implemented, but proper parameter handling was deferred
- **Complexity**: Low
- **Related Items**: ESP32-C3 I2C driver, error handling

**Recommendation**: Add timeout parameter validation and saturation handling to prevent invalid timeout values

---

### TODO #417: ESP32-C3 I2C read byte limit

**Location**: `port/espressif/esp/src/hal/i2c.zig:507`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: Maybe we don't need 31 byte limit for reads
```

**Code Context**:
```zig
pub fn read_blocking(self: *Self, address: u7, buffer: []u8) !void {
    if (buffer.len == 0) return;
    
    // TODO: Maybe we don't need 31 byte limit for reads
    if (buffer.len > 31) return error.BufferTooLarge;
```

**Analysis**:

- **Purpose**: Investigate and potentially remove the 31-byte limit for I2C read operations
- **Why Incomplete**: The limit was implemented conservatively, but may not be necessary for all cases
- **Complexity**: Medium
- **Related Items**: ESP32-C3 I2C hardware limitations, buffer management

**Recommendation**: Research ESP32-C3 I2C hardware capabilities to determine if the 31-byte limit can be removed or increased

---

### TODO #418: ESP32-C3 I2C utility function

**Location**: `port/espressif/esp/src/hal/i2c.zig:580`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: Write a new utility that does similar but that will coalesce into a specified size
```

**Code Context**:
```zig
fn write_bytes_to_fifo(self: *Self, bytes: []const u8) void {
    // TODO: Write a new utility that does similar but that will coalesce into a specified size
    for (bytes) |byte| {
        self.i2c.DATA.write(.{ .FIFO_RDATA = byte });
    }
}
```

**Analysis**:

- **Purpose**: Create a more efficient utility function that can coalesce multiple bytes into larger writes
- **Why Incomplete**: The current implementation writes bytes individually, which could be optimized
- **Complexity**: Medium
- **Related Items**: ESP32-C3 I2C performance, FIFO management

**Recommendation**: Implement a utility function that can write multiple bytes efficiently, potentially using word-sized writes where possible

---

### TODO #419: ESP32-C3 SPI chip select support

**Location**: `port/espressif/esp/src/hal/spi.zig:29`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: add support for peripheral controlled chip select pins
```

**Code Context**:
```zig
pub const Config = struct {
    clock_config: ClockConfig,
    
    // TODO: add support for peripheral controlled chip select pins
    
    pub fn apply(self: Config, spi: SPI) void {
        self.clock_config.apply(spi);
    }
};
```

**Analysis**:

- **Purpose**: Add support for hardware-controlled chip select pins in SPI configuration
- **Why Incomplete**: Initial SPI implementation used manual chip select control. Hardware control was planned for better timing
- **Complexity**: Medium
- **Related Items**: ESP32-C3 SPI hardware features, chip select timing

**Recommendation**: Implement peripheral-controlled chip select functionality to improve SPI timing and reduce CPU overhead

---

### TODO #420: ESP32-C3 SPI packed type return

**Location**: `port/espressif/esp/src/hal/spi.zig:51`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: we can return directly the packed type if we add some patches
```

**Code Context**:
```zig
fn get_clock_config(spi: SPI) ClockConfig {
    // TODO: we can return directly the packed type if we add some patches
    const reg = spi.CLOCK.read();
    return ClockConfig{
        .clk_equ_sysclk = reg.CLK_EQU_SYSCLK,
        .clkdiv_pre = reg.CLKDIV_PRE,
        .clkcnt_n = reg.CLKCNT_N,
    };
}
```

**Analysis**:

- **Purpose**: Optimize the function to return the packed register type directly instead of manual field copying
- **Why Incomplete**: Requires some patches or changes to the register generation to support direct packed type returns
- **Complexity**: Low
- **Related Items**: Register generation system, code optimization

**Recommendation**: Investigate the required patches to enable direct packed type returns and implement them for better performance

---

### TODO #421: ESP32-C3 SPI implementation clarity

**Location**: `port/espressif/esp/src/hal/spi.zig:163`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: not sure if this is the best way to do this
```

**Code Context**:
```zig
pub fn transfer_blocking(self: *Self, write_buffer: []const u8, read_buffer: []u8) !void {
    // TODO: not sure if this is the best way to do this
    if (write_buffer.len != read_buffer.len) {
        return error.BufferLengthMismatch;
    }
    
    try self.write_blocking(write_buffer);
    try self.read_blocking(read_buffer);
}
```

**Analysis**:

- **Purpose**: Review and potentially improve the SPI transfer implementation
- **Why Incomplete**: The current implementation was done quickly and may not be optimal
- **Complexity**: Medium
- **Related Items**: ESP32-C3 SPI driver design, transfer optimization

**Recommendation**: Review the SPI transfer implementation and optimize for better performance, potentially using simultaneous read/write operations

---

### TODO #422: ESP32-C3 system timer naming

**Location**: `port/espressif/esp/src/hal/systimer.zig:30`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: Not sure how this should be called.
```

**Code Context**:
```zig
pub fn get_counter_value() u64 {
    // TODO: Not sure how this should be called.
    const systimer = microzig.chip.peripherals.SYSTIMER;
    
    systimer.UNIT0_OP.write(.{ .TIMER_UNIT0_UPDATE = 1 });
    while (systimer.UNIT0_OP.read().TIMER_UNIT0_UPDATE == 1) {}
    
    const lo = systimer.UNIT0_VALUE_LO.read().TIMER_UNIT0_VALUE_LO;
    const hi = systimer.UNIT0_VALUE_HI.read().TIMER_UNIT0_VALUE_HI;
    
    return (@as(u64, hi) << 32) | lo;
}
```

**Analysis**:

- **Purpose**: Determine the appropriate name for the system timer counter value function
- **Why Incomplete**: Uncertainty about the best naming convention for this function
- **Complexity**: Low
- **Related Items**: ESP32-C3 system timer API design, naming conventions

**Recommendation**: Review similar functions in other HALs and choose a consistent naming convention, such as `get_counter_value` or `read_counter`

---

### TODO #423: ESP32-C3 UART chip independence

**Location**: `port/espressif/esp/src/hal/uart.zig:5`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: chip independent. currently specific to esp32c3.
```

**Code Context**:
```zig
//! UART HAL for ESP32-C3
//! 
//! TODO: chip independent. currently specific to esp32c3.

const std = @import("std");
const microzig = @import("microzig");
```

**Analysis**:

- **Purpose**: Make the UART HAL implementation chip-independent to support other ESP32 variants
- **Why Incomplete**: Initial implementation was ESP32-C3 specific for simplicity. Generalization was planned for later
- **Complexity**: High
- **Related Items**: ESP32 family support, HAL architecture

**Recommendation**: Refactor the UART HAL to support multiple ESP32 chips by abstracting chip-specific differences

---

### TODO #424: ESP32-C3 USB serial JTAG timestamp

**Location**: `port/espressif/esp/src/hal/usb_serial_jtag.zig:86`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: add timestamp to log message
```

**Code Context**:
```zig
pub fn log(
    comptime message_level: std.log.Level,
    comptime scope: @Type(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    // TODO: add timestamp to log message
    const level_txt = comptime message_level.asText();
    const prefix2 = if (scope == .default) ": " else "(" ++ @tagName(scope) ++ "): ";
    
    print(level_txt ++ prefix2 ++ format ++ "\r\n", args);
}
```

**Analysis**:

- **Purpose**: Add timestamp information to USB serial JTAG log messages for better debugging
- **Why Incomplete**: Basic logging was implemented first, timestamp support was deferred
- **Complexity**: Low
- **Related Items**: ESP32-C3 logging system, debugging features

**Recommendation**: Implement timestamp functionality using the system timer and add it to log message formatting

---

### TODO #425: GD32 board implementation

**Location**: `port/gigadevice/gd32/src/boards/longan_nano.zig:110`  
**Author**: Tudor Andrei Dicu (2025-04-09)  
**Commit**: 7b4645e89 - "esp32-c3: interrupts and clock configuration (#435)"

**Original Comment**:
```
// TODO: implement
```

**Code Context**:
```zig
pub fn debugWrite(string: []const u8) void {
    // TODO: implement
    _ = string;
}
```

**Analysis**:

- **Purpose**: Implement debug write functionality for the Longan Nano board
- **Why Incomplete**: The board support was added but debug output functionality was not implemented
- **Complexity**: Medium
- **Related Items**: GD32 board support, debugging infrastructure

**Recommendation**: Implement debug write functionality using UART or other available communication interface on the Longan Nano board

---

</content>
