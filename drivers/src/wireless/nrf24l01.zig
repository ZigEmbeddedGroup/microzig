//! Driver for the nRF24L01+ 2.4 GHz transceiver. It only uses features that
//! the Si24R1 clone has too.
//!
//! Datasheets:
//! - nRF24L01+: https://www.sparkfun.com/datasheets/Components/SMD/nRF24L01Pluss_Preliminary_Product_Specification_v1_0.pdf
//! - Si24R1: https://datasheet.lcsc.com/datasheet/pdf/be794b55cdcca6c6b9038ef8f521b6e9.pdf
//!
//! The `DatagramDevice` must be an SPI bus in mode 0 (MSB first, up to
//! 10 MHz) that drives CS low in `connect` and high in `disconnect`, and must
//! support `writev` and `writev_then_readv`.
//!
//! Functions return `!void` and pass results through pointers: on AVR, Zig
//! 0.17.0 can't compile error unions with a non-void payload
//! (https://codeberg.org/ziglang/zig/issues/37099).

const std = @import("std");
const mdf = @import("../root.zig");

const command = struct {
    const r_register = 0x00;
    const w_register = 0x20;
    const r_rx_payload = 0x61;
    const w_tx_payload = 0xA0;
    const flush_tx = 0xE1;
    const flush_rx = 0xE2;
};

const Register = enum(u8) {
    config = 0x00,
    en_aa = 0x01,
    en_rxaddr = 0x02,
    setup_aw = 0x03,
    setup_retr = 0x04,
    rf_ch = 0x05,
    rf_setup = 0x06,
    status = 0x07,
    rx_addr_p0 = 0x0A,
    tx_addr = 0x10,
    rx_pw_p0 = 0x11,
    fifo_status = 0x17,
    dynpd = 0x1C,
    feature = 0x1D,
};

/// Bits of the CONFIG register.
const config_bits = struct {
    const prim_rx = 1 << 0;
    const pwr_up = 1 << 1;
    const crco = 1 << 2; // 2-byte CRC
    const en_crc = 1 << 3;
};

/// Bits of the STATUS register. Writing 1 clears them.
const status_bits = struct {
    const max_rt = 1 << 4;
    const tx_ds = 1 << 5;
    const rx_dr = 1 << 6;
    /// Always reads as 0. A 1 means the radio isn't answering (e.g. MISO
    /// floating high).
    const reserved = 1 << 7;
};

/// Bits of the FIFO_STATUS register.
const fifo_status_bits = struct {
    const rx_empty = 1 << 0;
    /// Always reads as 0, like bit 7 of STATUS.
    const reserved = 1 << 7;
};

/// CONFIG value in standby, ready to send.
const config_tx = config_bits.en_crc | config_bits.crco | config_bits.pwr_up;
/// CONFIG value for receiving (`start_listening`).
const config_rx = config_tx | config_bits.prim_rx;

/// RF_SETUP bits kept by `apply`: the TX power, whose encoding differs between
/// the nRF24L01+ and the Si24R1. Clearing the rest selects 1 Mbps.
const rf_setup_power_mask = 0b111;

/// Pipe 0 is used both to receive and for the auto-acknowledgments.
const pipe_0 = 1 << 0;

/// Auto-retransmit delay and count, as in the RF24 Arduino library: up to 15
/// retransmits, each one (5 + 1) * 250 us = 1.5 ms after the end of the
/// previous transmission if no ACK arrived. SETUP_RETR holds the delay in
/// bits 7:4 and the count in bits 3:0.
const retransmit_delay = 5;
const retransmit_count = 15;

/// Time from setting PWR_UP until the radio is in standby, as in the RF24
/// Arduino library. It depends on the crystal: up to 4.5 ms on the nRF24L01+
/// and about 1.5 to 2 ms on the Si24R1.
const power_up_delay_ms = 5;

/// Time from raising CE until the radio is receiving (Tstby2a).
const rx_settling_us = 130;

/// Wait after lowering CE before leaving RX mode, as the RF24 Arduino library
/// does at 1 Mbps on fast platforms. It's a margin, not a datasheet minimum.
const stop_listening_delay_us = 280;

/// CE high time that starts a transmission (Thce, at least 10 us).
const ce_pulse_us = 10;

/// How long `send` waits for TX_DS or MAX_RT. All 15 retransmits of a 32-byte
/// payload take about 28 ms at 1 Mbps; this is a safety margin on top.
const send_timeout_ms = 95;

/// Pause between STATUS reads while `send` waits.
const send_poll_interval_us = 100;

pub const address_width = 5;
pub const max_channel = 125;
pub const max_payload_size = 32;

pub const Config = struct {
    /// The radio uses 2400 + `channel` MHz. The default is in the 2.4 GHz ISM
    /// band.
    channel: u7 = 76,
    /// Used both to send and to receive, least significant byte first. On the
    /// Si24R1 the last byte must not be 0x00, 0xFF, 0x55, 0xAA, 0x5A or 0xA5.
    address: [address_width]u8,
    /// Size of every payload, in bytes (1 to `max_payload_size`).
    payload_size: u6 = max_payload_size,
};

pub const NRF24L01_Options = struct {
    DatagramDevice: type = mdf.base.DatagramDevice,
    /// The CE pin.
    Digital_IO: type = mdf.base.Digital_IO,
    ClockDevice: type = mdf.base.ClockDevice,
};

/// nRF24L01+ driver using the base interfaces (vtables).
pub const NRF24L01 = NRF24L01_Generic(.{});

/// Creates a driver specialized for the concrete types of its arguments.
pub fn init(dev: anytype, ce: anytype, clock: anytype) NRF24L01_Generic(.{
    .DatagramDevice = @TypeOf(dev),
    .Digital_IO = @TypeOf(ce),
    .ClockDevice = @TypeOf(clock),
}) {
    return .init(dev, ce, clock);
}

pub fn NRF24L01_Generic(comptime options: NRF24L01_Options) type {
    return struct {
        const Self = @This();

        dev: options.DatagramDevice,
        ce: options.Digital_IO,
        clock: options.ClockDevice,
        /// Set by `apply`. 0 until then, so `send` and `receive` fail.
        payload_size: u6 = 0,

        /// Doesn't touch the hardware; call `apply` to set the radio up.
        pub fn init(dev: options.DatagramDevice, ce: options.Digital_IO, clock: options.ClockDevice) Self {
            return .{ .dev = dev, .ce = ce, .clock = clock };
        }

        /// Sets the radio up and leaves it in standby, ready to send: 1 Mbps,
        /// 2-byte CRC, auto-acknowledgment on pipe 0, and the TX power left as
        /// it was. Discards both FIFOs and clears the status flags.
        ///
        /// The radio must be past its power-on reset (up to 100 ms after power
        /// is applied). If this fails, the radio may be partly configured.
        pub fn apply(self: *Self, config: Config) !void {
            if (config.channel > max_channel or
                config.payload_size == 0 or config.payload_size > max_payload_size)
                return error.InvalidConfig;
            self.payload_size = 0;

            try self.ce.set_direction(.output);
            try self.ce.write(.low);
            // Power down first, so that the rest is written to an idle radio.
            try self.write_register(.config, config_bits.en_crc | config_bits.crco);

            try self.write_register(.en_aa, pipe_0);
            try self.write_register(.en_rxaddr, pipe_0);
            try self.write_register(.setup_aw, address_width - 2); // 0b11 = 5 bytes
            try self.write_register(.setup_retr, retransmit_delay << 4 | retransmit_count);
            try self.write_register(.rf_ch, config.channel);

            var rf_setup: u8 = undefined;
            try self.read_register(.rf_setup, &rf_setup);
            try self.write_register(.rf_setup, rf_setup & rf_setup_power_mask);

            try self.write_command(command.w_register | @backingInt(Register.rx_addr_p0), &config.address);
            try self.write_command(command.w_register | @backingInt(Register.tx_addr), &config.address);
            try self.write_register(.rx_pw_p0, config.payload_size);
            try self.write_register(.dynpd, 0);
            try self.write_register(.feature, 0);

            try self.write_register(.status, status_bits.rx_dr | status_bits.tx_ds | status_bits.max_rt);
            try self.write_command(command.flush_tx, &.{});
            try self.write_command(command.flush_rx, &.{});

            try self.write_register(.config, config_tx);
            self.clock.sleep_ms(power_up_delay_ms);
            self.payload_size = config.payload_size;
        }

        /// Starts receiving on pipe 0. Received packets wait in the RX FIFO
        /// until they are read.
        ///
        /// The radio must be in standby with CE low, as `apply` and
        /// `stop_listening` leave it. If this fails, CONFIG and CE may be
        /// partly changed.
        pub fn start_listening(self: Self) !void {
            try self.write_register(.config, config_rx);
            try self.ce.write(.high);
            self.clock.sleep_us(rx_settling_us);
        }

        /// Stops receiving and goes back to standby, ready to send. Packets
        /// already in the RX FIFO are kept.
        ///
        /// If this fails, CONFIG and CE may be partly changed.
        pub fn stop_listening(self: Self) !void {
            try self.ce.write(.low);
            self.clock.sleep_us(stop_listening_delay_us);
            try self.write_register(.config, config_tx);
        }

        /// Sends one payload and waits until it is acknowledged. `payload.len`
        /// must be the configured `payload_size`.
        ///
        /// The radio must be in standby, as `apply` and `stop_listening` leave
        /// it. Returns `error.MaxRetries` if no ACK arrived after all the
        /// retransmits. After `error.InvalidPayloadSize` and `error.MaxRetries`
        /// the radio is ready for the next `send`; after any other error
        /// (including `error.Timeout`, which can also come from the bus) its
        /// state is unknown: call `apply` again.
        pub fn send(self: Self, payload: []const u8) !void {
            if (self.payload_size == 0 or payload.len != self.payload_size)
                return error.InvalidPayloadSize;

            // A pending MAX_RT blocks any new transmission.
            try self.write_register(.status, status_bits.tx_ds | status_bits.max_rt);
            try self.write_command(command.w_tx_payload, payload);
            try self.ce.write(.high);
            self.clock.sleep_us(ce_pulse_us);
            try self.ce.write(.low);

            const timeout = self.clock.make_timeout(.from_ms(send_timeout_ms));
            while (true) {
                var status: u8 = undefined;
                try self.read_register(.status, &status);
                if (status & status_bits.reserved != 0) return error.IoError;
                if (status & status_bits.max_rt != 0) {
                    // FLUSH_TX drops the payload; MAX_RT is cleared by the next send.
                    try self.write_command(command.flush_tx, &.{});
                    return error.MaxRetries;
                }
                if (status & status_bits.tx_ds != 0) return;
                if (timeout.is_reached()) {
                    try self.write_command(command.flush_tx, &.{});
                    return error.Timeout;
                }
                self.clock.sleep_us(send_poll_interval_us);
            }
        }

        /// Reads one received payload into `buffer`, whose length must be the
        /// configured `payload_size`. Sets `received` to false if there was
        /// none. Works both while listening and in standby.
        ///
        /// It checks the RX FIFO, not RX_DR, so RX_DR is left set.
        pub fn receive(self: Self, buffer: []u8, received: *bool) !void {
            if (self.payload_size == 0 or buffer.len != self.payload_size)
                return error.InvalidPayloadSize;

            var fifo_status: u8 = undefined;
            try self.read_register(.fifo_status, &fifo_status);
            if (fifo_status & fifo_status_bits.reserved != 0) return error.IoError;
            if (fifo_status & fifo_status_bits.rx_empty != 0) {
                received.* = false;
                return;
            }

            try self.read_command(command.r_rx_payload, buffer);
            received.* = true;
        }

        /// Sends a command byte followed by `data`.
        fn write_command(self: Self, cmd: u8, data: []const u8) !void {
            try self.dev.connect();
            defer self.dev.disconnect();
            try self.dev.writev(&.{ &.{cmd}, data });
        }

        /// Sends a command byte and reads the reply into `buffer`.
        fn read_command(self: Self, cmd: u8, buffer: []u8) !void {
            try self.dev.connect();
            defer self.dev.disconnect();
            try self.dev.writev_then_readv(&.{&.{cmd}}, &.{buffer});
        }

        fn read_register(self: Self, register: Register, value: *u8) !void {
            try self.read_command(command.r_register | @backingInt(register), value[0..1]);
        }

        fn write_register(self: Self, register: Register, value: u8) !void {
            try self.write_command(command.w_register | @backingInt(register), &.{value});
        }
    };
}

const TestRadio = struct {
    dd: mdf.base.DatagramDevice.TestDevice,
    ce: mdf.base.Digital_IO.TestDevice,
    clock: mdf.base.ClockDevice.TestDevice,

    fn init(input: []const []const u8) TestRadio {
        return .{
            .dd = .init(input, true),
            .ce = .init(.output, .low),
            .clock = .init(),
        };
    }

    fn deinit(t: *TestRadio) void {
        t.dd.deinit();
    }

    fn driver(t: *TestRadio) NRF24L01 {
        return .init(t.dd.datagram_device(), t.ce.digital_io(), t.clock.clock_device());
    }
};

test "read_register sends R_REGISTER and reads one byte" {
    var t: TestRadio = .init(&.{&.{0x0E}});
    defer t.deinit();

    var value: u8 = undefined;
    try t.driver().read_register(.status, &value);

    try t.dd.expect_sent(&.{&.{0x07}});
    try std.testing.expectEqual(0x0E, value);
}

test "write_register sends W_REGISTER and the value" {
    var t: TestRadio = .init(&.{});
    defer t.deinit();

    try t.driver().write_register(.rf_ch, 76);

    try t.dd.expect_sent(&.{&.{ 0x25, 76 }});
}

test "write_command sends the command and its data in one transaction" {
    var t: TestRadio = .init(&.{});
    defer t.deinit();

    try t.driver().write_command(command.flush_tx, &.{});
    try t.driver().write_command(command.w_tx_payload, &.{ 1, 2, 3 });

    try t.dd.expect_sent(&.{ &.{0xE1}, &.{ 0xA0, 1, 2, 3 } });
}

test "apply writes the configuration and powers up" {
    // RF_SETUP is read back with all TX power bits set and 2 Mbps.
    var t: TestRadio = .init(&.{&.{0x0F}});
    defer t.deinit();
    t.ce = .init(.input, .high);

    var radio = t.driver();
    try radio.apply(.{ .channel = 76, .address = .{ 1, 2, 3, 4, 5 } });

    try t.dd.expect_sent(&.{
        &.{ 0x20, 0x0C }, // CONFIG: power down
        &.{ 0x21, 0x01 }, // EN_AA: pipe 0
        &.{ 0x22, 0x01 }, // EN_RXADDR: pipe 0
        &.{ 0x23, 0x03 }, // SETUP_AW: 5 bytes
        &.{ 0x24, 0x5F }, // SETUP_RETR: 1.5 ms, 15 retransmits
        &.{ 0x25, 76 }, // RF_CH
        &.{0x06}, // read RF_SETUP
        &.{ 0x26, 0x07 }, // RF_SETUP: 1 Mbps, TX power kept
        &.{ 0x2A, 1, 2, 3, 4, 5 }, // RX_ADDR_P0
        &.{ 0x30, 1, 2, 3, 4, 5 }, // TX_ADDR
        &.{ 0x31, 32 }, // RX_PW_P0
        &.{ 0x3C, 0x00 }, // DYNPD
        &.{ 0x3D, 0x00 }, // FEATURE
        &.{ 0x27, 0x70 }, // STATUS: clear RX_DR, TX_DS and MAX_RT
        &.{0xE1}, // FLUSH_TX
        &.{0xE2}, // FLUSH_RX
        &.{ 0x20, 0x0E }, // CONFIG: 2-byte CRC, PWR_UP, PRIM_RX=0
    });

    try std.testing.expectEqual(.output, t.ce.dir);
    try std.testing.expectEqual(.low, t.ce.state);
    try std.testing.expectEqual(5_000, t.clock.get_total_sleep_time());
}

test "apply keeps only the TX power bits of RF_SETUP" {
    // RF_DR_LOW (250 kbps) set and a TX power of 0b110.
    var t: TestRadio = .init(&.{&.{0x26}});
    defer t.deinit();

    var radio = t.driver();
    try radio.apply(.{ .address = .{ 1, 2, 3, 4, 5 } });

    const rf_setup_write = t.dd.packets.items[7];
    try std.testing.expectEqualSlices(u8, &.{ 0x26, 0x06 }, rf_setup_write);
}

test "apply rejects an invalid config without touching the radio" {
    const address: [address_width]u8 = .{ 1, 2, 3, 4, 5 };
    const invalid = [_]Config{
        .{ .channel = max_channel + 1, .address = address },
        .{ .payload_size = 0, .address = address },
        .{ .payload_size = max_payload_size + 1, .address = address },
    };

    for (invalid) |config| {
        var t: TestRadio = .init(&.{});
        defer t.deinit();
        t.ce = .init(.input, .high);

        var radio = t.driver();
        try std.testing.expectError(error.InvalidConfig, radio.apply(config));
        try t.dd.expect_sent(&.{});
        try std.testing.expectEqual(.input, t.ce.dir);
        try std.testing.expectEqual(.high, t.ce.state);
        try std.testing.expect(!t.dd.connected);
        try std.testing.expectEqual(0, t.clock.get_total_sleep_time());
    }
}

test "start_listening sets PRIM_RX and raises CE" {
    var t: TestRadio = .init(&.{});
    defer t.deinit();

    try t.driver().start_listening();

    try t.dd.expect_sent(&.{&.{ 0x20, 0x0F }}); // CONFIG: PRIM_RX
    try std.testing.expectEqual(.high, t.ce.state);
    try std.testing.expectEqual(130, t.clock.get_total_sleep_time());
}

test "stop_listening lowers CE and clears PRIM_RX" {
    var t: TestRadio = .init(&.{});
    defer t.deinit();
    t.ce = .init(.output, .high);

    try t.driver().stop_listening();

    try std.testing.expectEqual(.low, t.ce.state);
    try t.dd.expect_sent(&.{&.{ 0x20, 0x0E }}); // CONFIG: PRIM_RX=0
    try std.testing.expectEqual(280, t.clock.get_total_sleep_time());
}

test "apply sets payload_size" {
    var t: TestRadio = .init(&.{&.{0x06}});
    defer t.deinit();

    var radio = t.driver();
    try radio.apply(.{ .address = .{ 1, 2, 3, 4, 5 }, .payload_size = 4 });

    try std.testing.expectEqual(4, radio.payload_size);
}

test "send loads the payload, pulses CE and waits for TX_DS" {
    // STATUS: nothing yet, then TX_DS.
    var t: TestRadio = .init(&.{ &.{0x0E}, &.{0x2E} });
    defer t.deinit();
    var radio = t.driver();
    radio.payload_size = 3;

    try radio.send(&.{ 1, 2, 3 });

    try t.dd.expect_sent(&.{
        &.{ 0x27, 0x30 }, // STATUS: clear TX_DS and MAX_RT
        &.{ 0xA0, 1, 2, 3 }, // W_TX_PAYLOAD
        &.{0x07}, // read STATUS
        &.{0x07}, // read STATUS
    });
    try std.testing.expectEqual(.low, t.ce.state);
    try std.testing.expectEqual(10 + 100, t.clock.get_total_sleep_time());
}

test "send flushes the payload and fails after MAX_RT" {
    var t: TestRadio = .init(&.{&.{0x1E}});
    defer t.deinit();
    var radio = t.driver();
    radio.payload_size = 1;

    try std.testing.expectError(error.MaxRetries, radio.send(&.{1}));

    try std.testing.expectEqualSlices(u8, &.{0xE1}, t.dd.packets.items[t.dd.packets.items.len - 1]);
}

test "send flushes the payload and fails on timeout" {
    // STATUS never changes. Enough reads for the whole timeout.
    const status_reads: [1000][]const u8 = @splat(&.{0x0E});
    var t: TestRadio = .init(&status_reads);
    defer t.deinit();
    var radio = t.driver();
    radio.payload_size = 1;

    try std.testing.expectError(error.Timeout, radio.send(&.{1}));

    try std.testing.expectEqualSlices(u8, &.{0xE1}, t.dd.packets.items[t.dd.packets.items.len - 1]);
}

test "send fails if STATUS reads as 0xFF" {
    var t: TestRadio = .init(&.{&.{0xFF}});
    defer t.deinit();
    var radio = t.driver();
    radio.payload_size = 1;

    try std.testing.expectError(error.IoError, radio.send(&.{1}));
}

test "send and receive reject a wrong length without touching the radio" {
    var t: TestRadio = .init(&.{});
    defer t.deinit();
    var radio = t.driver();
    var buffer: [2]u8 = undefined;
    var received: bool = undefined;

    // Before apply.
    try std.testing.expectError(error.InvalidPayloadSize, radio.send(&.{}));
    try std.testing.expectError(error.InvalidPayloadSize, radio.receive(&.{}, &received));

    radio.payload_size = 3;
    try std.testing.expectError(error.InvalidPayloadSize, radio.send(&.{ 1, 2 }));
    try std.testing.expectError(error.InvalidPayloadSize, radio.receive(&buffer, &received));

    try t.dd.expect_sent(&.{});
    try std.testing.expectEqual(.low, t.ce.state);
}

test "receive reports an empty RX FIFO" {
    var t: TestRadio = .init(&.{&.{0x11}});
    defer t.deinit();
    var radio = t.driver();
    radio.payload_size = 2;

    var buffer: [2]u8 = undefined;
    var received = true;
    try radio.receive(&buffer, &received);

    try t.dd.expect_sent(&.{&.{0x17}}); // read FIFO_STATUS
    try std.testing.expect(!received);
}

test "receive fails if FIFO_STATUS reads as 0xFF" {
    var t: TestRadio = .init(&.{&.{0xFF}});
    defer t.deinit();
    var radio = t.driver();
    radio.payload_size = 2;

    var buffer: [2]u8 = undefined;
    var received: bool = undefined;
    try std.testing.expectError(error.IoError, radio.receive(&buffer, &received));
}

test "receive reads one payload" {
    var t: TestRadio = .init(&.{ &.{0x10}, &.{ 7, 8 } });
    defer t.deinit();
    var radio = t.driver();
    radio.payload_size = 2;

    var buffer: [2]u8 = undefined;
    var received = false;
    try radio.receive(&buffer, &received);

    try t.dd.expect_sent(&.{ &.{0x17}, &.{0x61} }); // FIFO_STATUS, R_RX_PAYLOAD
    try std.testing.expect(received);
    try std.testing.expectEqualSlices(u8, &.{ 7, 8 }, &buffer);
}
