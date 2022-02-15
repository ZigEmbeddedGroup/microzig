const std = @import("std");
const micro = @import("microzig.zig");
const chip = micro.chip;

pub const Mode = enum {
    input,
    output,
    input_output,
    open_drain,
    generic,
};

pub const State = enum(u1) {
    low = 0,
    high = 1,
};

pub const Drive = enum(u1) {
    disabled = 0,
    enabled = 1,
};

pub const Direction = enum(u1) {
    input = 0,
    output = 1,
};

pub fn Gpio(comptime pin: type, config: anytype) type {
    const mode = @as(Mode, config.mode);
    const Generic = struct {
        // all pins:
        fn init() void {
            switch (mode) {
                .input, .generic, .input_output => {
                    setDirection(.input, undefined);
                },
                .output => {
                    if (comptime !@hasField(@TypeOf(config), "initial_state"))
                        @compileError("An output pin requires initial_state to be either .high or .low");
                    setDirection(.output, switch (config.initial_state) {
                        .low => State.low,
                        .high => State.high,
                        else => @compileError("An output pin requires initial_state to be either .high or .low"),
                    });
                },
                .open_drain => {
                    if (comptime !@hasField(@TypeOf(config), "initial_state"))
                        @compileError("An open_drain pin requires initial_state to be either .floating or .driven");
                    setDirection(.input, undefined);
                    setDrive(switch (config.initial_state) {
                        .floating => Drive.disabled,
                        .driven => Drive.enabled,
                        else => @compileError("An open_drain pin requires initial_state to be either .floating or .driven"),
                    });
                },
            }
        }

        fn read() State {
            return chip.gpio.read(pin.source_pin);
        }

        // outputs:
        fn write(state: State) void {
            chip.gpio.write(pin.source_pin, state);
        }

        fn setToHigh() void {
            write(.high);
        }
        fn setToLow() void {
            write(.low);
        }
        fn toggle() void {
            if (comptime @hasDecl(chip.gpio, "toggle")) {
                chip.gpio.toggle(pin.source_pin);
            } else {
                write(switch (read()) {
                    .low => State.high,
                    .high => State.low,
                });
            }
        }

        // bi-di:
        fn setDirection(dir: Direction, output_state: State) void {
            switch (dir) {
                .output => {
                    chip.gpio.setOutput(pin.source_pin);
                    write(output_state);
                },
                .input => chip.gpio.setInput(pin.source_pin),
            }
        }
        fn getDirection() Direction {
            if (chip.gpio.isOutput(pin.source_pin)) {
                return .output;
            } else {
                return .input;
            }
        }

        // open drain
        fn setDrive(drive: Drive) void {
            _ = drive;
            @compileError("open drain not implemented yet!");
        }
        fn getDrive() Drive {
            @compileError("open drain not implemented yet!");
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
        .generic => Generic,
    }
}
