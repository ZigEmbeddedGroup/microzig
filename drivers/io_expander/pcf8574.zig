const mdf = @import("../framework.zig");
const Digital_IO = mdf.base.Digital_IO;
const State = Digital_IO.State;
const Vtable = Digital_IO.VTable;
const ReadError = Digital_IO.ReadError;
const SetBiasError = Digital_IO.SetBiasError;
const SetDirError = Digital_IO.SetDirError;
const WriteError = Digital_IO.WriteError;

pub const PCF8574_Config = struct {
    Datagram_Device: type = mdf.base.Datagram_Device,
};

pub fn PCF8574(comptime config: PCF8574_Config) type {
    return struct {
        const Self = @This();
        interface: config.Datagram_Device,
        pins: u8 = 0,
        pin_arr: [8]u8 = undefined,

        inline fn update(self: *const Self) !void {
            try self.interface.write(&[1]u8{self.pins});
        }

        pub fn put(self: *Self, pin: u3, st: State) !void {
            const mask: u8 = @as(u8, 1) << pin;
            switch (st) {
                .high => self.pins |= mask,
                .low => self.pins &= ~mask,
            }
            try self.update();
        }

        pub fn toggle(self: *Self, pin: u3) !void {
            const mask: u8 = @as(u8, 1) << pin;
            self.pins ^= mask;
            try self.update();
        }

        ///The PCF8574 does not have an internal configuration for output/input
        ///every read requires pullup enabled, otherwise it always returns 0 regardless of the signal on the pin
        pub fn read(self: *Self, pin: u3) !State {
            const mask: u8 = @as(u8, 1) << pin;
            var pkg: [1]u8 = .{mask | self.pins};
            const read_value = try self.interface.read(&pkg); //keep pullup enable until next call
            return if (read_value & mask != 0) State.high else State.low;
        }

        pub fn init(datagram: config.Datagram_Device) Self {
            var obj = Self{ .interface = datagram };
            for (0..obj.pin_arr.len) |index| {
                obj.pin_arr[index] = @intCast(index);
            }
            return obj;
        }

        const vtable = Vtable{
            .read_fn = read_fn,
            .set_bias_fn = set_bias_fn,
            .set_direction_fn = set_dir_fn,
            .write_fn = write_fn,
        };

        fn read_fn(ctx: *anyopaque) ReadError!State {
            const pin_ref: *u8 = @alignCast(@ptrCast(ctx));
            const index = pin_ref.*;
            const pin_base: *[8]u8 = @ptrFromInt(@intFromPtr(pin_ref) - index); //just 1 byte
            var PCF_base: *Self = @fieldParentPtr("pin_arr", pin_base);
            const state = PCF_base.read(@intCast(index)) catch return ReadError.IoError;
            return state;
        }

        fn write_fn(ctx: *anyopaque, state: State) WriteError!void {
            const pin_ref: *u8 = @alignCast(@ptrCast(ctx));
            const index = pin_ref.*;
            const pin_base: *[8]u8 = @ptrFromInt(@intFromPtr(pin_ref) - index); //just 1 byte
            var PCF_base: *Self = @fieldParentPtr("pin_arr", pin_base);
            PCF_base.put(@intCast(index), state) catch return WriteError.IoError;
        }

        fn set_bias_fn(_: *anyopaque, _: ?State) SetBiasError!void {
            return SetBiasError.Unsupported;
        }

        fn set_dir_fn(_: *anyopaque, _: Digital_IO.Direction) SetDirError!void {
            return SetDirError.Unsupported;
        }

        pub fn digital_IO(self: *Self, pin: u3) Digital_IO {
            return Digital_IO{
                .object = &self.pin_arr[pin],
                .vtable = &vtable,
            };
        }
    };
}
