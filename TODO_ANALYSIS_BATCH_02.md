# TODO Analysis - Batch 02: [drivers]

**Batch Info**: Items 26-50 from TODO_INVENTORY.json  
**Analysis Date**: 2024-12-24  
**Total TODOs in Batch**: 25

---

### TODO #26: Embedded event loop not supported yet

**Location**: `core/src/start.zig:72`  
**Author**: Matt Knight (2023-02-24)  
**Commit**: 11214ed8b - "new for loop syntax and remove import-module.zig (#110)"

**Original Comment**:
```
@compileError("TODO: Embedded event loop not supported yet. Please try again later.");
```

**Code Context**:
```zig
if (info.@"fn".calling_convention == .async)
    @compileError("TODO: Embedded event loop not supported yet. Please try again later.");

// A hal can export a default init function that runs before main for
// procedures like clock configuration. The user may override and customize
// this functionality by providing their own init function.
// function.
if (@hasDecl(app, "init"))
    app.init()
else if (microzig.hal != void and @hasDecl(microzig.hal, "init"))
    microzig.hal.init();
```

**Analysis**:

- **Purpose**: Block async main functions until embedded event loop support is implemented
- **Why Incomplete**: This is a complex feature requiring significant runtime support for async/await in embedded contexts. The commit was focused on syntax updates, not async runtime implementation.
- **Complexity**: High
- **Related Items**: None nearby

**Recommendation**: Implement embedded async runtime support or document limitations clearly

---

### TODO #27: Add more localizations

**Location**: `drivers/base/DateTime.zig:278`  
**Author**: Uthedris (2025-05-20)  
**Commit**: 5e03ee0c9 - "Rp2350 hal additions (#546)"

**Original Comment**:
```
// ### TODO ### Add more localizations
```

**Code Context**:
```zig
    // Español
    pub const es: Localization = .{
        .day_names = .{
            "Domingo",
            "Lunes",
            "Martes",
            "Miércoles",
            "Jueves",
            "Viernes",
            "Sábado",
        },
        .day_abbr = .{
            "Dom",
            "Lun",
            "Mar",
            "Mie",
            "Jue",
            "Vie",
            "Sab",
        },
        .month_names = .{
            "Enero",
            "Febrero",
            "Marzo",
            "Abril",
            "Mayo",
            "Junio",
            "Julio",
            "Agosto",
            "Septiembre",
            "Octubre",
            "Noviembre",
            "Diciembre",
        },
        .month_abbr = .{
            "Ene",
            "Feb",
            "Mar",
            "Abr",
            "May",
            "Jun",
            "Jul",
            "Ago",
            "Sep",
            "Oct",
            "Nov",
            "Dic",
        },
        .am_pm = .{
            "AM",
            "PM",
        },
    };

    // ### TODO ### Add more localizations
};
```

**Analysis**:

- **Purpose**: Expand DateTime localization support beyond English, German, French, and Spanish
- **Why Incomplete**: Feature enhancement - current localizations cover major languages but more could be useful
- **Complexity**: Low
- **Related Items**: None nearby

**Recommendation**: Add localizations for other common languages (Italian, Portuguese, Japanese, etc.) as needed

---

### TODO #28: Reserved addresses documentation

**Location**: `drivers/base/I2C_Device.zig:44`  
**Author**: Grazfather (2025-08-14)  
**Commit**: b929d670d - "Add I2C Interface (#642)"

**Original Comment**:
```
/// Reserved addresses are ones that match `0b0000XXX` or `0b1111XXX`.
```

**Code Context**:
```zig
    ///
    /// Returns an Address.Error if the Address is a reserved I²C address.
    /// The error gives detail on why the address is reserved, allowing the client to determine
    /// whether it should allow it.
    ///
    /// Reserved addresses are ones that match `0b0000XXX` or `0b1111XXX`.
    ///
    /// See more here: https://www.i2c-bus.org/addressing/
    pub fn check_reserved(addr: Address) Address.Error!void {
        const value: u7 = @intFromEnum(addr);

        switch (value) {
            0b0000000 => return Address.Error.GeneralCall,
            0b0000001 => return Address.Error.CBUSAddress,
            0b0000010 => return Address.Error.ReservedFormat,
            0b0000011 => return Address.Error.ReservedFuture,
            0b0001000...0b0001111 => return Address.Error.HighSpeedMaster,
            0b1111000...0b1111011 => return Address.Error.TenBitSlave,
            0b1111100...0b1111111 => return Address.Error.ReservedFuture,
            else => return,
        }
    }
```

**Analysis**:

- **Purpose**: This is actually documentation, not a TODO - it explains I2C reserved address patterns
- **Why Incomplete**: Not incomplete - this is proper documentation
- **Complexity**: N/A
- **Related Items**: None

**Recommendation**: This is not actually a TODO - it's documentation. Remove from TODO list.

---

### TODO #29: SPI 3-wire mode not implemented

**Location**: `drivers/display/sh1106.zig:132`  
**Author**: Stevie Hryciw (2025-04-27)  
**Commit**: bcc0f3b0e - "Add SH1106 driver (#501)"

**Original Comment**:
```
.spi_3wire => @compileError("TODO"),
```

**Code Context**:
```zig
        fn init_with_mode(mode: Driver_Init_Mode) !Self {
            var self = Self{
                .dd = switch (mode) {
                    .i2c => |opt| opt.device,
                    .spi_3wire => @compileError("TODO"),
                    .spi_4wire => |opt| opt.device,
                },
                .dc_pin = switch (mode) {
                    .i2c => undefined,
                    .spi_3wire => @compileError("TODO"),
                    .spi_4wire => |opt| opt.dc_pin,
                },
                .mode = switch (mode) {
                    .i2c => .i2c,
                    .spi_3wire => .spi_3wire,
                    .spi_4wire => .spi_4wire,
                },
            };
```

**Analysis**:

- **Purpose**: Implement 3-wire SPI mode for SH1106 display driver
- **Why Incomplete**: Initial driver implementation focused on I2C and 4-wire SPI modes first
- **Complexity**: Medium
- **Related Items**: TODO #30 (same file, line 137) - another 3-wire SPI TODO

**Recommendation**: Implement 3-wire SPI support or remove the mode option if not needed

---

### TODO #30: SPI 3-wire mode not implemented (duplicate)

**Location**: `drivers/display/sh1106.zig:137`  
**Author**: Stevie Hryciw (2025-04-27)  
**Commit**: bcc0f3b0e - "Add SH1106 driver (#501)"

**Original Comment**:
```
.spi_3wire => @compileError("TODO"),
```

**Code Context**:
```zig
                .dc_pin = switch (mode) {
                    .i2c => undefined,
                    .spi_3wire => @compileError("TODO"),
                    .spi_4wire => |opt| opt.dc_pin,
                },
```

**Analysis**:

- **Purpose**: Same as TODO #29 - implement 3-wire SPI mode for SH1106 display driver
- **Why Incomplete**: Same as TODO #29
- **Complexity**: Medium
- **Related Items**: TODO #29 (same file, line 132) - related 3-wire SPI TODO

**Recommendation**: Same as TODO #29 - implement together or remove mode option

---

### TODO #31: Add doc comments for functions

**Location**: `drivers/display/ssd1306.zig:74`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO(philippwendel) Add doc comments for functions
```

**Code Context**:
```zig
    // TODO(philippwendel) Add doc comments for functions
    // TODO(philippwendel) Find out why using 'inline if' in writeAll(&[_]u8{ControlByte.command, if(cond) val1 else val2 }); hangs code on atmega328p, since tests work fine
    return struct {
        const Self = @This();

        const Datagram_Device = options.Datagram_Device;
        const Digital_IO = switch (options.mode) {
            // 4-wire SPI mode uses a dedicated command/data control pin:
            .spi_4wire, .dynamic => options.Digital_IO,

            // The other two modes don't use that, so we use a `void` pin here to save
            // memory:
            .i2c, .spi_3wire => void,
        };
```

**Analysis**:

- **Purpose**: Add documentation comments to SSD1306 driver functions
- **Why Incomplete**: Driver framework integration focused on functionality first, documentation second
- **Complexity**: Low
- **Related Items**: TODO #32 (same file, line 75) - related documentation/debugging issue

**Recommendation**: Add comprehensive documentation comments to all public functions

---

### TODO #32: Investigate inline if hanging on atmega328p

**Location**: `drivers/display/ssd1306.zig:75`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO(philippwendel) Find out why using 'inline if' in writeAll(&[_]u8{ControlByte.command, if(cond) val1 else val2 }); hangs code on atmega328p, since tests work fine
```

**Code Context**:
```zig
    // TODO(philippwendel) Add doc comments for functions
    // TODO(philippwendel) Find out why using 'inline if' in writeAll(&[_]u8{ControlByte.command, if(cond) val1 else val2 }); hangs code on atmega328p, since tests work fine
    return struct {
```

**Analysis**:

- **Purpose**: Debug platform-specific issue where inline conditionals cause hangs on ATmega328p
- **Why Incomplete**: Platform-specific debugging issue discovered during testing
- **Complexity**: Medium
- **Related Items**: TODO #31 (same file, line 74) - related documentation TODO

**Recommendation**: Investigate compiler/runtime differences between test environment and ATmega328p target

---

### TODO #33: SPI 3-wire mode not implemented (SSD1306)

**Location**: `drivers/display/ssd1306.zig:149`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
.spi_3wire => @compileError("TODO"),
```

**Code Context**:
```zig
        fn init_with_mode(mode: Driver_Init_Mode) !Self {
            var self = Self{
                .dd = switch (mode) {
                    .i2c => |opt| opt.device,
                    .spi_3wire => @compileError("TODO"),
                    .spi_4wire => |opt| opt.device,
                },
```

**Analysis**:

- **Purpose**: Implement 3-wire SPI mode for SSD1306 display driver
- **Why Incomplete**: Same as SH1106 driver - initial implementation focused on I2C and 4-wire SPI
- **Complexity**: Medium
- **Related Items**: TODO #34 (same file, line 154), TODOs #29-30 (SH1106 driver has same issue)

**Recommendation**: Implement 3-wire SPI support consistently across display drivers

---

### TODO #34: SPI 3-wire mode not implemented (SSD1306 duplicate)

**Location**: `drivers/display/ssd1306.zig:154`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
.spi_3wire => @compileError("TODO"),
```

**Code Context**:
```zig
                .dc_pin = switch (mode) {
                    .i2c => undefined,
                    .spi_3wire => @compileError("TODO"),
                    .spi_4wire => |opt| opt.dc_pin,
                },
```

**Analysis**:

- **Purpose**: Same as TODO #33 - implement 3-wire SPI mode for SSD1306 display driver
- **Why Incomplete**: Same as TODO #33
- **Complexity**: Medium
- **Related Items**: TODO #33 (same file, line 149), TODOs #29-30 (SH1106 driver)

**Recommendation**: Same as TODO #33 - implement together with other 3-wire SPI TODOs

---

### TODO #35: Make config to enum

**Location**: `drivers/display/ssd1306.zig:346`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO(philippwendel) Make config to enum
```

**Code Context**:
```zig
        // TODO(philippwendel) Make config to enum
        pub fn set_com_pins_hardware_configuration(self: Self, config: u2) !void {
            try self.execute_command(0xDA, &.{@as(u8, config) << 4 | 0x02});
        }
```

**Analysis**:

- **Purpose**: Replace raw u2 parameter with a proper enum for COM pins hardware configuration
- **Why Incomplete**: Initial implementation used raw values for simplicity
- **Complexity**: Low
- **Related Items**: None nearby

**Recommendation**: Create enum with meaningful names for COM pin configuration options

---

### TODO #36: Split in two functions

**Location**: `drivers/display/ssd1306.zig:352`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO(philippwendel) Split in two funktions
```

**Code Context**:
```zig
        // Timing & Driving Scheme Setting Commands
        // TODO(philippwendel) Split in two funktions
        pub fn set_display_clock_divide_ratio_and_oscillator_frequency(self: Self, divide_ratio: u4, freq: u4) !void {
            try self.execute_command(0xD5, &.{(@as(u8, freq) << 4) | @as(u8, divide_ratio)});
        }
```

**Analysis**:

- **Purpose**: Split the combined clock/frequency function into separate functions for better API design
- **Why Incomplete**: Initial implementation combined related settings for convenience
- **Complexity**: Low
- **Related Items**: None nearby

**Recommendation**: Create separate functions for clock divide ratio and oscillator frequency

---

### TODO #37: Make level to enum

**Location**: `drivers/display/ssd1306.zig:363`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO(philippwendel) Make level to enum
```

**Code Context**:
```zig
        // TODO(philippwendel) Make level to enum
        pub fn set_v_comh_deselect_level(self: Self, level: u3) !void {
            try self.execute_command(0xDB, &.{@as(u8, level) << 4});
        }
```

**Analysis**:

- **Purpose**: Replace raw u3 parameter with a proper enum for VCOMH deselect levels
- **Why Incomplete**: Initial implementation used raw values for simplicity
- **Complexity**: Low
- **Related Items**: TODO #35 (same pattern - raw values to enums)

**Recommendation**: Create enum with meaningful names for VCOMH deselect level options

---

### TODO #38: Test more values and error

**Location**: `drivers/display/ssd1306.zig:533`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO(philippwendel) Test more values and error
```

**Code Context**:
```zig
        // Scrolling Commands
        // TODO(philippwendel) Test more values and error
        test continuous_horizontal_scroll_setup {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.continuous_horizontal_scroll_setup(.right, 0, 0, 0);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }
```

**Analysis**:

- **Purpose**: Expand test coverage for horizontal scroll setup with more parameter values and error conditions
- **Why Incomplete**: Initial test implementation covered basic functionality only
- **Complexity**: Low
- **Related Items**: None nearby

**Recommendation**: Add comprehensive test cases covering edge cases and error conditions

---

### TODO #39: HACK comment in ST77xx driver

**Location**: `drivers/display/st77xx.zig:441`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
//     ST77XX_INVON  ,   ST_CMD_DELAY,  //  7: hack
```

**Code Context**:
```zig
//     ST77XX_INVON  ,   ST_CMD_DELAY,  //  7: hack
```

**Analysis**:

- **Purpose**: Address a hack in the ST77xx display driver initialization sequence
- **Why Incomplete**: Temporary workaround during driver development
- **Complexity**: Medium
- **Related Items**: None nearby

**Recommendation**: Investigate proper initialization sequence and remove hack

---

### TODO #40: Optimize to single Mode1 read

**Location**: `drivers/io_expander/pca9685.zig:50`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: this can be optimized to single Mode1 read
```

**Code Context**:
```zig
// TODO: this can be optimized to single Mode1 read
```

**Analysis**:

- **Purpose**: Optimize PCA9685 driver to use single register read instead of multiple reads
- **Why Incomplete**: Initial implementation prioritized correctness over optimization
- **Complexity**: Low
- **Related Items**: None nearby

**Recommendation**: Refactor to read Mode1 register once and cache/parse the result

---

### TODO #41: Write burn functions (scary)

**Location**: `drivers/sensor/AS5600.zig:174`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Write burn functions. Scary.
```

**Code Context**:
```zig
// TODO: Write burn functions. Scary.
```

**Analysis**:

- **Purpose**: Implement OTP (One-Time Programmable) burn functions for AS5600 magnetic sensor
- **Why Incomplete**: These functions permanently modify hardware and require extreme caution
- **Complexity**: High
- **Related Items**: None nearby

**Recommendation**: Implement with extensive safety checks and clear warnings about permanent nature

---

### TODO #42: General TODO comment

**Location**: `drivers/sensor/ICM-20948.zig:27`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
//! TODO:
```

**Code Context**:
```zig
//! TODO:
```

**Analysis**:

- **Purpose**: Incomplete TODO comment - unclear what needs to be done
- **Why Incomplete**: Placeholder TODO without specific task description
- **Complexity**: Unknown
- **Related Items**: Multiple other TODOs in same file (TODOs #43-46)

**Recommendation**: Clarify what specific work is needed or remove empty TODO

---

### TODO #43: Fields to enable each part and configure what we need

**Location**: `drivers/sensor/ICM-20948.zig:200`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Fields to enable each part and only configure what we need. Put the rest in low power mode
```

**Code Context**:
```zig
// TODO: Fields to enable each part and only configure what we need. Put the rest in low power mode
```

**Analysis**:

- **Purpose**: Add selective configuration for ICM-20948 sensor components with power management
- **Why Incomplete**: Initial implementation enables all components, not optimized for power consumption
- **Complexity**: Medium
- **Related Items**: TODOs #42, #44-46 (same file)

**Recommendation**: Implement component-specific enable/disable with power management

---

### TODO #44: Support converting to Gs

**Location**: `drivers/sensor/ICM-20948.zig:208`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Support converting to Gs
```

**Code Context**:
```zig
// TODO: Support converting to Gs
```

**Analysis**:

- **Purpose**: Add support for converting accelerometer readings to G-force units
- **Why Incomplete**: Initial implementation returns raw values without unit conversion
- **Complexity**: Low
- **Related Items**: TODOs #42-43, #45-46 (same file)

**Recommendation**: Implement conversion functions using sensor sensitivity settings

---

### TODO #45: Support converting to radians

**Location**: `drivers/sensor/ICM-20948.zig:230`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Support converting to radians
```

**Code Context**:
```zig
// TODO: Support converting to radians
```

**Analysis**:

- **Purpose**: Add support for converting gyroscope readings to radians per second
- **Why Incomplete**: Initial implementation returns raw values without unit conversion
- **Complexity**: Low
- **Related Items**: TODOs #42-44, #46 (same file)

**Recommendation**: Implement conversion functions using sensor sensitivity settings

---

### TODO #46: Support setting these individually

**Location**: `drivers/sensor/ICM-20948.zig:507`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Support setting these individually. Could set based on if ODR fields are set (make
```

**Code Context**:
```zig
// TODO: Support setting these individually. Could set based on if ODR fields are set (make
```

**Analysis**:

- **Purpose**: Allow individual configuration of Output Data Rate (ODR) settings for different sensor components
- **Why Incomplete**: Initial implementation uses combined settings
- **Complexity**: Medium
- **Related Items**: TODOs #42-45 (same file)

**Recommendation**: Implement individual ODR configuration with conditional logic

---

### TODO #47: General TODO comment (MPU-6050)

**Location**: `drivers/sensor/MPU-6050.zig:19`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
//! TODO:
```

**Code Context**:
```zig
//! TODO:
```

**Analysis**:

- **Purpose**: Incomplete TODO comment - unclear what needs to be done
- **Why Incomplete**: Placeholder TODO without specific task description
- **Complexity**: Unknown
- **Related Items**: None nearby

**Recommendation**: Clarify what specific work is needed or remove empty TODO

---

### TODO #48: Support other modes

**Location**: `drivers/sensor/TLV493D.zig:176`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Support other modes
```

**Code Context**:
```zig
// TODO: Support other modes
```

**Analysis**:

- **Purpose**: Add support for additional operating modes in TLV493D magnetic sensor
- **Why Incomplete**: Initial implementation supports basic mode only
- **Complexity**: Medium
- **Related Items**: TODOs #49-50 (same file)

**Recommendation**: Implement additional sensor operating modes as needed

---

### TODO #49: Figure out broadcast address issue

**Location**: `drivers/sensor/TLV493D.zig:188`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Figure out why when using the broadcast address, the subsequent reads seem to hang
```

**Code Context**:
```zig
// TODO: Figure out why when using the broadcast address, the subsequent reads seem to hang
```

**Analysis**:

- **Purpose**: Debug issue where broadcast address usage causes subsequent read operations to hang
- **Why Incomplete**: Hardware/timing issue discovered during testing
- **Complexity**: High
- **Related Items**: TODOs #48, #50 (same file)

**Recommendation**: Investigate I2C timing, bus state, and sensor response to broadcast commands

---

### TODO #50: Figure out device stop responding

**Location**: `drivers/sensor/TLV493D.zig:235`  
**Author**: Felix Queißner (2024-11-14)  
**Commit**: 2c17eb883 - "Integrates driver framework (#246)"

**Original Comment**:
```
// TODO: Figure out why this causes the device to stop responding
```

**Code Context**:
```zig
// TODO: Figure out why this causes the device to stop responding
```

**Analysis**:

- **Purpose**: Debug issue where certain operations cause TLV493D sensor to become unresponsive
- **Why Incomplete**: Hardware/communication issue discovered during testing
- **Complexity**: High
- **Related Items**: TODOs #48-49 (same file)

**Recommendation**: Investigate sensor state machine, power management, and communication protocol compliance

---

## Summary

**Batch 02 Analysis Complete**: 25 TODOs analyzed from the [drivers] section

**Complexity Breakdown**:
- **Low**: 8 TODOs (documentation, enums, simple optimizations)
- **Medium**: 10 TODOs (feature implementations, API improvements)
- **High**: 4 TODOs (async runtime, hardware debugging, OTP functions)
- **Unknown/N/A**: 3 TODOs (empty TODOs, documentation)

**Key Themes**:
1. **3-wire SPI Support**: Multiple display drivers need 3-wire SPI implementation
2. **API Improvements**: Many drivers need better enums instead of raw values
3. **Documentation**: Several drivers lack comprehensive documentation
4. **Hardware Debugging**: Some sensor drivers have unresolved hardware communication issues
5. **Power Management**: Sensor drivers need better power optimization features

**Priority Recommendations**:
1. Implement 3-wire SPI support across display drivers (TODOs #29-30, #33-34)
2. Replace raw values with proper enums for better type safety (TODOs #35, #37)
3. Investigate and resolve sensor communication issues (TODOs #49-50)
4. Add comprehensive documentation to driver functions (TODOs #31, #38)

---
