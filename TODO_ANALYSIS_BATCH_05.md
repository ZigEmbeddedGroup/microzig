# TODO Analysis - Batch 05: port

**Batch Info**: Items 159-183 from TODO_INVENTORY.json
**Directory**: port
**Total Items**: 25

---

### TODO #159: set mode when configure alternative mode.

**Location**: `port/wch/ch32v/src/hals/ch32v003/pins.zig:32`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: set mode when configure alternative mode.
```

**Code Context**:
```zig
    pub const Configuration = struct {
        name: ?[:0]const u8 = null,
        mode: ?gpio.Mode = null,
        speed: ?gpio.Speed = null,
        pull: ?gpio.Pull = null,

        pub fn get_mode(comptime config: Configuration) gpio.Mode {
            return if (config.mode) |mode|
                mode
>>>                 // TODO: set mode when configure alternative mode.
                // else if (comptime config.function.is_pwm())
                //     .output
                // else if (comptime config.function.is_uart_tx())
                //     .output
                // else if (comptime config.function.is_uart_rx())
                //     .input
                // else if (comptime config.function.is_adc())
                //     .input
            else
                @panic("TODO");
```

**Analysis**:

- **Purpose**: Implement automatic mode detection for alternative pin functions (PWM, UART, ADC)
- **Why Incomplete**: Feature requires determining pin mode based on alternative function configuration
- **Complexity**: Medium - Needs function type introspection and mode mapping
- **Related Items**: Related to TODO #160, #167 (similar GPIO configuration issues)

**Recommendation**: Implement function-to-mode mapping logic for alternative pin configurations

---

### TODO #160: Implementation needed

**Location**: `port/wch/ch32v/src/hals/ch32v003/pins.zig:42`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
@panic("TODO");
```

**Code Context**:
```zig
                // else if (comptime config.function.is_adc())
                //     .input
            else
>>>                 @panic("TODO");
        }
    };
```

**Analysis**:

- **Purpose**: Handle default case when pin mode cannot be determined
- **Why Incomplete**: Panic used as placeholder for proper error handling
- **Complexity**: Low - Replace panic with proper compile error or default
- **Related Items**: Part of pin configuration system in CH32V HAL

**Recommendation**: Replace panic with compile error or sensible default mode

---

### TODO #161: Read current output from ODR.

**Location**: `port/wch/ch32v/src/hals/ch32v003/pins.zig:71`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Read current output from ODR.
```

**Code Context**:
```zig
        .output => struct {
            const pin = gpio.Pin.init(port, num);

            pub inline fn put(self: @This(), value: u1) void {
                _ = self;
                pin.put(value);
            }

            pub inline fn toggle(self: @This()) void {
                _ = self;
                pin.toggle();
            }

>>>             // TODO: Read current output from ODR.
            // pub inline fn read(self: @This()) u1 {
            //     _ = self;
            //     return pin.output_read();
            // }
        },
```

**Analysis**:

- **Purpose**: Implement reading current output pin state from Output Data Register
- **Why Incomplete**: Function commented out, needs implementation or verification
- **Complexity**: Low - Simple register read operation
- **Related Items**: Similar TODO #168 in generic pins.zig

**Recommendation**: Implement pin.output_read() method to read from ODR register

---

### TODO #162: GPIOD has only 3 ports. Check this.

**Location**: `port/wch/ch32v/src/hals/ch32v003/pins.zig:201`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: GPIOD has only 3 ports. Check this.
```

**Code Context**:
```zig
                // Configure port mode.
                inline for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
>>>                     // TODO: GPIOD has only 3 ports. Check this.
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
                        // TODO: Remove this loop. Set at once.
                        pin.set_mode(pin_config.mode.?);
                    }
                }
```

**Analysis**:

- **Purpose**: Add validation that GPIOD port only has 3 pins on CH32V003
- **Why Incomplete**: Hardware-specific constraint not enforced in code
- **Complexity**: Low - Add compile-time assertion
- **Related Items**: Similar constraint checking needed across GPIO implementation

**Recommendation**: Add compile-time check to prevent invalid GPIOD pin configurations

---

### TODO #163: Remove this loop. Set at once.

**Location**: `port/wch/ch32v/src/hals/ch32v003/pins.zig:204`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Remove this loop. Set at once.
```

**Code Context**:
```zig
                    // TODO: GPIOD has only 3 ports. Check this.
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
>>>                         // TODO: Remove this loop. Set at once.
                        pin.set_mode(pin_config.mode.?);
                    }
                }
```

**Analysis**:

- **Purpose**: Optimize pin configuration by setting all modes in single register write
- **Why Incomplete**: Current implementation sets pins individually, inefficient
- **Complexity**: Medium - Requires batching configuration changes
- **Related Items**: Similar TODO #164 for pull configuration

**Recommendation**: Batch pin mode changes and write to configuration register once

---

### TODO #164: Remove this loop. Set at once.

**Location**: `port/wch/ch32v/src/hals/ch32v003/pins.zig:218`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Remove this loop. Set at once.
```

**Code Context**:
```zig
                if (input_gpios != 0) {
                    inline for (@typeInfo(Port.Configuration).@"struct".fields) |field|
                        if (@field(port_config, field.name)) |pin_config| {
                            var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
                            const pull = pin_config.pull orelse continue;
                            if (comptime pin_config.get_mode() != .input)
                                @compileError("Only input pins can have pull up/down enabled");

>>>                             // TODO: Remove this loop. Set at once.
                            pin.set_pull(pull);
                        };
                }
```

**Analysis**:

- **Purpose**: Optimize pull resistor configuration by batching writes
- **Why Incomplete**: Individual pin writes are inefficient
- **Complexity**: Medium - Batch configuration changes
- **Related Items**: Related to TODO #163

**Recommendation**: Batch pull resistor configurations and write once

---

### TODO #165: Implementation needed

**Location**: `port/wch/ch32v/src/hals/ch32v003/gpio.zig:63`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO:
```

**Code Context**:
```zig
    pub fn toggle(self: Pin) void {
        const offset: u5 = @intCast(self.pin);
        self.get_port_reg().OUTDR.raw ^= @as(u32, 1) << offset;
    }

>>>     // TODO:
    // fn get_config_bits(cfg: u2) @Vector(4, u1) {
    //     return @Vector(4, u1){
    //         (cfg >> 0) & 1,
```

**Analysis**:

- **Purpose**: Complete configuration bit manipulation helper function
- **Why Incomplete**: Function implementation commented out
- **Complexity**: Low - Simple bit manipulation
- **Related Items**: Part of GPIO configuration system

**Recommendation**: Complete or remove commented configuration function

---

### TODO #166: set mode when configure alternative mode.

**Location**: `port/wch/ch32v/src/hals/pins.zig:40`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: set mode when configure alternative mode.
```

**Code Context**:
```zig
    pub const Configuration = struct {
        name: ?[:0]const u8 = null,
        mode: ?gpio.Mode = null,
        speed: ?gpio.Speed = null,
        pull: ?gpio.Pull = null,

        pub fn get_mode(comptime config: Configuration) gpio.Mode {
            return if (config.mode) |mode|
                mode
>>>                 // TODO: set mode when configure alternative mode.
                // else if (comptime config.function.is_pwm())
                //     .output
```

**Analysis**:

- **Purpose**: Implement automatic mode detection for alternative functions
- **Why Incomplete**: Same as TODO #159, different file variant
- **Complexity**: Medium
- **Related Items**: Duplicate of TODO #159 in generic pins.zig

**Recommendation**: Implement function-to-mode mapping (consolidate with #159)

---

### TODO #167: Implementation needed

**Location**: `port/wch/ch32v/src/hals/pins.zig:50`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
@panic("TODO");
```

**Code Context**:
```zig
                // else if (comptime config.function.is_adc())
                //     .input
            else
>>>                 @panic("TODO");
        }
    };
```

**Analysis**:

- **Purpose**: Handle undefined pin mode case
- **Why Incomplete**: Placeholder panic
- **Complexity**: Low
- **Related Items**: Duplicate of TODO #160

**Recommendation**: Replace with proper error handling

---

### TODO #168: Read current output from ODR.

**Location**: `port/wch/ch32v/src/hals/pins.zig:79`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Read current output from ODR.
```

**Code Context**:
```zig
            pub inline fn toggle(self: @This()) void {
                _ = self;
                pin.toggle();
            }

>>>             // TODO: Read current output from ODR.
            // pub inline fn read(self: @This()) u1 {
            //     _ = self;
            //     return pin.output_read();
            // }
```

**Analysis**:

- **Purpose**: Implement output pin state reading
- **Why Incomplete**: Same as TODO #161
- **Complexity**: Low
- **Related Items**: Duplicate of TODO #161

**Recommendation**: Implement ODR read method

---

### TODO #169: GPIOD has only 3 ports. Check this.

**Location**: `port/wch/ch32v/src/hals/pins.zig:238`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: GPIOD has only 3 ports. Check this.
```

**Code Context**:
```zig
                inline for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
>>>                     // TODO: GPIOD has only 3 ports. Check this.
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
```

**Analysis**:

- **Purpose**: Validate GPIOD pin count constraint
- **Why Incomplete**: Same as TODO #162
- **Complexity**: Low
- **Related Items**: Duplicate of TODO #162

**Recommendation**: Add constraint validation

---

### TODO #170: Remove this loop. Set at once.

**Location**: `port/wch/ch32v/src/hals/pins.zig:241`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Remove this loop. Set at once.
```

**Code Context**:
```zig
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
>>>                         // TODO: Remove this loop. Set at once.
                        pin.set_mode(pin_config.mode.?);
                    }
```

**Analysis**:

- **Purpose**: Batch pin mode configuration
- **Why Incomplete**: Same as TODO #163
- **Complexity**: Medium
- **Related Items**: Duplicate of TODO #163

**Recommendation**: Implement batched configuration

---

### TODO #171: Remove this loop. Set at once.

**Location**: `port/wch/ch32v/src/hals/pins.zig:255`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Remove this loop. Set at once.
```

**Code Context**:
```zig
                            if (comptime pin_config.get_mode() != .input)
                                @compileError("Only input pins can have pull up/down enabled");

>>>                             // TODO: Remove this loop. Set at once.
                            pin.set_pull(pull);
                        };
```

**Analysis**:

- **Purpose**: Batch pull resistor configuration
- **Why Incomplete**: Same as TODO #164
- **Complexity**: Medium
- **Related Items**: Duplicate of TODO #164

**Recommendation**: Implement batched pull configuration

---

### TODO #172: Implementation needed

**Location**: `port/wch/ch32v/src/hals/gpio.zig:68`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO:
```

**Code Context**:
```zig
    pub fn toggle(self: Pin) void {
        const offset: u5 = @intCast(self.pin);
        self.get_port_reg().OUTDR.raw ^= @as(u32, 1) << offset;
    }

>>>     // TODO:
    // fn get_config_bits(cfg: u2) @Vector(4, u1) {
    //     return @Vector(4, u1){
```

**Analysis**:

- **Purpose**: Complete configuration helper
- **Why Incomplete**: Same as TODO #165
- **Complexity**: Low
- **Related Items**: Duplicate of TODO #165

**Recommendation**: Complete or remove function

---

### TODO #173: Cleanup!

**Location**: `port/wch/ch32v/src/hals/gpio.zig:119`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Cleanup!
```

**Code Context**:
```zig
    pub fn set_pull(self: Pin, pull: Pull) void {
        const reg = self.get_port_reg();
        const offset: u5 = @intCast(self.pin);
>>>         // TODO: Cleanup!
        switch (pull) {
            .up => {
                reg.OUTDR.raw |= @as(u32, 1) << offset;
```

**Analysis**:

- **Purpose**: Refactor pull resistor configuration code
- **Why Incomplete**: Code works but needs cleanup/refactoring
- **Complexity**: Low - Code quality improvement
- **Related Items**: Part of GPIO pull configuration

**Recommendation**: Refactor for clarity and maintainability

---

### TODO #174: Add support for other USARTs/UARTs

**Location**: `port/wch/ch32v/src/hals/usart.zig:151`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: Add support for other USARTs/UARTs
```

**Code Context**:
```zig
pub fn USART(comptime index: usize, comptime pins: Pins) type {
    if (pins.tx == null or pins.rx == null)
        @compileError("tx and rx pins are required for UART");

>>>     // TODO: Add support for other USARTs/UARTs
    if (index != 1)
        @compileError("TODO: only USART1 is supported for now");
```

**Analysis**:

- **Purpose**: Extend UART support beyond USART1
- **Why Incomplete**: Only USART1 currently implemented
- **Complexity**: Medium - Requires multiple UART peripheral configurations
- **Related Items**: Hardware abstraction layer expansion

**Recommendation**: Implement USART2, USART3, etc. with similar patterns

---

### TODO #175: check if pin is already configured as output

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:36`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: check if pin is already configured as output
```

**Code Context**:
```zig
pub const pin_config = hal.pin.StaticPinConfig{
    .output = .{
        .function = function,
>>>         // TODO: check if pin is already configured as output
    },
    .input = .{
        // TODO: check if pin is already configured as input
```

**Analysis**:

- **Purpose**: Add validation to prevent reconfiguring pins
- **Why Incomplete**: No state tracking for pin configuration
- **Complexity**: Medium - Requires pin state management
- **Related Items**: Related to TODOs #176, #177, #178

**Recommendation**: Implement pin configuration state tracking

---

### TODO #176: check if pin is already configured as input

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:40`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: check if pin is already configured as input
```

**Code Context**:
```zig
        // TODO: check if pin is already configured as output
    },
    .input = .{
>>>         // TODO: check if pin is already configured as input
        .function = function,
    },
```

**Analysis**:

- **Purpose**: Validate input pin configuration state
- **Why Incomplete**: Same as TODO #175
- **Complexity**: Medium
- **Related Items**: Part of pin state validation system

**Recommendation**: Implement input configuration validation

---

### TODO #177: check if pin is configured as input

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:45`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: check if pin is configured as input
```

**Code Context**:
```zig
pub fn read(gpio: Gpio) hal.gpio.State {
>>>     // TODO: check if pin is configured as input
    return if (gpio.read_input()) .high else .low;
}
```

**Analysis**:

- **Purpose**: Validate pin mode before reading
- **Why Incomplete**: No mode checking before read operation
- **Complexity**: Low - Add assertion
- **Related Items**: Pin validation series

**Recommendation**: Add runtime or compile-time mode check

---

### TODO #178: check if pin is configured as output

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:52`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: check if pin is configured as output
```

**Code Context**:
```zig
pub fn write(gpio: Gpio, state: hal.gpio.State) void {
>>>     // TODO: check if pin is configured as output
    gpio.write_output(state);
}
```

**Analysis**:

- **Purpose**: Validate pin mode before writing
- **Why Incomplete**: No mode checking before write
- **Complexity**: Low
- **Related Items**: Completes pin validation series

**Recommendation**: Add mode validation before write operations

---

### TODO #179: custom pins are not currently supported

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103.zig:79`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
@compileError("TODO: custom pins are not currently supported");
```

**Code Context**:
```zig
    pub fn init(config: Config) Uart {
        const pins = config.pins orelse pin_config[config.num];
        _ = pins; // NOTE: For now, default pins are used
        if (config.pins != null)
>>>             @compileError("TODO: custom pins are not currently supported");

        switch (config.num) {
```

**Analysis**:

- **Purpose**: Add support for custom UART pin assignments
- **Why Incomplete**: Only default pins currently supported
- **Complexity**: Medium - Requires pin remapping configuration
- **Related Items**: UART configuration flexibility

**Recommendation**: Implement pin remapping for UART peripherals

---

### TODO #180: custom pins are not currently supported

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103/uart.zig:29`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
@compileError("TODO: custom pins are not currently supported");
```

**Code Context**:
```zig
const pins = pins_opt orelse pin_configs[num];
_ = pins;
if (pins_opt != null)
>>>     @compileError("TODO: custom pins are not currently supported");
```

**Analysis**:

- **Purpose**: Support custom UART pins
- **Why Incomplete**: Same as TODO #179
- **Complexity**: Medium
- **Related Items**: Duplicate of TODO #179

**Recommendation**: Implement custom pin configuration

---

### TODO #181: Implementation needed

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103/pins.zig:54`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
@panic("TODO");
```

**Code Context**:
```zig
                // else if (comptime config.function.is_adc())
                //     .input
            else
>>>                 @panic("TODO");
        }
    };
```

**Analysis**:

- **Purpose**: Handle default pin mode case
- **Why Incomplete**: Placeholder panic
- **Complexity**: Low
- **Related Items**: Similar to TODOs #160, #167

**Recommendation**: Replace with proper error handling

---

### TODO #182: ensure only one instance of an input function exists

**Location**: `port/gigadevice/gd32/src/hals/GD32VF103/pins.zig:187`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: ensure only one instance of an input function exists
```

**Code Context**:
```zig
            return @field(port_reg, struct_name).IDR.read().value;
        }
    };

>>>     // TODO: ensure only one instance of an input function exists
    const function_table = block: {
        @setEvalBranchQuota(10_000);
```

**Analysis**:

- **Purpose**: Prevent duplicate input function assignments
- **Why Incomplete**: No uniqueness validation for pin functions
- **Complexity**: Medium - Requires compile-time validation
- **Related Items**: Pin function assignment validation

**Recommendation**: Add compile-time check for duplicate function assignments

---

### TODO #183: implement

**Location**: `port/gigadevice/gd32/src/boards/longan_nano.zig:110`  
**Author**: Analysis in progress  
**Commit**: Analyzing...

**Original Comment**:
```zig
// TODO: implement
```

**Code Context**:
```zig
    pub const debugWrite = hal.uart.debugWrite;

    pub fn debugFlush() void {
>>>         // TODO: implement
    }
};
```

**Analysis**:

- **Purpose**: Implement UART debug flush operation
- **Why Incomplete**: Function stub without implementation
- **Complexity**: Low - Simple UART flush operation
- **Related Items**: Debug output functionality

**Recommendation**: Implement UART transmit buffer flush

---

## Batch Summary

**Total TODOs Analyzed**: 25
**Primary Categories**:
- Pin/GPIO Configuration: 15 TODOs
- UART/Serial Support: 3 TODOs
- Code Quality/Optimization: 4 TODOs
- Validation/Error Handling: 3 TODOs

**Key Patterns**:
1. Many duplicate TODOs across ch32v003-specific and generic implementations
2. Optimization opportunities for batch register writes
3. Missing pin configuration validation
4. Incomplete alternative function support

**Priority Recommendations**:
1. **High**: Implement pin mode validation (TODOs #175-#178)
2. **Medium**: Add alternative function mode detection (#159, #166)
3. **Medium**: Optimize batch configuration writes (#163-#164, #170-#171)
4. **Low**: Replace panic statements with proper errors (#160, #167, #181)
