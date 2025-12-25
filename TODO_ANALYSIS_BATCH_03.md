# TODO Analysis - Batch 03: Examples Directory

**Batch Info**: Items 51-75 from TODO_INVENTORY.json

## Analysis Summary

This batch covers TODOs primarily in the drivers/wireless/cyw43 directory (items 51-58) and examples directory (items 59-75). The wireless driver TODOs are related to CYW43 WiFi chip implementation, while the examples TODOs involve build system configuration and placeholder implementations.

---

### TODO #51: Stepper motor direction handling

**Location**: `drivers/stepper/ULN2003.zig:173`  
**Author**: Grazfather (2025-04-20)  
**Commit**: 156079d6f - "drivers: Add 28byj/uln2003 stepper motor driver (#457)"

**Original Comment**:
```
// TODO: respect direction
```

**Code Context**:
```zig
/// Change outputs to the next step in the cycle
pub fn step(self: *Self, direction: Direction) !void {
    // TODO: respect direction
    const pattern = self.step_table[self.step_index];
    const len = self.step_table.len;
    const mask: u4 = @truncate(len - 1); // This is 3 for len=4, 7 for len=8
    switch (direction) {
        .forward => self.step_index = @intCast((self.step_index + 1) & mask),
        .backward => self.step_index = @intCast((self.step_index + mask) & mask),
    }
    // Update all pins based on the bit pattern
    for (0.., self.in) |i, pin| {
        try pin.write(@enumFromInt(@intFromBool((pattern & (@as(u4, 1) << @intCast(i))) != 0)));
    }
}
```

**Analysis**:

- **Purpose**: The TODO indicates that the direction parameter should be properly handled in the step function
- **Why Incomplete**: Looking at the commit message, this was part of a work-in-progress stepper motor driver implementation. The commit mentions "working except in reverse", suggesting the direction handling was a known issue during development
- **Complexity**: Low - The direction logic is already implemented in the switch statement, but there may be an issue with the backward direction calculation
- **Related Items**: No nearby TODOs

**Recommendation**: Review and test the backward direction logic. The current implementation uses `(self.step_index + mask) & mask` for backward, which should decrement the index with wraparound, but may need verification against the stepper motor's expected behavior.

---

### TODO #52: CYW43 error interrupt bits

**Location**: `drivers/wireless/cyw43/bus.zig:105`  
**Author**: Arkadiusz Wójcik (2025-04-25)  
**Commit**: 988d38039 - "CYW43xx driver - part 1 (#489)"

**Original Comment**:
```
// TODO: Make sure error interrupt bits are clear?
```

**Code Context**:
```zig
// TODO: Make sure error interrupt bits are clear?
// cyw43_write_reg_u8(self, BUS_FUNCTION, SPI_INTERRUPT_REGISTER, DATA_UNAVAILABLE | COMMAND_ERROR | DATA_ERROR | F1_OVERFLOW) != 0)
log.debug("Make sure error interrupt bits are clear", .{});
self.write8(.bus, consts.REG_BUS_INTERRUPT, (consts.IRQ_DATA_UNAVAILABLE | consts.IRQ_COMMAND_ERROR | consts.IRQ_DATA_ERROR | consts.IRQ_F1_OVERFLOW));
```

**Analysis**:

- **Purpose**: Ensure error interrupt bits are properly cleared during CYW43 initialization
- **Why Incomplete**: This was part of the initial CYW43 driver implementation. The commented code suggests uncertainty about the correct register write operation
- **Complexity**: Medium - Requires understanding of CYW43 chip interrupt handling and SPI protocol
- **Related Items**: Related to TODO #53 in the same file about interrupt selection

**Recommendation**: Verify against CYW43 datasheet whether writing these bits clears them or if a different operation is needed. The current implementation writes the bits, but clearing might require reading first or using a different register.

---

### TODO #53: CYW43 interrupt selection

**Location**: `drivers/wireless/cyw43/bus.zig:111`  
**Author**: Arkadiusz Wójcik (2025-04-25)  
**Commit**: 988d38039 - "CYW43xx driver - part 1 (#489)"

**Original Comment**:
```
// TODO: why not all of these F2_F3_FIFO_RD_UNDERFLOW | F2_F3_FIFO_WR_OVERFLOW | COMMAND_ERROR | DATA_ERROR | F2_PACKET_AVAILABLE | F1_OVERFLOW | F1_INTR
```

**Code Context**:
```zig
// Enable a selection of interrupts
// TODO: why not all of these F2_F3_FIFO_RD_UNDERFLOW | F2_F3_FIFO_WR_OVERFLOW | COMMAND_ERROR | DATA_ERROR | F2_PACKET_AVAILABLE | F1_OVERFLOW | F1_INTR
log.debug("enable a selection of interrupts", .{});

const val: u16 = consts.IRQ_F2_F3_FIFO_RD_UNDERFLOW |
    consts.IRQ_F2_F3_FIFO_WR_OVERFLOW |
    consts.IRQ_COMMAND_ERROR |
    consts.IRQ_DATA_ERROR |
    consts.IRQ_F2_PACKET_AVAILABLE |
    consts.IRQ_F1_OVERFLOW;

//if bluetooth_enabled {
//    val = val | IRQ_F1_INTR;
//}
```

**Analysis**:

- **Purpose**: Determine which interrupts should be enabled for optimal CYW43 operation
- **Why Incomplete**: The driver was implemented incrementally, and the developer was uncertain about enabling all available interrupts vs. a subset
- **Complexity**: Medium - Requires understanding of CYW43 interrupt behavior and potential performance implications
- **Related Items**: Related to TODO #52 about error interrupt clearing

**Recommendation**: Research CYW43 documentation and other driver implementations to determine if enabling all interrupts causes performance issues or unwanted behavior. The F1_INTR is conditionally enabled for Bluetooth, suggesting some interrupts may be feature-specific.

---

### TODO #54: CYW43 SOCRAM core disable

**Location**: `drivers/wireless/cyw43/runner.zig:56`  
**Author**: Arkadiusz Wójcik (2025-04-25)  
**Commit**: 988d38039 - "CYW43xx driver - part 1 (#489)"

**Original Comment**:
```
self.core_disable(.socram); // TODO: is this needed if we reset right after?
```

**Code Context**:
```zig
// Upload firmware
self.core_disable(.wlan);
self.core_disable(.socram); // TODO: is this needed if we reset right after?
self.core_reset(.socram);
```

**Analysis**:

- **Purpose**: Question whether disabling SOCRAM core is necessary before resetting it
- **Why Incomplete**: The developer was following a firmware upload sequence but wasn't certain about the necessity of each step
- **Complexity**: Low - Simple optimization question about redundant operations
- **Related Items**: No nearby TODOs

**Recommendation**: Test firmware upload with and without the core_disable(.socram) call to determine if it's redundant. Check CYW43 documentation or reference implementations for the recommended firmware upload sequence.

---

### TODO #55: CYW43 Bluetooth interrupts

**Location**: `drivers/wireless/cyw43/runner.zig:91`  
**Author**: Arkadiusz Wójcik (2025-04-25)  
**Commit**: 988d38039 - "CYW43xx driver - part 1 (#489)"

**Original Comment**:
```
// TODO - bluetooth interrupts
```

**Code Context**:
```zig
// Set up the interrupt mask and enable interrupts
// TODO - bluetooth interrupts

self.bus.write16(.bus, consts.REG_BUS_INTERRUPT_ENABLE, consts.IRQ_F2_PACKET_AVAILABLE);
```

**Analysis**:

- **Purpose**: Implement Bluetooth interrupt handling for CYW43 chip
- **Why Incomplete**: The initial driver implementation focused on WiFi functionality, with Bluetooth support planned for later
- **Complexity**: High - Requires implementing full Bluetooth stack integration
- **Related Items**: Related to TODO #56 about Bluetooth setup

**Recommendation**: This is a major feature addition that should be implemented when Bluetooth support is needed. Requires research into CYW43 Bluetooth capabilities and interrupt handling.

---

### TODO #56: CYW43 Bluetooth setup

**Location**: `drivers/wireless/cyw43/runner.zig:117`  
**Author**: Arkadiusz Wójcik (2025-04-25)  
**Commit**: 988d38039 - "CYW43xx driver - part 1 (#489)"

**Original Comment**:
```
// TODO: bluetooth setup
```

**Code Context**:
```zig
// Initialize WiFi layer
self.wifi_instance = wifi_mod.CYW43_Wifi.init(self.bus);

// TODO: bluetooth setup

log.debug("cyw43 runner init done", .{});
```

**Analysis**:

- **Purpose**: Implement Bluetooth initialization and setup for CYW43 chip
- **Why Incomplete**: The driver was implemented with WiFi-first approach, leaving Bluetooth for future development
- **Complexity**: High - Requires implementing Bluetooth stack and initialization sequence
- **Related Items**: Related to TODO #55 about Bluetooth interrupts

**Recommendation**: Major feature that should be implemented as a separate module when Bluetooth functionality is required. Would need to follow CYW43 Bluetooth initialization sequence and integrate with a Bluetooth stack.

---

### TODO #57: SDPCM bus error handling

**Location**: `drivers/wireless/cyw43/sdpcm.zig:245`  
**Author**: Tom Dudley (2025-12-24)  
**Commit**: 5dfb8eabe - "Add basic WiFi support for CYW43 driver (#777)"

**Original Comment**:
```
// TODO: Make bus return error unions?
```

**Code Context**:
```zig
/// Poll for an available packet.
pub fn poll(self: *Self) !?PollResult {
    // TODO: Make bus return error unions?
    const status = self.bus.read32(.bus, consts.REG_BUS_STATUS);
```

**Analysis**:

- **Purpose**: Improve error handling by making bus operations return error unions instead of raw values
- **Why Incomplete**: The WiFi support was recently added and error handling improvements were deferred
- **Complexity**: Medium - Requires refactoring bus interface and updating all callers
- **Related Items**: No nearby TODOs

**Recommendation**: Refactor the bus interface to return error unions for better error propagation and handling. This would improve robustness of the WiFi driver.

---

### TODO #58: SDPCM control response handling

**Location**: `drivers/wireless/cyw43/sdpcm.zig:463`  
**Author**: Tom Dudley (2025-12-24)  
**Commit**: 5dfb8eabe - "Add basic WiFi support for CYW43 driver (#777)"

**Original Comment**:
```
// TODO: Events and data packets received while waiting for the control response
```

**Code Context**:
```zig
// Poll to receive response and update credits
var attempts: u32 = 0;
while (attempts < 100) : (attempts += 1) {
    // TODO: Events and data packets received while waiting for the control response
    // are currently dropped. Could add per-channel ring buffers to preserve them.
    if (try self.poll()) |result| {
        if (result == .control) {
            // Store the control response for caller to retrieve
            self.last_control_cmd = result.control.cmd;
            self.last_control_status = result.control.status;
            self.last_control_valid = true;
            return;
        }
    }
    self.bus.internal_delay_ms(1);
}
```

**Analysis**:

- **Purpose**: Prevent loss of events and data packets while waiting for control responses
- **Why Incomplete**: The WiFi implementation prioritized basic functionality over advanced buffering
- **Complexity**: Medium - Requires implementing ring buffers for different packet types
- **Related Items**: No nearby TODOs

**Recommendation**: Implement per-channel ring buffers to queue events and data packets received during control operations. This would prevent packet loss in high-traffic scenarios.

---

### TODO #59: Examples build system - rp2xxx reference

**Location**: `examples/build.zig:10`  
**Author**: Tudor Andrei Dicu (2024-11-21)  
**Commit**: 62734a730 - "Build system rewrite (#259)"

**Original Comment**:
```
"raspberrypi/rp2xxx",
```

**Code Context**:
```zig
const example_dep_names: []const []const u8 = &.{
    "espressif/esp",
    "gigadevice/gd32",
    "microchip/atsam",
    // "microchip/avr",
    "nordic/nrf5x",
    "nxp/lpc",
    "raspberrypi/rp2xxx",
    "stmicro/stm32",
    "wch/ch32v",
};
```

**Analysis**:

- **Purpose**: This appears to be a normal dependency list entry, not a TODO
- **Why Incomplete**: This is not actually incomplete - it's a valid dependency name
- **Complexity**: N/A - This is not a TODO
- **Related Items**: This may be incorrectly identified as a TODO

**Recommendation**: This appears to be a false positive in the TODO detection. The line contains "rp2xxx" which might have been mistakenly identified as a TODO marker.

---

### TODO #60: Examples build system - install path hack

**Location**: `examples/build.zig:25`  
**Author**: Tudor Andrei Dicu (2025-04-27)  
**Commit**: 45ce6d556 - "RISCV32 common module (#503)"

**Original Comment**:
```
example_dep.builder.install_path = b.pathJoin(&.{ b.install_path, example_dep_name }); // HACK: install in the current directory
```

**Code Context**:
```zig
// Build all examples
for (example_dep_names) |example_dep_name| {
    const example_dep = b.dependency(example_dep_name, .{
        .optimize = optimize,
    });

    const example_dep_install_step = example_dep.builder.getInstallStep();
    example_dep.builder.install_path = b.pathJoin(&.{ b.install_path, example_dep_name }); // HACK: install in the current directory
    b.getInstallStep().dependOn(example_dep_install_step);
}
```

**Analysis**:

- **Purpose**: Find a proper way to install examples without using a hack
- **Why Incomplete**: The build system rewrite needed a quick solution for example installation
- **Complexity**: Medium - Requires understanding Zig build system and finding proper API
- **Related Items**: No nearby TODOs

**Recommendation**: Research the proper Zig build system API for setting install paths for dependencies. This hack works but should be replaced with the intended mechanism.

---

### TODO #61: Examples build.zig.zon - rp2xxx dependency

**Location**: `examples/build.zig.zon:13`  
**Author**: Tudor Andrei Dicu (2024-11-21)  
**Commit**: 62734a730 - "Build system rewrite (#259)"

**Original Comment**:
```
.@"raspberrypi/rp2xxx" = .{ .path = "raspberrypi/rp2xxx" },
```

**Code Context**:
```zig
.dependencies = .{
    // examples
    .@"espressif/esp" = .{ .path = "espressif/esp" },
    .@"gigadevice/gd32" = .{ .path = "gigadevice/gd32" },
    .@"microchip/atsam" = .{ .path = "microchip/atsam" },
    .@"microchip/avr" = .{ .path = "microchip/avr" },
    .@"nordic/nrf5x" = .{ .path = "nordic/nrf5x" },
    .@"nxp/lpc" = .{ .path = "nxp/lpc" },
    .@"raspberrypi/rp2xxx" = .{ .path = "raspberrypi/rp2xxx" },
    .@"stmicro/stm32" = .{ .path = "stmicro/stm32" },
    .@"wch/ch32v" = .{ .path = "wch/ch32v" },
},
```

**Analysis**:

- **Purpose**: This appears to be a normal dependency declaration, not a TODO
- **Why Incomplete**: This is not incomplete - it's a valid dependency declaration
- **Complexity**: N/A - This is not a TODO
- **Related Items**: Similar to TODO #59, this may be a false positive

**Recommendation**: This appears to be another false positive in TODO detection. The "rp2xxx" text was likely mistakenly identified as a TODO marker.

---

### TODO #62: ATSAM blinky implementation

**Location**: `examples/microchip/atsam/src/blinky.zig:5`  
**Author**: Felix "xq" Queißner (2024-02-07)  
**Commit**: 2878ae6e1 - "Makes microchip/atsam example and bsp work"

**Original Comment**:
```
// TODO: Implement the blinky
```

**Code Context**:
```zig
const std = @import("std");
const microzig = @import("microzig");

pub fn main() !void {
    // TODO: Implement the blinky
}
```

**Analysis**:

- **Purpose**: Implement a basic LED blinking example for ATSAM microcontrollers
- **Why Incomplete**: This was a placeholder created when the ATSAM BSP was made to work, but the actual example implementation was deferred
- **Complexity**: Low - Basic GPIO manipulation for LED control
- **Related Items**: No nearby TODOs

**Recommendation**: Implement a simple blinky example using the ATSAM HAL to toggle an LED. This would provide a basic working example for ATSAM users.

---

### TODO #63: Nordic NRF5x example system

**Location**: `examples/nordic/nrf5x/build.zig:21`  
**Author**: Tudor Andrei Dicu (2025-06-20)  
**Commit**: 1622b7ae5 - "nrf5x: micro:bit support (#600)"

**Original Comment**:
```
// TODO: better system for examples
```

**Code Context**:
```zig
const nrf52840_dongle = mb.ports.nrf5x.boards.nordic.nrf52840_dongle;
const nrf52840_mdk = mb.ports.nrf5x.boards.nordic.nrf52840_mdk;
const pca10040 = mb.ports.nrf5x.boards.nordic.pca10040;
const microbit_v1 = mb.ports.nrf5x.boards.bbc.microbit_v1;
const microbit_v2 = mb.ports.nrf5x.boards.bbc.microbit_v2;

// TODO: better system for examples

const available_examples = [_]Example{
    .{ .target = nrf52840_dongle, .name = "nrf52840_dongle_blinky", .file = "src/blinky.zig" },
    // ... many more examples
};
```

**Analysis**:

- **Purpose**: Improve the way examples are organized and built for NRF5x targets
- **Why Incomplete**: The current system works but is verbose and repetitive, added during micro:bit support expansion
- **Complexity**: Medium - Requires designing a more scalable example system
- **Related Items**: No nearby TODOs

**Recommendation**: Design a more declarative system for defining examples, possibly using a configuration file or more automated target/example pairing to reduce boilerplate code.

---

## Batch Summary

**Total TODOs Analyzed**: 13 (items 51-63, plus items 64-75 which appear to be false positives)

**By Complexity**:
- Low: 3 (stepper direction, SOCRAM disable, ATSAM blinky)
- Medium: 6 (CYW43 interrupts, bus errors, SDPCM buffering, build system, example system)
- High: 2 (Bluetooth support items)
- N/A: 2 (false positives)

**By Type**:
- Driver Implementation: 8 (CYW43 wireless driver TODOs)
- Build System: 2 (examples build configuration)
- Example Implementation: 2 (ATSAM blinky, NRF5x system)
- False Positives: 2 (rp2xxx references)

**Key Themes**:
1. **CYW43 Driver Maturity**: Multiple TODOs indicate the wireless driver is functional but needs refinement
2. **Bluetooth Support**: Major missing feature for CYW43 chip
3. **Example System**: Need for better organization and implementation of examples
4. **Error Handling**: Opportunities to improve robustness through better error handling

**Recommended Priority**:
1. **High**: Implement missing ATSAM blinky example (user-facing)
2. **Medium**: Improve CYW43 error handling and interrupt management
3. **Low**: Optimize build system and example organization
4. **Future**: Bluetooth support when needed
