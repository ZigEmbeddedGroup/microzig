//! Driver interfaces (`microzig.drivers.base`) on top of the ATmega328P HAL.
//!
//! The pins are comptime parameters, because the GPIO functions need them at
//! compile time (they use SBI/CBI). None of the adapters keep state, so their
//! interfaces use an `undefined` pointer.

const microzig = @import("microzig");
const mdf = microzig.drivers;
const gpio = microzig.hal.gpio;
const spi = @import("spi.zig");
const time = @import("time.zig");

const ClockDevice = mdf.base.ClockDevice;
const DatagramDevice = mdf.base.DatagramDevice;
const Digital_IO = mdf.base.Digital_IO;

/// `Digital_IO` for `pin`.
pub fn GPIO_Device(comptime pin: gpio.Pin) type {
    return struct {
        const Self = @This();

        pub fn digital_io(_: Self) Digital_IO {
            return .{ .ptr = undefined, .vtable = &vtable };
        }

        pub fn set_direction(_: Self, dir: Digital_IO.Direction) Digital_IO.SetDirError!void {
            switch (dir) {
                .input => pin.set_direction(.input),
                .output => pin.set_direction(.output),
            }
        }

        /// `.high` enables the internal pull-up and `null` disables it;
        /// `.low` is unsupported (there are no pull-downs). The pull-up is
        /// the PORT bit, so on an output this sets the level instead, and it
        /// only works while PUD (MCUCR) is 0, as after reset.
        pub fn set_bias(_: Self, bias: ?Digital_IO.State) Digital_IO.SetBiasError!void {
            const state = bias orelse return pin.put(0);
            switch (state) {
                .high => pin.put(1),
                .low => return error.Unsupported,
            }
        }

        pub fn write(_: Self, state: Digital_IO.State) Digital_IO.WriteError!void {
            pin.put(state.value());
        }

        pub fn read(_: Self) Digital_IO.ReadError!Digital_IO.State {
            return @fromBackingInt(pin.read());
        }

        const vtable: Digital_IO.VTable = .{
            .set_direction_fn = set_direction_fn,
            .set_bias_fn = set_bias_fn,
            .write_fn = write_fn,
            .read_fn = read_fn,
        };

        fn set_direction_fn(_: *anyopaque, dir: Digital_IO.Direction) Digital_IO.SetDirError!void {
            return Self.set_direction(.{}, dir);
        }

        fn set_bias_fn(_: *anyopaque, bias: ?Digital_IO.State) Digital_IO.SetBiasError!void {
            return Self.set_bias(.{}, bias);
        }

        fn write_fn(_: *anyopaque, state: Digital_IO.State) Digital_IO.WriteError!void {
            return Self.write(.{}, state);
        }

        fn read_fn(_: *anyopaque) Digital_IO.ReadError!Digital_IO.State {
            return Self.read(.{});
        }
    };
}

/// `DatagramDevice` for a device on the SPI bus with an active-low chip
/// select on `cs_pin`, driven by `connect` and `disconnect`.
///
/// Call `init` first, and set the SPI up (`spi_setup.apply`). The device
/// must have the bus to itself between `connect` and `disconnect`; nothing
/// checks that. The transfers poll without a timeout.
pub fn SPI_DatagramDevice(comptime cs_pin: gpio.Pin) type {
    return struct {
        const Self = @This();
        const bus = spi.instance.SPI0;

        /// Deselects the device and makes CS an output.
        pub fn init() Self {
            cs_pin.put(1);
            cs_pin.set_direction(.output);
            return .{};
        }

        pub fn datagram_device(_: Self) DatagramDevice {
            return .{ .ptr = undefined, .vtable = &vtable };
        }

        pub fn connect(_: Self) DatagramDevice.ConnectError!void {
            cs_pin.put(0);
        }

        pub fn disconnect(_: Self) void {
            cs_pin.put(1);
        }

        pub fn writev(_: Self, chunks: []const []const u8) DatagramDevice.WriteError!void {
            bus.writev_blocking(chunks);
        }

        /// The chunks must add up to at most `maxInt(usize)` bytes (65535).
        pub fn readv(_: Self, chunks: []const []u8) DatagramDevice.ReadError!usize {
            var total: usize = 0;
            for (chunks) |chunk| {
                const sum, const overflow = @addWithOverflow(total, chunk.len);
                microzig.assert(overflow == 0, .{});
                total = sum;
            }
            bus.readv_blocking(chunks);
            return total;
        }

        pub fn writev_then_readv(
            _: Self,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) DatagramDevice.ReadError!void {
            bus.writev_blocking(write_chunks);
            bus.readv_blocking(read_chunks);
        }

        const vtable: DatagramDevice.VTable = .{
            .connect_fn = connect_fn,
            .disconnect_fn = disconnect_fn,
            .writev_fn = writev_fn,
            .readv_fn = readv_fn,
            .writev_then_readv_fn = writev_then_readv_fn,
        };

        fn connect_fn(_: *anyopaque) DatagramDevice.ConnectError!void {
            return Self.connect(.{});
        }

        fn disconnect_fn(_: *anyopaque) void {
            Self.disconnect(.{});
        }

        fn writev_fn(_: *anyopaque, chunks: []const []const u8) DatagramDevice.WriteError!void {
            return Self.writev(.{}, chunks);
        }

        fn readv_fn(_: *anyopaque, chunks: []const []u8) DatagramDevice.ReadError!usize {
            return Self.readv(.{}, chunks);
        }

        fn writev_then_readv_fn(
            _: *anyopaque,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) DatagramDevice.ReadError!void {
            return Self.writev_then_readv(.{}, write_chunks, read_chunks);
        }
    };
}

/// `ClockDevice` on `hal.time`. Sleeps use `time.sleep_us`, which waits at
/// least the requested time.
///
/// `hal.time` must be set up (handler registered, `init` called, interrupts
/// enabled), and the sleeps can't be used in an interrupt handler.
pub fn clock_device() ClockDevice {
    const S = struct {
        const vtable: ClockDevice.VTable = .{
            .get_time_since_boot = get_time_since_boot_fn,
            .sleep = sleep_fn,
        };

        fn get_time_since_boot_fn(_: *anyopaque) mdf.time.Absolute {
            return time.get_time_since_boot();
        }

        fn sleep_fn(_: *anyopaque, time_us: u64) void {
            time.sleep_us(time_us);
        }
    };
    return .{ .ptr = undefined, .vtable = &S.vtable };
}
