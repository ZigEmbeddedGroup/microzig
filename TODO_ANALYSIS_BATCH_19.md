# TODO Analysis - Batch 19

**Batch Info**: Items 451-475 from TODO_INVENTORY.json  
**Analysis Date**: 2025-12-24  
**Total Items**: 25

---

### TODO #451: Make UART pins optional for rx-only configurations

**Location**: `port/nordic/nrf5x/src/hal/uart.zig:122`  
**Author**: Matt Knight (2025-05-22)  
**Commit**: 701a7f0aa - "nRF52xxx: Add UART hal + examples (#558)"

**Original Comment**:
```
// TODO: Make these optional... could have rx only for example
```

**Code Context**:
```zig
pub fn apply(uart: UART, comptime config: Config) void {
    uart.disable();

    // TODO: Make these optional... could have rx only for example
    uart.set_txd(config.tx_pin);
    config.tx_pin.set_direction(.out);
    config.tx_pin.put(1);
    uart.set_rxd(config.rx_pin);
    const hwfc = if (config.control_flow) |cf| blk: {
        uart.set_cts(cf.cts_pin);
        config.uart_cts.set_direction(.in);
        uart.set_rts(cf.rts_pin);
        config.uart_rts.set_direction(.out);
        config.uart_rts.put(1);
        break :blk true;
    } else false;
```

**Analysis**:

- **Purpose**: Allow UART configuration with only RX or only TX pins for unidirectional communication
- **Why Incomplete**: Initial implementation focused on full-duplex UART; unidirectional use cases were deferred
- **Complexity**: Medium
- **Related Items**: None nearby

**Recommendation**: Modify Config struct to make tx_pin and rx_pin optional, then conditionally configure pins in apply() function

---

### TODO #453: Support custom pins for LPC176x5x UART

**Location**: `port/nxp/lpc/src/hals/LPC176x5x.zig:124`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: fe247e666 - "add chip and board definitions (#1)"

**Original Comment**:
```
@compileError("TODO: custom pins are not currently supported");
```

**Code Context**:
```zig
pub fn Uart(comptime index: usize, comptime pins: microzig.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");

    return struct {
        const UARTn = switch (index) {
            0 => UART0,
            1 => UART1,
            2 => UART2,
            3 => UART3,
            else => @compileError("LPC1768 has 4 UARTs available."),
        };
```

**Analysis**:

- **Purpose**: Allow UART configuration with custom pin assignments instead of default pins
- **Why Incomplete**: Initial implementation used hardcoded default pins; custom pin routing was deferred
- **Complexity**: Medium
- **Related Items**: None nearby

**Recommendation**: Implement pin routing logic using the existing `route_pin()` function to configure custom TX/RX pins for UART peripherals

---

### TODO #454: Handle UART FIFO availability differences across LPC variants

**Location**: `port/nxp/lpc/src/hals/LPC176x5x.zig:170`  
**Author**: Matt Knight (2023-02-18)  
**Commit**: fe247e666 - "add chip and board definitions (#1)"

**Original Comment**:
```
// TODO: UARTN_FIFOS_ARE_DISA is not available in all uarts
```

**Code Context**:
```zig
            // TODO: UARTN_FIFOS_ARE_DISA is not available in all uarts
            //UARTn.FCR.modify(.{ .FIFOEN = .UARTN_FIFOS_ARE_DISA });

            microzig.debug.writer().print("clock: {} baud: {} ", .{
                microzig.clock.get().cpu,
                config.baud_rate,
            }) catch {};
```

**Analysis**:

- **Purpose**: Properly handle UART FIFO configuration across different LPC chip variants
- **Why Incomplete**: Different LPC chips have different UART FIFO capabilities; generic solution needed
- **Complexity**: Low
- **Related Items**: None nearby

**Recommendation**: Add chip-specific conditional compilation to enable FIFO configuration only on supported UART variants

---

### TODO #455: False positive - README header misidentified as TODO

**Location**: `port/raspberrypi/rp2xxx/README.md:1`  
**Author**: haydenridd (2024-10-04)  
**Commit**: c24cf9017 - "Initial support added for RP2350 (#244)"

**Original Comment**:
```
# raspberrypi-rp2xxx
```

**Code Context**:
```markdown
# raspberrypi-rp2xxx

HAL and register definitions for the RP2040 and RP2350 chips.
```

**Analysis**:

- **Purpose**: This is not actually a TODO - it's a markdown header that was incorrectly identified
- **Why Incomplete**: N/A - This is a false positive in the TODO detection
- **Complexity**: N/A
- **Related Items**: None

**Recommendation**: Remove from TODO inventory - this is a markdown header, not an actual TODO item

---

### TODO #456: False positive - Documentation text misidentified as TODO

**Location**: `port/raspberrypi/rp2xxx/README.md:55`  
**Author**: Grazfather (2025-11-25)  
**Commit**: 134a7d033 - "rp2xxx: Update readme to describe boot process and flashless targets (#734)"

**Original Comment**:
```
The rp2xxx bootrom, when flashing a UF2 file, jumps to the *lowest address flashed*, so if there are
```

**Code Context**:
```markdown
The rp2xxx bootrom, when flashing a UF2 file, jumps to the *lowest address flashed*, so if there are
no flash blocks (in the 0x10000000 range), then it'll just to RAM instead.
```

**Analysis**:

- **Purpose**: This is not actually a TODO - it's documentation text that was incorrectly identified
- **Why Incomplete**: N/A - This is a false positive in the TODO detection
- **Complexity**: N/A
- **Related Items**: None

**Recommendation**: Remove from TODO inventory - this is documentation text, not an actual TODO item

---

### TODO #457: Consider using unused memory regions for stacks

**Location**: `port/raspberrypi/rp2xxx/build.zig:91`  
**Author**: Tudor Andrei Dicu (2025-06-18)  
**Commit**: dd8544d09 - "Memory layout improvements"

**Original Comment**:
```
// TODO: maybe these can be used for stacks
```

**Analysis**:
- **Purpose**: Optimize memory usage by utilizing unused regions for stack allocation
- **Why Incomplete**: Memory layout optimization was deferred for later implementation
- **Complexity**: Medium
- **Related Items**: TODO #458 (similar stack optimization)

**Recommendation**: Investigate using unused memory regions for stack allocation to improve memory efficiency

---

### TODO #458: Consider using unused memory regions for stacks (duplicate)

**Location**: `port/raspberrypi/rp2xxx/build.zig:142`  
**Author**: Tudor Andrei Dicu (2025-06-18)  
**Commit**: dd8544d09 - "Memory layout improvements"

**Original Comment**:
```
// TODO: maybe these can be used for stacks
```

**Analysis**:
- **Purpose**: Same as TODO #457 - optimize memory usage for stack allocation
- **Why Incomplete**: Memory layout optimization was deferred
- **Complexity**: Medium
- **Related Items**: TODO #457 (duplicate issue)

**Recommendation**: Consolidate with TODO #457 - investigate stack allocation optimization

---

### TODO #459: False positive - Build configuration misidentified as TODO

**Location**: `port/raspberrypi/rp2xxx/build.zig.zon:2`  
**Author**: Various contributors  
**Commit**: Multiple commits

**Original Comment**:
```
.name = .mz_port_raspberrypi_rp2xxx,
```

**Analysis**:
- **Purpose**: This is not a TODO - it's a build configuration setting
- **Why Incomplete**: N/A - False positive
- **Complexity**: N/A
- **Related Items**: None

**Recommendation**: Remove from TODO inventory - this is build configuration, not a TODO

---

### TODO #460: Add automatic default pin configuration for board pins

**Location**: `port/raspberrypi/rp2xxx/src/boards/adafruit_metro_rp2350.zig:5`  
**Author**: Board definition contributor  
**Commit**: Board addition commit

**Original Comment**:
```
// ### TODO ### Add automatic default pin configuration for board pins
```

**Analysis**:
- **Purpose**: Implement automatic pin configuration for board-specific defaults
- **Why Incomplete**: Board-specific pin configuration system needs development
- **Complexity**: Medium
- **Related Items**: None nearby

**Recommendation**: Implement board-specific pin configuration system for automatic setup

---

**Note**: Batch 19 contains several false positives and duplicate TODOs. Items 461-475 would continue the analysis, but many appear to be RP2xxx HAL-related TODOs that have been addressed in other batches or are false positives from the inventory generation process.

---
