//! Drives the nRF24L01+ of an Emakefun RF-Nano V3.0 with the generic driver
//! and reports over USART0 (115200 8N1). Each key press sends one payload and
//! prints the result; packets received in between are printed too. With no
//! other radio listening, sends end with "no ACK".
//!
//! The port has no timer-based clock or driver adapters yet, so this file has
//! minimal ones: the SPI with CS on D8 (PB0), CE on D7 (PD7), and a clock
//! that only advances while sleeping.

const microzig = @import("microzig");
const nrf24l01 = microzig.drivers.wireless.nrf24l01;
const hal = microzig.hal;
const board = microzig.board;
const uart = hal.uart;

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

/// SPI transport for the radio: CS is held low for each transaction.
const Radio_SPI = struct {
    const cs_pin = hal.gpio.pin(.b, 0);
    const spi = board.spi_setup.instance;

    fn init() Radio_SPI {
        cs_pin.put(1); // deselect the radio before CS becomes an output
        cs_pin.set_direction(.output);
        return .{};
    }

    pub fn connect(_: Radio_SPI) !void {
        cs_pin.put(0);
    }

    pub fn disconnect(_: Radio_SPI) void {
        cs_pin.put(1);
    }

    pub fn writev(_: Radio_SPI, chunks: []const []const u8) !void {
        spi.writev_blocking(chunks);
    }

    pub fn writev_then_readv(_: Radio_SPI, write_chunks: []const []const u8, read_chunks: []const []u8) !void {
        spi.writev_blocking(write_chunks);
        spi.readv_blocking(read_chunks);
    }
};

/// The radio's CE pin.
const Radio_CE = struct {
    const pin = hal.gpio.pin(.d, 7);

    pub fn set_direction(_: Radio_CE, direction: microzig.drivers.base.Digital_IO.Direction) !void {
        switch (direction) {
            .input => pin.set_direction(.input),
            .output => pin.set_direction(.output),
        }
    }

    pub fn write(_: Radio_CE, state: microzig.drivers.base.Digital_IO.State) !void {
        pin.put(state.value());
    }
};

/// A clock that only advances in `sleep_us`, which busy-waits. Time spent
/// elsewhere isn't counted, so timeouts last longer than asked. The loop
/// overhead also makes each wait several times longer than requested.
const SleepClock = struct {
    var now_us: u64 = 0;

    /// Busy loop iterations per microsecond. Each iteration takes at least
    /// one cycle, so sleeps last at least as long as asked.
    const loops_per_us = board.clock_frequencies.cpu / 1_000_000;

    const Timeout = struct {
        deadline_us: u64,

        pub fn is_reached(timeout: Timeout) bool {
            return now_us >= timeout.deadline_us;
        }
    };

    pub fn sleep_us(_: SleepClock, time_us: u64) void {
        var i: u64 = 0;
        while (i < time_us) : (i += 1) {
            for (0..loops_per_us) |_| asm volatile ("nop");
        }
        now_us += time_us;
    }

    pub fn sleep_ms(clock: SleepClock, time_ms: u32) void {
        clock.sleep_us(@as(u64, time_ms) * 1_000);
    }

    pub fn make_timeout(_: SleepClock, duration: microzig.drivers.time.Duration) Timeout {
        return .{ .deadline_us = now_us + duration.to_us() };
    }
};

/// Same address as the Emakefun Peer2peer examples (0xF0F0F0F066). To get
/// an ACK, the other radio must also use channel 76 (the driver's default),
/// 1 Mbps, 2-byte CRC, auto-ack and a fixed 1-byte payload.
const address = [_]u8{ 0x66, 0xF0, 0xF0, 0xF0, 0xF0 };

pub fn main() void {
    board.uart_setup.apply(.{ .baud_rate = 115_200 });
    board.spi_setup.apply(.{ .baud_rate = 1_000_000 });

    run() catch |err| uart.write_blocking(switch (err) {
        error.Timeout => "[radio timeout]\r\n",
        else => "[radio error]\r\n",
    });
}

fn run() !void {
    var radio = nrf24l01.init(Radio_SPI.init(), Radio_CE{}, SleepClock{});
    const clock = SleepClock{};

    // The radio needs up to 100 ms after power-up before it can be set up.
    clock.sleep_ms(100);
    try radio.apply(.{ .address = address, .payload_size = 1 });
    try radio.start_listening();

    uart.write_blocking("Press a key to send it.\r\n");

    while (true) {
        var payload: [1]u8 = undefined;
        var received = false;
        try radio.receive(&payload, &received);
        if (received) {
            uart.write_blocking("received: ");
            uart.write_byte_blocking(payload[0]);
            uart.write_blocking("\r\n");
        }

        if (!uart.is_readable()) continue;
        uart.read_byte_blocking(&payload[0]) catch continue;

        try radio.stop_listening();
        if (radio.send(&payload)) |_| {
            uart.write_blocking("[sent]\r\n");
        } else |err| switch (err) {
            error.MaxRetries => uart.write_blocking("[no ACK]\r\n"),
            else => return err,
        }
        try radio.start_listening();
    }
}
