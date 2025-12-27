# TODO Analysis - Batch 04: modules

**Batch Information**: Items 305, 135-158 from TODO_INVENTORY.json  
**Directory Focus**: modules/ and various port/ subdirectories  
**Total TODOs**: 25  
**Analysis Date**: 2024-12-26

---

## Summary

This batch covers TODOs primarily in:
- RISC-V common module (1 TODO)
- Nordic nRF5x port (18 TODOs) 
- NXP LPC port (2 TODOs)
- WCH CH32V port (4 TODOs)

The TODOs range from missing hardware abstraction features to optimization opportunities and incomplete driver implementations.

---

### TODO #305: Add supervisor level CSR definitions

**Location**: `modules/riscv32-common/src/riscv32_common.zig:130`  
**Author**: Matt Knight (2024-10-29)  
**Commit**: 6b9efa50 - "add riscv32 common cpu module"

**Original Comment**:
```zig
// TODO: supervisor level csrs
```

**Code Context**:
```zig
    pub const hpmcounter30h = Csr(0xC9E, u32);
    pub const hpmcounter31h = Csr(0xC9F, u32);

    // TODO: supervisor level csrs

    pub const mvendorid = Csr(0xF11, u32);
    pub const marchid = Csr(0xF12, u32);
    pub const mimpid = Csr(0xF13, u32);
    pub const mhartid = Csr(0xF14, u32);
    pub const mconfigptr = Csr(0xF15, u32);
```

**Analysis**:

- **Purpose**: Add Control and Status Register (CSR) definitions for RISC-V supervisor privilege level
- **Why Incomplete**: The initial riscv32-common module focused on machine-level CSRs first. Supervisor CSRs are only needed when running operating systems with privilege separation
- **Complexity**: Low - Straightforward additions following the existing Csr() pattern for addresses 0x100-0x1FF range
- **Related Items**: None nearby

**Recommendation**: Add supervisor CSR definitions (sstatus, sie, stvec, sscratch, sepc, scause, stval, sip, satp) when needed for OS-level projects. This is a low-priority enhancement since most embedded systems run at machine level only.

---

### TODO #135: Use code RAM for .ram_text section

**Location**: `port/nordic/nrf5x/build.zig:123`  
**Author**: Brendan Hedges (2024-11-06)  
**Commit**: ad2e8e89 - "update some file names"

**Original Comment**:
```zig
// TODO: use code ram for `.ram_text`
```

**Code Context**:
```zig
        .memory_regions = &.{
            MemoryRegion{ .offset = 0x00000000, .length = config.flash_size, .kind = .flash },
            MemoryRegion{ .offset = 0x20000000, .length = config.ram_size, .kind = .ram },
        },

        // TODO: use code ram for `.ram_text`
    };
}
```

**Analysis**:

- **Purpose**: Configure Nordic chips to use dedicated code RAM region for performance-critical code
- **Why Incomplete**: Nordic nRF5x chips have separate code RAM (faster than flash) but basic memory layout was prioritized first
- **Complexity**: Medium - Requires understanding chip-specific memory map and linker script modifications
- **Related Items**: None nearby

**Recommendation**: Add third memory region for code RAM when implementing performance-critical applications. Nordic chips support executing code from RAM for zero-wait-state performance.

---

### TODO #136: Implement UARTE0 DMA-based UART

**Location**: `port/nordic/nrf5x/src/hal/uart.zig:8`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: UARTE0? Does DMA, just set rxd.ptr or txd.ptr. UART0 is deprecated (but still works?) on nRF52840
```

**Code Context**:
```zig
const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

// Note: Most Nordic chips have two separate UART peripherals: UART and UARTE
// UART is the older one, UARTE adds EasyDMA support
// TODO: UARTE0? Does DMA, just set rxd.ptr or txd.ptr. UART0 is deprecated (but still works?) on nRF52840

pub fn Uart(comptime index: usize) type {
```

**Analysis**:

- **Purpose**: Implement UARTE peripheral with EasyDMA support for efficient UART communication
- **Why Incomplete**: Initial implementation used legacy UART0 for simplicity; UARTE requires DMA setup
- **Complexity**: Medium - Needs DMA buffer management and EasyDMA peripheral configuration
- **Related Items**: None nearby

**Recommendation**: Implement UARTE variant for newer Nordic chips (nRF52+). The UARTE peripheral is more efficient and recommended by Nordic for new designs.

---

### TODO #137: Support configurable STOP bits on nRF52840

**Location**: `port/nordic/nrf5x/src/hal/uart.zig:65`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: On 52840 the CONFIG register has 1 bit for STOP bits
```

**Code Context**:
```zig
            const baud_rate: u32 = @intFromEnum(config.baud_rate);
            self.regs.BAUDRATE.write(.{ .BAUDRATE = baud_rate });

            // TODO: On 52840 the CONFIG register has 1 bit for STOP bits
            // But we only support 1 stop bit for now, and 1 stop bit is default
            // so we can just leave it.
            const parity_include: u1 = if (config.parity == .none) 0 else 1;
            const parity_type: u3 = switch (config.parity) {
```

**Analysis**:

- **Purpose**: Add support for 2 stop bits configuration on nRF52840
- **Why Incomplete**: Default 1 stop bit works for most use cases; 2 stop bits rarely needed
- **Complexity**: Low - Simple register bit configuration
- **Related Items**: Related to TODO #138 about optional pins

**Recommendation**: Add when 2-stop-bit support is requested. Low priority since 1 stop bit is standard for most protocols.

---

### TODO #138: Make RX/TX pins optional for UART

**Location**: `port/nordic/nrf5x/src/hal/uart.zig:122`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Make these optional... could have rx only for example
```

**Code Context**:
```zig
            peripherals.GPIO.P0.OUTSET.write(.{ .PIN = pins.tx.mask() });
            pins.tx.set_direction(.output);

            // TODO: Make these optional... could have rx only for example
            self.regs.PSELTXD.write(.{ .PIN = @intCast(pins.tx.num), .CONNECT = 0 });
            self.regs.PSELRXD.write(.{ .PIN = @intCast(pins.rx.num), .CONNECT = 0 });

            // CTS and RTS are optional
```

**Analysis**:

- **Purpose**: Allow UART to be configured with only TX or only RX pin for simplex communication
- **Why Incomplete**: Full-duplex is most common; simplex support deferred
- **Complexity**: Low - Use optional pin parameters and conditional register writes
- **Related Items**: None nearby

**Recommendation**: Add optional pin support when implementing simplex UART applications (e.g., transmit-only logging, receive-only data collection).

---

### TODO #139: Move I2C validity check into read/write methods

**Location**: `port/nordic/nrf5x/src/hal/i2c.zig:185`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Could move the check into read/write and remove this struct
```

**Code Context**:
```zig
    };
}

// TODO: Could move the check into read/write and remove this struct
const ValidatedDevice = struct {
    addr: u7,
    bus: *Bus,
```

**Analysis**:

- **Purpose**: Simplify I2C device structure by moving validation into methods
- **Why Incomplete**: Current design works; refactoring is optimization
- **Complexity**: Low - Simple refactoring task
- **Related Items**: None nearby

**Recommendation**: Refactor when redesigning I2C API. This is a minor code cleanup that doesn't affect functionality.

---

### TODO #140: Make SPIM frequency chip-specific

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:79`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Chip-specific
```

**Code Context**:
```zig
    pub const Frequency = enum(u32) {
        k125 = 0x02000000,
        k250 = 0x04000000,
        k500 = 0x08000000,
        m1 = 0x10000000,
        m2 = 0x20000000,
        m4 = 0x40000000,
        // TODO: Chip-specific
        m8 = 0x80000000,
        m16 = 0x0A000000,
        m32 = 0x14000000,
    };
```

**Analysis**:

- **Purpose**: Make higher SPI frequencies (8/16/32 MHz) available only on chips that support them
- **Why Incomplete**: Not all nRF5x chips support all frequencies; needs chip-dependent enum
- **Complexity**: Low - Use conditional compilation based on chip type
- **Related Items**: None nearby

**Recommendation**: Use comptime chip detection to include only supported frequencies. Prevents runtime errors from invalid frequency selection.

---

### TODO #141: Determine if MOSI idle state changes with configuration

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:113`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Does MOSI idle change here?
```

**Code Context**:
```zig
            peripherals.GPIO.P0.OUTCLR.write(.{ .PIN = pins.mosi.mask() });
            pins.mosi.set_direction(.output);

            // TODO: Does MOSI idle change here?
            peripherals.GPIO.P0.PIN_CNF[@intCast(pins.sck.num)].write(.{
                .DIR = 1,
                .INPUT = 0,
```

**Analysis**:

- **Purpose**: Clarify if MOSI pin idle level needs to be configured based on SPI mode
- **Why Incomplete**: Unclear from documentation if configuration affects idle state
- **Complexity**: Low - Requires testing or Nordic documentation review
- **Related Items**: None nearby

**Recommendation**: Test with oscilloscope or logic analyzer to verify MOSI idle behavior, or consult Nordic technical support. Document findings.

---

### TODO #142: Handle DMA limitations for Flash memory

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:256`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: DMA won't work if they are trying to copy from Flash (e.g. program memory). In that
```

**Code Context**:
```zig
            try self.wait_for_end(timeout);
        }

        // TODO: DMA won't work if they are trying to copy from Flash (e.g. program memory). In that
        //       case, we would need to copy the data to RAM first.
        pub fn transceive_blocking(self: *Self, tx_buffer: []const u8, rx_buffer: []u8, timeout: ?u32) Error!void {
            if (tx_buffer.len != rx_buffer.len) {
                return Error.InvalidLength;
```

**Analysis**:

- **Purpose**: Add check and workaround for DMA accessing Flash memory (which is invalid on Nordic chips)
- **Why Incomplete**: Most use cases have data in RAM; Flash DMA case is edge case
- **Complexity**: Medium - Requires buffer address checking and temporary RAM buffer allocation
- **Related Items**: None nearby

**Recommendation**: Add address range check and automatic RAM buffer for Flash data. Important for const string transmission and similar use cases.

---

### TODO #143: Handle SPIM task stop on timeout

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:285`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Do we have to stop the task on timeout?
```

**Code Context**:
```zig
                    return Error.Timeout;
                }
            }

            // TODO: Do we have to stop the task on timeout?
            self.regs.EVENTS_END.write(.{ .EVENTS_END = 0 });
        }
    };
```

**Analysis**:

- **Purpose**: Determine if SPI task needs explicit stop command on timeout to avoid hung state
- **Why Incomplete**: Timeout handling path not fully tested
- **Complexity**: Low - Add TASKS_STOP write if needed
- **Related Items**: None nearby

**Recommendation**: Test timeout scenarios and add TASKS_STOP if hardware can hang. Consult Nordic reference manual section on error recovery.

---

### TODO #144: Encode package info in GPIO pin type

**Location**: `port/nordic/nrf5x/src/hal/gpio.zig:46`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Do we want to follow the rp2350 design where we encode the package
```

**Code Context**:
```zig
    pub fn num(self: Pin) u5 {
        return @intCast(self.source & 0x1f);
    }

    // TODO: Do we want to follow the rp2350 design where we encode the package
    //       in the pin type? It would prevent accidentally using QFN pins with WLCSP package...
    //       But it also makes the code a lot more verbose.
    // TODO: Add support for LATCH, DETECTMODE
    pub const Config = extern struct {
        dir: Direction = .input,
```

**Analysis**:

- **Purpose**: Consider encoding package type in Pin type for compile-time package validation
- **Why Incomplete**: Design decision deferred - balancing safety vs. simplicity
- **Complexity**: Medium - Requires Pin type redesign and affects all HAL code
- **Related Items**: TODO #145 about LATCH and DETECTMODE support

**Recommendation**: Consider this enhancement if package mismatches become a common issue. The rp2350 approach provides strong typing but increases verbosity.

---

### TODO #145: Add LATCH and DETECTMODE GPIO support

**Location**: `port/nordic/nrf5x/src/hal/gpio.zig:50`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Add support for LATCH, DETECTMODE
```

**Code Context**:
```zig
    // TODO: Do we want to follow the rp2350 design where we encode the package
    //       in the pin type? It would prevent accidentally using QFN pins with WLCSP package...
    //       But it also makes the code a lot more verbose.
    // TODO: Add support for LATCH, DETECTMODE
    pub const Config = extern struct {
        dir: Direction = .input,
        input: enum(u1) {
            connect = 0,
```

**Analysis**:

- **Purpose**: Add support for pin latching and PORT event detection modes
- **Why Incomplete**: Basic GPIO functionality prioritized; advanced features deferred
- **Complexity**: Low - Add fields to Config struct and handle in configuration code
- **Related Items**: Related to TODO #144

**Recommendation**: Implement when PORT events or pin latching needed for low-power applications. These are power-saving features for interrupt-driven designs.

---

### TODO #146: Use better naming for I2CDMA functions

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:30`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: Name these more nicely
```

**Code Context**:
```zig
        pub const StartOnTxReady = enum(u1) { disabled = 0, enabled = 1 };
        pub const StartOnRxReady = enum(u1) { disabled = 0, enabled = 1 };
        pub const StopOnTxReady = enum(u1) { disabled = 0, enabled = 1 };
        pub const StopOnRxReady = enum(u1) { disabled = 0, enabled = 1 };
        // TODO: Name these more nicely

        pub const suspend_on_tx_ready: SuspendOnTxReady = .disabled;
        pub const suspend_on_rx_ready: SuspendOnRxReady = .disabled;
```

**Analysis**:

- **Purpose**: Improve naming of DMA shortcut configuration enums
- **Why Incomplete**: Functional but verbose naming scheme
- **Complexity**: Low - Rename enums and update usage sites
- **Related Items**: None nearby

**Recommendation**: Refactor to more concise names (e.g., AutoStart, AutoStop) when API stabilizes. Code cleanup task.

---

### TODO #147: Better MAXCNT type handling for nRF chips

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:146`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
```

**Code Context**:
```zig
            // Check if we're trying to send more than the hardware supports
            if (buffer.len > std.math.maxInt(usize)) {
                return Error.BufferTooLarge;
            }
            // TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
            //       nRF52832. We need to handle both.
            const CountType = @TypeOf(self.regs.TXD.MAXCNT.read().MAXCNT);
            if (buffer.len > std.math.maxInt(CountType)) {
                return Error.BufferTooLarge;
```

**Analysis**:

- **Purpose**: Find cleaner way to handle different MAXCNT register widths across nRF chip variants
- **Why Incomplete**: Current solution works but feels inelegant
- **Complexity**: Medium - May require regz or microzig core changes for better type inference
- **Related Items**: TODO #148 has identical issue for RX

**Recommendation**: Consider microzig enhancement for accessing register field types directly. This is a broader framework issue affecting multiple HALs.

---

### TODO #148: Better MAXCNT type handling for nRF chips (RX)

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:161`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
```

**Code Context**:
```zig
            // Check if we're trying to receive more than the hardware supports
            if (buffer.len > std.math.maxInt(usize)) {
                return Error.BufferTooLarge;
            }
            // TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
            //       nRF52832. We need to handle both.
            const CountType = @TypeOf(self.regs.RXD.MAXCNT.read().MAXCNT);
            if (buffer.len > std.math.maxInt(CountType)) {
                return Error.BufferTooLarge;
```

**Analysis**:

- **Purpose**: Same as TODO #147 but for RX path
- **Why Incomplete**: Same reason as #147
- **Complexity**: Medium - Same solution needed
- **Related Items**: Duplicate of TODO #147

**Recommendation**: Resolve together with TODO #147. Both need same framework-level solution.

---

### TODO #149: Handle zero-length I2C transactions

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:360`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: We can handle this if for some reason we want to send a start and immediate stop?
```

**Code Context**:
```zig
        pub fn write_blocking(self: *Self, address: I2CAddress, buffer: []const u8, timeout: ?u32) Error!void {
            if (buffer.len == 0) {
                return Error.InvalidLength;
            }
            // TODO: We can handle this if for some reason we want to send a start and immediate stop?
            try self.start_write(address, buffer);
            try self.wait_for_stop(timeout);
        }
```

**Analysis**:

- **Purpose**: Support zero-length write transactions (START + STOP only)
- **Why Incomplete**: Zero-length writes are unusual; unclear if hardware supports it
- **Complexity**: Low - Test hardware behavior and handle if supported
- **Related Items**: None nearby

**Recommendation**: Implement only if specific I2C device requires START-STOP probing. Most I2C devices require actual data transfer.

---

### TODO #150: Support writev with automatic STOP on last transaction

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:377`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: We only set the stop one if this is the last transaction... we could handle writev
```

**Code Context**:
```zig
            try self.start_write(address, buffer);

            if (stop) {
                self.set_shorts(.{ .lasttx_stop = .enabled });
            } else {
                // TODO: We only set the stop one if this is the last transaction... we could handle writev
                //       here and send multiple buffers with a single stop at the end.
                self.set_shorts(.{ .lasttx_suspend = .enabled });
            }

            try self.wait_for_suspended_or_stop(timeout);
```

**Analysis**:

- **Purpose**: Implement vectored write (multiple buffers in one transaction) with single STOP
- **Why Incomplete**: Basic single-buffer write implemented first
- **Complexity**: Medium - Needs state machine for multiple buffer sequencing
- **Related Items**: None nearby

**Recommendation**: Implement writev for efficient multi-buffer I2C transactions (e.g., command+data writes). Useful optimization for sensor communication.

---

### TODO #151: Handle read continuation after START

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:401`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: We can handle this actually
```

**Code Context**:
```zig
        pub fn read_blocking(self: *Self, address: I2CAddress, buffer: []u8, timeout: ?u32) Error!void {
            if (buffer.len == 0) {
                return Error.InvalidLength;
            }
            // TODO: We can handle this actually
            try self.start_read(address, buffer);

            self.set_shorts(.{ .lastrx_stop = .enabled });
```

**Analysis**:

- **Purpose**: Support read continuation patterns (non-obvious from comment context)
- **Why Incomplete**: Basic read-with-stop implemented; advanced patterns deferred
- **Complexity**: Low - Clarify requirement and implement
- **Related Items**: None nearby

**Recommendation**: Clarify this TODO - it's unclear what specific functionality is missing. Review I2C transaction patterns that might need support.

---

### TODO #152: Add missing Nordic peripheral drivers

**Location**: `port/nordic/nrf5x/src/hal.zig:12`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: adc, timers, pwm, rng, rtc alarms, interrupts, wdt, wifi, nfc, bt, zigbee
```

**Code Context**:
```zig
pub const uart = @import("hal/uart.zig");
pub const spim = @import("hal/spim.zig");
pub const i2c = @import("hal/i2c.zig");
pub const i2cdma = @import("hal/i2cdma.zig");
pub const gpio = @import("hal/gpio.zig");

// TODO: adc, timers, pwm, rng, rtc alarms, interrupts, wdt, wifi, nfc, bt, zigbee
```

**Analysis**:

- **Purpose**: List of major peripheral drivers still needed for comprehensive Nordic support
- **Why Incomplete**: Initial HAL focused on core peripherals (UART, SPI, I2C, GPIO)
- **Complexity**: Varies - ADC/timers are Medium, wireless protocols are High
- **Related Items**: None nearby

**Recommendation**: Prioritize based on user needs: ADC and PWM (Medium priority), timers (High for advanced apps), wireless (implement as separate modules). This is a roadmap TODO.

---

### TODO #153: Make LED matrix a proper driver

**Location**: `port/nordic/nrf5x/src/boards/microbit.zig:70`  
**Author**: Brendan Hedges (2024-10-31)  
**Commit**: 00ef5dcb - "port nrf5x-hal"

**Original Comment**:
```zig
// TODO: should led matrix be a driver?
```

**Code Context**:
```zig
    // The led matrix is directly attached to gpio pins
    // row 1-3, col 1-9
    // The cathode is hooked to the row pins and the anode is hooked to the
    // col pins. So to light up an LED, you set the row pin low, and the col
    // pin high
    //
    // TODO: should led matrix be a driver?
    pub const LedMatrix = enum {
        row1 = 21,
        row2 = 22,
```

**Analysis**:

- **Purpose**: Consider moving micro:bit LED matrix from board definition to proper driver
- **Why Incomplete**: Current board-specific code works but isn't reusable
- **Complexity**: Low - Extract to drivers/ directory with proper abstraction
- **Related Items**: None nearby

**Recommendation**: Move to `drivers/display/led-matrix.zig` if other boards use similar matrix displays. Creates reusable component.

---

### TODO #154: Support custom UART pins on LPC176x5x

**Location**: `port/nxp/lpc/src/hals/LPC176x5x.zig:124`  
**Author**: Ian Shehadeh (2024-09-23)  
**Commit**: 30dda2cc - "add LPCXpresso LPC1769 and LPC1768 boards"

**Original Comment**:
```zig
@compileError("TODO: custom pins are not currently supported");
```

**Code Context**:
```zig
    pub fn Uart(comptime uart_num: u8, comptime pins: Pins) type {
        if (pins != .default) {
            @compileError("TODO: custom pins are not currently supported");
        }
        const SystemConfiguration = Regs.SystemConfiguration;
        const uart_info = comptime switch (uart_num) {
```

**Analysis**:

- **Purpose**: Enable custom pin selection for UART (instead of just default pins)
- **Why Incomplete**: Default pins work for eval boards; custom routing for custom boards deferred
- **Complexity**: Medium - Requires pin muxing and PINSEL register configuration
- **Related Items**: None nearby

**Recommendation**: Implement when users need custom board designs. Requires understanding LPC pin multiplexing in datasheet.

---

### TODO #155: Check if UARTN_FIFOS_ARE_DISA exists on all LPC UARTs

**Location**: `port/nxp/lpc/src/hals/LPC176x5x.zig:170`  
**Author**: Ian Shehadeh (2024-09-23)  
**Commit**: 30dda2cc - "add LPCXpresso LPC1769 and LPC1768 boards"

**Original Comment**:
```zig
// TODO: UARTN_FIFOS_ARE_DISA is not available in all uarts
```

**Code Context**:
```zig
                regs.UART1_TER.write(.{ .TXEN = 1 });
                regs.UART1_FCR.write(.{
                    .FIFO_ENABLE = 1,
                    // TODO: UARTN_FIFOS_ARE_DISA is not available in all uarts
                    //       This line may need to be removed depending on the chip variant
                    .UART1_FIFOS_ARE_DISA = 0,
                    .RX_FIFO_RESET = 1,
                    .TX_FIFO_RESET = 1,
```

**Analysis**:

- **Purpose**: Handle chip variants where FIFO disable bit doesn't exist
- **Why Incomplete**: Register definitions may vary across LPC17xx variants
- **Complexity**: Low - Use conditional compilation based on chip model
- **Related Items**: None nearby

**Recommendation**: Review LPC17xx datasheets for all supported variants and use comptime checks. Prevents compilation errors on some chips.

---

### TODO #156: Determine when AFIOEN needs to be set

**Location**: `port/wch/ch32v/src/hals/clocks.zig:14`  
**Author**: Vesim (2024-09-01)  
**Commit**: 5b99cb01 - "support remapping pins"

**Original Comment**:
```zig
// TODO: How do we know if we need to set the AFIOEN?
```

**Code Context**:
```zig
// TODO: clarify if the RCC needs separate enables for each peripheral or
// just the peripherals register needs to be written

// TODO: How do we know if we need to set the AFIOEN?
pub fn enable_periph_clock(comptime periph: Peripheral) void {
    switch (periph) {
        .RCC => {},
```

**Analysis**:

- **Purpose**: Clarify when Alternate Function I/O enable (AFIOEN) clock is required
- **Why Incomplete**: WCH documentation may be unclear on AFIO clock requirements
- **Complexity**: Low - Review WCH reference manual and document findings
- **Related Items**: None nearby

**Recommendation**: Test pin remapping scenarios and document when AFIOEN is required. Likely needed whenever using alternate pin functions.

---

### TODO #157: Make CH32V clock configuration more flexible

**Location**: `port/wch/ch32v/src/hals/clocks.zig:150`  
**Author**: Vesim (2024-09-01)  
**Commit**: 5b99cb01 - "support remapping pins"

**Original Comment**:
```zig
// TODO: Make this more flexible.
```

**Code Context**:
```zig
    comptime {
        microzig.core.VectorTable.init_vector_table();
    }

    // TODO: Make this more flexible.
    const HSE = 8_000_000;
    const PLL_MULT: u4 = 18;
    const SYS_FREQ: u32 = HSE / 2 * PLL_MULT;
```

**Analysis**:

- **Purpose**: Allow configurable system clock instead of hardcoded 72MHz setup
- **Why Incomplete**: Fixed configuration works for initial testing
- **Complexity**: Medium - Needs clock tree calculation and validation
- **Related Items**: None nearby

**Recommendation**: Add clock configuration API accepting desired frequencies and calculating PLL multipliers. Important for power optimization.

---

### TODO #158: Verify flash wait state calculation for CH32V

**Location**: `port/wch/ch32v/src/hals/clocks.zig:173`  
**Author**: Vesim (2024-09-01)  
**Commit**: 5b99cb01 - "support remapping pins"

**Original Comment**:
```zig
// TODO: Why is this 4, not 2? Check
```

**Code Context**:
```zig
    // Configure flash wait states
    // Divide by 4 because WS is calculated from HCLK / 4
    // TODO: Why is this 4, not 2? Check
    FLASH.ACTLR.write(.{ .LATENCY = @divExact(SYS_FREQ, 24_000_000) });

    // Enable HSE
```

**Analysis**:

- **Purpose**: Verify correct flash wait state divisor (documentation unclear)
- **Why Incomplete**: Formula may be incorrect or documentation ambiguous
- **Complexity**: Low - Test and verify with actual hardware
- **Related Items**: None nearby

**Recommendation**: Test different frequencies and verify no flash access errors occur. Consult WCH technical support if documentation is unclear.

---

## Batch Summary

**Key Findings**:
1. Nordic nRF5x port has most TODOs (18/25) - indicates active development
2. Most TODOs are enhancement requests rather than bugs
3. Several chip-specific limitations need addressing (MAXCNT types, frequency support)
4. Missing peripheral drivers are documented as roadmap items

**Priority Recommendations**:
- **High**: TODO #142 (DMA Flash handling) - Can cause silent failures
- **Medium**: TODOs #147-148 (MAXCNT types) - Framework improvement needed
- **Low**: Most others are enhancements or optimizations

**Common Themes**:
- Chip variant handling (different register sizes, features)
- Advanced peripheral features deferred to basic implementation
- API design decisions (verbosity vs. safety)
- Missing peripheral drivers for complete platform support
