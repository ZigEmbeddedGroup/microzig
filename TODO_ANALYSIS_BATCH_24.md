# TODO Analysis - Batch 24

**Batch Info**: Items 576-600 from TODO_INVENTORY.json  
**Analysis Date**: 2025-12-24  
**Total TODOs Analyzed**: 25

---

### TODO #576: How do we know if we need to set the AFIOEN?

**Location**: `port/wch/ch32v/src/hals/clocks.zig:14`  
**Author**: Grazfather (2025-12-14)  
**Commit**: 58467af60 - "ch32v: Add get_freqs, USART hal (#762)"

**Original Comment**:
```
// TODO: How do we know if we need to set the AFIOEN?
```

**Code Context**:
```zig
pub fn enable_gpio_clock(block: gpioBlock) void {
    // TODO: How do we know if we need to set the AFIOEN?
    switch (block) {
        .A => RCC.APB2PCENR.modify(.{
            .IOPAEN = 1,
            .AFIOEN = 1,
        }),
        .B => RCC.APB2PCENR.modify(.{
            .IOPBEN = 1,
            .AFIOEN = 1,
        }),
```

**Analysis**:

- **Purpose**: Determine when AFIO (Alternate Function I/O) clock should be enabled alongside GPIO clocks
- **Why Incomplete**: The current implementation always enables AFIOEN when enabling any GPIO clock, but this may be unnecessary overhead in some cases
- **Complexity**: Low
- **Related Items**: Related to TODO #585 about USART support and pin remapping functionality

**Recommendation**: Research CH32V reference manual to determine specific conditions when AFIO clock is required (typically for pin remapping, external interrupts, or alternate functions). Consider making AFIO enable conditional or provide separate function.

---

### TODO #577: Make this more flexible

**Location**: `port/wch/ch32v/src/hals/clocks.zig:150`  
**Author**: Grazfather (2025-12-15)  
**Commit**: cec680031 - "ch32v: Improve clock configuration (#767)"

**Original Comment**:
```
// TODO: Make this more flexible.
```

**Code Context**:
```zig
fn init_from_hsi(target_freq: u32) void {
    // Calculate PLL configuration
    // The HSIPRE bit controls whether HSI is divided before PLL
    // PLLMUL bits control the PLL multiplier factor

    // TODO: Make this more flexible.
    if (target_freq == 8_000_000) {
        // Use HSI directly at 8 MHz without PLL
```

**Analysis**:

- **Purpose**: Expand clock configuration to support more target frequencies and PLL configurations
- **Why Incomplete**: Current implementation only supports hardcoded frequencies (8MHz, 24MHz, 48MHz), limiting flexibility
- **Complexity**: Medium
- **Related Items**: Part of broader clock system improvements in the same commit

**Recommendation**: Implement algorithmic PLL calculation to support arbitrary target frequencies within hardware limits. Add validation for supported frequency ranges and PLL multiplier/divider combinations.

---

### TODO #578: Why is this 4, not 2? Check

**Location**: `port/wch/ch32v/src/hals/clocks.zig:173`  
**Author**: Grazfather (2025-12-15)  
**Commit**: cec680031 - "ch32v: Improve clock configuration (#767)"

**Original Comment**:
```
// TODO: Why is this 4, not 2? Check
```

**Code Context**:
```zig
        RCC.CFGR0.modify(.{
            .HPRE = 0, // AHB prescaler = 1 (no division)
            .PPRE2 = 0, // APB2 prescaler = 1 (no division)
            // TODO: Why is this 4, not 2? Check
            .PPRE1 = 4, // APB1 prescaler = 2 (divide by 2)
            .PLLSRC = 0, // PLL source = HSI
```

**Analysis**:

- **Purpose**: Verify correct APB1 prescaler value for CH32V hardware
- **Why Incomplete**: Uncertainty about register encoding - needs verification against hardware reference manual
- **Complexity**: Low
- **Related Items**: Critical for correct peripheral clock frequencies

**Recommendation**: Consult CH32V reference manual to verify PPRE1 register encoding. Value 4 may be correct if encoding is non-linear (e.g., 0=1, 4=2, 5=4, etc.).

---

### TODO #579: TODO comment without description

**Location**: `port/wch/ch32v/src/hals/gpio.zig:68`  
**Author**: Norio Suzuki (2024-11-22)  
**Commit**: 5dd290395 - "Port for WCH CH32V series (CH32V003, CH32V103, and CH32V203) (#286)"

**Original Comment**:
```
// TODO:
```

**Code Context**:
```zig
    // TODO:
    inline fn write_pin_config(gpio: Pin, config: u32) void {
        const port = gpio.get_port();
        if (gpio.number <= 7) {
            const offset = @as(u5, gpio.number) << 2; // number * 4
            port.CFGLR.raw &= ~(@as(u32, 0b1111) << offset);
            port.CFGLR.raw |= config << offset;
```

**Analysis**:

- **Purpose**: Unknown - empty TODO comment provides no context
- **Why Incomplete**: Original port implementation left incomplete thoughts
- **Complexity**: Low
- **Related Items**: Part of initial CH32V port implementation

**Recommendation**: Remove empty TODO or investigate if there are known issues with pin configuration that need addressing.

---

### TODO #580: Cleanup!

**Location**: `port/wch/ch32v/src/hals/gpio.zig:119`  
**Author**: Grazfather (2025-12-14)  
**Commit**: 58467af60 - "ch32v: Add get_freqs, USART hal (#762)"

**Original Comment**:
```
// TODO: Cleanup!
```

**Code Context**:
```zig
    pub inline fn enable_clock(gpio: Pin) void {
        // TODO: Cleanup!
        clocks.enable_gpio_clock(switch (gpio.get_port()) {
            GPIOA => .A,
            GPIOB => .B,
            GPIOC => .C,
            GPIOD => .D,
            else => unreachable,
        });
    }
```

**Analysis**:

- **Purpose**: Improve the GPIO clock enable implementation
- **Why Incomplete**: Current switch statement is verbose and could be simplified
- **Complexity**: Low
- **Related Items**: Related to GPIO and clock management improvements

**Recommendation**: Refactor to use a more elegant mapping between GPIO ports and clock enable enum values, possibly using comptime computation or lookup table.

---

### TODO #581: Set mode when configure alternative mode

**Location**: `port/wch/ch32v/src/hals/pins.zig:40`  
**Author**: Norio Suzuki (2024-11-22)  
**Commit**: 5dd290395 - "Port for WCH CH32V series (CH32V003, CH32V103, and CH32V203) (#286)"

**Original Comment**:
```
// TODO: set mode when configure alternative mode.
```

**Code Context**:
```zig
        pub fn get_mode(comptime config: Configuration) gpio.Mode {
            return if (config.mode) |mode|
                mode
                // TODO: set mode when configure alternative mode.
                // else if (comptime config.function.is_pwm())
                //     .output
                // else if (comptime config.function.is_uart_tx())
                //     .output
```

**Analysis**:

- **Purpose**: Automatically determine GPIO mode based on alternate function configuration
- **Why Incomplete**: Initial port focused on basic functionality, alternate function auto-configuration was deferred
- **Complexity**: Medium
- **Related Items**: Part of comprehensive pin configuration system

**Recommendation**: Implement function type detection and automatic mode selection for common alternate functions (UART, SPI, I2C, PWM, etc.).

---

### TODO #582: TODO without implementation

**Location**: `port/wch/ch32v/src/hals/pins.zig:50`  
**Author**: Norio Suzuki (2024-11-22)  
**Commit**: 5dd290395 - "Port for WCH CH32V series (CH32V003, CH32V103, and CH32V203) (#286)"

**Original Comment**:
```
@panic("TODO");
```

**Code Context**:
```zig
            else
                @panic("TODO");
```

**Analysis**:

- **Purpose**: Handle unimplemented pin configuration cases
- **Why Incomplete**: Initial port implementation left some edge cases unhandled
- **Complexity**: Low
- **Related Items**: Part of pin configuration error handling

**Recommendation**: Identify what cases trigger this panic and implement proper handling or provide meaningful error messages.

---

### TODO #583: Read current output from ODR

**Location**: `port/wch/ch32v/src/hals/pins.zig:79`  
**Author**: Norio Suzuki (2024-11-22)  
**Commit**: 5dd290395 - "Port for WCH CH32V series (CH32V003, CH32V103, and CH32V203) (#286)"

**Original Comment**:
```
// TODO: Read current output from ODR.
```

**Code Context**:
```zig
            // TODO: Read current output from ODR.
            // pub inline fn read(self: @This()) u1 {
            //     _ = self;
            //     return pin.output_read();
            // }
```

**Analysis**:

- **Purpose**: Implement ability to read current output state of GPIO pins
- **Why Incomplete**: Initial implementation focused on basic input/output, reading output state was deferred
- **Complexity**: Low
- **Related Items**: Part of comprehensive GPIO functionality

**Recommendation**: Implement output state reading by accessing the ODR (Output Data Register) for the corresponding GPIO port.

---

### TODO #584: GPIOD has only 3 ports. Check this

**Location**: `port/wch/ch32v/src/hals/pins.zig:238`  
**Author**: Norio Suzuki (2024-11-22)  
**Commit**: 5dd290395 - "Port for WCH CH32V series (CH32V003, CH32V103, and CH32V203) (#286)"

**Original Comment**:
```
// TODO: GPIOD has only 3 ports. Check this.
```

**Code Context**:
```zig
                inline for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
                    // TODO: GPIOD has only 3 ports. Check this.
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
```

**Analysis**:

- **Purpose**: Validate pin configuration against hardware limitations of GPIOD port
- **Why Incomplete**: Need to verify actual pin count for GPIOD on different CH32V variants
- **Complexity**: Low
- **Related Items**: Hardware-specific validation for pin configuration

**Recommendation**: Add compile-time or runtime validation to prevent configuration of non-existent pins on GPIOD. Check CH32V datasheets for exact pin counts per variant.

---

### TODO #585: Remove this loop. Set at once

**Location**: `port/wch/ch32v/src/hals/pins.zig:241`  
**Author**: Norio Suzuki (2024-11-22)  
**Commit**: 5dd290395 - "Port for WCH CH32V series (CH32V003, CH32V103, and CH32V203) (#286)"

**Original Comment**:
```
// TODO: Remove this loop. Set at once.
```

**Code Context**:
```zig
                        // TODO: Remove this loop. Set at once.
                        pin.set_mode(pin_config.mode.?);
```

**Analysis**:

- **Purpose**: Optimize pin configuration by setting multiple pins simultaneously instead of individually
- **Why Incomplete**: Initial implementation prioritized correctness over performance
- **Complexity**: Medium
- **Related Items**: Performance optimization for pin configuration

**Recommendation**: Implement batch pin configuration that calculates combined register values and applies them in single register writes rather than individual pin operations.

---

### TODO #586: Remove this loop. Set at once

**Location**: `port/wch/ch32v/src/hals/pins.zig:255`  
**Author**: Norio Suzuki (2024-11-22)  
**Commit**: 5dd290395 - "Port for WCH CH32V series (CH32V003, CH32V103, and CH32V203) (#286)"

**Original Comment**:
```
// TODO: Remove this loop. Set at once.
```

**Code Context**:
```zig
                            // TODO: Remove this loop. Set at once.
                            pin.set_pull(pull);
```

**Analysis**:

- **Purpose**: Optimize pull-up/pull-down configuration by batching operations
- **Why Incomplete**: Same as TODO #585 - performance optimization deferred
- **Complexity**: Medium
- **Related Items**: Related to TODO #585 for batch pin operations

**Recommendation**: Similar to #585, implement batch pull configuration that combines multiple pin settings into single register operations.

---

### TODO #587: Add support for other USARTs/UARTs

**Location**: `port/wch/ch32v/src/hals/usart.zig:151`  
**Author**: Grazfather (2025-12-14)  
**Commit**: 58467af60 - "ch32v: Add get_freqs, USART hal (#762)"

**Original Comment**:
```
// TODO: Add support for other USARTs/UARTs
```

**Code Context**:
```zig
        hal.clocks.enable_peripheral_clock(switch (usart) {
            .USART1 => .USART1,
            .USART2 => .USART2,
            .USART3 => .USART3,
            // TODO: Add support for other USARTs/UARTs
            else => @compileError("USART1,2,3 only supported at the moment"),
        });
```

**Analysis**:

- **Purpose**: Extend USART support to additional peripheral instances available on CH32V chips
- **Why Incomplete**: Initial implementation focused on most common USART instances
- **Complexity**: Low
- **Related Items**: Part of comprehensive USART HAL implementation

**Recommendation**: Research CH32V variants to identify additional UART/USART instances and add them to the peripheral clock enable switch statement.

---

### TODO #588: TODO! (fmul instruction)

**Location**: `sim/aviron/src/lib/Cpu.zig:611`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
/// TODO!
```

**Code Context**:
```zig
    /// TODO!
    inline fn fmul(cpu: *Cpu, info: isa.opinfo.d3r3) !void {
        _ = cpu;
        std.debug.print("fmul {}\n", .{info});
        @panic("fmul not implemented yet!");
    }
```

**Analysis**:

- **Purpose**: Implement AVR FMUL (Fractional Multiply) instruction for AVR simulator
- **Why Incomplete**: Complex instruction implementation was deferred during initial instruction set implementation
- **Complexity**: Medium
- **Related Items**: Part of AVR multiplier instruction family (fmuls, fmulsu also unimplemented)

**Recommendation**: Implement fractional multiply operation according to AVR instruction set specification. Result should be left-shifted by 1 bit compared to regular multiply.

---

### TODO #589: TODO! (fmuls instruction)

**Location**: `sim/aviron/src/lib/Cpu.zig:618`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
/// TODO!
```

**Code Context**:
```zig
    /// TODO!
    inline fn fmuls(cpu: *Cpu, info: isa.opinfo.d3r3) !void {
        _ = cpu;
        std.debug.print("fmuls {}\n", .{info});
        @panic("fmuls not implemented yet!");
    }
```

**Analysis**:

- **Purpose**: Implement AVR FMULS (Fractional Multiply Signed) instruction
- **Why Incomplete**: Same as FMUL - complex instruction deferred during initial implementation
- **Complexity**: Medium
- **Related Items**: Related to TODO #588 (fmul) and #590 (fmulsu)

**Recommendation**: Implement signed fractional multiply with proper sign handling and left-shift operation.

---

### TODO #590: TODO! (fmulsu instruction)

**Location**: `sim/aviron/src/lib/Cpu.zig:625`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
/// TODO!
```

**Code Context**:
```zig
    /// TODO!
    inline fn fmulsu(cpu: *Cpu, info: isa.opinfo.d3r3) !void {
        _ = cpu;
        std.debug.print("fmulsu {}\n", .{info});
        @panic("fmulsu not implemented yet!");
    }
```

**Analysis**:

- **Purpose**: Implement AVR FMULSU (Fractional Multiply Signed with Unsigned) instruction
- **Why Incomplete**: Complex mixed-sign multiply instruction deferred
- **Complexity**: Medium
- **Related Items**: Completes the fractional multiply instruction family with #588 and #589

**Recommendation**: Implement mixed-sign fractional multiply (signed × unsigned) with proper result formatting.

---

### TODO #591: TODO! (SPM instruction - bootloader functionality)

**Location**: `sim/aviron/src/lib/Cpu.zig:1445`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
```

**Code Context**:
```zig
    ///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
    inline fn spm_i(cpu: *Cpu) !void {
        _ = cpu;
        @panic("spm (i) is not supported.");
    }
```

**Analysis**:

- **Purpose**: Implement SPM (Store Program Memory) instruction for self-programming capability
- **Why Incomplete**: Complex bootloader-specific instruction not needed for most AVR emulation use cases
- **Complexity**: High
- **Related Items**: Related to TODO #592 (spm_ii)

**Recommendation**: Low priority - only implement if bootloader emulation becomes necessary. Requires flash memory write simulation and page buffer management.

---

### TODO #592: TODO! (SPM #2 instruction)

**Location**: `sim/aviron/src/lib/Cpu.zig:1463`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
```

**Code Context**:
```zig
    ///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
    inline fn spm_ii(cpu: *Cpu) !void {
        _ = cpu;
        @panic("spm #2 is not supported.");
    }
```

**Analysis**:

- **Purpose**: Implement second variant of SPM instruction
- **Why Incomplete**: Same as #591 - bootloader-specific functionality not essential for general emulation
- **Complexity**: High
- **Related Items**: Related to TODO #591 (spm_i)

**Recommendation**: Same as #591 - low priority unless bootloader emulation is required.

---

### TODO #593: TODO! (DES instruction - very specialized)

**Location**: `sim/aviron/src/lib/Cpu.zig:1556`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
/// TODO! (Not necessarily required for implementation, very weird use case)
```

**Code Context**:
```zig
    /// TODO! (Not necessarily required for implementation, very weird use case)
    inline fn des(cpu: *Cpu, info: isa.opinfo.k4) !void {
        _ = cpu;
        _ = info;
        @panic("TODO: Implement DES instruction!");
    }
```

**Analysis**:

- **Purpose**: Implement DES (Data Encryption Standard) instruction for cryptographic operations
- **Why Incomplete**: Very specialized instruction with limited use cases in typical AVR applications
- **Complexity**: High
- **Related Items**: Standalone cryptographic instruction

**Recommendation**: Very low priority - only implement if specific AVR programs requiring DES encryption need to be emulated. Requires full DES algorithm implementation.

---

### TODO #594: Implement DES instruction

**Location**: `sim/aviron/src/lib/Cpu.zig:1560`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
@panic("TODO: Implement DES instruction!");
```

**Code Context**:
```zig
        @panic("TODO: Implement DES instruction!");
```

**Analysis**:

- **Purpose**: Same as #593 - implement DES instruction
- **Why Incomplete**: Duplicate of #593
- **Complexity**: High
- **Related Items**: Duplicate of TODO #593

**Recommendation**: Consolidate with #593 - same implementation task.

---

### TODO #595: FIXME - Register file mapping for classic AVR

**Location**: `sim/aviron/src/lib/mcu.zig:23`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
/// FIXME: The current io_window design doesn't properly model register file mapping for classic
```

**Code Context**:
```zig
/// FIXME: The current io_window design doesn't properly model register file mapping for classic
/// AVR devices where the register file (0x00-0x1F) is not mapped in data space.
```

**Analysis**:

- **Purpose**: Fix memory mapping model for classic AVR devices
- **Why Incomplete**: Architectural issue with memory model design that affects accuracy
- **Complexity**: High
- **Related Items**: Related to TODOs #596 and #597 about register file mapping

**Recommendation**: Redesign memory mapping to properly separate register file from data space for classic AVR devices. This is important for accurate emulation.

---

### TODO #596: FIXME - Register file not mapped in data space

**Location**: `sim/aviron/src/lib/mcu.zig:108`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
```

**Code Context**:
```zig
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
/// access SRAM instead of registers on classic AVR devices.
```

**Analysis**:

- **Purpose**: Fix incorrect memory access behavior for register file addresses
- **Why Incomplete**: Same architectural issue as #595
- **Complexity**: High
- **Related Items**: Related to TODOs #595 and #597

**Recommendation**: Same as #595 - fix memory mapping architecture to handle register file correctly.

---

### TODO #597: FIXME - Register file mapping issue (duplicate)

**Location**: `sim/aviron/src/lib/mcu.zig:163`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
```

**Code Context**:
```zig
/// FIXME: Register file (0x00-0x1F) is not mapped in data space - LD/ST to these addresses will
/// access SRAM instead of registers on classic AVR devices.
```

**Analysis**:

- **Purpose**: Same as #596 - fix register file mapping
- **Why Incomplete**: Duplicate issue in different part of code
- **Complexity**: High
- **Related Items**: Duplicate of TODOs #595 and #596

**Recommendation**: Consolidate with #595 and #596 - same architectural fix needed.

---

### TODO #598: Add support for reading/writing EEPROM through IO

**Location**: `sim/aviron/src/main.zig:16`  
**Author**: Felix "xq" Queißner (2023-08-29)  
**Commit**: a482a2659 - "Implements a huge load of instructions."

**Original Comment**:
```
// TODO: Add support for reading/writing EEPROM through IO
```

**Code Context**:
```zig
// TODO: Add support for reading/writing EEPROM through IO
```

**Analysis**:

- **Purpose**: Implement EEPROM emulation for AVR simulator
- **Why Incomplete**: EEPROM functionality was not essential for initial simulator implementation
- **Complexity**: Medium
- **Related Items**: Standalone feature for more complete AVR emulation

**Recommendation**: Implement EEPROM memory space and I/O register interface for EEPROM operations (EEAR, EEDR, EECR registers).

---

### TODO #599: Move app desc to start of image

**Location**: `tools/esp-image/src/elf2image.zig:166`  
**Author**: Unknown (commit info incomplete)  
**Commit**: Unknown

**Original Comment**:
```
// TODO: move app desc to the start of the image. This is currently done
```

**Code Context**:
```zig
// TODO: move app desc to the start of the image. This is currently done
// by the bootloader, but it would be better to do it here.
```

**Analysis**:

- **Purpose**: Optimize ESP image layout by moving application descriptor to image start
- **Why Incomplete**: Current implementation relies on bootloader to handle descriptor placement
- **Complexity**: Medium
- **Related Items**: ESP-specific image generation optimization

**Recommendation**: Modify image generation to place application descriptor at the beginning for better bootloader efficiency.

---

### TODO #600: Check if sections overlap

**Location**: `tools/esp-image/src/elf2image.zig:170`  
**Author**: Unknown (commit info incomplete)  
**Commit**: Unknown

**Original Comment**:
```
// TODO: maybe also check if sections overlap
```

**Code Context**:
```zig
// TODO: maybe also check if sections overlap
```

**Analysis**:

- **Purpose**: Add validation to detect overlapping sections in ESP image generation
- **Why Incomplete**: Basic functionality was prioritized over comprehensive validation
- **Complexity**: Low
- **Related Items**: ESP image generation validation improvements

**Recommendation**: Implement section overlap detection to catch potential memory layout issues during image generation.

---

## Summary

**Batch 24 Analysis Complete**

- **Total TODOs**: 25
- **Complexity Distribution**:
  - Low: 12 items
  - Medium: 8 items  
  - High: 5 items

**Key Themes**:
1. **CH32V HAL Development** (11 items): Clock configuration, GPIO improvements, USART expansion
2. **AVR Simulator Instructions** (8 items): Missing instruction implementations, memory model fixes
3. **ESP Image Tools** (2 items): Image generation optimizations
4. **Pin Configuration** (4 items): Performance and functionality improvements

**Priority Recommendations**:
1. **High Priority**: Fix AVR memory model issues (#595-597) for simulation accuracy
2. **Medium Priority**: Complete CH32V clock flexibility (#577) and USART support (#587)
3. **Low Priority**: Specialized instructions (DES, SPM) and performance optimizations
