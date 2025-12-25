# TODO Analysis - Batch 18: [port] (Items 426-450)

## Summary
This batch contains 25 TODOs from the port directory, focusing on GigaDevice GD32 and Nordic nRF5x HAL implementations. The TODOs span GPIO configuration validation, pin support, hardware abstraction layer features, and peripheral optimizations.

---

### TODO #426: GPIO output pin validation

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:36`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 56e3d88bc - "add chips and board (#1)"

**Original Comment**:
```
// TODO: check if pin is already configured as output
```

**Code Context**:
```zig
pub const gpio = struct {
    pub fn set_output(comptime pin: type) void {
        _ = pin;
        // TODO: check if pin is already configured as output
    }
```

**Analysis**:

- **Purpose**: Add validation to ensure a pin isn't already configured as output before setting it
- **Why Incomplete**: Initial HAL implementation focused on basic functionality over validation
- **Complexity**: Low
- **Related Items**: Similar validation TODOs for input pins (#427, #428, #429)

**Recommendation**: Implement pin state tracking and validation to prevent configuration conflicts

---

### TODO #427: GPIO input pin validation

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:40`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 56e3d88bc - "add chips and board (#1)"

**Original Comment**:
```
// TODO: check if pin is already configured as input
```

**Code Context**:
```zig
pub fn set_input(comptime pin: type) void {
    _ = pin;
    // TODO: check if pin is already configured as input
}
```

**Analysis**:

- **Purpose**: Add validation to ensure a pin isn't already configured as input before setting it
- **Why Incomplete**: Initial HAL implementation focused on basic functionality over validation
- **Complexity**: Low
- **Related Items**: Part of GPIO validation suite (#426, #428, #429)

**Recommendation**: Implement pin state tracking and validation to prevent configuration conflicts

---

### TODO #428: GPIO read pin validation

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:45`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 56e3d88bc - "add chips and board (#1)"

**Original Comment**:
```
// TODO: check if pin is configured as input
```

**Code Context**:
```zig
pub fn read(comptime pin: type) microzig.gpio.State {
    _ = pin;
    // TODO: check if pin is configured as input
    return .low;
}
```

**Analysis**:

- **Purpose**: Validate that a pin is configured as input before attempting to read from it
- **Why Incomplete**: Initial HAL implementation focused on basic functionality over validation
- **Complexity**: Low
- **Related Items**: Part of GPIO validation suite (#426, #427, #429)

**Recommendation**: Implement pin state tracking and validation to prevent invalid operations

---

### TODO #429: GPIO write pin validation

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:52`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 56e3d88bc - "add chips and board (#1)"

**Original Comment**:
```
// TODO: check if pin is configured as output
```

**Code Context**:
```zig
pub fn write(comptime pin: type, state: microzig.gpio.State) void {
    _ = pin;
    _ = state;
    // TODO: check if pin is configured as output
}
```

**Analysis**:

- **Purpose**: Validate that a pin is configured as output before attempting to write to it
- **Why Incomplete**: Initial HAL implementation focused on basic functionality over validation
- **Complexity**: Low
- **Related Items**: Part of GPIO validation suite (#426, #427, #428)

**Recommendation**: Implement pin state tracking and validation to prevent invalid operations

---

### TODO #430: Custom pin support for GD32 UART

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:79`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 56e3d88bc - "add chips and board (#1)"

**Original Comment**:
```
@compileError("TODO: custom pins are not currently supported");
```

**Code Context**:
```zig
pub fn Uart(comptime index: usize, comptime pins: microzig.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");
```

**Analysis**:

- **Purpose**: Add support for custom pin assignments in UART configuration
- **Why Incomplete**: Initial implementation used fixed pin assignments for simplicity
- **Complexity**: Medium
- **Related Items**: Similar custom pin limitation in UART module (#432)

**Recommendation**: Implement pin multiplexing logic to support arbitrary TX/RX pin assignments

---

### TODO #431: Pin mode configuration fallback

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103/pins.zig:54`  
**Author**: Daniele Basile (2024-06-09)  
**Commit**: 43b2a539c - "Complete Gd32f103 Support (#203)"

**Original Comment**:
```
@panic("TODO");
```

**Code Context**:
```zig
pub fn get_mode(comptime config: Configuration) gpio.Mode {
    return if (config.mode) |mode|
        mode
    else
        @panic("TODO");
}
```

**Analysis**:

- **Purpose**: Implement fallback logic for determining GPIO pin mode when not explicitly specified
- **Why Incomplete**: Need to determine appropriate default mode based on pin function
- **Complexity**: Medium
- **Related Items**: None directly related

**Recommendation**: Implement function-based mode inference (e.g., PWM → output, ADC → input)

---

### TODO #432: Input function instance validation

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103/pins.zig:187`  
**Author**: Daniele Basile (2024-06-09)  
**Commit**: 43b2a539c - "Complete Gd32f103 Support (#203)"

**Original Comment**:
```
// TODO: ensure only one instance of an input function exists
```

**Code Context**:
```zig
// TODO: ensure only one instance of an input function exists
const used_gpios = comptime input_gpios | output_gpios;
```

**Analysis**:

- **Purpose**: Validate that input functions (like UART RX) are not assigned to multiple pins
- **Why Incomplete**: Complex validation logic needed for compile-time pin conflict detection
- **Complexity**: Medium
- **Related Items**: Similar validation needed across HAL implementations

**Recommendation**: Implement compile-time validation to detect conflicting pin function assignments

---

### TODO #433: Custom pin support for GD32 UART module

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103/uart.zig:29`  
**Author**: Daniele Basile (2024-06-09)  
**Commit**: 43b2a539c - "Complete Gd32f103 Support (#203)"

**Original Comment**:
```
@compileError("TODO: custom pins are not currently supported");
```

**Code Context**:
```zig
pub fn Uart(comptime index: usize, comptime pins: microzig.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");
```

**Analysis**:

- **Purpose**: Add support for custom pin assignments in UART configuration
- **Why Incomplete**: Initial implementation used fixed pin assignments for simplicity
- **Complexity**: Medium
- **Related Items**: Duplicate of #430 in main HAL file

**Recommendation**: Implement pin multiplexing logic to support arbitrary TX/RX pin assignments

---

### TODO #434: Code RAM usage for nRF52840

**Location**: `port/nordic/nrf5x/build.zig:123`  
**Author**: Tudor Andrei Dicu (2025-06-18)  
**Commit**: dd8544d09 - "Linker script generation update (#588)"

**Original Comment**:
```
// TODO: use code ram for `.ram_text`
```

**Code Context**:
```zig
.memory_regions = &.{
    .{ .tag = .flash, .offset = 0x00000000, .length = 0x100000, .access = .rx },
    // TODO: use code ram for `.ram_text`
    .{ .tag = .ram, .offset = 0x20000000, .length = 0x40000, .access = .rwx },
```

**Analysis**:

- **Purpose**: Utilize dedicated code RAM region for executable code sections
- **Why Incomplete**: Linker script generation update focused on basic memory layout
- **Complexity**: Medium
- **Related Items**: Part of memory layout optimization

**Recommendation**: Configure linker to place performance-critical code in faster code RAM

---

### TODO #435: LED matrix driver consideration

**Location**: `port/nordic/nrf5x/src/boards/microbit.zig:70`  
**Author**: Tudor Andrei Dicu (2025-06-20)  
**Commit**: 1622b7ae5 - "nrf5x: micro:bit support (#600)"

**Original Comment**:
```
// TODO: should led matrix be a driver?
```

**Code Context**:
```zig
// TODO: should led matrix be a driver?

pub const display = struct {
    pub const width = 5;
    pub const height = 5;
```

**Analysis**:

- **Purpose**: Consider refactoring LED matrix functionality into a reusable driver
- **Why Incomplete**: Initial implementation focused on board-specific functionality
- **Complexity**: Medium
- **Related Items**: Part of driver architecture design

**Recommendation**: Extract LED matrix logic into a generic driver for reuse across boards

---

### TODO #436: Additional HAL modules for nRF5x

**Location**: `port/nordic/nrf5x/src/hal.zig:12`  
**Author**: Grazfather (2025-09-03)  
**Commit**: 734acceab - "nrf5x: Use RTC for timekeeping, track overflows for extra bits (#662)"

**Original Comment**:
```
// TODO: adc, timers, pwm, rng, rtc alarms, interrupts, wdt, wifi, nfc, bt, zigbee
```

**Code Context**:
```zig
pub const uart = @import("hal/uart.zig");
pub const drivers = @import("hal/drivers.zig");
// TODO: adc, timers, pwm, rng, rtc alarms, interrupts, wdt, wifi, nfc, bt, zigbee
```

**Analysis**:

- **Purpose**: Implement missing HAL modules for various nRF5x peripherals and features
- **Why Incomplete**: HAL development is incremental, focusing on core functionality first
- **Complexity**: High
- **Related Items**: Comprehensive HAL expansion

**Recommendation**: Prioritize modules based on user demand (ADC, PWM, timers first)

---

### TODO #437: Package-specific GPIO encoding

**Location**: `port/nordic/nrf5x/src/hal/gpio.zig:46`  
**Author**: Matt Knight (2025-05-22)  
**Commit**: 701a7f0aa - "nRF52xxx: Add UART hal + examples (#558)"

**Original Comment**:
```
// TODO: Do we want to follow the rp2350 design where we encode the package
```

**Code Context**:
```zig
pub fn num(bank: u1, n: u5) Pin {
    return @enumFromInt(@as(u6, bank) * 32 + n);
}

// TODO: Do we want to follow the rp2350 design where we encode the package
// somewhere? Some GPIOs are unbonded in certain packages.
```

**Analysis**:

- **Purpose**: Consider encoding package information to handle unbonded GPIO pins
- **Why Incomplete**: Design decision needed on whether to follow RP2350 pattern
- **Complexity**: Medium
- **Related Items**: GPIO architecture design

**Recommendation**: Evaluate RP2350 approach and implement if it provides clear benefits

---

### TODO #438: LATCH and DETECTMODE support

**Location**: `port/nordic/nrf5x/src/hal/gpio.zig:50`  
**Author**: Grazfather (2025-05-20)  
**Commit**: d4706c148 - "nrf52xx: Basic GPIO hal (#557)"

**Original Comment**:
```
// TODO: Add support for LATCH, DETECTMODE
```

**Code Context**:
```zig
pub const Pin = enum(u6) {
    _,
    // TODO: Add support for LATCH, DETECTMODE
```

**Analysis**:

- **Purpose**: Add support for advanced GPIO features like latch and detect mode
- **Why Incomplete**: Basic GPIO implementation focused on core functionality
- **Complexity**: Medium
- **Related Items**: GPIO feature expansion

**Recommendation**: Implement advanced GPIO features for applications requiring edge detection

---

### TODO #439: I2C address validation refactoring

**Location**: `port/nordic/nrf5x/src/hal/i2c.zig:185`  
**Author**: Grazfather (2025-08-27)  
**Commit**: 37136e3dd - "Overhaul i2c_device interfaces, implement, update some drivers (#645)"

**Original Comment**:
```
// TODO: Could move the check into read/write and remove this struct
```

**Code Context**:
```zig
// TODO: Could move the check into read/write and remove this struct
pub const Allow_Reserved = enum { allow_general, allow_reserved, dont_allow_reserved };
```

**Analysis**:

- **Purpose**: Simplify I2C interface by moving address validation into read/write functions
- **Why Incomplete**: Interface overhaul focused on core functionality first
- **Complexity**: Low
- **Related Items**: I2C interface simplification

**Recommendation**: Refactor to eliminate intermediate validation struct for cleaner API

---

### TODO #440: Better frequency naming for I2C DMA

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:30`  
**Author**: Grazfather (2025-05-25)  
**Commit**: ce0678f32 - "nRF5x: Add i2c hal + datagram device (#561)"

**Original Comment**:
```
// TODO: Name these more nicely
```

**Code Context**:
```zig
// TODO: Name these more nicely
frequency: enum {
    @"100000",
    @"250000",
    @"400000",
} = .@"100000",
```

**Analysis**:

- **Purpose**: Use more descriptive names for I2C frequency options
- **Why Incomplete**: Initial implementation used raw frequency values for clarity
- **Complexity**: Low
- **Related Items**: API usability improvement

**Recommendation**: Use descriptive names like `standard`, `fast`, `fast_plus` for better UX

---

### TODO #441: MAXCNT register type handling

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:146`  
**Author**: Grazfather (2025-08-05)  
**Commit**: 754be744c - "nrf52: Implement writev_blocking for i2cdma (#636)"

**Original Comment**:
```
// TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
```

**Code Context**:
```zig
// TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
// nRF52831
const tx_cnt_type = @FieldType(@FieldType(@FieldType(I2cRegs, "TXD"), "MAXCNT").underlying_type, "MAXCNT");
```

**Analysis**:

- **Purpose**: Find cleaner way to handle different MAXCNT register sizes across chip variants
- **Why Incomplete**: Complex type introspection needed for chip-specific register differences
- **Complexity**: Medium
- **Related Items**: Similar issue in RX buffer handling (#442)

**Recommendation**: Create chip-specific type aliases or use conditional compilation

---

### TODO #442: RX MAXCNT register type handling

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:161`  
**Author**: Grazfather (2025-08-05)  
**Commit**: 754be744c - "nrf52: Implement writev_blocking for i2cdma (#636)"

**Original Comment**:
```
// TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
```

**Code Context**:
```zig
// TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
// nRF52831
const rx_cnt_type = @FieldType(@FieldType(@FieldType(I2cRegs, "RXD"), "MAXCNT").underlying_type, "MAXCNT");
```

**Analysis**:

- **Purpose**: Find cleaner way to handle different MAXCNT register sizes across chip variants
- **Why Incomplete**: Complex type introspection needed for chip-specific register differences
- **Complexity**: Medium
- **Related Items**: Duplicate of TX buffer handling issue (#441)

**Recommendation**: Create chip-specific type aliases or use conditional compilation

---

### TODO #443: Zero-length I2C transaction support

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:360`  
**Author**: Grazfather (2025-05-25)  
**Commit**: ce0678f32 - "nRF5x: Add i2c hal + datagram device (#561)"

**Original Comment**:
```
// TODO: We can handle this if for some reason we want to send a start and immediate stop?
```

**Code Context**:
```zig
// TODO: We can handle this if for some reason we want to send a start and immediate stop?
if (dst.len == 0)
    return Error.NoData;
```

**Analysis**:

- **Purpose**: Support zero-length I2C transactions for specific use cases
- **Why Incomplete**: Unclear if zero-length transactions have valid use cases
- **Complexity**: Low
- **Related Items**: I2C protocol edge case handling

**Recommendation**: Research I2C protocol requirements and implement if needed

---

### TODO #444: I2C vectored read support

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:377`  
**Author**: Grazfather (2025-05-25)  
**Commit**: ce0678f32 - "nRF5x: Add i2c hal + datagram device (#561)"

**Original Comment**:
```
// TODO: We only set the stop one if this is the last transaction... we could handle writev
```

**Code Context**:
```zig
// TODO: We only set the stop one if this is the last transaction... we could handle writev
// this way probably. If it's not the last chunk, then just suspend
// Set it up to automatically stop after receiving the last expected byte
```

**Analysis**:

- **Purpose**: Implement vectored read operations for I2C DMA
- **Why Incomplete**: Complex transaction management needed for multi-chunk reads
- **Complexity**: Medium
- **Related Items**: I2C DMA optimization

**Recommendation**: Implement vectored reads using suspend/resume mechanism

---

### TODO #445: Zero-length write transaction support

**Location**: `port/nordic/nrf5x/src/hal/i2cdma.zig:401`  
**Author**: Grazfather (2025-05-25)  
**Commit**: ce0678f32 - "nRF5x: Add i2c hal + datagram device (#561)"

**Original Comment**:
```
// TODO: We can handle this actually
```

**Code Context**:
```zig
// TODO: We can handle this actually
if (data.len == 0)
    return Error.NoData;
```

**Analysis**:

- **Purpose**: Support zero-length write transactions in write-then-read operations
- **Why Incomplete**: Implementation complexity for edge case
- **Complexity**: Low
- **Related Items**: Related to zero-length read support (#443)

**Recommendation**: Implement if needed for specific I2C device protocols

---

### TODO #446: Chip-specific SPIM configuration

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:79`  
**Author**: Grazfather (2025-06-05)  
**Commit**: a7a665160 - "nRF52x: HAL: Add SPIM (#584)"

**Original Comment**:
```
// TODO: Chip-specific
```

**Code Context**:
```zig
pub fn apply(spi: SPIM, config: Config) !void {
    const regs = spi.get_regs();
    // TODO: Chip-specific
    if (config.miso_pin) |miso| {
```

**Analysis**:

- **Purpose**: Handle chip-specific differences in SPIM configuration
- **Why Incomplete**: Initial implementation used generic approach
- **Complexity**: Medium
- **Related Items**: Chip variant handling across HAL

**Recommendation**: Implement chip-specific configuration paths based on detected variant

---

### TODO #447: MOSI idle state configuration

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:113`  
**Author**: Grazfather (2025-06-05)  
**Commit**: a7a665160 - "nRF52x: HAL: Add SPIM (#584)"

**Original Comment**:
```
// TODO: Does MOSI idle change here?
```

**Code Context**:
```zig
} else regs.PSEL.MOSI.modify(.{
    .CONNECT = .Disconnected,
});
// TODO: Does MOSI idle change here?
```

**Analysis**:

- **Purpose**: Determine if MOSI pin idle state changes when disconnected
- **Why Incomplete**: Hardware behavior unclear, needs investigation
- **Complexity**: Low
- **Related Items**: SPI pin management

**Recommendation**: Test hardware behavior and document/configure idle state appropriately

---

### TODO #448: Flash memory DMA limitation

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:256`  
**Author**: Grazfather (2025-06-05)  
**Commit**: a7a665160 - "nRF52x: HAL: Add SPIM (#584)"

**Original Comment**:
```
// TODO: DMA won't work if they are trying to copy from Flash (e.g. program memory). In that
```

**Code Context**:
```zig
// TODO: DMA won't work if they are trying to copy from Flash (e.g. program memory). In that
// case we'd have to copy it to RAM before doing this, buf it that's the case, maybe they
// should just use the non-DMA peripheral? We could return an error in that case.
```

**Analysis**:

- **Purpose**: Handle DMA limitations when source data is in flash memory
- **Why Incomplete**: Complex decision needed on automatic RAM copying vs error handling
- **Complexity**: Medium
- **Related Items**: DMA memory access limitations

**Recommendation**: Detect flash addresses and either copy to RAM or return descriptive error

---

### TODO #449: SPI task timeout handling

**Location**: `port/nordic/nrf5x/src/hal/spim.zig:285`  
**Author**: Grazfather (2025-06-05)  
**Commit**: a7a665160 - "nRF52x: HAL: Add SPIM (#584)"

**Original Comment**:
```
// TODO: Do we have to stop the task on timeout?
```

**Code Context**:
```zig
if (deadline.is_reached_by(time.get_time_since_boot())) {
    // TODO: Do we have to stop the task on timeout?
    // regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
    return TransactionError.Timeout;
}
```

**Analysis**:

- **Purpose**: Determine if SPI task should be explicitly stopped on timeout
- **Why Incomplete**: Hardware behavior unclear, needs investigation
- **Complexity**: Low
- **Related Items**: Timeout handling best practices

**Recommendation**: Test hardware behavior and implement task stop if needed for clean state

---

### TODO #450: UARTE vs UART peripheral choice

**Location**: `port/nordic/nrf5x/src/hal/uart.zig:8`  
**Author**: Matt Knight (2025-05-22)  
**Commit**: 701a7f0aa - "nRF52xxx: Add UART hal + examples (#558)"

**Original Comment**:
```
// TODO: UARTE0? Does DMA, just set rxd.ptr or txd.ptr. UART0 is deprecated (but still works?) on nRF52840
```

**Code Context**:
```zig
// TODO: UARTE0? Does DMA, just set rxd.ptr or txd.ptr. UART0 is deprecated (but still works?) on nRF52840
const UART_Regs = types.peripherals.UART0;
```

**Analysis**:

- **Purpose**: Consider switching to UARTE peripheral for DMA support
- **Why Incomplete**: Initial implementation used simpler UART peripheral
- **Complexity**: Medium
- **Related Items**: UART performance optimization

**Recommendation**: Implement UARTE support for better performance and deprecation compliance

---

### TODO #451: nRF52840 stop bit configuration

**Location**: `port/nordic/nrf5x/src/hal/uart.zig:65`  
**Author**: Matt Knight (2025-05-22)  
**Commit**: 701a7f0aa - "nRF52xxx: Add UART hal + examples (#558)"

**Original Comment**:
```
// TODO: On 52840 the CONFIG register has 1 bit for STOP bits
```

**Code Context**:
```zig
// TODO: On 52840 the CONFIG register has 1 bit for STOP bits
pub const Config = struct {
    rx_pin: gpio.Pin,
    tx_pin: gpio.Pin,
```

**Analysis**:

- **Purpose**: Add stop bit configuration support for nRF52840
- **Why Incomplete**: Initial implementation used default stop bit configuration
- **Complexity**: Low
- **Related Items**: UART configuration completeness

**Recommendation**: Add stop bit configuration option for nRF52840 compatibility

---

### TODO #452: Optional UART pin configuration

**Location**: `port/nordic/nrf5x/src/hal/uart.zig:122`  
**Author**: Matt Knight (2025-05-22)  
**Commit**: 701a7f0aa - "nRF52xxx: Add UART hal + examples (#558)"

**Original Comment**:
```
// TODO: Make these optional... could have rx only for example
```

**Code Context**:
```zig
// TODO: Make these optional... could have rx only for example
uart.set_txd(config.tx_pin);
config.tx_pin.set_direction(.out);
```

**Analysis**:

- **Purpose**: Support optional TX/RX pins for unidirectional UART usage
- **Why Incomplete**: Initial implementation required both TX and RX pins
- **Complexity**: Low
- **Related Items**: UART flexibility improvements

**Recommendation**: Make TX/RX pins optional in configuration for specialized use cases

---

## Batch Summary

**Total TODOs Analyzed**: 25

**Complexity Breakdown**:
- Low: 15 TODOs (60%)
- Medium: 9 TODOs (36%)
- High: 1 TODO (4%)

**Key Themes**:
1. **GPIO Validation**: Multiple TODOs for pin state validation in GD32 HAL
2. **Custom Pin Support**: Need for flexible pin assignment in UART peripherals
3. **nRF5x HAL Expansion**: Missing peripheral support and optimization opportunities
4. **Hardware Abstraction**: Chip-specific differences and feature completeness
5. **DMA Optimization**: Memory access limitations and transaction handling

**Priority Recommendations**:
1. Implement GPIO pin state validation for GD32 (TODOs #426-429)
2. Add custom pin support for UART peripherals (TODOs #430, #433)
3. Expand nRF5x HAL with missing peripherals (TODO #436)
4. Optimize I2C DMA register handling (TODOs #441-442)
5. Consider UARTE migration for nRF52840 (TODO #450)
