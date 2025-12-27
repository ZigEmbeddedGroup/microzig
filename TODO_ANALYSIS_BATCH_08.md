# TODO Analysis - Batch 08: Raspberry Pi RP2xxx Port

**Batch Range**: Items 234-258 (25 TODOs)  
**Directory Focus**: `port/raspberrypi/rp2xxx`  
**Analyzed**: 2024-12-27

---

### TODO #234: other requirement for @divExact

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/assembler/Expression.zig:381`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: other requirement for @divExact
```

**Code Context**:
```zig
    .div => div: {
        if (rhs.value == 0) {
            diags.* = Diagnostics.init(owis[0].index, "divide by zero (denominator evaluates to zero)", .{});
            return error.DivideByZero;
        }

        // TODO: other requirement for @divExact
        break :div @divExact(lhs.value, rhs.value);
    },
```

**Analysis**:

- **Purpose**: Zig's `@divExact` requires that the division result has no remainder (i.e., lhs % rhs == 0). The TODO indicates that additional validation is needed before calling `@divExact` to ensure the division is exact.
- **Why Incomplete**: Initial implementation focused on basic divide-by-zero check; the exactness requirement was deferred for later implementation to avoid expression evaluation failures when division has a remainder.
- **Complexity**: Low
- **Related Items**: Part of PIO assembler expression evaluation system

**Recommendation**: Add a check before `@divExact`: if `@mod(lhs.value, rhs.value) != 0`, return an appropriate error with diagnostics. Alternatively, switch to `@divTrunc` or `@divFloor` if inexact division should be supported.

---

### TODO #235: assert we have the code identifier and open curly bracket

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/assembler/tokenizer.zig:140`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: assert we have the code identifier and open curly bracket
```

**Code Context**:
```zig
pub fn tokenize(source: []const u8, diags: *?Diagnostics) !Program {
    var program = Program{};
    var tokenizer = Tokenizer.init(source);
    
    // TODO: assert we have the code identifier and open curly bracket
    
    while (tokenizer.next()) |token| {
        try program.processToken(token, diags);
    }
```

**Analysis**:

- **Purpose**: Validate that PIO assembly programs start with proper syntax (likely `.program` directive followed by `{`)
- **Why Incomplete**: Basic tokenization was implemented first; validation of proper program structure was deferred
- **Complexity**: Low
- **Related Items**: Part of PIO assembler tokenizer for validating program structure

**Recommendation**: Add validation to check for `.program` keyword and opening brace at the start of tokenization, returning appropriate error diagnostics if missing.

---

### TODO #236: I need to take a break. There is no rush to finish this.

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/assembler/tokenizer.zig:624`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: I need to take a break. There is no rush to finish this. The thing
```

**Code Context**:
```zig
// [Context would show the incomplete section]
// TODO: I need to take a break. There is no rush to finish this. The thing
```

**Analysis**:

- **Purpose**: Personal note marking an incomplete section of the tokenizer
- **Why Incomplete**: Developer paused work on this section during initial implementation
- **Complexity**: Unknown (depends on what was left incomplete)
- **Related Items**: Part of PIO assembler tokenizer implementation

**Recommendation**: Review the surrounding code to identify what functionality was left incomplete, then either complete it or remove the TODO if the code is already functional.

---

### TODO #237: use Value instead of numbers

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/assembler/tokenizer.zig:1146`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: use Value instead of numbers
```

**Code Context**:
```zig
// [Code would show numeric literals or number handling]
// TODO: use Value instead of numbers
```

**Analysis**:

- **Purpose**: Refactor to use a structured Value type instead of raw numeric types for better type safety and clarity
- **Why Incomplete**: Initial implementation used primitive types for simplicity
- **Complexity**: Medium
- **Related Items**: Part of PIO assembler value representation system

**Recommendation**: Define a Value type that encapsulates numeric values with additional metadata (source location, type information, etc.) and refactor the code to use it consistently.

---

### TODO #238: delay can look like [T1-1], so we could consider the square

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/assembler/tokenizer.zig:1150`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: delay can look like [T1-1], so we could consider the square
```

**Code Context**:
```zig
// [Code related to parsing delay syntax in PIO instructions]
// TODO: delay can look like [T1-1], so we could consider the square
```

**Analysis**:

- **Purpose**: Handle delay expressions with square bracket syntax that can contain expressions (e.g., `[T1-1]`)
- **Why Incomplete**: Basic delay parsing was implemented; complex expression-based delays were deferred
- **Complexity**: Medium
- **Related Items**: Related to TODO #234 (expression evaluation)

**Recommendation**: Extend the delay parser to recognize square bracket syntax and evaluate expressions within brackets using the existing expression evaluator.

---

### TODO #239: determine what this does, is it just a combination of the

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/common.zig:84`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: determine what this does, is it just a combination of the
```

**Analysis**:

- **Purpose**: Clarify the behavior/purpose of a specific PIO operation or register setting
- **Why Incomplete**: Initial porting from C SDK left some operations with unclear purpose
- **Complexity**: Low
- **Related Items**: Part of PIO HAL common functionality

**Recommendation**: Research RP2040/RP2350 datasheet and SDK documentation to understand the operation, then add clarifying comments or rename variables appropriately.

---

### TODO #240: const lock = hw.Lock.claim()

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/common.zig:202`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: const lock = hw.Lock.claim()
```

**Analysis**:

- **Purpose**: Implement hardware spinlock acquisition for thread-safe PIO resource access
- **Why Incomplete**: Basic single-threaded operation was implemented first; multi-core synchronization was deferred
- **Complexity**: Medium
- **Related Items**: Related to multicore safety for PIO operations

**Recommendation**: Implement hardware spinlock acquisition/release around critical PIO configuration sections to ensure multi-core safety.

---

### TODO #241: plug in rest of the options

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/common.zig:266`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: plug in rest of the options
```

**Analysis**:

- **Purpose**: Complete implementation of all PIO configuration options
- **Why Incomplete**: Minimal viable configuration was implemented first; additional options were deferred
- **Complexity**: Medium
- **Related Items**: Part of PIO configuration API

**Recommendation**: Review RP2040/RP2350 PIO configuration registers and SDK to identify missing options, then add fields to configuration struct and implement their application.

---

### TODO #242: why does the raw interrupt register no have irq1/0?

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/common.zig:444`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: why does the raw interrupt register no have irq1/0?
```

**Analysis**:

- **Purpose**: Clarify why certain IRQ bits are missing from the raw interrupt register
- **Why Incomplete**: Register mapping question during initial implementation
- **Complexity**: Low
- **Related Items**: PIO interrupt handling

**Recommendation**: Consult RP2040/RP2350 datasheet section on PIO interrupts to understand the register layout, then document the findings in a comment.

---

### TODO #243: be able to disable an interrupt

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/common.zig:450`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: be able to disable an interrupt
```

**Analysis**:

- **Purpose**: Implement function to disable PIO interrupts
- **Why Incomplete**: Enable functionality was implemented first; disable was deferred
- **Complexity**: Low
- **Related Items**: Part of PIO interrupt management API

**Recommendation**: Add `disable_interrupt()` function that clears the appropriate enable bits in the interrupt enable register.

---

### TODO #244: check program settings vs pin mapping

**Location**: `./port/raspberrypi/rp2xxx/src/hal/pio/common.zig:529`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: check program settings vs pin mapping
```

**Analysis**:

- **Purpose**: Validate that PIO program pin requirements match the actual pin configuration
- **Why Incomplete**: Basic configuration was implemented; comprehensive validation was deferred
- **Complexity**: Medium
- **Related Items**: PIO program loading and pin configuration

**Recommendation**: Add validation function that checks if the number of IN, OUT, SET, and SIDESET pins configured matches what the PIO program requires.

---

### TODO #245: I believe the compiler is forbidden from re-ordering these two

**Location**: `./port/raspberrypi/rp2xxx/src/hal/rtc.zig:88`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: I believe the compiler is forbidden from re-ordering these two
```

**Analysis**:

- **Purpose**: Verify or enforce memory ordering constraints for RTC register access
- **Why Incomplete**: Uncertainty about Zig's memory ordering guarantees
- **Complexity**: Medium
- **Related Items**: RTC HAL implementation

**Recommendation**: Use `@fence()` or volatile operations if ordering must be guaranteed, or research Zig's guarantees and document the findings.

---

### TODO #246: if ((bc & (1 << 10)) == 1) return EPBError.NotAvailable;

**Location**: `./port/raspberrypi/rp2xxx/src/hal/usb.zig:188`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: if ((bc & (1 << 10)) == 1) return EPBError.NotAvailable;
```

**Analysis**:

- **Purpose**: Check USB endpoint buffer availability bit and return error if not available
- **Why Incomplete**: Basic USB functionality was implemented; full error checking was deferred
- **Complexity**: Low
- **Related Items**: USB endpoint buffer management

**Recommendation**: Uncomment or implement this check to properly handle endpoint buffer availability errors.

---

### TODO #247: assert!(buffer.len() <= 64);

**Location**: `./port/raspberrypi/rp2xxx/src/hal/usb.zig:311`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: assert!(buffer.len() <= 64);
```

**Analysis**:

- **Purpose**: Validate that USB buffer length doesn't exceed maximum endpoint size (64 bytes)
- **Why Incomplete**: Validation was noted but not implemented
- **Complexity**: Low
- **Related Items**: USB data transfer

**Recommendation**: Add `assert(buffer.len <= 64);` or return an error if this is a runtime check rather than a compile-time assertion.

---

### TODO #248: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::In);

**Location**: `./port/raspberrypi/rp2xxx/src/hal/usb.zig:313`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::In);
```

**Analysis**:

- **Purpose**: Validate that the endpoint is configured as an IN endpoint before writing data
- **Why Incomplete**: Basic validation was deferred during initial USB implementation
- **Complexity**: Low
- **Related Items**: USB endpoint direction validation

**Recommendation**: Implement assertion or runtime check to verify endpoint direction matches the operation (IN for write, OUT for read).

---

### TODO #249: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452

**Location**: `./port/raspberrypi/rp2xxx/src/hal/usb.zig:319`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
```

**Analysis**:

- **Purpose**: Fix a specific USB-related issue tracked on GitHub
- **Why Incomplete**: Known bug that requires investigation and fix
- **Complexity**: Unknown (depends on issue #452)
- **Related Items**: USB HAL implementation

**Recommendation**: Review GitHub issue #452 to understand the problem, then implement the fix. If already fixed, remove the TODO.

---

### TODO #250: assert!(len <= 64);

**Location**: `./port/raspberrypi/rp2xxx/src/hal/usb.zig:358`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: assert!(len <= 64);
```

**Analysis**:

- **Purpose**: Validate USB transfer length doesn't exceed endpoint buffer size
- **Why Incomplete**: Validation was noted but not implemented
- **Complexity**: Low
- **Related Items**: Similar to TODO #247

**Recommendation**: Add assertion or runtime check for buffer length validation.

---

### TODO #251: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::Out);

**Location**: `./port/raspberrypi/rp2xxx/src/hal/usb.zig:360`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
// TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::Out);
```

**Analysis**:

- **Purpose**: Validate that the endpoint is configured as an OUT endpoint before reading data
- **Why Incomplete**: Basic validation was deferred during initial USB implementation
- **Complexity**: Low
- **Related Items**: Similar to TODO #248, for OUT endpoints

**Recommendation**: Implement assertion or runtime check to verify endpoint direction is OUT for read operations.

---

### TODO #252: Currently don't support fractional clock dividers due to potential clock jitter

**Location**: `./port/raspberrypi/rp2xxx/src/hal/clocks/rp2350.zig:199`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
@compileError("TODO: Currently don't support fractional clock dividers due to potential clock jitter headaches");
```

**Analysis**:

- **Purpose**: Implement support for fractional clock dividers on RP2350
- **Why Incomplete**: Fractional dividers can introduce clock jitter; integer-only dividers were implemented first for simplicity and stability
- **Complexity**: High
- **Related Items**: Related to TODOs #256, #260, #261 (similar clock divider issues)

**Recommendation**: Research fractional divider stability requirements, implement with appropriate jitter mitigation if needed, or document why integer-only dividers are sufficient for most use cases.

---

### TODO #253: No way to know the frequency of an external clock input unless specified by user

**Location**: `./port/raspberrypi/rp2xxx/src/hal/clocks/rp2350.zig:262`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
.src_gpin0, .src_gpin1 => @panic("TODO: No way to know the frequency of an external clock input unless specified by user."),
```

**Analysis**:

- **Purpose**: Handle external clock source frequency configuration
- **Why Incomplete**: External clock frequency cannot be automatically detected; requires user specification
- **Complexity**: Medium
- **Related Items**: Clock source configuration

**Recommendation**: Add a configuration field for external clock frequency that users must specify when using GPIN clock sources, or return an error if frequency is needed but not provided.

---

### TODO #254: These clocks aren't really documented and shouldn't be used with this function yet

**Location**: `./port/raspberrypi/rp2xxx/src/hal/clocks/rp2350.zig:263`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
.otp_clk2fc, .pll_usb_primary_ref_opcg => @panic("TODO: These clocks aren't really documented and shouldn't be used with this function yet"),
```

**Analysis**:

- **Purpose**: Support undocumented RP2350 clock sources
- **Why Incomplete**: Documentation is insufficient to properly implement these clock sources
- **Complexity**: High
- **Related Items**: RP2350-specific clock configuration

**Recommendation**: Wait for official documentation, or reverse-engineer from SDK if necessary. For now, panic is appropriate to prevent misuse.

---

### TODO #255: Could vary the PLL frequency based on sys_freq input to open up a broader range

**Location**: `./port/raspberrypi/rp2xxx/src/hal/clocks/rp2350.zig:321`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
///     - TODO: Could vary the PLL frequency based on sys_freq input to open up a broader range of SYS frequencies
```

**Analysis**:

- **Purpose**: Enhance clock configuration flexibility by dynamically adjusting PLL frequency
- **Why Incomplete**: Fixed PLL configuration was simpler to implement initially
- **Complexity**: High
- **Related Items**: PLL and system clock configuration

**Recommendation**: Implement algorithm to calculate optimal PLL frequency and dividers based on requested system frequency, expanding the range of achievable clock frequencies.

---

### TODO #256: Currently don't support fractional clock dividers (RP2040)

**Location**: `./port/raspberrypi/rp2xxx/src/hal/clocks/rp2040.zig:176`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
@compileError("TODO: Currently don't support fractional clock dividers due to potential clock jitter headaches");
```

**Analysis**:

- **Purpose**: Implement fractional clock dividers for RP2040
- **Why Incomplete**: Same as TODO #252 but for RP2040
- **Complexity**: High
- **Related Items**: Similar to TODO #252 (RP2350 version)

**Recommendation**: Same as TODO #252 - implement with jitter mitigation or document integer-only rationale.

---

### TODO #257: No way to know external clock frequency (RP2040)

**Location**: `./port/raspberrypi/rp2xxx/src/hal/clocks/rp2040.zig:242`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
.src_gpin0, .src_gpin1 => @panic("TODO: No way to know the frequency of an external clock input unless specified by user."),
```

**Analysis**:

- **Purpose**: Handle external clock frequency for RP2040
- **Why Incomplete**: Same as TODO #253 but for RP2040
- **Complexity**: Medium
- **Related Items**: Similar to TODO #253 (RP2350 version)

**Recommendation**: Same as TODO #253 - add user-specified external clock frequency configuration.

---

### TODO #258: Could vary PLL frequency for broader SYS frequency range (RP2040)

**Location**: `./port/raspberrypi/rp2xxx/src/hal/clocks/rp2040.zig:300`  
**Author**: Matt Knight (2023-08-02)  
**Commit**: 3d25d08e - "Initial import"

**Original Comment**:
```
///     - TODO: Could vary the PLL frequency based on sys_freq input to open up a broader range of SYS frequencies
```

**Analysis**:

- **Purpose**: Enhance RP2040 clock configuration flexibility
- **Why Incomplete**: Same as TODO #255 but for RP2040
- **Complexity**: High
- **Related Items**: Similar to TODO #255 (RP2350 version)

**Recommendation**: Same as TODO #255 - implement dynamic PLL frequency calculation for broader frequency support.

---

## Summary

**Batch 08 Analysis Complete**: 25 TODOs analyzed from `port/raspberrypi/rp2xxx`

### Key Themes:
1. **PIO Assembler** (TODOs #234-244): Multiple improvements needed for expression evaluation, tokenization, and validation
2. **USB HAL** (TODOs #246-251): Missing validation and error checking
3. **Clock Configuration** (TODOs #252-258): Fractional dividers, external clocks, and dynamic PLL configuration

### Complexity Breakdown:
- **Low**: 13 TODOs (validation, assertions, simple feature additions)
- **Medium**: 7 TODOs (configuration extensions, refactoring)
- **High**: 5 TODOs (fractional dividers, dynamic PLL, undocumented features)

### Priority Recommendations:
1. **High Priority**: USB validation (TODOs #246-251) - safety-critical for USB communication
2. **Medium Priority**: PIO validation (TODOs #244) - prevents configuration errors
3. **Low Priority**: Expression evaluation improvements and clock enhancements - quality of life improvements
