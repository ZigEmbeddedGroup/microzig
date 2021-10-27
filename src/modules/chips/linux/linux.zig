const std = @import("std");
const micro = @import("microzig");
const micro_linker = @import("microzig-linker");

pub const cpu_frequency = 1337;

pub const cpu = struct {
    pub const startup_logic = void;
    pub fn cli() void {}
};

pub const memory_regions = [_]micro_linker.MemoryRegion{
    micro_linker.MemoryRegion{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
    micro_linker.MemoryRegion{ .offset = 0x800100, .length = 2048, .kind = .ram },
};

pub fn debugWrite(string: []const u8) void {
    std.debug.print("debug: {s}\n", .{string});
}

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec.len != 3)
        @compileError(invalid_format_msg);
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);

    return struct {};
}

pub const gpio = struct {
    fn regs(comptime desc: type) type {
        _ = desc;
        return struct {};
    }

    pub fn setOutput(comptime pin: type) void {
        _ = pin;
    }

    pub fn setInput(comptime pin: type) void {
        _ = pin;
    }

    pub fn read(comptime pin: type) u1 {
        _ = pin;
    }

    pub fn write(comptime pin: type, state: u1) void {
        _ = pin;
        _ = state;
    }

    pub fn toggle(comptime pin: type) void {
        _ = pin;
    }
};

pub const uart = struct {
    pub const DataBits = enum(u2) {
        five = 0,
        six = 1,
        seven = 2,
        eight = 3,
    };

    pub const StopBits = enum(u1) {
        one = 0,
        two = 1,
    };

    pub const Parity = enum(u2) {
        odd = 0,
        even = 1,
        mark = 2,
        space = 3,
    };
};

pub fn Uart(comptime index: usize) type {
    return struct {
        handle: std.os.fd_t,

        const UARTn = std.fmt.comptimePrint("/dev/ttyACM{}", .{index});
        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            _ = config;
            return Self{
                .handle = std.os.open(UARTn, std.os.O.RDWR | std.os.O.NOCTTY | std.os.O.SYNC, 0) catch return error.UnsupportedBaudRate,
            };
        }

        pub fn canWrite(self: Self) bool {
            _ = self;
            return true;
        }
        pub fn tx(self: Self, ch: u8) void {
            _ = std.os.write(self.handle, std.mem.asBytes(&ch)) catch {
                @panic("write failed");
            };
        }

        pub fn canRead(self: Self) bool {
            _ = self;
            return true;
        }
        pub fn rx(self: Self) u8 {
            var temp: u8 = undefined;
            _ = std.os.read(self.handle, std.mem.asBytes(&temp)) catch {
                @panic("read failed");
            };
            return temp;
        }
    };
}
