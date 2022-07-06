const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

pub fn I2CController(comptime index: usize, comptime pins: Pins) type {
    const SystemI2CController = chip.I2CController(index, pins);

    const I2CDevice = struct {
        const Device = @This();

        internal: SystemI2CController,
        address: u7,

        const Direction = enum { read, write };
        fn Transfer(comptime direction: Direction) type {
            return switch (direction) {
                .read => struct {
                    const Self = @This();

                    state: SystemI2CController.ReadState,

                    pub const Reader = std.io.Reader(*Self, ReadError, readSome);

                    /// NOTE that some platforms, notably most (all?) STM32 microcontrollers,
                    /// allow only a single read call per transfer.
                    pub fn reader(self: *Self) Reader {
                        return Reader{ .context = self };
                    }

                    fn readSome(self: *Self, buffer: []u8) ReadError!usize {
                        try self.state.readNoEof(buffer);
                        return buffer.len;
                    }

                    /// STOP the transfer, invalidating this object.
                    pub fn stop(self: *Self) !void {
                        try self.state.stop();
                    }

                    /// RESTART to a new transfer, invalidating this object.
                    /// Note that some platforms set the repeated START condition
                    /// on the first read or write call.
                    pub fn restartTransfer(self: *Self, comptime new_direction: Direction) !Transfer(new_direction) {
                        return Transfer(direction){ .state = try self.state.restartTransfer(new_direction) };
                    }
                },
                .write => struct {
                    const Self = @This();

                    state: SystemI2CController.WriteState,

                    pub const Writer = std.io.Writer(*Self, WriteError, writeSome);

                    /// NOTE that some platforms, notably most (all?) STM32 microcontrollers,
                    /// will not immediately write all bytes, but postpone that
                    /// to the next write call, or to the stop() call.
                    pub fn writer(self: *Self) Writer {
                        return Writer{ .context = self };
                    }

                    fn writeSome(self: *Self, buffer: []const u8) WriteError!usize {
                        try self.state.writeAll(buffer);
                        return buffer.len;
                    }

                    /// STOP the transfer, invalidating this object.
                    pub fn stop(self: *Self) !void {
                        try self.state.stop();
                    }

                    /// RESTART to a new transfer, invalidating this object.
                    /// Note that some platforms set the repeated START condition
                    /// on the first read or write call.
                    pub fn restartTransfer(self: *Self, comptime new_direction: Direction) !Transfer(new_direction) {
                        return switch (new_direction) {
                            .read => Transfer(new_direction){ .state = try self.state.restartRead() },
                            .write => Transfer(new_direction){ .state = try self.state.restartWrite() },
                        };
                    }
                },
            };
        }

        /// START a new transfer.
        /// Note that some platforms set the START condition
        /// on the first read or write call.
        pub fn startTransfer(self: Device, comptime direction: Direction) !Transfer(direction) {
            return switch (direction) {
                .read => Transfer(direction){ .state = try SystemI2CController.ReadState.start(self.address) },
                .write => Transfer(direction){ .state = try SystemI2CController.WriteState.start(self.address) },
            };
        }

        /// Shorthand for 'register-based' devices
        pub fn writeRegister(self: Device, register_address: u8, byte: u8) ReadError!void {
            try self.writeRegisters(register_address, &.{byte});
        }

        /// Shorthand for 'register-based' devices
        pub fn writeRegisters(self: Device, register_address: u8, buffer: []u8) ReadError!void {
            var wt = try self.startTransfer(.write);
            defer wt.stop() catch {};
            try wt.writer().writeByte(register_address);
            try wt.writer().writeAll(buffer);
        }

        /// Shorthand for 'register-based' devices
        pub fn readRegister(self: Device, register_address: u8) ReadError!u8 {
            var buffer: [1]u8 = undefined;
            try self.readRegisters(register_address, &buffer);
            return buffer[0];
        }

        /// Shorthand for 'register-based' devices
        pub fn readRegisters(self: Device, register_address: u8, buffer: []u8) ReadError!void {
            var rt = write_and_restart: {
                var wt = try self.startTransfer(.write);
                errdefer wt.stop() catch {};
                try wt.writer().writeByte(1 << 7 | register_address); // MSB == 'keep sending until I STOP'
                break :write_and_restart try wt.restartTransfer(.read);
            };
            defer rt.stop() catch {};
            try rt.reader().readNoEof(buffer);
        }
    };

    return struct {
        const Self = @This();

        internal: SystemI2CController,

        pub fn init(config: Config) InitError!Self {
            return Self{
                .internal = try SystemI2CController.init(config),
            };
        }

        pub fn device(self: Self, address: u7) I2CDevice {
            return I2CDevice{ .internal = self.internal, .address = address };
        }
    };
}

/// The pin configuration. This is used to optionally configure specific pins to be used with the chosen I2C.
/// This makes sense only with microcontrollers supporting multiple pins for an I2C peripheral.
pub const Pins = struct {
    scl: ?type = null,
    sda: ?type = null,
};

/// A UART configuration. The config defaults to the *8N1* setting, so "8 data bits, no parity, 1 stop bit" which is the
/// most common serial format.
pub const Config = struct {
    /// The target speed in bit/s. Note that the actual speed can differ from this, due to prescaler rounding.
    target_speed: u32,
};

pub const InitError = error{
    InvalidBusFrequency,
    InvalidSpeed,
};
pub const WriteError = error{};
pub const ReadError = error{
    EndOfStream,
    TooFewBytesReceived,
    TooManyBytesReceived,
};
