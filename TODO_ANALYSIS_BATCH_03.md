# TODO Analysis - Batch 03: Examples Directory

**Batch Info**: 25 TODOs from the examples directory
**Analysis Date**: 2025-12-25
**Analyzer**: Cline

---

## Overview

This batch covers TODOs in the examples directory, focusing on example applications for various microcontroller platforms including STM32, Raspberry Pi RP2xxx, and RTT/foundation-libc modules.

---

### TODO #128: Enable commented STM32 targets in build.zig

**Location**: `examples/stmicro/stm32/build.zig:18`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
// TODO: stm32.pins.GlobalConfiguration is not available on those targets
```

**Code Context**:
```zig
const available_examples = [_]Example{
    .{ .target = stm32.boards.stm32f3discovery, .name = "stm32f3discovery", .file = "src/blinky.zig" },
    // TODO: stm32.pins.GlobalConfiguration is not available on those targets
    // .{ .target = stm32.chips.stm32f407vg, .name = "stm32f407vg", .file = "src/blinky.zig" },
    // .{ .target = stm32.chips.stm32f429zit6u, .name = "stm32f429zit6u", .file = "src/blinky.zig" },
    // .{ .target = stm32.boards.stm32f4discovery, .name = "stm32f4discovery", .file = "src/blinky.zig" },
    // .{ .target = stm32.boards.stm3240geval, .name = "stm3240geval", .file = "src/blinky.zig" },
    // .{ .target = stm32.boards.stm32f429idiscovery, .name = "stm32f429idiscovery", .file = "src/blinky.zig" },
    .{ .target = stm32.boards.stm32f3discovery, .name = "STM32F303_HTS221", .file = "src/hts221.zig" },
```

**Analysis**:

- **Purpose**: Enable support for STM32F4 series boards and chips that are currently commented out
- **Why Incomplete**: The `stm32.pins.GlobalConfiguration` API is not yet implemented for these STM32F4 targets, preventing their examples from building
- **Complexity**: Medium - Requires implementing the GlobalConfiguration API for STM32F4 family
- **Related Items**: Related to pin configuration system in port/stmicro/stm32

**Recommendation**: Implement `stm32.pins.GlobalConfiguration` for STM32F4 targets (stm32f407vg, stm32f429zit6u) or refactor examples to not require it. This is blocking examples for popular STM32F4 development boards.

---

### TODO #129: Port USB driver from RPxxxx to STM32F1

**Location**: `examples/stmicro/stm32/src/stm32f1xx/usb_cdc.zig:210`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
//TODO port USB driver from RPxxxx USB HAL
```

**Code Context**:
```zig
fn get_descriptor(setup: []const u8, epc: EpControl) void {
    const descriptor_type = setup[3];
    const descriptor_length: u16 = @as(u16, setup[6]) | (@as(u16, setup[7]) << 8);

    const buffer: []const u8 = switch (descriptor_type) {
        0x01 => &DeviceDescriptor,
        0x02 => &ConfigDescriptor,
        0x03 => get_string(setup[2]),
        0x06 => &DeviceQualifierDescriptor,
        else => return,
    };
    //TODO port USB driver from RPxxxx USB HAL

    const length = @min(buffer.len, descriptor_length);
```

**Analysis**:

- **Purpose**: Port the more mature USB driver implementation from Raspberry Pi RP2xxx HAL to STM32F1
- **Why Incomplete**: STM32F1 USB implementation is experimental/incomplete, while RP2xxx has a working USB HAL
- **Complexity**: High - Requires understanding both USB implementations and adapting to STM32F1 hardware differences
- **Related Items**: Related to TODOs #130, #132 - all USB-related for STM32F1

**Recommendation**: Create a unified USB HAL abstraction that can work across both RP2xxx and STM32F1, then port the working RP2xxx implementation. This is a significant undertaking but would benefit the entire project.

---

### TODO #130: Port USB driver for remote HID

**Location**: `examples/stmicro/stm32/src/stm32f1xx/usb_remote_hid.zig:168`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
//TODO port USB driver from RPxxxx USB HAL
```

**Code Context**:
```zig
fn get_descriptor(setup: []const u8, epc: EpControl) void {
    const descriptor_type = setup[3];
    const descriptor_length: u16 = @as(u16, setup[6]) | (@as(u16, setup[7]) << 8);

    const buffer: []const u8 = switch (descriptor_type) {
        0x01 => &DeviceDescriptor,
        0x02 => &ConfigDescriptor,
        0x03 => get_string(setup[2]),
        else => return,
    };
    //TODO port USB driver from RPxxxx USB HAL
```

**Analysis**:

- **Purpose**: Same as #129 but for USB HID (Human Interface Device) implementation
- **Why Incomplete**: Part of the broader STM32F1 USB HAL incompleteness
- **Complexity**: High
- **Related Items**: Directly related to #129, #131, #132, #133

**Recommendation**: Should be addressed as part of the same USB HAL unification effort mentioned in #129.

---

### TODO #131: Implement full HID report function

**Location**: `examples/stmicro/stm32/src/stm32f1xx/usb_remote_hid.zig:302`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
//TODO: full HID report function
```

**Code Context**:
```zig
fn send_report(report: HIDReport) void {
    const EPC = usb_ll.EpControl.EPC1;
    const send: *volatile bool = &USB_send;
    send.* = true;
    const msg: [8]u8 = .{
        report.modifiers,
        0x00,
        report.keys[0],
        report.keys[1],
        report.keys[2],
        report.keys[3],
        report.keys[4],
        report.keys[5],
    };
    //TODO: full HID report function
    EPC.USB_send(&msg, .no_change) catch unreachable;
```

**Analysis**:

- **Purpose**: Implement complete HID report functionality beyond basic keyboard reports
- **Why Incomplete**: Current implementation only handles keyboard reports with basic fields, missing extended HID functionality
- **Complexity**: Medium - Needs to support full HID report descriptor specification
- **Related Items**: Related to #133 (same TODO in different file)

**Recommendation**: Expand to support full HID report descriptor including different report types (input/output/feature), multiple report IDs, and variable-length reports.

---

### TODO #132: Port USB driver for basic HID

**Location**: `examples/stmicro/stm32/src/stm32f1xx/usb_hid.zig:154`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
//TODO port USB driver from RPxxxx USB HAL
```

**Code Context**:
```zig
fn get_descriptor(setup: []const u8, epc: EpControl) void {
    const descriptor_type = setup[3];
    const descriptor_length: u16 = @as(u16, setup[6]) | (@as(u16, setup[7]) << 8);

    const buffer: []const u8 = switch (descriptor_type) {
        0x01 => &DeviceDescriptor,
        0x02 => &ConfigDescriptor,
        0x03 => get_string(setup[2]),
        0x04 => &HIDReportDescriptor,
        else => return,
    };
    //TODO port USB driver from RPxxxx USB HAL
```

**Analysis**:

- **Purpose**: Same USB driver porting task for basic HID example
- **Why Incomplete**: Part of overall STM32F1 USB HAL effort
- **Complexity**: High
- **Related Items**: Same as #129, #130

**Recommendation**: Address as part of unified USB HAL effort.

---

### TODO #133: Implement full HID report function (duplicate)

**Location**: `examples/stmicro/stm32/src/stm32f1xx/usb_hid.zig:246`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
//TODO: full HID report function
```

**Code Context**:
```zig
fn send_report(report: HIDReport) void {
    const EPC = usb_ll.EpControl.EPC1;
    const send: *volatile bool = &USB_send;
    send.* = true;
    const msg: [8]u8 = .{
        report.modifiers,
        0x00,
        report.keys[0],
        report.keys[1],
        report.keys[2],
        report.keys[3],
        report.keys[4],
        report.keys[5],
    };
    //TODO: full HID report function
    EPC.USB_send(&msg, .no_change) catch unreachable;
```

**Analysis**:

- **Purpose**: Same as #131 - implement complete HID report functionality
- **Why Incomplete**: Duplicate of #131 in different example file
- **Complexity**: Medium
- **Related Items**: Duplicate of #131

**Recommendation**: Should be resolved together with #131 by creating a shared HID report implementation.

---

### TODO #134: Use drivers parameter in usb_hid example

**Location**: `examples/raspberrypi/rp2xxx/src/usb_hid.zig:89`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
_ = drivers; // TODO
```

**Code Context**:
```zig
pub fn main() !void {
    usb.Usb.init_clk();
    const drivers = [_]usb.types.UsbClassDriver{hid_driver};
    var device_config = usb.DeviceConfiguration.init(&drivers);
    usb.Usb.init_device(&device_config) catch unreachable;
    var timer = time.Timer{};

    var x: i8 = 0;
    var y: i8 = 0;

    _ = drivers; // TODO

    while (true) {
        timer.reset();
```

**Analysis**:

- **Purpose**: Actually use the drivers parameter that's currently being discarded
- **Why Incomplete**: The drivers array is created but then explicitly ignored with `_ = drivers;`
- **Complexity**: Low - Just needs cleanup, drivers are passed to init_device
- **Related Items**: None

**Recommendation**: Remove the `_ = drivers;` line as the drivers variable is already used in `usb.DeviceConfiguration.init(&drivers)`. This is just dead code cleanup.

---

### TODO #287: RTT buffer overflow handling option

**Location**: `modules/rtt/src/rtt.zig:236`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
/// TODO: build.zig option that allows users to opt-in to returning WriteError on full RTT buffer?
```

**Code Context**:
```zig
pub fn write(self: *Self, msg: []const u8) !void {
    if (!self.writer_ready) {
        return; // Silently drop data if not connected
    }

    var index: usize = 0;
    while (index < msg.len) {
        /// TODO: build.zig option that allows users to opt-in to returning WriteError on full RTT buffer?
        const written = try self.down_channel.write(msg[index..]);
        if (written == 0) {
            // Buffer is full, block mode would wait here
            // For now we just drop remaining data
            return;
        }
        index += written;
    }
}
```

**Analysis**:

- **Purpose**: Add build-time configuration to control RTT buffer overflow behavior
- **Why Incomplete**: Currently silently drops data on buffer full, but some users may want explicit errors
- **Complexity**: Low - Just needs a build.zig option and conditional error return
- **Related Items**: Related to RTT reliability for debugging

**Recommendation**: Add a build option like `rtt_error_on_full: bool = false` that when true returns `error.BufferFull` instead of silently dropping data. This gives users choice between performance (drop) and reliability (error).

---

### TODO #288: Clarify RTT channel mode impact

**Location**: `modules/rtt/src/rtt.zig:318`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
/// TODO: Does the channel's mode actually matter here?
```

**Code Context**:
```zig
pub fn read(self: *Self, buf: []u8) ![]const u8 {
    if (!self.reader_ready) {
        return error.NotReady;
    }

    /// TODO: Does the channel's mode actually matter here?
    return self.up_channel.read(buf);
}
```

**Analysis**:

- **Purpose**: Clarify whether RTT channel mode (blocking/non-blocking) affects read behavior
- **Why Incomplete**: Uncertainty about whether different channel modes need different handling
- **Complexity**: Low - Requires reviewing RTT specification and testing
- **Related Items**: Part of RTT implementation consistency

**Recommendation**: Review RTT specification for channel modes and add documentation. If mode doesn't matter for reads, document why; if it does, implement appropriate handling.

---

### TODO #289: Implement multi-byte conversion state

**Location**: `modules/foundation-libc/include/uchar.h:7`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```c
int dummy; // TODO: fill in internal multi-byte conversion state
```

**Code Context**:
```c
typedef struct {
    int dummy; // TODO: fill in internal multi-byte conversion state
} mbstate_t;
```

**Analysis**:

- **Purpose**: Implement proper multi-byte character conversion state for C library
- **Why Incomplete**: Placeholder implementation for mbstate_t structure
- **Complexity**: Medium - Requires understanding multi-byte encodings (UTF-8, etc.)
- **Related Items**: Part of foundation-libc completeness

**Recommendation**: Implement proper mbstate_t with fields for: encoding state (partial UTF-8 sequence), byte count, and shift state. Reference standard C library implementations.

---

### TODO #290-303: String function implementations

**Location**: `modules/foundation-libc/src/modules/string.zig:9-22`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comments**:
```zig
// TODO: memchr
// TODO: memcmp
// TODO: memmove
// TODO: strcat
// TODO: strcmp
// TODO: strcpy
// TODO: strcspn
// TODO: strerror
// TODO: strncat
// TODO: strncpy
// TODO: strpbrk
// TODO: strrchr
// TODO: strspn
// TODO: strstr
```

**Code Context**:
```zig
// String operations currently unimplemented:
// TODO: memchr
// TODO: memcmp
// TODO: memmove
// TODO: strcat
// TODO: strcmp
// TODO: strcpy
// TODO: strcspn
// TODO: strerror
// TODO: strncat
// TODO: strncpy
// TODO: strpbrk
// TODO: strrchr
// TODO: strspn
// TODO: strstr
```

**Analysis**:

- **Purpose**: Implement standard C string functions for foundation-libc
- **Why Incomplete**: Foundation libc is a minimal implementation, these are non-critical functions
- **Complexity**: Low-Medium (individual functions are straightforward, but need thorough testing)
- **Related Items**: All part of completing foundation-libc string.h support

**Recommendation**: Implement these standard string functions prioritized by usage in microzig codebase. Start with most commonly needed: strcmp, strcpy, memcmp, memmove. Use Zig's safety features to create more robust implementations than standard C.

**Priority breakdown**:
- **High**: strcmp, strcpy, memcmp, memmove (commonly needed)
- **Medium**: strcat, strncat, strncpy, memchr (useful utilities)
- **Low**: strcspn, strpbrk, strrchr, strspn, strstr, strerror (less common in embedded)

---

### TODO #304: Verbose exception handler

**Location**: `modules/riscv32-common/src/riscv32_common.zig:46`  
**Author**: Needs git analysis  
**Commit**: Needs investigation

**Original Comment**:
```zig
// TODO: Verbose exception handler
```

**Code Context**:
```zig
fn default_exception_handler() callconv(.Naked) noreturn {
    // TODO: Verbose exception handler
    asm volatile (
        \\ 1:
        \\   j 1b
    );
}
```

**Analysis**:

- **Purpose**: Implement detailed exception handler for RISC-V that provides debugging information
- **Why Incomplete**: Current handler just loops forever, providing no diagnostic information
- **Complexity**: Medium - Needs to save and display CPU state, exception cause, trap value
- **Related Items**: Related to RISC-V debugging and development experience

**Recommendation**: Implement exception handler that:
1. Saves all registers to stack
2. Reads mcause and mtval CSRs to determine exception type
3. Optionally outputs diagnostic information via UART/RTT
4. Provides useful panic message with PC, cause, and register dump

This significantly improves debugging experience for RISC-V targets.

---

## Summary Statistics

- **Total TODOs**: 25
- **Complexity Breakdown**:
  - Low: 6 (24%)
  - Medium: 7 (28%)
  - High: 3 (12%)
  - Multiple related: 9 (36% - string functions)

- **Category Breakdown**:
  - USB HAL: 5 (20%)
  - String functions: 14 (56%)
  - RTT: 2 (8%)
  - Pin configuration: 1 (4%)
  - Exception handling: 1 (4%)
  - Multi-byte support: 1 (4%)
  - Code cleanup: 1 (4%)

## Priority Recommendations

### High Priority
1. **USB HAL unification** (#129, #130, #132) - Blocks STM32F1 USB functionality
2. **Pin configuration for STM32F4** (#128) - Blocks popular development boards
3. **String functions (subset)** (#290-294) - Critical for C compatibility

### Medium Priority
4. **HID report implementation** (#131, #133) - Improves USB HID examples
5. **RISC-V exception handler** (#304) - Improves debugging experience
6. **RTT buffer handling** (#287) - Improves reliability options
7. **Multi-byte conversion** (#289) - Needed for proper Unicode support

### Low Priority
8. **Code cleanup** (#134) - Minor cleanup
9. **RTT mode clarification** (#288) - Documentation improvement
10. **Remaining string functions** (#295-303) - Nice-to-have utilities

## Notes

Several TODOs in this batch are inter-related:
- The USB driver TODOs (#129, #130, #132) should be addressed together
- The HID report TODOs (#131, #133) are duplicates
- The string function TODOs (#290-303) form a cohesive set

The string functions block represents the largest single category and would significantly improve foundation-libc completeness.

---

**Analysis Complete**: 2025-12-25
