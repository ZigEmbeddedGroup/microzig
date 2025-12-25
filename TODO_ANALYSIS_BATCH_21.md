# TODO Analysis Batch 21: port/raspberrypi/rp2xxx

**Batch Info**: Items 501-525 from TODO_INVENTORY.json

## Analysis Summary

This batch focuses on TODOs in the RP2xxx port, specifically in the PIO (Programmable I/O) subsystem, PWM, ROM, RTC, UART, USB, and watchdog modules. Most TODOs are implementation gaps or questions about hardware behavior.

---

### TODO #501: PIO interrupt register question

**Location**: `port/raspberrypi/rp2xxx/src/hal/pio/common.zig:444`  
**Author**: Grazfather (2024-12-06)  
**Commit**: b534a670c - "Add PIO support to rp2350 (#306)"

**Original Comment**:
```
// TODO: why does the raw interrupt register no have irq1/0?
```

**Code Context**:
```zig
pub fn sm_clear_interrupt(
    self: EnumType,
    sm: StateMachine,
    irq: Irq,
    source: Irq.Source,
) void {
    // TODO: why does the raw interrupt register no have irq1/0?
    _ = irq;
    const regs = self.get_regs();
    regs.IRQ.raw |= @as(u32, 1) << interrupt_bit_pos(sm, source);
}
```

**Analysis**:

- **Purpose**: Question about PIO interrupt register design - why the raw IRQ register doesn't distinguish between IRQ0/IRQ1
- **Why Incomplete**: This is a hardware design question that needs investigation of the RP2xxx datasheet
- **Complexity**: Low
- **Related Items**: TODO #502 (interrupt disabling)

**Recommendation**: Research RP2xxx PIO interrupt architecture in datasheet to understand register layout

---

### TODO #502: PIO interrupt disabling

**Location**: `port/raspberrypi/rp2xxx/src/hal/pio/common.zig:450`  
**Author**: Grazfather (2024-12-06)  
**Commit**: b534a670c - "Add PIO support to rp2350 (#306)"

**Original Comment**:
```
// TODO: be able to disable an interrupt
```

**Code Context**:
```zig
// TODO: be able to disable an interrupt
pub fn sm_enable_interrupt(
    self: EnumType,
    sm: StateMachine,
    irq: Irq,
    source: Irq.Source,
) void {
    const irq_regs = self.get_irq_regs(irq);
    irq_regs.enable.raw |= @as(u32, 1) << interrupt_bit_pos(sm, source);
}
```

**Analysis**:

- **Purpose**: Add function to disable PIO state machine interrupts (complement to enable function)
- **Why Incomplete**: Only enable function implemented, disable function missing
- **Complexity**: Low
- **Related Items**: TODO #501 (interrupt register question)

**Recommendation**: Implement `sm_disable_interrupt` function that clears the appropriate bit in the enable register

---

### TODO #503: PIO program settings validation

**Location**: `port/raspberrypi/rp2xxx/src/hal/pio/common.zig:529`  
**Author**: Grazfather (2024-12-06)  
**Commit**: b534a670c - "Add PIO support to rp2350 (#306)"

**Original Comment**:
```
// TODO: check program settings vs pin mapping
```

**Code Context**:
```zig
// TODO: check program settings vs pin mapping
const offset = try self.add_program(program);

try self.sm_init(sm, offset, .{
    .clkdiv = options.clkdiv,
    .shift = options.shift,
    .pin_mappings = options.pin_mappings,
```

**Analysis**:

- **Purpose**: Validate that program requirements match configured pin mappings
- **Why Incomplete**: Safety/validation feature not yet implemented
- **Complexity**: Medium
- **Related Items**: None nearby

**Recommendation**: Add validation to ensure program side-set, out, set, and in pin requirements match the configured pin mappings

---

### TODO #504: PWM pin function documentation

**Location**: `port/raspberrypi/rp2xxx/src/hal/pwm.zig:68`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
/// e.g. rp2xxx.gpio.num(pin_num).set_function(.pwm)
```

**Code Context**:
```zig
/// e.g. rp2xxx.gpio.num(pin_num).set_function(.pwm)
```

**Analysis**:

- **Purpose**: Documentation example for setting GPIO pin to PWM function
- **Why Incomplete**: This appears to be documentation, not a TODO
- **Complexity**: Low
- **Related Items**: None

**Recommendation**: This seems to be documentation rather than a TODO - verify if this should be removed from TODO list

---

### TODO #505: ROM access documentation

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom.zig:1`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
//! Access to functions and data in the RP2XXX bootrom.
```

**Code Context**:
```zig
//! Access to functions and data in the RP2XXX bootrom.
```

**Analysis**:

- **Purpose**: Module documentation for ROM access
- **Why Incomplete**: This is documentation, not a TODO
- **Complexity**: N/A
- **Related Items**: None

**Recommendation**: This is documentation, not a TODO - should be removed from TODO inventory

---

### TODO #506: ROM table copying to RAM

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:16`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: maybe support copying the table to ram as well?
```

**Code Context**:
```zig
// TODO: maybe support copying the table to ram as well?
```

**Analysis**:

- **Purpose**: Consider supporting copying ROM function table to RAM for performance
- **Why Incomplete**: Performance optimization not implemented
- **Complexity**: Medium
- **Related Items**: None

**Recommendation**: Evaluate if RAM copying would provide significant performance benefits for ROM function calls

---

### TODO #507: ROM function signature verification

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:64`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
// TODO: Is the signature correct?
```

**Analysis**:

- **Purpose**: Verify ROM function signature is correct
- **Why Incomplete**: Function signature needs verification against datasheet
- **Complexity**: Low
- **Related Items**: TODO #508 (another signature verification)

**Recommendation**: Cross-reference function signatures with RP2040 datasheet ROM function documentation

---

### TODO #508: ROM function signature verification

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:66`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
// TODO: Is the signature correct?
```

**Analysis**:

- **Purpose**: Verify ROM function signature is correct
- **Why Incomplete**: Function signature needs verification against datasheet
- **Complexity**: Low
- **Related Items**: TODO #507, #509, #510 (other signature verifications)

**Recommendation**: Cross-reference function signatures with RP2040 datasheet ROM function documentation

---

### TODO #509: ROM function signature verification

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:195`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
// TODO: Is the signature correct?
```

**Analysis**:

- **Purpose**: Verify ROM function signature is correct
- **Why Incomplete**: Function signature needs verification against datasheet
- **Complexity**: Low
- **Related Items**: TODO #507, #508, #510 (other signature verifications)

**Recommendation**: Cross-reference function signatures with RP2040 datasheet ROM function documentation

---

### TODO #510: ROM function signature verification

**Location**: `port/raspberrypi/rp2xxx/src/hal/rom/rp2040.zig:197`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: Is the signature correct?
```

**Code Context**:
```zig
// TODO: Is the signature correct?
```

**Analysis**:

- **Purpose**: Verify ROM function signature is correct
- **Why Incomplete**: Function signature needs verification against datasheet
- **Complexity**: Low
- **Related Items**: TODO #507, #508, #509 (other signature verifications)

**Recommendation**: Cross-reference function signatures with RP2040 datasheet ROM function documentation

---

### TODO #511: RTC register ordering concern

**Location**: `port/raspberrypi/rp2xxx/src/hal/rtc.zig:88`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: I believe the compiler is forbidden from re-ordering these two
```

**Code Context**:
```zig
// TODO: I believe the compiler is forbidden from re-ordering these two
```

**Analysis**:

- **Purpose**: Ensure compiler doesn't reorder critical RTC register operations
- **Why Incomplete**: Memory ordering guarantees need verification
- **Complexity**: Medium
- **Related Items**: None

**Recommendation**: Add explicit memory barriers or volatile operations to ensure correct ordering

---

### TODO #512: UART DMA future modification

**Location**: `port/raspberrypi/rp2xxx/src/hal/uart.zig:325`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: Will potentially be modified in a future DMA overhaul
```

**Code Context**:
```zig
// TODO: Will potentially be modified in a future DMA overhaul
```

**Analysis**:

- **Purpose**: Note that UART implementation may change with DMA redesign
- **Why Incomplete**: Waiting for DMA subsystem redesign
- **Complexity**: High
- **Related Items**: None

**Recommendation**: Keep this note until DMA overhaul is completed, then update UART implementation accordingly

---

### TODO #513: USB max endpoints constant

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:19`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;
```

**Code Context**:
```zig
pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;
```

**Analysis**:

- **Purpose**: Define maximum USB endpoints for RP2xxx
- **Why Incomplete**: This appears to be a constant definition, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #514

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #514: USB max endpoints default

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:23`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
max_endpoints_count: u8 = RP2XXX_MAX_ENDPOINTS_COUNT,
```

**Code Context**:
```zig
max_endpoints_count: u8 = RP2XXX_MAX_ENDPOINTS_COUNT,
```

**Analysis**:

- **Purpose**: Set default max endpoints count
- **Why Incomplete**: This appears to be a field definition, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #513

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #515: USB buffer structure

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:59`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
const rp2xxx_buffers = struct {
```

**Code Context**:
```zig
const rp2xxx_buffers = struct {
```

**Analysis**:

- **Purpose**: USB buffer structure definition
- **Why Incomplete**: This appears to be a struct definition, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #516

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #516: USB endpoints structure

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:82`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
const rp2xxx_endpoints = struct {
```

**Code Context**:
```zig
const rp2xxx_endpoints = struct {
```

**Analysis**:

- **Purpose**: USB endpoints structure definition
- **Why Incomplete**: This appears to be a struct definition, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #515

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #517: USB endpoints count validation

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:116`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
if (device_config.max_endpoints_count > RP2XXX_MAX_ENDPOINTS_COUNT)
```

**Code Context**:
```zig
if (device_config.max_endpoints_count > RP2XXX_MAX_ENDPOINTS_COUNT)
```

**Analysis**:

- **Purpose**: Validate USB endpoints count doesn't exceed maximum
- **Why Incomplete**: This appears to be validation code, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #518

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #518: USB endpoints count error message

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:117`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
@compileError("RP2XXX USB endpoints number can't be grater than RP2XXX_MAX_ENDPOINTS_COUNT");
```

**Code Context**:
```zig
@compileError("RP2XXX USB endpoints number can't be grater than RP2XXX_MAX_ENDPOINTS_COUNT");
```

**Analysis**:

- **Purpose**: Compile-time error for invalid endpoint count
- **Why Incomplete**: This appears to be error handling, not a TODO. Note: "grater" should be "greater"
- **Complexity**: N/A
- **Related Items**: TODO #517

**Recommendation**: Fix typo "grater" → "greater", but this is not a TODO - should be removed from TODO inventory

---

### TODO #519: USB buffer availability check

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:188`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: if ((bc & (1 << 10)) == 1) return EPBError.NotAvailable;
```

**Code Context**:
```zig
// TODO: if ((bc & (1 << 10)) == 1) return EPBError.NotAvailable;
```

**Analysis**:

- **Purpose**: Check USB buffer availability before operations
- **Why Incomplete**: Buffer availability check not implemented
- **Complexity**: Low
- **Related Items**: None

**Recommendation**: Implement buffer availability check to prevent operations on unavailable buffers

---

### TODO #520: USB endpoint control register access

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:228`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
rp2xxx_endpoints.get_ep_ctrl(@enumFromInt(i), .In).?.write_raw(0);
```

**Code Context**:
```zig
rp2xxx_endpoints.get_ep_ctrl(@enumFromInt(i), .In).?.write_raw(0);
```

**Analysis**:

- **Purpose**: Clear USB endpoint control registers
- **Why Incomplete**: This appears to be implementation code, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #521, #522, #523

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #521: USB endpoint control register access

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:229`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
rp2xxx_endpoints.get_ep_ctrl(@enumFromInt(i), .Out).?.write_raw(0);
```

**Code Context**:
```zig
rp2xxx_endpoints.get_ep_ctrl(@enumFromInt(i), .Out).?.write_raw(0);
```

**Analysis**:

- **Purpose**: Clear USB endpoint control registers
- **Why Incomplete**: This appears to be implementation code, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #520, #522, #523

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #522: USB buffer control register access

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:233`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
rp2xxx_endpoints.get_buf_ctrl(@enumFromInt(i), .In).?.write_raw(0);
```

**Code Context**:
```zig
rp2xxx_endpoints.get_buf_ctrl(@enumFromInt(i), .In).?.write_raw(0);
```

**Analysis**:

- **Purpose**: Clear USB buffer control registers
- **Why Incomplete**: This appears to be implementation code, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #520, #521, #523

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #523: USB buffer control register access

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:234`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
rp2xxx_endpoints.get_buf_ctrl(@enumFromInt(i), .Out).?.write_raw(0);
```

**Code Context**:
```zig
rp2xxx_endpoints.get_buf_ctrl(@enumFromInt(i), .Out).?.write_raw(0);
```

**Analysis**:

- **Purpose**: Clear USB buffer control registers
- **Why Incomplete**: This appears to be implementation code, not a TODO
- **Complexity**: N/A
- **Related Items**: TODO #520, #521, #522

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #524: USB data buffer assignment

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:280`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
.data_buffer = rp2xxx_buffers.data_buffer,
```

**Code Context**:
```zig
.data_buffer = rp2xxx_buffers.data_buffer,
```

**Analysis**:

- **Purpose**: Assign USB data buffer
- **Why Incomplete**: This appears to be implementation code, not a TODO
- **Complexity**: N/A
- **Related Items**: None

**Recommendation**: This is not a TODO - should be removed from TODO inventory

---

### TODO #525: USB buffer length assertion

**Location**: `port/raspberrypi/rp2xxx/src/hal/usb.zig:311`  
**Author**: Unknown (need git blame)  
**Commit**: Unknown  

**Original Comment**:
```
// TODO: assert!(buffer.len() <= 64);
```

**Code Context**:
```zig
// TODO: assert!(buffer.len() <= 64);
```

**Analysis**:

- **Purpose**: Add assertion to validate USB buffer length doesn't exceed 64 bytes
- **Why Incomplete**: Safety check not implemented
- **Complexity**: Low
- **Related Items**: TODO #526, #528, #529

**Recommendation**: Add assertion to validate buffer length is within USB packet size limits

---

## Summary

**Total TODOs Analyzed**: 25

**By Complexity**:
- Low: 12 (actual TODOs requiring implementation)
- Medium: 3
- High: 1
- N/A: 9 (not actual TODOs)

**By Type**:
- Implementation gaps: 8
- Documentation/comments: 9 (should be removed from TODO list)
- Validation/safety: 4
- Hardware questions: 2
- Future considerations: 2

**Key Findings**:
1. Many items in this batch are not actual TODOs but code comments or struct definitions
2. PIO interrupt handling needs completion
3. USB buffer validation needs implementation
4. ROM function signatures need verification
5. Several items should be removed from the TODO inventory

**Recommended Actions**:
1. Clean up TODO inventory to remove non-TODO items (#504, #505, #513-518, #520-524)
2. Implement missing PIO interrupt functionality (#501, #502)
3. Add USB buffer validation (#519, #525)
4. Verify ROM function signatures (#507-510)
5. Research PIO interrupt register architecture (#501)
