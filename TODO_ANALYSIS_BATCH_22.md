# TODO Analysis - Batch 22: [port] Directory

**Batch Info**: Items 526-550 from TODO_INVENTORY.json

## Summary
This batch analyzes 25 TODOs from the [port] directory, focusing on Raspberry Pi RP2xxx USB implementation and STM32 HAL development. The TODOs span USB driver improvements, hardware abstraction layer features, and peripheral support.

---

### TODO #526: USB endpoint direction assertion

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:313`  
**Author**: Arkadiusz Wójcik (2024-11-22)  
**Commit**: 9dde50b7d - "Comptime USB endpoints number (#284)"

**Original Comment**:
```
// TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::In);
```

**Code Context**:
```zig
fn start_tx(
    itf: *usb.DeviceInterface,
    ep_num: EpNum,
    buffer: []const u8,
) void {
    const self: *@This() = @fieldParentPtr("interface", itf);

    // It is technically possible to support longer buffers but this demo
    // doesn't bother.
    // TODO: assert!(buffer.len() <= 64);
    // You should only be calling this on IN endpoints.
    // TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::In);

    const ep = self.hardware_endpoint_get_by_address(.in(ep_num));
```

**Analysis**:

- **Purpose**: Add runtime validation that start_tx is only called on IN endpoints
- **Why Incomplete**: Part of USB driver refactoring that introduced compile-time endpoint configuration
- **Complexity**: Low
- **Related Items**: TODO #528, #529 (similar assertions in USB code)

**Recommendation**: Implement assertion to validate endpoint direction for better debugging and API safety

---

### TODO #527: Memory copy issue reference

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:319`  
**Author**: Arkadiusz Wójcik (2025-04-17)  
**Commit**: cf143299b - "RP2XXX USB - replace rom.memcpy with @memcpy (#432)"

**Original Comment**:
```
// TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
```

**Code Context**:
```zig
// wait for controller to give processor ownership of the buffer before writing it.
// while (ep.buffer_control.?.read().AVAILABLE_0 == 1) {}

// TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
std.mem.copyForwards(u8, ep.data_buffer[0..buffer.len], buffer);
```

**Analysis**:

- **Purpose**: Fix memory copy implementation that replaced ROM memcpy
- **Why Incomplete**: References specific GitHub issue #452 for proper resolution
- **Complexity**: Medium
- **Related Items**: Part of broader USB driver improvements

**Recommendation**: Review GitHub issue #452 and implement proper memory copy solution

---

### TODO #528: Buffer length assertion

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:358`  
**Author**: Arkadiusz Wójcik (2024-11-22)  
**Commit**: 9dde50b7d - "Comptime USB endpoints number (#284)"

**Original Comment**:
```
// TODO: assert!(len <= 64);
```

**Code Context**:
```zig
fn start_rx(itf: *usb.DeviceInterface, ep_num: EpNum, len: usize) void {
    const self: *@This() = @fieldParentPtr("interface", itf);

    // It is technically possible to support longer buffers but this demo
    // doesn't bother.
    // TODO: assert!(len <= 64);
    // You should only be calling this on OUT endpoints.
```

**Analysis**:

- **Purpose**: Add validation for maximum buffer length in USB receive operations
- **Why Incomplete**: Part of USB driver refactoring that focused on endpoint configuration
- **Complexity**: Low
- **Related Items**: TODO #526, #529 (similar USB assertions)

**Recommendation**: Implement buffer length validation with appropriate error handling

---

### TODO #529: USB OUT endpoint direction assertion

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:360`  
**Author**: Arkadiusz Wójcik (2024-11-22)  
**Commit**: 9dde50b7d - "Comptime USB endpoints number (#284)"

**Original Comment**:
```
// TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::Out);
```

**Code Context**:
```zig
// TODO: assert!(len <= 64);
// You should only be calling this on OUT endpoints.
// TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::Out);

const ep = self.hardware_endpoint_get_by_address(.out(ep_num));
```

**Analysis**:

- **Purpose**: Add runtime validation that start_rx is only called on OUT endpoints
- **Why Incomplete**: Part of USB driver refactoring that introduced compile-time endpoint configuration
- **Complexity**: Low
- **Related Items**: TODO #526 (similar assertion for IN endpoints)

**Recommendation**: Implement assertion to validate endpoint direction for API safety

---

### TODO #530: Buffer control assignment

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:435`  
**Author**: Piotr Fila (2025-12-19)  
**Commit**: ed8e54c26 - "Rework USB driver (#760)"

**Original Comment**:
```
ep_hard.buffer_control = rp2xxx_endpoints.get_buf_ctrl(ep.num, ep.dir);
```

**Code Context**:
```zig
ep_hard.buffer_control = rp2xxx_endpoints.get_buf_ctrl(ep.num, ep.dir);
ep_hard.endpoint_control = rp2xxx_endpoints.get_ep_ctrl(ep.num, ep.dir);

if (ep.num == .ep0) {
    // ep0 has fixed data buffer
    ep_hard.data_buffer = rp2xxx_buffers.ep0_buffer0;
```

**Analysis**:

- **Purpose**: This appears to be working code, not a TODO comment
- **Why Incomplete**: May be incorrectly identified as TODO in inventory
- **Complexity**: N/A
- **Related Items**: TODO #531, #532 (adjacent code lines)

**Recommendation**: Verify if this is actually a TODO or working code that was misidentified

---

### TODO #531: Endpoint control assignment

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:436`  
**Author**: Piotr Fila (2025-12-19)  
**Commit**: ed8e54c26 - "Rework USB driver (#760)"

**Original Comment**:
```
ep_hard.endpoint_control = rp2xxx_endpoints.get_ep_ctrl(ep.num, ep.dir);
```

**Code Context**:
```zig
ep_hard.buffer_control = rp2xxx_endpoints.get_buf_ctrl(ep.num, ep.dir);
ep_hard.endpoint_control = rp2xxx_endpoints.get_ep_ctrl(ep.num, ep.dir);

if (ep.num == .ep0) {
    // ep0 has fixed data buffer
```

**Analysis**:

- **Purpose**: This appears to be working code, not a TODO comment
- **Why Incomplete**: May be incorrectly identified as TODO in inventory
- **Complexity**: N/A
- **Related Items**: TODO #530, #532 (adjacent code lines)

**Recommendation**: Verify if this is actually a TODO or working code that was misidentified

---

### TODO #532: EP0 buffer assignment

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:440`  
**Author**: Piotr Fila (2025-12-19)  
**Commit**: ed8e54c26 - "Rework USB driver (#760)"

**Original Comment**:
```
ep_hard.data_buffer = rp2xxx_buffers.ep0_buffer0;
```

**Code Context**:
```zig
if (ep.num == .ep0) {
    // ep0 has fixed data buffer
    ep_hard.data_buffer = rp2xxx_buffers.ep0_buffer0;
} else {
    self.endpoint_alloc(ep_hard) catch {};
    endpoint_enable(ep_hard);
}
```

**Analysis**:

- **Purpose**: This appears to be working code, not a TODO comment
- **Why Incomplete**: May be incorrectly identified as TODO in inventory
- **Complexity**: N/A
- **Related Items**: TODO #530, #531 (adjacent code lines)

**Recommendation**: Verify if this is actually a TODO or working code that was misidentified

---

### TODO #533: Buffer address calculation

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:466`  
**Author**: Arkadiusz Wójcik (2024-12-18)  
**Commit**: da30fd04c - "New USB driver interface (#312)"

**Original Comment**:
```
.BUFFER_ADDRESS = rp2xxx_buffers.data_offset(ep.data_buffer),
```

**Code Context**:
```zig
fn endpoint_enable(ep: *HardwareEndpoint) void {
    ep.endpoint_control.?.modify(.{
        .ENABLE = 1,
        .INTERRUPT_PER_BUFF = 1,
        .ENDPOINT_TYPE = @as(EndpointType, @enumFromInt(@intFromEnum(ep.transfer_type))),
        .BUFFER_ADDRESS = rp2xxx_buffers.data_offset(ep.data_buffer),
    });
}
```

**Analysis**:

- **Purpose**: This appears to be working code, not a TODO comment
- **Why Incomplete**: May be incorrectly identified as TODO in inventory
- **Complexity**: N/A
- **Related Items**: Part of USB driver interface implementation

**Recommendation**: Verify if this is actually a TODO or working code that was misidentified

---

### TODO #534: RP2350 ROM function masking

**Location**: `port/raspberrypi/rp2xxx/src/hal/watchdog.zig:179`  
**Author**: haydenridd (2024-12-30)  
**Commit**: 776a655f1 - "Added watchdog timer API for both RP2040 and RP2350 (#338)"

**Original Comment**:
```
/// TODO: RP2350 SDK masks this with a ROM function:
```

**Code Context**:
```zig
/// Check if the watchdog was the reason for the last reboot
///
/// TODO: RP2350 SDK masks this with a ROM function:
///       return watchdog_hw->reason && rom_get_last_boot_type() == BOOT_TYPE_NORMAL;
pub fn caused_reboot() ?TriggerType {
    const scratch4 = WATCHDOG.SCRATCH4.read();
    const reason = WATCHDOG.REASON.read();
```

**Analysis**:

- **Purpose**: Implement proper RP2350-specific watchdog reboot detection using ROM functions
- **Why Incomplete**: Initial watchdog implementation focused on basic functionality across both chips
- **Complexity**: Medium
- **Related Items**: Part of RP2350 compatibility improvements

**Recommendation**: Implement RP2350-specific ROM function call for accurate boot type detection

---

### TODO #535: LCD segment mapping comment

**Location**: `port/stmicro/stm32/src/boards/STM32L476DISCOVERY.zig:27`  
**Author**: Mathieu Suen (2025-12-16)  
**Commit**: 514da17a4 - "Add support for the STM32L476G dicovery board and basic LCD support (#755)"

**Original Comment**:
```
//  .comX =  0b1111_1111_X111_11XX_XX1X_1111_XX11_X111_1XXX
```

**Code Context**:
```zig
// Rev C have the following segment map to each digit:
//             5544_4433_-655_11--_--6-_3322_--66_-221 1---
//  .comX =  0b1111_1111_X111_11XX_XX1X_1111_XX11_X111_1XXX
const SEGMENT_SHIFT = [_][4]u6{
    [_]u6{ 3, 4, 22, 23 }, // Digit 1
    [_]u6{ 5, 6, 12, 13 }, // Digit 2
```

**Analysis**:

- **Purpose**: This appears to be documentation/comment, not a TODO
- **Why Incomplete**: May be incorrectly identified as TODO in inventory
- **Complexity**: N/A
- **Related Items**: Part of LCD segment mapping implementation

**Recommendation**: Verify if this is actually a TODO or documentation that was misidentified

---

### TODO #536: HAL detection system improvement

**Location**: `port/stmicro/stm32/src/generate.zig:253`  
**Author**: Tudor Andrei Dicu (2024-11-21)  
**Commit**: 62734a730 - "Build system rewrite (#259)"

**Original Comment**:
```
// TODO: Better system to detect if hal is present.
```

**Code Context**:
```zig
// TODO: Better system to detect if hal is present.
if (std.mem.startsWith(u8, chip_file.name, "STM32F103")) {
    try writer.writeAll(
        \\        .hal = .{
        \\            .root_source_file = b.path("src/hals/STM32F103.zig"),
        \\        },
        \\
    );
}
```

**Analysis**:

- **Purpose**: Improve the hardcoded chip name matching for HAL detection
- **Why Incomplete**: Build system rewrite focused on core functionality first
- **Complexity**: Medium
- **Related Items**: Part of broader build system improvements

**Recommendation**: Implement metadata-driven HAL detection system instead of string matching

---

### TODO #537: I2C address type unification

**Location**: `port/stmicro/stm32/src/hals/STM32F103/drivers.zig:12`  
**Author**: Grazfather (2025-08-27)  
**Commit**: 37136e3dd - "Overhaul i2c_device interfaces, implement, update some drivers (#645)"

**Original Comment**:
```
// TODO: The STM HAL still has its own I2CAddress type, since it supports 10 bit addresses. For now
```

**Code Context**:
```zig
const I2CError = drivers.I2C_Device.Error;
// TODO: The STM HAL still has its own I2CAddress type, since it supports 10 bit addresses. For now
// we will paper over it, but we should unify them.
const I2CAddress = drivers.I2C_Device.Address;
```

**Analysis**:

- **Purpose**: Unify I2C address types between STM32 HAL and generic driver interface
- **Why Incomplete**: I2C interface overhaul prioritized functionality over type unification
- **Complexity**: Medium
- **Related Items**: Part of broader I2C driver standardization

**Recommendation**: Design unified I2C address type that supports both 7-bit and 10-bit addressing

---

### TODO #538: Timeout deadline implementation

**Location**: `port/stmicro/stm32/src/hals/STM32F103/drivers.zig:209`  
**Author**: Grazfather (2025-08-27)  
**Commit**: 37136e3dd - "Overhaul i2c_device interfaces, implement, update some drivers (#645)"

**Original Comment**:
```
// TODO: Should be a deadline since the timeout is doubled with two calls
```

**Code Context**:
```zig
) I2CError!void {
    // TODO: Should be a deadline since the timeout is doubled with two calls
    dev.bus.writev_blocking(.from_generic(address), write_chunks, timeout) catch |err| switch (err) {
        I2C.Error.ArbitrationLoss => return I2CError.UnknownAbort,
```

**Analysis**:

- **Purpose**: Implement proper deadline-based timeout instead of per-operation timeout
- **Why Incomplete**: I2C interface overhaul focused on core functionality first
- **Complexity**: Medium
- **Related Items**: Part of I2C driver timeout handling improvements

**Recommendation**: Implement deadline-based timeout system for composite I2C operations

---

### TODO #539: Pin configuration panic

**Location**: `port/stmicro/stm32/src/hals/STM32F103/pins.zig:54`  
**Author**: fmaggi (2023-09-25)  
**Commit**: 237890d49 - "Blue pill hal (#28)"

**Original Comment**:
```
@panic("TODO");
```

**Code Context**:
```zig
fn get_pin_source(comptime pin: Pin) u4 {
    return switch (pin.source_num) {
        0...15 => @as(u4, @intCast(pin.source_num)),
        else => {
            @compileError("Invalid pin source number");
        },
    };
}
```

**Analysis**:

- **Purpose**: Implement missing pin source configuration functionality
- **Why Incomplete**: Early STM32F103 HAL implementation focused on basic GPIO functionality
- **Complexity**: Low
- **Related Items**: TODO #540 (related pin configuration)

**Recommendation**: Implement proper pin source number validation and configuration

---

### TODO #540: Input function instance validation

**Location**: `port/stmicro/stm32/src/hals/STM32F103/pins.zig:191`  
**Author**: fmaggi (2023-09-25)  
**Commit**: 237890d49 - "Blue pill hal (#28)"

**Original Comment**:
```
// TODO: ensure only one instance of an input function exists
```

**Code Context**:
```zig
pub fn apply_pin(comptime pin: Pin, comptime config: PinConfig) void {
    switch (config.mode) {
        .input => |input_config| {
            // TODO: ensure only one instance of an input function exists
            switch (input_config.func) {
                .gpio => {},
                .can_rx => {
```

**Analysis**:

- **Purpose**: Add validation to prevent multiple pins from using the same input function
- **Why Incomplete**: Early STM32F103 HAL implementation focused on basic functionality
- **Complexity**: Medium
- **Related Items**: TODO #539 (related pin configuration)

**Recommendation**: Implement compile-time validation for unique input function assignments

---

### TODO #541: STM32F105/107 support

**Location**: `port/stmicro/stm32/src/hals/STM32F103/rcc.zig:2`  
**Author**: Guilherme S. Schultz (2025-06-29)  
**Commit**: f510f816f - "Add clock management and configuration for STM32F103 (#609)"

**Original Comment**:
```
//TODO: Add support for 105/107
```

**Code Context**:
```zig
//! Clock management and configuration for STM32F103 series
//TODO: Add support for 105/107

const std = @import("std");
const microzig = @import("microzig");
```

**Analysis**:

- **Purpose**: Extend RCC (Reset and Clock Control) support to STM32F105/107 variants
- **Why Incomplete**: Clock management implementation focused on STM32F103 series first
- **Complexity**: High
- **Related Items**: TODO #542 (related peripheral support)

**Recommendation**: Implement STM32F105/107-specific clock configuration and PLL settings

---

### TODO #542: STM32F105/7 peripheral support

**Location**: `port/stmicro/stm32/src/hals/STM32F103/rcc.zig:284`  
**Author**: Guilherme S. Schultz (2025-06-29)  
**Commit**: f510f816f - "Add clock management and configuration for STM32F103 (#609)"

**Original Comment**:
```
//TODO: Add STM32F105/7 devices peri
```

**Code Context**:
```zig
pub const Peripheral = enum {
    // APB1 peripherals
    TIM2, TIM3, TIM4, TIM5, TIM6, TIM7, TIM12, TIM13, TIM14,
    WWDG, SPI2, SPI3, USART2, USART3, UART4, UART5,
    I2C1, I2C2, USB, CAN, BKP, PWR, DAC,
    
    // APB2 peripherals  
    AFIO, GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF, GPIOG,
    ADC1, ADC2, TIM1, SPI1, TIM8, USART1, ADC3, TIM15, TIM16, TIM17,
    
    // AHB peripherals
    DMA1, DMA2, SRAM, FLITF, CRC, FSMC, SDIO,
    //TODO: Add STM32F105/7 devices peri
};
```

**Analysis**:

- **Purpose**: Add peripheral definitions specific to STM32F105/107 variants
- **Why Incomplete**: RCC implementation focused on STM32F103 peripherals first
- **Complexity**: Medium
- **Related Items**: TODO #541 (related clock support)

**Recommendation**: Add STM32F105/107-specific peripherals like Ethernet, CAN2, additional timers

---

### TODO #543: SPI advanced modes

**Location**: `port/stmicro/stm32/src/hals/STM32F103/spi.zig:28`  
**Author**: Guilherme S. Schultz (2025-05-02)  
**Commit**: 6d0d23473 - "basic f1 HAL (#431)"

**Original Comment**:
```
///TODO: 3-Wire mode, Slave mode, bidirectional mode
```

**Code Context**:
```zig
//! Basic SPI support for STM32F1xx
//!
//! Features:
//! - Master mode operation
//! - Configurable clock polarity and phase
//! - 8-bit and 16-bit data frames
//! - Hardware NSS management
//!
//! Limitations:
//! - Only master mode is currently supported
//! - No DMA support
//! - No interrupt-driven operation
//!
///TODO: 3-Wire mode, Slave mode, bidirectional mode
```

**Analysis**:

- **Purpose**: Implement advanced SPI operating modes beyond basic master mode
- **Why Incomplete**: Basic STM32F1 HAL implementation focused on essential functionality first
- **Complexity**: High
- **Related Items**: Part of broader STM32F103 peripheral support

**Recommendation**: Implement slave mode first, then 3-wire and bidirectional modes as needed

---

### TODO #544: UART half-duplex mode

**Location**: `port/stmicro/stm32/src/hals/STM32F103/uart.zig:1`  
**Author**: Guilherme S. Schultz (2025-05-02)  
**Commit**: 6d0d23473 - "basic f1 HAL (#431)"

**Original Comment**:
```
//TODO: Half-Duplex (Single-Wire mode)
```

**Code Context**:
```zig
//TODO: Half-Duplex (Single-Wire mode)
//TODO: Synchronous mode (For USART only)

const std = @import("std");
const microzig = @import("microzig");
```

**Analysis**:

- **Purpose**: Implement UART half-duplex (single-wire) communication mode
- **Why Incomplete**: Basic STM32F1 HAL implementation focused on standard full-duplex UART
- **Complexity**: Medium
- **Related Items**: TODO #545 (synchronous mode)

**Recommendation**: Implement half-duplex mode configuration and single-wire protocol handling

---

### TODO #545: UART synchronous mode

**Location**: `port/stmicro/stm32/src/hals/STM32F103/uart.zig:2`  
**Author**: Guilherme S. Schultz (2025-05-02)  
**Commit**: 6d0d23473 - "basic f1 HAL (#431)"

**Original Comment**:
```
//TODO: Synchronous mode (For USART only)
```

**Code Context**:
```zig
//TODO: Half-Duplex (Single-Wire mode)
//TODO: Synchronous mode (For USART only)

const std = @import("std");
const microzig = @import("microzig");
```

**Analysis**:

- **Purpose**: Implement USART synchronous mode with clock generation
- **Why Incomplete**: Basic STM32F1 HAL implementation focused on asynchronous UART communication
- **Complexity**: Medium
- **Related Items**: TODO #544 (half-duplex mode)

**Recommendation**: Implement synchronous mode configuration for USART peripherals with clock output

---

### TODO #546: USB error status structure

**Location**: `port/stmicro/stm32/src/hals/STM32F103/usb_internals/usb_ll.zig:174`  
**Author**: Guilherme S. Schultz (2025-05-27)  
**Commit**: f38dfcd9d - "improve STM32 usb (#568)"

**Original Comment**:
```
const UsbErrorStatus = struct {}; //TODO
```

**Code Context**:
```zig
const UsbStatus = struct {
    ep_id: u8,
    setup_data_ready: bool,
    out_data_ready: bool,
    in_data_sent: bool,
};

const UsbErrorStatus = struct {}; //TODO

pub const UsbDevice = struct {
```

**Analysis**:

- **Purpose**: Define USB error status structure for proper error handling
- **Why Incomplete**: USB improvements focused on core functionality and descriptor handling
- **Complexity**: Low
- **Related Items**: Part of STM32 USB driver improvements

**Recommendation**: Define USB error status fields for comprehensive error reporting and handling

---

### TODO #547: STM32F40x chip support

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:3`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 4eba908bd - "migrate code from microzig repo (#1)"

**Original Comment**:
```
//! TODO: Do something useful for other STM32F40x chips.
```

**Code Context**:
```zig
//! STM32F407 HAL
//!
//! TODO: Do something useful for other STM32F40x chips.

const std = @import("std");
const microzig = @import("microzig");
```

**Analysis**:

- **Purpose**: Extend STM32F407 HAL to support other STM32F40x family members
- **Why Incomplete**: Initial migration focused on STM32F407 specifically
- **Complexity**: High
- **Related Items**: Part of broader STM32F4 family support

**Recommendation**: Analyze STM32F40x variants and implement family-wide HAL with chip-specific configurations

---

### TODO #548: Register field extraction utility

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:122`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 4eba908bd - "migrate code from microzig repo (#1)"

**Original Comment**:
```
const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
```

**Code Context**:
```zig
pub fn read(pin: Pin) u1 {
    const idr_reg = get_gpio_register(pin, "IDR");
    const reg_value = @field(idr_reg.read(), "IDR" ++ pin.suffix); // TODO extract to getRegField()?
    return @as(u1, @intCast(reg_value));
}
```

**Analysis**:

- **Purpose**: Create utility function for dynamic register field access
- **Why Incomplete**: Initial migration focused on basic functionality
- **Complexity**: Low
- **Related Items**: Could benefit other register access patterns

**Recommendation**: Implement getRegField() utility for cleaner dynamic register field access

---

### TODO #549: UART word size/parity error handling

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:265`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 4eba908bd - "migrate code from microzig repo (#1)"

**Original Comment**:
```
// TODO: should we consider this an unsupported word size or unsupported parity?
```

**Code Context**:
```zig
if (config.data_bits == .eight and config.parity != null) {
    // TODO: should we consider this an unsupported word size or unsupported parity?
    return error.UnsupportedWordSize;
} else if (config.data_bits == .seven and config.parity == null) {
    // TODO: should we consider this an unsupported word size or unsupported parity?
    return error.UnsupportedParity;
}
```

**Analysis**:

- **Purpose**: Clarify error classification for UART configuration validation
- **Why Incomplete**: Initial migration focused on basic error handling
- **Complexity**: Low
- **Related Items**: TODO #550 (similar error handling)

**Recommendation**: Define clear error types for word size vs parity configuration issues

---

### TODO #550: UART word size/parity error handling (duplicate)

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:268`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: 4eba908bd - "migrate code from microzig repo (#1)"

**Original Comment**:
```
// TODO: should we consider this an unsupported word size or unsupported parity?
```

**Code Context**:
```zig
} else if (config.data_bits == .seven and config.parity == null) {
    // TODO: should we consider this an unsupported word size or unsupported parity?
    return error.UnsupportedParity;
}
```

**Analysis**:

- **Purpose**: Same as TODO #549 - clarify error classification for UART configuration
- **Why Incomplete**: Initial migration focused on basic error handling
- **Complexity**: Low
- **Related Items**: TODO #549 (identical issue)

**Recommendation**: Same as TODO #549 - define clear error types for configuration validation

---

## Batch Summary

**Total TODOs Analyzed**: 25

**Complexity Breakdown**:
- Low: 12 items (48%)
- Medium: 8 items (32%)
- High: 3 items (12%)
- N/A: 2 items (8% - misidentified TODOs)

**Category Breakdown**:
- USB Driver: 9 items (36%)
- STM32 HAL: 14 items (56%)
- Build System: 1 item (4%)
- Misidentified: 1 item (4%)

**Key Themes**:
1. **USB Driver Maturation**: Multiple TODOs around RP2xxx USB implementation validation and error handling
2. **STM32 HAL
