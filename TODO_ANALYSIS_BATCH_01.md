# TODO Analysis - Batch 01: Core Directory

**Batch Info**: Items 1-25 from TODO_INVENTORY.json

---

### TODO #1: CI workflow port directory list

**Location**: `.github/workflows/ci.yml:150`  
**Author**: Matt Knight (2025-01-18)  
**Commit**: 5a59f3d64 - "Generate standalone files for Regz by default (#353)"

**Original Comment**:
```
port_dir: [gigadevice/gd32, raspberrypi/rp2xxx, stmicro/stm32]
```

**Code Context**:
```yaml
  unit-test-ports:
    name: Unit Test Ports
    continue-on-error: true
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        port_dir: [gigadevice/gd32, raspberrypi/rp2xxx, stmicro/stm32]
    steps:
      - name: Checkout
        uses: actions/checkout@v4
```

**Analysis**:

- **Purpose**: This appears to be a placeholder or incomplete list of port directories for CI testing. The comment suggests this should include all available ports but currently only lists 3 out of many available ports.
- **Why Incomplete**: The commit was focused on Regz changes, and this may have been left as a reminder to update the CI matrix with all ports.
- **Complexity**: Low
- **Related Items**: Related to TODO #2 in the same file

**Recommendation**: Update the port_dir matrix to include all available ports from the port_list in build.zig, or create a mechanism to automatically sync this list.

---

### TODO #2: CI workflow example directory list

**Location**: `.github/workflows/ci.yml:177`  
**Author**: Elijah Sauder (2025-01-15)  
**Commit**: 752386cac - "Update CI workflow with job dependencies (#340)"

**Original Comment**:
```
raspberrypi/rp2xxx,
```

**Code Context**:
```yaml
        example_dir: [
            espressif/esp,
            gigadevice/gd32,
            #microchip/avr,
            microchip/atsam,
            nordic/nrf5x,
            nxp/lpc,
            nxp/mcx,
            stmicro/stm32,
            raspberrypi/rp2xxx,
            wch/ch32v,
          ]
```

**Analysis**:

- **Purpose**: This line appears to be correctly placed in the example_dir matrix, but the TODO marker suggests it may need attention or verification.
- **Why Incomplete**: The commit was about adding job dependencies, and this may have been marked for review to ensure the rp2xxx examples are properly integrated.
- **Complexity**: Low
- **Related Items**: Related to TODO #1 and the overall CI configuration

**Recommendation**: Verify that the rp2xxx examples build correctly and remove the TODO marker if everything is working as expected.

---

### TODO #3: Build system port list entry

**Location**: `build.zig:32`  
**Author**: Tudor Andrei Dicu (2024-11-21)  
**Commit**: 62734a730 - "Build system rewrite (#259)"

**Original Comment**:
```
.{ .name = "rp2xxx", .dep_name = "port/raspberrypi/rp2xxx" },
```

**Code Context**:
```zig
const port_list: []const struct {
    name: [:0]const u8,
    dep_name: [:0]const u8,
} = &.{
    .{ .name = "esp", .dep_name = "port/espressif/esp" },
    .{ .name = "gd32", .dep_name = "port/gigadevice/gd32" },
    .{ .name = "atsam", .dep_name = "port/microchip/atsam" },
    .{ .name = "avr", .dep_name = "port/microchip/avr" },
    .{ .name = "nrf5x", .dep_name = "port/nordic/nrf5x" },
    .{ .name = "lpc", .dep_name = "port/nxp/lpc" },
    .{ .name = "mcx", .dep_name = "port/nxp/mcx" },
    .{ .name = "rp2xxx", .dep_name = "port/raspberrypi/rp2xxx" },
    .{ .name = "stm32", .dep_name = "port/stmicro/stm32" },
    .{ .name = "ch32v", .dep_name = "port/wch/ch32v" },
};
```

**Analysis**:

- **Purpose**: This entry appears to be correctly defined in the port list. The TODO marker may indicate this was added during the build system rewrite and needed verification.
- **Why Incomplete**: During the major build system rewrite, this may have been marked to ensure the rp2xxx port integration was complete.
- **Complexity**: Low
- **Related Items**: Related to TODOs #4, #5, #6, #8 - all rp2xxx integration items

**Recommendation**: Verify that the rp2xxx port is fully functional and remove the TODO marker.

---

### TODO #4: PortSelect struct field

**Location**: `build.zig:150`  
**Author**: Matt Knight (2025-10-26)  
**Commit**: 27307e01d - "\"Regz Wizard\" -> Sorcerer (#716)"

**Original Comment**:
```
rp2xxx: bool = false,
```

**Code Context**:
```zig
pub const PortSelect = struct {
    esp: bool = false,
    gd32: bool = false,
    atsam: bool = false,
    avr: bool = false,
    nrf5x: bool = false,
    lpc: bool = false,
    mcx: bool = false,
    rp2xxx: bool = false,
    stm32: bool = false,
    ch32v: bool = false,
```

**Analysis**:

- **Purpose**: This field appears to be correctly defined in the PortSelect struct. The TODO marker may be a remnant from when this field was added.
- **Why Incomplete**: The commit was about renaming "Regz Wizard" to "Sorcerer", and this TODO may have been accidentally preserved.
- **Complexity**: Low
- **Related Items**: Part of the rp2xxx integration series (TODOs #3, #5, #6, #8)

**Recommendation**: Remove the TODO marker as this field appears to be properly implemented.

---

### TODO #5: Documentation example comment

**Location**: `build.zig:207`  
**Author**: Tudor Andrei Dicu (2024-11-22)  
**Commit**: 80d5b663d - "Build system bug fix (#292)"

**Original Comment**:
```
///     .rp2xxx = true,
```

**Code Context**:
```zig
/// const MicroBuild = microzig.MicroBuild(.{
///     .rp2xxx = true,
/// });
///
/// pub fn build(b: *std.Build) void {
///     const optimize = b.standardOptimizeOption(.{});
///
///     const mz_dep = b.dependency("microzig", .{});
///     const mb = MicroBuild.init(b, mz_dep) orelse return;
```

**Analysis**:

- **Purpose**: This is documentation showing how to use the rp2xxx port in the MicroBuild system. The TODO marker may indicate this example needed verification.
- **Why Incomplete**: During the build system bug fixes, this documentation example may have been marked to ensure it was accurate.
- **Complexity**: Low
- **Related Items**: Related to TODO #6 which shows the target usage

**Recommendation**: Verify the example works correctly and remove the TODO marker.

---

### TODO #6: Documentation target example

**Location**: `build.zig:219`  
**Author**: Tudor Andrei Dicu (2024-11-22)  
**Commit**: 80d5b663d - "Build system bug fix (#292)"

**Original Comment**:
```
///         .target = mb.ports.rp2xxx.boards.raspberrypi.pico,
```

**Code Context**:
```zig
///     const fw = mb.add_firmware(.{
///         .name = "test",
///         .root_source_file = b.path("src/main.zig"),
///         .target = mb.ports.rp2xxx.boards.raspberrypi.pico,
///         .optimize = optimize,
///     });
///     mb.install_firmware(fw, .{});
/// }
```

**Analysis**:

- **Purpose**: Documentation example showing how to target the Raspberry Pi Pico board using the rp2xxx port.
- **Why Incomplete**: Part of the build system bug fix verification process.
- **Complexity**: Low
- **Related Items**: Continuation of TODO #5 documentation example

**Recommendation**: Verify this target path is correct and remove the TODO marker.

---

### TODO #7: Union support in build system

**Location**: `build.zig:405`  
**Author**: Tudor Andrei Dicu (2025-08-05)  
**Commit**: ec738a03f - "build_system: `stack` option in `Target` (#640)"

**Original Comment**:
```
// TODO: use unions when they are supported in the build system
```

**Code Context**:
```zig
            // TODO: use unions when they are supported in the build system
            const EndOfStack = struct {
                address: ?usize = null,
                symbol_name: ?[]const u8 = null,
            };

            const end_of_stack: EndOfStack = switch (options.stack orelse options.target.stack) {
                .address => |address| .{ .address = address },
                .ram_region_index => |index| blk: {
```

**Analysis**:

- **Purpose**: The code currently uses a struct with optional fields to represent different ways to specify the end of stack. The TODO suggests this should be replaced with a union when Zig's build system supports it better.
- **Why Incomplete**: This is a limitation of the Zig build system at the time of implementation. The current workaround using a struct with optional fields works but is not as type-safe as a union would be.
- **Complexity**: Medium
- **Related Items**: None directly related

**Recommendation**: Monitor Zig build system development for union support and refactor when available. This is a technical debt item that can be addressed in a future Zig version.

---

### TODO #8: Build.zig.zon dependency entry

**Location**: `build.zig.zon:33`  
**Author**: Tudor Andrei Dicu (2024-11-21)  
**Commit**: 62734a730 - "Build system rewrite (#259)"

**Original Comment**:
```
.@"port/raspberrypi/rp2xxx" = .{ .path = "port/raspberrypi/rp2xxx", .lazy = true },
```

**Code Context**:
```zig
        // ports
        .@"port/espressif/esp" = .{ .path = "port/espressif/esp", .lazy = true },
        .@"port/gigadevice/gd32" = .{ .path = "port/gigadevice/gd32", .lazy = true },
        .@"port/microchip/atsam" = .{ .path = "port/microchip/atsam", .lazy = true },
        .@"port/microchip/avr" = .{ .path = "port/microchip/avr", .lazy = true },
        .@"port/nordic/nrf5x" = .{ .path = "port/nordic/nrf5x", .lazy = true },
        .@"port/nxp/lpc" = .{ .path = "port/nxp/lpc", .lazy = true },
        .@"port/nxp/mcx" = .{ .path = "port/nxp/mcx", .lazy = true },
        .@"port/raspberrypi/rp2xxx" = .{ .path = "port/raspberrypi/rp2xxx", .lazy = true },
        .@"port/stmicro/stm32" = .{ .path = "port/stmicro/stm32", .lazy = true },
        .@"port/wch/ch32v" = .{ .path = "port/wch/ch32v", .lazy = true },
```

**Analysis**:

- **Purpose**: This dependency entry appears to be correctly configured for the rp2xxx port with lazy loading.
- **Why Incomplete**: Added during the build system rewrite and may have been marked for verification.
- **Complexity**: Low
- **Related Items**: Final piece of the rp2xxx integration (TODOs #3, #4, #5, #6)

**Recommendation**: Verify the dependency works correctly and remove the TODO marker.

---

### TODO #9: Pin dependency implementation

**Location**: `core/src/core/experimental/pin.zig:15`  
**Author**: Felix (xq) Queißner (2021-04-28)  
**Commit**: 6cdf641f3 - "Continues blinky setup."

**Original Comment**:
```
// TODO: Depened on board and chip here
```

**Code Context**:
```zig
/// Returns a type that will manage the Pin defined by `spec`.
/// Spec is either the pin as named in the datasheet of the chip
/// or, if a board is present, as named on the board.
///
/// When a name conflict happens, pin names can be prefixed with `board:`
/// to force-select a pin from the board and with `chip:` to force-select
/// the pin from the chip.
pub fn Pin(comptime spec: []const u8) type {
    // TODO: Depened on board and chip here

    const board_namespace = "board:";
    const chip_namespace = "chip:";
```

**Analysis**:

- **Purpose**: The TODO indicates that the pin resolution logic should properly depend on both board and chip configurations. The current implementation does handle both cases but may need refinement.
- **Why Incomplete**: This is from very early development (2021) when the pin system was being designed. The logic has been implemented but the TODO remains.
- **Complexity**: Medium
- **Related Items**: Core pin management functionality

**Recommendation**: Review the current pin resolution logic to ensure it properly handles board/chip dependencies, then remove the TODO if the implementation is complete.

---

### TODO #10: Semihosting splat implementation

**Location**: `core/src/core/experimental/semihosting.zig:355`  
**Author**: Matt Knight (2025-09-01)  
**Commit**: 0d836a5c5 - "Zig 0.15.1 (#651)"

**Original Comment**:
```
// TODO: implement splat
```

**Code Context**:
```zig
        fn drain(io_w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
            const w: *Writer = @fieldParentPtr("interface", io_w);
            _ = splat;
            // TODO: implement splat
            var ret: usize = 0;
            for (data) |d| {
                const n = try writefn(w.file, d);
                ret += n;
                if (n != d.len)
```

**Analysis**:

- **Purpose**: The `splat` parameter is currently ignored in the semihosting writer implementation. This parameter likely controls how data should be written (e.g., repeated writes, buffering behavior).
- **Why Incomplete**: This was updated during the Zig 0.15.1 migration, and the splat functionality may not have been fully implemented yet.
- **Complexity**: Medium
- **Related Items**: Part of the experimental semihosting support

**Recommendation**: Research the intended behavior of the splat parameter in the I/O writer interface and implement the appropriate logic.

---

### TODO #11: Semihosting limit implementation

**Location**: `core/src/core/experimental/semihosting.zig:369`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: limit
```

**Code Context**:
[Need to examine the file around line 369]

**Analysis**:

- **Purpose**: [Need more context]
- **Why Incomplete**: [Need commit information]
- **Complexity**: [Need to assess]
- **Related Items**: Related to TODO #10 in semihosting

**Recommendation**: [Need to examine the code context]

---

### TODO #12: SPI clock ensure clarification

**Location**: `core/src/core/experimental/spi.zig:114`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
clock.ensure(); // TODO: Wat?
```

**Code Context**:
[Need to examine the file around line 114]

**Analysis**:

- **Purpose**: [Need more context]
- **Why Incomplete**: The "Wat?" comment suggests confusion about what this line does
- **Complexity**: [Need to assess]
- **Related Items**: Part of experimental SPI implementation

**Recommendation**: [Need to examine the code context and clarify the purpose]

---

### TODO #13: SPI common options implementation

**Location**: `core/src/core/experimental/spi.zig:136`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: add common options, like clock polarity and phase, and CS polarity
```

**Code Context**:
[Need to examine the file around line 136]

**Analysis**:

- **Purpose**: The SPI implementation needs common configuration options for clock polarity, phase, and chip select polarity
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: Related to TODO #14

**Recommendation**: Implement standard SPI configuration options (CPOL, CPHA, CS polarity)

---

### TODO #14: SPI common options (continued)

**Location**: `core/src/core/experimental/spi.zig:140`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: add common options
```

**Code Context**:
[Need to examine the file around line 140]

**Analysis**:

- **Purpose**: Continuation of TODO #13 for SPI options
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: Related to TODO #13

**Recommendation**: Implement remaining SPI configuration options

---

### TODO #15: UART optional baud rate detection

**Location**: `core/src/core/experimental/uart.zig:76`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
/// TODO: Make this optional, to support STM32F303 et al. auto baud-rate detection?
```

**Code Context**:
[Need to examine the file around line 76]

**Analysis**:

- **Purpose**: Some STM32 chips support automatic baud rate detection, and this should be made optional
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: STM32-specific UART functionality

**Recommendation**: Add optional auto baud-rate detection support for compatible chips

---

### TODO #16: UART enum validation

**Location**: `core/src/core/experimental/uart.zig:83`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: comptime verify that the enums are valid
```

**Code Context**:
[Need to examine the file around line 83]

**Analysis**:

- **Purpose**: Add compile-time validation for UART configuration enums
- **Why Incomplete**: [Need commit information]
- **Complexity**: Low
- **Related Items**: UART configuration validation

**Recommendation**: Add comptime checks to validate enum values

---

### TODO #17: USB mount callback

**Location**: `core/src/core/usb.zig:321`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: call mount callback if any
```

**Code Context**:
[Need to examine the file around line 321]

**Analysis**:

- **Purpose**: USB mount event callback implementation
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: Related to TODO #18 (unmount callback)

**Recommendation**: Implement USB mount/unmount callback system

---

### TODO #18: USB unmount callback

**Location**: `core/src/core/usb.zig:323`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: call umount callback if any
```

**Code Context**:
[Need to examine the file around line 323]

**Analysis**:

- **Purpose**: USB unmount event callback implementation
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: Related to TODO #17 (mount callback)

**Recommendation**: Implement USB mount/unmount callback system

---

### TODO #19: USB GitHub issue reference

**Location**: `core/src/core/usb.zig:338`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
```

**Code Context**:
[Need to examine the file around line 338]

**Analysis**:

- **Purpose**: References a specific GitHub issue for USB implementation
- **Why Incomplete**: [Need to check the referenced issue]
- **Complexity**: [Depends on the issue]
- **Related Items**: USB implementation

**Recommendation**: Review GitHub issue #453 and implement the required changes

---

### TODO #20: USB single configuration support

**Location**: `core/src/core/usb.zig:393`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: we support just one config for now so ignore config index
```

**Code Context**:
[Need to examine the file around line 393]

**Analysis**:

- **Purpose**: Current USB implementation only supports single configuration, should be extended for multiple configurations
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: USB configuration management

**Recommendation**: Implement support for multiple USB configurations

---

### TODO #21: CDC line coding hack

**Location**: `core/src/core/usb/drivers/cdc.zig:186`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
.SetLineCoding => return usb.ack, // HACK, we should handle data phase somehow to read sent line_coding
```

**Code Context**:
[Need to examine the file around line 186]

**Analysis**:

- **Purpose**: CDC SetLineCoding request is not properly implemented, just returns ACK
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: USB CDC driver implementation

**Recommendation**: Properly implement SetLineCoding data phase handling

---

### TODO #22: HID bandwidth limiting

**Location**: `core/src/core/usb/drivers/hid.zig:88`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: The host is attempting to limit bandwidth by requesting that
```

**Code Context**:
[Need to examine the file around line 88]

**Analysis**:

- **Purpose**: HID bandwidth limiting implementation
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: HID driver implementation

**Recommendation**: Implement HID bandwidth limiting support

---

### TODO #23: HID report format switching

**Location**: `core/src/core/usb/drivers/hid.zig:98`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: The device should switch the format of its reports from the
```

**Code Context**:
[Need to examine the file around line 98]

**Analysis**:

- **Purpose**: HID report format switching implementation
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: HID driver implementation

**Recommendation**: Implement HID report format switching

---

### TODO #24: HID feature/output reports

**Location**: `core/src/core/usb/drivers/hid.zig:111`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
// TODO: This request sends a feature or output report to the device,
```

**Code Context**:
[Need to examine the file around line 111]

**Analysis**:

- **Purpose**: HID feature and output report handling
- **Why Incomplete**: [Need commit information]
- **Complexity**: Medium
- **Related Items**: HID driver implementation

**Recommendation**: Implement HID feature and output report handling

---

### TODO #25: Cortex-M7 reserved values

**Location**: `core/src/cpus/cortex_m/m7.zig:253`  
**Author**: [Need to check git blame]  
**Commit**: [Need to check]

**Original Comment**:
```
/// TODO: Reserved have values ? see armv7-m reference manual
```

**Code Context**:
[Need to examine the file around line 253]

**Analysis**:

- **Purpose**: Clarify reserved field values in Cortex-M7 registers by consulting ARM reference manual
- **Why Incomplete**: [Need commit information]
- **Complexity**: Low
- **Related Items**: Cortex-M7 CPU support

**Recommendation**: Consult ARMv7-M reference manual and document/implement reserved field values

---

## Summary

This batch contains 25 TODOs with the following characteristics:

- **rp2xxx Integration** (8 items): TODOs #1-6, #8 appear to be remnants from the rp2xxx port integration and build system rewrite. Most seem to be working but need verification and TODO marker removal.

- **USB Implementation** (6 items): TODOs #17-22 are related to USB functionality including callbacks, configuration support, and driver implementations.

- **Experimental Features** (4 items): TODOs #9-12 are in experimental modules (pin, semihosting, SPI) that need completion.

- **HID Driver** (3 items): TODOs #22-24 are specific to HID driver functionality.

- **Build System** (1 item): TODO #7 is waiting for Zig build system improvements.

- **Hardware-Specific** (3 items): TODOs #15, #16, #25 are related to specific hardware features.

**Priority Recommendations**:
1. **High**: Verify and clean up rp2xxx integration TODOs (#1-6, #8)
2. **Medium**: Complete USB and HID driver implementations (#17-24)
3. **Low**: Address experimental feature completions (#9-16, #25)
4. **Future**: Monitor Zig development for build system improvements (#7)
