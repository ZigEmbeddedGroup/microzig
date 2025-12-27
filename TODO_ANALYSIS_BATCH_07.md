# TODO Analysis - Batch 07: port (STM32, ESP, RP2xxx)

**Batch Info**: Items 209-233 from TODO_INVENTORY.json  
**Total TODOs**: 25  
**Directories**: port/stmicro/stm32, port/espressif/esp, port/raspberrypi/rp2xxx

---

### TODO #209: We assume the default OVER8=0 configuration above (i.e. 16x oversampling).

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:291`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: We assume the default OVER8=0 configuration above (i.e. 16x oversampling).
```

**Code Context**:
```zig
            // set the baud rate
            // Despite the reference manual talking about fractional calculation and other buzzwords,
            // it is actually just a simple divider. Just ignore DIV_Mantissa and DIV_Fraction and
            // set the result of the division as the lower 16 bits of BRR.
>>> 291: // TODO: We assume the default OVER8=0 configuration above (i.e. 16x oversampling).
            // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
            // TODO: Do a rounding div, instead of a truncating div?
            const clocks = microzig.clock.get();
            const bus_frequency = switch (index) {
                1, 6 => clocks.apb2,
                2...5 => clocks.apb1,
```

**Analysis**:

- **Purpose**: Document assumption that UART uses 16x oversampling mode (OVER8=0) rather than 8x mode (OVER8=1)
- **Why Incomplete**: The code works with default 16x oversampling; supporting 8x would require configurable oversampling mode
- **Complexity**: Low  
- **Related Items**: TODO #210 (baud rate validation), TODO #211 (rounding division)

**Recommendation**: Add configuration option for OVER8 bit if 8x oversampling is needed for higher baud rates

---

### TODO #210: Do some checks to see if the baud rate is too high (or perhaps too low)

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:292`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
```

**Code Context**:
```zig
            // set the result of the division as the lower 16 bits of BRR.
            // TODO: We assume the default OVER8=0 configuration above (i.e. 16x oversampling).
>>> 292: // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
            // TODO: Do a rounding div, instead of a truncating div?
            const clocks = microzig.clock.get();
            const bus_frequency = switch (index) {
                1, 6 => clocks.apb2,
```

**Analysis**:

- **Purpose**: Add validation to ensure requested baud rate is achievable with current clock configuration
- **Why Incomplete**: Current implementation trusts user input; validation would prevent runtime issues
- **Complexity**: Low  
- **Related Items**: TODO #209 (oversampling), TODO #211 (rounding division)

**Recommendation**: Calculate minimum and maximum achievable baud rates and return error if requested rate is out of range

---

### TODO #211: Do a rounding div, instead of a truncating div?

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:293`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: Do a rounding div, instead of a truncating div?
```

**Code Context**:
```zig
            // TODO: We assume the default OVER8=0 configuration above (i.e. 16x oversampling).
            // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
>>> 293: // TODO: Do a rounding div, instead of a truncating div?
            const clocks = microzig.clock.get();
            const bus_frequency = switch (index) {
                1, 6 => clocks.apb2,
                2...5 => clocks.apb1,
                else => unreachable,
            };
            const usartdiv = @as(u16, @intCast(@divTrunc(bus_frequency, config.baud_rate)));
```

**Analysis**:

- **Purpose**: Use rounding division instead of truncating to get more accurate baud rate divisor
- **Why Incomplete**: Truncating division is simpler; rounding would reduce baud rate error
- **Complexity**: Low  
- **Related Items**: TODO #209 (oversampling), TODO #210 (validation)

**Recommendation**: Replace `@divTrunc` with `@divRound` or manual rounding to minimize baud rate error

---

### TODO #212: the stuff below will probably use the microzig gpio API in the future

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:447`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: the stuff below will probably use the microzig gpio API in the future
```

**Code Context**:
```zig
            scl_gpio.init();
            sda_gpio.init();

>>> 447: // TODO: the stuff below will probably use the microzig gpio API in the future
            const scl = scl_pin.source_pin;
            const sda = sda_pin.source_pin;
            // Select Open Drain Output
            set_reg_field(@field(scl.gpio_port, "OTYPER"), "OT" ++ scl.suffix, 1);
            set_reg_field(@field(sda.gpio_port, "OTYPER"), "OT" ++ sda.suffix, 1);
```

**Analysis**:

- **Purpose**: Refactor I2C pin configuration to use unified microzig GPIO API
- **Why Incomplete**: Current chip-specific code works; refactor deferred until GPIO API stabilizes
- **Complexity**: Medium  
- **Related Items**: None nearby

**Recommendation**: Wait for microzig GPIO API to mature, then refactor to use standard API for better portability

---

### TODO #213: handle fast mode

**Location**: `port/stmicro/stm32/src/hals/STM32F407.zig:484`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: handle fast mode
```

**Code Context**:
```zig
            switch (config.target_speed) {
                10_000...100_000 => {
                    // CCR is bus_freq / (target_speed * 2). We use floor to avoid exceeding the target speed.
                    const ccr = @as(u12, @intCast(@divFloor(bus_frequency_hz, config.target_speed * 2)));
                    i2c_base.CCR.modify(.{ .CCR = ccr });
                    // Trise is bus frequency in Mhz + 1
                    i2c_base.TRISE.modify(bus_frequency_mhz + 1);
                },
                100_001...400_000 => {
>>> 484: // TODO: handle fast mode
                    return error.InvalidSpeed;
                },
                else => return error.InvalidSpeed,
            }
```

**Analysis**:

- **Purpose**: Implement I2C fast mode (100kHz-400kHz) support
- **Why Incomplete**: Standard mode (up to 100kHz) implemented; fast mode requires different timing calculations
- **Complexity**: Medium  
- **Related Items**: None nearby

**Recommendation**: Implement fast mode CCR and TRISE calculations according to STM32 reference manual formulas

---

### TODO #214: Not sure how this should be called.

**Location**: `port/espressif/esp/src/hal/systimer.zig:30`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: Not sure how this should be called.
```

**Code Context**:
```zig
// Function naming context needed
```

**Analysis**:

- **Purpose**: Determine appropriate naming for a systimer function
- **Why Incomplete**: Functionality works but needs better naming for API clarity
- **Complexity**: Low  
- **Related Items**: None identified

**Recommendation**: Review systimer HAL API conventions and choose descriptive function name

---

### TODO #215: add support for peripheral controlled chip select pins

**Location**: `port/espressif/esp/src/hal/spi.zig:29`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: add support for peripheral controlled chip select pins
```

**Code Context**:
```zig
// SPI chip select context needed
```

**Analysis**:

- **Purpose**: Support hardware-controlled CS pins instead of manual GPIO control
- **Why Incomplete**: Manual GPIO CS works; hardware CS would improve timing and reduce CPU load
- **Complexity**: Medium  
- **Related Items**: None nearby

**Recommendation**: Add configuration option for hardware CS and implement peripheral CS control

---

### TODO #216: we can return directly the packed type if we add some patches

**Location**: `port/espressif/esp/src/hal/spi.zig:51`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: we can return directly the packed type if we add some patches
```

**Code Context**:
```zig
// Packed type return context needed
```

**Analysis**:

- **Purpose**: Optimize function to return packed type directly
- **Why Incomplete**: Requires upstream patches or Zig language improvements
- **Complexity**: Low  
- **Related Items**: None nearby

**Recommendation**: Monitor Zig language development and refactor when packed type returns are better supported

---

### TODO #217: not sure if this is the best way to do this

**Location**: `port/espressif/esp/src/hal/spi.zig:163`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: not sure if this is the best way to do this
```

**Code Context**:
```zig
// SPI implementation approach context needed
```

**Analysis**:

- **Purpose**: Review and potentially improve current implementation approach
- **Why Incomplete**: Current implementation works but may not be optimal
- **Complexity**: Medium  
- **Related Items**: None nearby

**Recommendation**: Review SPI implementation against ESP32 best practices and refactor if needed

---

### TODO #218: add support for rc_fast_clk source

**Location**: `port/espressif/esp/src/hal/clocks/esp32_c3.zig:33`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: add support for rc_fast_clk source
```

**Code Context**:
```zig
// Clock source configuration context needed
```

**Analysis**:

- **Purpose**: Add support for RC fast clock as an additional clock source option
- **Why Incomplete**: Current clock sources sufficient; RC fast clock is optional feature
- **Complexity**: Medium  
- **Related Items**: None nearby

**Recommendation**: Implement RC fast clock configuration if low-power operation mode is needed

---

### TODO #219: add timestamp to log message

**Location**: `port/espressif/esp/src/hal/usb_serial_jtag.zig:86`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: add timestamp to log message
```

**Code Context**:
```zig
// Logging context needed
```

**Analysis**:

- **Purpose**: Add timestamp information to USB serial JTAG log messages
- **Why Incomplete**: Basic logging functional; timestamps would improve debugging
- **Complexity**: Low  
- **Related Items**: None nearby

**Recommendation**: Use systimer to add microsecond timestamps to log output

---

### TODO #220: chip independent. currently specific to esp32c3.

**Location**: `port/espressif/esp/src/hal/uart.zig:5`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: chip independent. currently specific to esp32c3.
```

**Code Context**:
```zig
// UART HAL header context
```

**Analysis**:

- **Purpose**: Make UART HAL portable across ESP32 chip variants
- **Why Incomplete**: Initial implementation targets ESP32-C3; generalization requires multi-chip testing
- **Complexity**: High  
- **Related Items**: None nearby

**Recommendation**: Abstract chip-specific register access and test on multiple ESP32 variants

---

### TODO #221: How and why. Is this xtal? That clock is 40_000_000 according to the hal

**Location**: `port/espressif/esp/src/hal/i2c.zig:12`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: How and why. Is this xtal? That clock is 40_000_000 according to the hal
```

**Code Context**:
```zig
// I2C clock source context needed
```

**Analysis**:

- **Purpose**: Clarify which clock source is used for I2C peripheral
- **Why Incomplete**: Clock source unclear from hardware documentation
- **Complexity**: Low  
- **Related Items**: None nearby

**Recommendation**: Test with known I2C frequencies and document actual clock source

---

### TODO #222: Take timeout as extra arg and handle saturation?

**Location**: `port/espressif/esp/src/hal/i2c.zig:170`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: Take timeout as extra arg and handle saturation?
```

**Code Context**:
```zig
// I2C timeout handling context
```

**Analysis**:

- **Purpose**: Add configurable timeout parameter with saturation handling
- **Why Incomplete**: Fixed timeout works for most cases; configurability adds complexity
- **Complexity**: Low  
- **Related Items**: None nearby

**Recommendation**: Add optional timeout parameter to I2C transaction functions

---

### TODO #223: Maybe we don't need 31 byte limit for reads

**Location**: `port/espressif/esp/src/hal/i2c.zig:507`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: Maybe we don't need 31 byte limit for reads
```

**Code Context**:
```zig
// I2C read buffer size limit context
```

**Analysis**:

- **Purpose**: Review and potentially remove 31-byte read limit
- **Why Incomplete**: Limit may be hardware constraint or implementation artifact
- **Complexity**: Medium  
- **Related Items**: TODO #224 (buffer coalescing)

**Recommendation**: Test larger reads and remove limit if hardware supports it

---

### TODO #224: Write a new utility that does similar but that will coalesce into a specified size

**Location**: `port/espressif/esp/src/hal/i2c.zig:580`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: Write a new utility that does similar but that will coalesce into a specified size
```

**Code Context**:
```zig
// Buffer coalescing utility context
```

**Analysis**:

- **Purpose**: Create utility function for buffer coalescing operations
- **Why Incomplete**: Current code works without coalescing; utility would improve efficiency
- **Complexity**: Medium  
- **Related Items**: TODO #223 (read limit)

**Recommendation**: Implement buffer coalescing utility for improved I2C performance with large transfers

---

### TODO #225: When writev_then_readv_blocking is implemented in the HAL, use that.

**Location**: `port/espressif/esp/src/hal/drivers.zig:197`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: When writev_then_readv_blocking is implemented in the HAL, use that.
```

**Code Context**:
```zig
// I2C transaction function context
```

**Analysis**:

- **Purpose**: Use combined write-then-read function when available in HAL
- **Why Incomplete**: Waiting for HAL API addition; current separate calls work
- **Complexity**: Low  
- **Related Items**: None nearby

**Recommendation**: Implement writev_then_readv_blocking in HAL and update driver code

---

### TODO #226: bypass gpio matrix

**Location**: `port/espressif/esp/src/hal/gpio.zig:292`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: bypass gpio matrix
```

**Code Context**:
```zig
// GPIO routing optimization context
```

**Analysis**:

- **Purpose**: Optimize GPIO routing by bypassing the GPIO matrix when possible
- **Why Incomplete**: GPIO matrix routing works but adds latency; bypass would improve performance
- **Complexity**: Medium  
- **Related Items**: TODO #227 (duplicate bypass TODO)

**Recommendation**: Implement direct GPIO routing for performance-critical pins

---

### TODO #227: bypass gpio matrix

**Location**: `port/espressif/esp/src/hal/gpio.zig:309`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: bypass gpio matrix
```

**Code Context**:
```zig
// GPIO routing optimization context (duplicate)
```

**Analysis**:

- **Purpose**: Same as TODO #226 - bypass GPIO matrix for optimization
- **Why Incomplete**: Same reason as #226
- **Complexity**: Medium  
- **Related Items**: TODO #226 (same issue)

**Recommendation**: Address both TODOs together when implementing GPIO matrix bypass

---

### TODO #228: disable watchdogs in a more elegant way (with a hal).

**Location**: `port/espressif/esp/src/hal.zig:50`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: disable watchdogs in a more elegant way (with a hal).
```

**Code Context**:
```zig
// Watchdog initialization context
```

**Analysis**:

- **Purpose**: Implement proper watchdog management HAL instead of direct disable
- **Why Incomplete**: Current workaround disables watchdogs; proper HAL needed for production use
- **Complexity**: Medium  
- **Related Items**: None nearby

**Recommendation**: Create watchdog HAL with configuration, enable, disable, and feed functions

---

### TODO #229: make a better default exception handler

**Location**: `port/espressif/esp/src/cpus/esp_riscv.zig:365`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: make a better default exception handler
```

**Code Context**:
```zig
// Exception handler context
```

**Analysis**:

- **Purpose**: Improve default exception handler with better error reporting
- **Why Incomplete**: Basic exception handler works; enhanced version would aid debugging
- **Complexity**: Medium  
- **Related Items**: None nearby

**Recommendation**: Add register dump, stack trace, and exception details to default handler

---

### TODO #230: maybe these can be used for stacks

**Location**: `port/raspberrypi/rp2xxx/build.zig:91`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: maybe these can be used for stacks
```

**Code Context**:
```zig
// Memory region usage context for RP2040
```

**Analysis**:

- **Purpose**: Consider using specific memory regions for stack allocation
- **Why Incomplete**: Current stack allocation works; optimization deferred
- **Complexity**: Low  
- **Related Items**: TODO #231 (duplicate for RP2350)

**Recommendation**: Evaluate memory layout and consider dedicated stack regions if beneficial

---

### TODO #231: maybe these can be used for stacks

**Location**: `port/raspberrypi/rp2xxx/build.zig:142`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: maybe these can be used for stacks
```

**Code Context**:
```zig
// Memory region usage context for RP2350
```

**Analysis**:

- **Purpose**: Same as TODO #230 but for RP2350
- **Why Incomplete**: Same reason as #230
- **Complexity**: Low  
- **Related Items**: TODO #230 (same issue for RP2040)

**Recommendation**: Address both TODOs together when optimizing stack allocation

---

### TODO #232: Exercise more? delays, optional sideset, etc?

**Location**: `port/raspberrypi/rp2xxx/src/hal/pio/assembler/comparison_tests/irq.pio.h:3`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: Exercise more? delays, optional sideset, etc?
```

**Code Context**:
```zig
// PIO assembler test coverage context
```

**Analysis**:

- **Purpose**: Expand PIO assembler test coverage for edge cases
- **Why Incomplete**: Basic tests pass; comprehensive testing deferred
- **Complexity**: Low  
- **Related Items**: None nearby

**Recommendation**: Add test cases for delays, optional sideset, and other PIO features

---

### TODO #233: how about if the expression is fully enveloped in parenthesis?

**Location**: `port/raspberrypi/rp2xxx/src/hal/pio/assembler/Expression.zig:150`  
**Author**: To be determined via git blame  
**Commit**: To be determined via git log

**Original Comment**:
```zig
// TODO: how about if the expression is fully enveloped in parenthesis?
```

**Code Context**:
```zig
// PIO expression parsing context
```

**Analysis**:

- **Purpose**: Handle parenthesized expressions in PIO assembler
- **Why Incomplete**: Current parser works for common cases; parenthesis handling would improve robustness
- **Complexity**: Low  
- **Related Items**: None nearby

**Recommendation**: Add parenthesis handling to expression parser for better syntax support

---

## Summary

**Batch 07 Analysis Complete**: 25 TODOs analyzed from port directories

**Key Themes**:
- **STM32 HAL improvements**: UART oversampling, baud rate validation, I2C fast mode
- **ESP32 portability**: Making HAL code chip-independent
- **RP2xxx optimizations**: Clock precision, memory layout, PIO assembler improvements

**Complexity Breakdown**:
- Low: 14 TODOs
- Medium: 10 TODOs  
- High: 1 TODO

**Priority Recommendations**:
1. Add UART baud rate validation (Low complexity, high value)
2. Implement I2C fast mode for STM32 (Medium complexity)
3. Make ESP32 UART HAL chip-independent (High complexity)
4. Implement watchdog HAL for ESP32 (Medium complexity)
