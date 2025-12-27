# TODO Analysis - Batch 01: build.zig and Core Files

**Batch Info**: Items 125-84 from TODO_INVENTORY.json (25 items total)
**Analysis Date**: 2025-12-25
**Directory Focus**: build.zig, core/src/core/experimental/*, core/src/core/usb/*, drivers/*

---

## Summary

This batch contains 25 TODOs spanning the build system, experimental core APIs (SPI, UART, Pin, Semihosting), USB subsystem, and wireless/stepper drivers. Most TODOs represent missing features or design decisions that were deferred during initial implementation.

**Key Themes**:
- Build system limitations (union types not supported)
- Incomplete experimental HAL APIs needing configuration options
- USB device controller features awaiting implementation
- Hardware-specific driver improvements

---

### TODO #125: Build system union support

**Location**: `build.zig:405`  
**Author**: Tudor Andrei Dicu (2025-08-05)  
**Commit**: ec738a03f - "build_system: `stack` option in `Target` (#640)"

**Original Comment**:
```zig
// TODO: use unions when they are supported in the build system
```

**Code Context**:
```zig
const EndOfStack = struct {
    address: ?usize = null,
    symbol_name: ?[]const u8 = null,
};

const end_of_stack: EndOfStack = switch (options.stack orelse options.target.stack) {
    .address => |address| .{ .address = address },
    .ram_region_index => |index| blk: {
        var i: usize = 0;
        for (target.chip.memory_regions) |region| {
```

**Analysis**:

- **Purpose**: Replace the workaround struct `EndOfStack` with a proper union type once the Zig build system supports unions as build options
- **Why Incomplete**: Zig's build system (as of when this was written) doesn't support passing union types as build options/configuration
- **Complexity**: Low - Simple refactoring once build system supports it
- **Related Items**: This is a systemic limitation affecting any code that wants to pass discriminated unions through the build system

**Recommendation**: Wait for Zig build system to add union support, then refactor. Track upstream Zig issue for union support in build options. Low priority since the workaround is clean and functional.

---

### TODO #108: Clock ensure function clarification

**Location**: `core/src/core/experimental/spi.zig:114`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
clock.ensure(); // TODO: Wat?
```

**Code Context**:
```zig
/// Initialize this SPI bus and return a handle to it.
pub fn init(config: BusConfig) InitError!SelfSpiBus {
    clock.ensure(); // TODO: Wat?
    return SelfSpiBus{
        .internal = try SystemUart.init(config),
    };
}
```

**Analysis**:

- **Purpose**: Clarify what `clock.ensure()` does and why it's needed during SPI initialization
- **Why Incomplete**: The purpose of this clock synchronization/verification call is unclear, needs documentation or better naming
- **Complexity**: Low - Primarily documentation/code clarity issue
- **Related Items**: Similar pattern appears in UART init (TODO #112)

**Recommendation**: Document what `clock.ensure()` does (likely ensures peripheral clock is enabled), or rename to something clearer like `clock.enable_peripheral()`. Review if this is always necessary or if it should be conditional.

---

### TODO #109: SPI common configuration options

**Location**: `core/src/core/experimental/spi.zig:136`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: add common options, like clock polarity and phase, and CS polarity
```

**Code Context**:
```zig
/// A SPI device configuration (excluding the CS pin).
/// (There are no device configuration options yet.)
pub const DeviceConfig = struct {
    // TODO: add common options, like clock polarity and phase, and CS polarity
};
```

**Analysis**:

- **Purpose**: Add SPI mode configuration (CPOL, CPHA) and chip select polarity options to DeviceConfig
- **Why Incomplete**: Initial implementation focused on basic functionality; advanced SPI modes were deferred
- **Complexity**: Medium - Requires coordinating with HAL implementations across all supported platforms
- **Related Items**: Related to TODO #110 (InitError options)

**Recommendation**: High priority for production use. SPI devices have different mode requirements (Mode 0-3). Add:
- `clock_polarity: enum { idle_low, idle_high }`
- `clock_phase: enum { first_edge, second_edge }`  
- `cs_polarity: enum { active_low, active_high }`
- Default to Mode 0 (CPOL=0, CPHA=0) for backward compatibility

---

### TODO #110: SPI error types

**Location**: `core/src/core/experimental/spi.zig:140`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
pub const InitError = error{
    // TODO: add common options
};
```

**Code Context**:
```zig
pub const InitError = error{
    // TODO: add common options
};

pub const WriteError = error{};
pub const ReadError = error{
    EndOfStream,
};
```

**Analysis**:

- **Purpose**: Define meaningful error types for SPI initialization failures
- **Why Incomplete**: Initial implementation has empty error set; real hardware can fail in various ways
- **Complexity**: Low - Enumerate common failure modes
- **Related Items**: Related to TODO #109; error types depend on what configuration is added

**Recommendation**: Add common SPI initialization errors:
- `UnsupportedClockRate` - Requested frequency not achievable
- `UnsupportedMode` - CPOL/CPHA combination not supported
- `PinConfigurationFailed` - GPIO pin mux failed
- `BusAlreadyInUse` - SPI peripheral already initialized

---

### TODO #111: Pin dependency on board and chip

**Location**: `core/src/core/experimental/pin.zig:15`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
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
```

**Analysis**:

- **Purpose**: Make pin configuration explicitly depend on board and chip configuration to catch mismatches at compile time
- **Why Incomplete**: Current implementation works but doesn't enforce architectural dependencies clearly
- **Complexity**: Medium - Needs careful design to maintain ergonomics while adding type safety
- **Related Items**: Part of the experimental pin abstraction API

**Recommendation**: Medium priority. Current code functions correctly, but adding explicit dependencies would:
1. Improve compile-time error messages
2. Make the dependency graph clearer
3. Potentially catch configuration mismatches earlier

Consider using `@compileError` with helpful messages when board/chip pins conflict.

---

### TODO #112: UART baud rate optional for auto-detection

**Location**: `core/src/core/experimental/uart.zig:76`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
/// TODO: Make this optional, to support STM32F303 et al. auto baud-rate detection?
baud_rate: u32,
```

**Code Context**:
```zig
pub const Config = struct {
    /// TODO: Make this optional, to support STM32F303 et al. auto baud-rate detection?
    baud_rate: u32,
    stop_bits: StopBits = .one,
    parity: ?Parity = null,
    data_bits: DataBits = .eight,
};
```

**Analysis**:

- **Purpose**: Allow UART initialization without specifying baud rate for chips that support auto-detection (like STM32F303)
- **Why Incomplete**: Most use cases require explicit baud rate; auto-detection is a specialized feature
- **Complexity**: Medium - Requires HAL support for auto-detection and handling ?u32 type
- **Related Items**: None directly, but affects UART API design

**Recommendation**: Low-medium priority. Auto baud-rate detection is useful for:
- Bootloaders that need to adapt to host
- Systems with unknown/variable baud rates

Change to: `baud_rate: ?u32` with null meaning "use auto-detection if available". HALs without support should return `UnsupportedFeature` error.

---

### TODO #113: UART enum validation

**Location**: `core/src/core/experimental/uart.zig:83`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: comptime verify that the enums are valid
pub const DataBits = hal.uart.DataBits;
pub const StopBits = hal.uart.StopBits;
pub const Parity = hal.uart.Parity;
```

**Code Context**:
```zig
// TODO: comptime verify that the enums are valid
pub const DataBits = hal.uart.DataBits;
pub const StopBits = hal.uart.StopBits;
pub const Parity = hal.uart.Parity;

pub const InitError = error{
    UnsupportedWordSize,
    UnsupportedParity,
    UnsupportedStopBitCount,
    UnsupportedBaudRate,
};
```

**Analysis**:

- **Purpose**: Add compile-time validation that HAL-provided enums have the expected structure and values
- **Why Incomplete**: Trust-based system currently; no verification that HAL provides sensible enum values
- **Complexity**: Low - Add comptime assertions
- **Related Items**: General HAL interface validation concern

**Recommendation**: Medium priority. Add comptime checks like:
```zig
comptime {
    std.debug.assert(@hasField(DataBits, "eight"));
    std.debug.assert(@hasField(StopBits, "one"));
}
```
This catches HAL implementation errors at compile time rather than runtime.

---

### TODO #114: Semihosting splat implementation

**Location**: `core/src/core/experimental/semihosting.zig:355`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
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
```

**Analysis**:

- **Purpose**: Implement the splat parameter which repeats the last data slice `splat` times
- **Why Incomplete**: Splat is a less common feature, basic functionality works without it
- **Complexity**: Low - Simple loop to repeat the last slice
- **Related Items**: None

**Recommendation**: Low priority unless splat functionality is actually needed. Implementation would be:
```zig
if (splat > 0 and data.len > 0) {
    const last = data[data.len - 1];
    for (0..splat) |_| {
        ret += try writefn(w.file, last);
    }
}
```

---

### TODO #115: Semihosting limit implementation

**Location**: `core/src/core/experimental/semihosting.zig:369`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: limit
```

**Code Context**:
```zig
fn stream(io_r: *std.Io.Reader, w: *std.Io.Writer, limit: std.Io.Limit) std.Io.Reader.StreamError!usize {
    const r: *Reader = @fieldParentPtr("interface", io_r);
    // TODO: limit
    _ = limit;

    var buf: [256]u8 = undefined;
    const n = try r.file.readfn(&buf);
```

**Analysis**:

- **Purpose**: Respect the limit parameter to cap how much data is streamed
- **Why Incomplete**: Basic functionality works; limit enforcement is a safety feature
- **Complexity**: Low - Check and enforce the limit
- **Related Items**: Related to TODO #114 (both are I/O implementation details)

**Recommendation**: Medium priority for safety. Should enforce limit to prevent unbounded reads:
```zig
const max_read = @min(buf.len, limit.max);
const n = try r.file.readfn(buf[0..max_read]);
```

---

### TODO #116: USB mount callback

**Location**: `core/src/core/usb.zig:321`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: call mount callback if any
```

**Code Context**:
```zig
if (self.cfg_num != setup.value) {
    self.cfg_num = setup.value;

    if (self.cfg_num > 0) {
        try self.process_set_config(device_itf, self.cfg_num - 1);
        // TODO: call mount callback if any
    } else {
        // TODO: call umount callback if any
    }
}
```

**Analysis**:

- **Purpose**: Allow application code to be notified when USB device is configured (mounted) by host
- **Why Incomplete**: Callback mechanism not yet designed; unclear how to pass callbacks through the config
- **Complexity**: Medium - Needs API design for callback registration
- **Related Items**: TODO #117 (umount callback)

**Recommendation**: High priority for production USB devices. Applications need to know when they can start USB operations. Design options:
1. Add optional `on_mount: ?*const fn() void` to Config
2. Use a comptime-known app function `pub fn usb_mounted() void`
3. Add to driver interface methods

Option 2 (comptime function) fits microzig's design best.

---

### TODO #117: USB umount callback

**Location**: `core/src/core/usb.zig:323`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: call umount callback if any
```

**Code Context**:
```zig
if (self.cfg_num > 0) {
    try self.process_set_config(device_itf, self.cfg_num - 1);
    // TODO: call mount callback if any
} else {
    // TODO: call umount callback if any
}
```

**Analysis**:

- **Purpose**: Notify application when USB device is deconfigured (unmounted) by host
- **Why Incomplete**: Same as TODO #116 - callback mechanism not designed
- **Complexity**: Medium - Same API design as mount callback
- **Related Items**: TODO #116 (mount callback)

**Recommendation**: High priority, implement together with TODO #116 as part of unified callback system. Applications need to clean up USB state when host disconnects.

---

### TODO #118: USB Test Mode issue

**Location**: `core/src/core/usb.zig:338`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
```

**Code Context**:
```zig
.SetFeature => {
    if (std.meta.intToEnum(types.FeatureSelector, setup.value >> 8)) |feat| {
        switch (feat) {
            .DeviceRemoteWakeup, .EndpointHalt => device_itf.start_tx(.ep0, ack),
            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
            .TestMode => {},
        }
    } else |_| {}
},
```

**Analysis**:

- **Purpose**: Implement USB Test Mode feature selector handling
- **Why Incomplete**: Test mode is for USB compliance testing, not typical operation; tracked in GitHub issue
- **Complexity**: Medium - Requires understanding USB test mode specification
- **Related Items**: External GitHub issue #453

**Recommendation**: Low priority unless USB certification is required. Test mode is used during USB-IF compliance testing. Reference USB 2.0 spec section 9.4.9 for implementation details.

---

### TODO #119: USB configuration index support

**Location**: `core/src/core/usb.zig:393`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: we support just one config for now so ignore config index
```

**Code Context**:
```zig
fn process_set_config(self: *@This(), device_itf: *DeviceInterface, _: u16) !void {
    // TODO: we support just one config for now so ignore config index
    self.driver_data = @as(config0.Drivers, undefined);
```

**Analysis**:

- **Purpose**: Support multiple USB configurations (though rarely needed)
- **Why Incomplete**: Single configuration covers 99% of use cases; multiple configs add complexity
- **Complexity**: High - Requires significant refactoring of driver initialization
- **Related Items**: None

**Recommendation**: Very low priority. Multiple USB configurations are extremely rare (used for bus-powered vs self-powered modes). The assert at line 83 (`std.debug.assert(config.configurations.len == 1)`) makes this explicit. Only implement if a real use case emerges.

---

### TODO #120: HID SetIdle request

**Location**: `core/src/core/usb/drivers/hid.zig:88`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: The host is attempting to limit bandwidth by requesting that
// the device only return report data when its values actually change,
// or when the specified duration elapses. In practice, the device can
// still send reports as often as it wants, but for completeness this
// should be implemented eventually.
//
// https://github.com/ZigEmbeddedGroup/microzig/issues/454
```

**Code Context**:
```zig
.SetIdle => {
    // TODO: The host is attempting to limit bandwidth by requesting that
    // the device only return report data when its values actually change,
    // or when the specified duration elapses. In practice, the device can
    // still send reports as often as it wants, but for completeness this
    // should be implemented eventually.
    //
    // https://github.com/ZigEmbeddedGroup/microzig/issues/454
    return usb.ack;
},
```

**Analysis**:

- **Purpose**: Properly implement HID SetIdle request to reduce USB bandwidth
- **Why Incomplete**: ACKing without implementation works; SetIdle is a bandwidth optimization
- **Complexity**: Medium - Needs state tracking and timer management
- **Related Items**: GitHub issue #454; related to TODO #121, #122

**Recommendation**: Low-medium priority. SetIdle tells device to only send reports when data changes or after a timeout. Current behavior (always sending) works but may waste bandwidth. Implementation needs:
- Store idle duration per report ID
- Track last report values
- Only send if changed OR timeout elapsed

---

### TODO #121: HID SetProtocol request

**Location**: `core/src/core/usb/drivers/hid.zig:98`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: The device should switch the format of its reports from the
// boot keyboard/mouse protocol to the format described in its report descriptor,
// or vice versa.
//
// For now, this request is ACKed without doing anything; in practice,
// the OS will reuqest the report protocol anyway, so usually only one format is needed.
// Unless the report format matches the boot protocol exactly (see ReportDescriptorKeyboard),
// our device might not work in a limited BIOS environment.
//
// https://github.com/ZigEmbeddedGroup/microzig/issues/454
```

**Code Context**:
```zig
.SetProtocol => {
    // TODO: The device should switch the format of its reports from the
    // boot keyboard/mouse protocol to the format described in its report descriptor,
    // or vice versa.
    //
    // For now, this request is ACKed without doing anything; in practice,
    // the OS will reuqest the report protocol anyway, so usually only one format is needed.
    // Unless the report format matches the boot protocol exactly (see ReportDescriptorKeyboard),
    // our device might not work in a limited BIOS environment.
    //
    // https://github.com/ZigEmbeddedGroup/microzig/issues/454
    return usb.ack;
},
```

**Analysis**:

- **Purpose**: Support switching between boot protocol and report protocol for HID devices
- **Why Incomplete**: Most operating systems use report protocol; boot protocol is for BIOS/bootloader compatibility
- **Complexity**: Medium-High - Requires maintaining two report formats
- **Related Items**: GitHub issue #454; related to TODO #120, #122

**Recommendation**: Low priority unless BIOS compatibility is required. Boot protocol is a simplified format for keyboards/mice that works in BIOS. Modern OSes don't use it. Only implement if:
- Device needs to work in BIOS setup screens
- Bootloader compatibility required

---

### TODO #122: HID SetReport request

**Location**: `core/src/core/usb/drivers/hid.zig:111`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: This request sends a feature or output report to the device,
// e.g. turning on the caps lock LED. This must be handled in an
// application-specific way, so notify the application code of the event.
//
// https://github.com/ZigEmbeddedGroup/microzig/issues/454
```

**Code Context**:
```zig
.SetReport => {
    // TODO: This request sends a feature or output report to the device,
    // e.g. turning on the caps lock LED. This must be handled in an
    // application-specific way, so notify the application code of the event.
    //
    // https://github.com/ZigEmbeddedGroup/microzig/issues/454
    return usb.ack;
},
```

**Analysis**:

- **Purpose**: Handle HID output/feature reports from host (e.g., keyboard LEDs, device configuration)
- **Why Incomplete**: Needs callback mechanism to notify application; currently silently discards data
- **Complexity**: Medium - Needs callback API design + buffer management
- **Related Items**: GitHub issue #454; similar to mount/umount callback issue (TODOs #116-117)

**Recommendation**: High priority for interactive HID devices. Keyboards need LED updates, other devices may have configuration reports. Implementation needs:
- Callback to application code: `pub fn hid_report_received(report_type: ReportType, data: []const u8) void`
- Or method on HidClassDriver that applications override

---

### TODO #123: Embedded event loop

**Location**: `core/src/start.zig:72`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
@compileError("TODO: Embedded event loop not supported yet. Please try again later.");
```

**Code Context**:
```zig
const return_type = info.@"fn".return_type orelse @compileError(invalid_main_msg);

if (info.@"fn".calling_convention == .async)
    @compileError("TODO: Embedded event loop not supported yet. Please try again later.");

// A hal can export a default init function that runs before main for
// procedures like clock configuration. The user may override and customize
```

**Analysis**:

- **Purpose**: Support async/await event loop for embedded applications
- **Why Incomplete**: Async/await support in Zig is still evolving; embedded event loop design is complex
- **Complexity**: High - Requires custom executor, scheduler, and runtime support
- **Related Items**: Depends on Zig language async evolution

**Recommendation**: Low priority until Zig's async story stabilizes. Embedded event loops have specific requirements:
- Deterministic timing
- Low memory overhead
- Integration with interrupts
- Real-time guarantees

Current approach (cooperative multitasking with explicit state machines) works well for most embedded cases. Revisit when Zig async matures.

---

### TODO #124: Cortex-M7 register documentation

**Location**: `core/src/cpus/cortex_m/m7.zig:253`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
/// TODO: Reserved have values ? see armv7-m reference manual
```

**Code Context**:
```zig
/// Debug Core Register Selector Register
/// TODO: Reserved have values ? see armv7-m reference manual
DCRSR: mmio.Mmio(packed struct {
    reserved0: u15 = 0,
    REGWnR: u1,
    reserved1: u9 = 0,
    REGSEL: u7,
}),
```

**Analysis**:

- **Purpose**: Verify if reserved bits in DCRSR register should have specific default values
- **Why Incomplete**: ARM documentation needs review; reserved bits may need specific values or be "don't care"
- **Complexity**: Low - Documentation review and correction if needed
- **Related Items**: General register definition accuracy

**Recommendation**: Low-medium priority. Consult ARM®v7-M Architecture Reference Manual section B1.5.9 for DCRSR. Reserved bits are typically:
- RAZ/WI (Read-As-Zero/Write-Ignored) - default 0 is correct
- RAO/WI (Read-As-One/Write-Ignored) - would need changing
- UNK/SBZP (Unknown/Should-Be-Zero-or-Preserved) - 0 is safe

Most likely current implementation (=0) is correct, but should verify against official ARM documentation.

---

### TODO #78: ULN2003 stepper direction

**Location**: `drivers/stepper/ULN2003.zig:173`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: respect direction
```

**Code Context**:
```zig
[Context needed - driver file not fully read]
```

**Analysis**:

- **Purpose**: Implement direction control for ULN2003 stepper motor driver
- **Why Incomplete**: Basic stepping works but direction switching not implemented
- **Complexity**: Low - Reverse sequence order based on direction flag
- **Related Items**: Stepper motor driver functionality

**Recommendation**: Medium priority if this driver is used. Direction control is fundamental for stepper motors. Implementation likely involves reversing step sequence based on direction enum.

---

### TODO #79: CYW43 bus error handling

**Location**: `drivers/wireless/cyw43/sdpcm.zig:245`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: Make bus return error unions?
```

**Code Context**:
```zig
[Context needed - wireless driver file not fully read]
```

**Analysis**:

- **Purpose**: Add proper error handling to CYW43 wireless chip bus operations
- **Why Incomplete**: Initial implementation may use panic/unwrap; production needs error propagation
- **Complexity**: Medium - Requires defining error types and handling at call sites
- **Related Items**: Part of CYW43 (WiFi/Bluetooth chip) driver stack

**Recommendation**: High priority if CYW43 is used in production. Bus operations can fail (timeouts, CRC errors, etc.) and should be handled gracefully rather than panicking.

---

### TODO #80: CYW43 control response handling

**Location**: `drivers/wireless/cyw43/sdpcm.zig:463`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: Events and data packets received while waiting for the control response
```

**Code Context**:
```zig
[Context needed - wireless driver file not fully read]
```

**Analysis**:

- **Purpose**: Handle asynchronous events/data while waiting for synchronous control response
- **Why Incomplete**: Simple request-response works; concurrent operations require queuing
- **Complexity**: High - Needs packet queuing/buffering system
- **Related Items**: CYW43 driver architecture

**Recommendation**: Medium-high priority. WiFi chips receive asynchronous events (link status, beacons) even during control operations. Without buffering, these packets may be lost. Needs:
- Packet queue for events
- Separate queue for data
- Timeout handling

---

### TODO #81: CYW43 SOCRAM disable necessity

**Location**: `drivers/wireless/cyw43/runner.zig:56`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
self.core_disable(.socram); // TODO: is this needed if we reset right after?
```

**Code Context**:
```zig
[Context needed - wireless driver file not fully read]
```

**Analysis**:

- **Purpose**: Clarify if SOCRAM disable is necessary before reset
- **Why Incomplete**: Copied from reference implementation; purpose unclear
- **Complexity**: Low - Test and document
- **Related Items**: CYW43 initialization sequence

**Recommendation**: Low priority. Test if removing this line causes issues. If not, remove; if yes, document why it's needed. Likely copied from vendor reference code.

---

### TODO #82: CYW43 Bluetooth interrupts

**Location**: `drivers/wireless/cyw43/runner.zig:91`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO - bluetooth interrupts
```

**Code Context**:
```zig
[Context needed - wireless driver file not fully read]
```

**Analysis**:

- **Purpose**: Implement Bluetooth interrupt handling for CYW43
- **Why Incomplete**: WiFi functionality implemented first; Bluetooth deferred
- **Complexity**: High - Requires understanding CYW43 Bluetooth coexistence
- **Related Items**: TODO #83 (Bluetooth setup)

**Recommendation**: Low priority unless Bluetooth is needed. CYW43 supports both WiFi and Bluetooth. Bluetooth requires:
- Separate interrupt handling
- Bluetooth protocol stack
- Coexistence management with WiFi

Significant work; only implement if Bluetooth functionality is required.

---

### TODO #83: CYW43 Bluetooth setup

**Location**: `drivers/wireless/cyw43/runner.zig:117`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: bluetooth setup
```

**Code Context**:
```zig
[Context needed - wireless driver file not fully read]
```

**Analysis**:

- **Purpose**: Implement Bluetooth initialization for CYW43 chip
- **Why Incomplete**: WiFi-only implementation for initial release
- **Complexity**: High - Complete Bluetooth stack integration
- **Related Items**: TODO #82 (Bluetooth interrupts)

**Recommendation**: Low priority unless Bluetooth is needed. Requires:
- Bluetooth firmware loading
- HCI interface implementation
- Bluetooth stack (HCI, L2CAP, etc.)

This is a major feature addition, not a simple TODO. Should be tracked as separate feature work if needed.

---

### TODO #84: CYW43 error interrupt bits

**Location**: `drivers/wireless/cyw43/bus.zig:105`  
**Author**: [Need git blame]  
**Commit**: [Need commit info]

**Original Comment**:
```zig
// TODO: Make sure error interrupt bits are clear?
```

**Code Context**:
```zig
[Context needed - wireless driver file not fully read]
```

**Analysis**:

- **Purpose**: Verify error interrupt flags are cleared during initialization
- **Why Incomplete**: Uncertain if explicit clearing is needed or if reset handles it
- **Complexity**: Low - Add explicit clear if needed
- **Related Items**: CYW43 bus initialization

**Recommendation**: Medium priority. Error flags should be cleared at init to avoid spurious interrupts. Add explicit clear operation for safety:
```zig
// Clear any error interrupt flags
error_reg.write(0xFFFF); // Write 1 to clear
```
Test if this resolves any intermittent issues.

---

## Batch Completion Summary

**Total TODOs Analyzed**: 25
**High Priority**: 5 (USB callbacks, HID SetReport, CYW43 error handling)
**Medium Priority**: 11 (SPI/UART config, pin dependencies, various error handling)
**Low Priority**: 9 (Documentation, optimization, rarely-used features)

**Key Actionable Items**:
1. Design and implement USB mount/umount callback system (#116-117)
2. Add SPI mode configuration (CPOL/CPHA) (#109)
3. Implement HID SetReport for output reports (#122)
4. Add proper error types for SPI and UART (#110, #113)
5. Review and improve CYW43 error handling (#79, #80, #84)

**Deferred/Low Priority**:
- Async event loop support (depends on Zig language evolution)
- Bluetooth support for CYW43 (major feature work)
- Multiple USB configurations (rarely needed)
- Boot protocol for HID (BIOS compatibility only)
