const std = @import("std");
const microzig = @import("microzig");
const hal = @import("hal");

pub const Mode = enum {
    input,
    output,
    input_output,
    open_drain,
    generic,
    alternate_function,
};

pub const State = enum(u1) {
    low = 0,
    high = 1,

    pub fn value(self: State) u1 {
        return @intFromEnum(self);
    }
};

pub const Drive = enum(u1) {
    disabled = 0,
    enabled = 1,
};

pub const Direction = enum(u1) {
    input = 0,
    output = 1,
};

pub fn Gpio(comptime pin: type, comptime config: anytype) type {
    const mode = @as(Mode, config.mode);
    const Generic = struct {
        // all pins:
        fn init() void {
            switch (mode) {
                .input, .generic, .input_output => {
                    set_direction(.input, undefined);
                },
                .output => {
                    if (comptime !@hasField(@TypeOf(config), "initial_state"))
                        @compileError("An output pin requires initial_state to be either .high or .low");
                    set_direction(.output, switch (config.initial_state) {
                        .low => State.low,
                        .high => State.high,
                        else => @compileError("An output pin requires initial_state to be either .high or .low"),
                    });
                },
                .open_drain => {
                    if (comptime !@hasField(@TypeOf(config), "initial_state"))
                        @compileError("An open_drain pin requires initial_state to be either .floating or .driven");
                    set_direction(.input, undefined);
                    set_drive(switch (config.initial_state) {
                        .floating => Drive.disabled,
                        .driven => Drive.enabled,
                        else => @compileError("An open_drain pin requires initial_state to be either .floating or .driven"),
                    });
                },
                .alternate_function => {
                    if (comptime @hasDecl(hal.gpio, "AlternateFunction")) {
                        const alternate_function = @as(hal.gpio.AlternateFunction, config.alternate_function);
                        set_alternate_function(alternate_function);
                    } else {
                        @compileError("Alternate Function not supported yet");
                    }
                },
            }
        }

        fn read() State {
            return hal.gpio.read(pin.source_pin);
        }

        // outputs:
        fn write(state: State) void {
            hal.gpio.write(pin.source_pin, state);
        }

        fn set_to_high() void {
            write(.high);
        }
        fn set_to_low() void {
            write(.low);
        }
        fn toggle() void {
            if (comptime @hasDecl(hal.gpio, "toggle")) {
                hal.gpio.toggle(pin.source_pin);
            } else {
                write(switch (read()) {
                    .low => State.high,
                    .high => State.low,
                });
            }
        }

        // bi-di:
        fn set_direction(dir: Direction, output_state: State) void {
            switch (dir) {
                .output => {
                    hal.gpio.setOutput(pin.source_pin);
                    write(output_state);
                },
                .input => hal.gpio.setInput(pin.source_pin),
            }
        }
        fn get_direction() Direction {
            if (hal.gpio.isOutput(pin.source_pin)) {
                return .output;
            } else {
                return .input;
            }
        }

        // open drain
        fn set_drive(drive: Drive) void {
            _ = drive;
            @compileError("open drain not implemented yet!");
        }
        fn get_drive() Drive {
            @compileError("open drain not implemented yet!");
        }

        // alternate function
        fn set_alternate_function(af: hal.gpio.AlternateFunction) void {
            hal.gpio.setAlternateFunction(pin.source_pin, af);
        }
    };
    // return only a subset of Generic for the requested pin.
    switch (mode) {
        .input => return struct {
            pub const init = Generic.init;
            pub const read = Generic.read;
        },
        .output => return struct {
            pub const init = Generic.init;
            pub const read = Generic.read;
            pub const write = Generic.write;
            pub const setToHigh = Generic.setToHigh;
            pub const setToLow = Generic.setToLow;
            pub const toggle = Generic.toggle;
        },
        .input_output => return struct {
            pub const init = Generic.init;
            pub const read = Generic.read;
            pub const write = Generic.write;
            pub const setToHigh = Generic.setToHigh;
            pub const setToLow = Generic.setToLow;
            pub const setDirection = Generic.setDirection;
            pub const getDirection = Generic.getDirection;
        },
        .open_drain => return struct {
            pub const init = Generic.init;
            pub const read = Generic.read;
            pub const setDrive = Generic.setDrive;
            pub const getDrive = Generic.getDrive;
        },
        .alternate_function => return struct {
            pub const init = Generic.init;
        },
        .generic => Generic,
    }
}
