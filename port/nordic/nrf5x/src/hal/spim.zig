const std = @import("std");

const microzig = @import("microzig");
const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const compatibility = @import("compatibility.zig");

const gpio = @import("gpio.zig");
const time = @import("time.zig");

const SPIM0 = peripherals.SPIM0;
const SPIM1 = peripherals.SPIM1;
const SPIM2 = peripherals.SPIM2;
const SPIM3 = peripherals.SPIM3;

const SpimRegs = microzig.chip.types.peripherals.SPIM0;

// const EASY_DMA_SIZE = switch (compatibility.chip) {
//     .nrf52 => std.math.maxInt(u8),
//     .nrf52840 => std.math.maxInt(u16),
// };
const EASY_DMA_SIZE = std.math.maxInt(
    @FieldType(@FieldType(@FieldType(SpimRegs, "TXD"), "MAXCNT").underlying_type, "MAXCNT"),
);

const Config = struct {
    sck_pin: gpio.Pin,
    miso_pin: ?gpio.Pin,
    mosi_pin: ?gpio.Pin,
    frequency: Frequency,
    mode: enum { mode0, mode1, mode2, mode3 } = .mode0,
    bit_order: enum(u1) { msbFirst = 0, lsbFirst = 1 } = .msbFirst,
    overread_char: u8 = 0x00,
    sck_drive: gpio.DriveStrength = .SOS1,
    mosi_drive: gpio.DriveStrength = .SOS1,
};

const Frequency = switch (compatibility.chip) {
    .nrf52 => enum { K125, K250, K500, M1, M2, M4, M8 },
    .nrf52840 => enum { K125, K250, K500, M1, M2, M4, M8, M16, M32 },
};

pub const TransactionError = error{
    Timeout,
    NoData,
    Overrun,
    UnknownAbort,
};

pub fn num(n: u2) SPIM {
    return @as(SPIM, @enumFromInt(n));
}

pub const SPIM = enum(u1) {
    _,

    pub fn get_regs(spi: SPIM) *volatile SpimRegs {
        return switch (@intFromEnum(spi)) {
            0 => SPIM0,
            1 => SPIM1,
        };
    }

    pub fn apply(spi: SPIM, config: Config) !void {
        const regs = spi.get_regs();
        // TODO: Chip-specific
        if (config.miso_pin) |miso| {
            miso.set_direction(.in);
            switch (compatibility.chip) {
                .nrf52 => regs.PSEL.MISO.write(.{
                    .PIN = miso.index(),
                    .CONNECT = .Connected,
                }),
                .nrf52840 => regs.PSEL.MISO.write(.{
                    .PIN = miso.index(),
                    .PORT = miso.port(),
                    .CONNECT = .Connected,
                }),
            }
        } else regs.PSEL.MISO.modify(.{
            .CONNECT = .Disconnected,
        });
        if (config.mosi_pin) |mosi| {
            mosi.set_direction(.out);
            mosi.set_drive_strength(config.mosi_drive);
            switch (compatibility.chip) {
                .nrf52 => regs.PSEL.MOSI.write(.{
                    .PIN = mosi.index(),
                    .CONNECT = .Connected,
                }),
                .nrf52840 => regs.PSEL.MOSI.write(.{
                    .PIN = mosi.index(),
                    .PORT = mosi.port(),
                    .CONNECT = .Connected,
                }),
            }
        } else regs.PSEL.MOSI.modify(.{
            .CONNECT = .Disconnected,
        });
        // TODO: Does MOSI idle change here?
        switch (config.mode) {
            .mode0 => regs.CONFIG.write(.{
                .ORDER = @enumFromInt(@intFromBool(config.bit_order == .lsbFirst)),
                .CPHA = .Leading,
                .CPOL = .ActiveHigh,
            }),
            .mode1 => regs.CONFIG.write(.{
                .ORDER = @enumFromInt(@intFromBool(config.bit_order == .lsbFirst)),
                .CPHA = .Trailing,
                .CPOL = .ActiveHigh,
            }),

            .mode2 => regs.CONFIG.write(.{
                .ORDER = @enumFromInt(@intFromBool(config.bit_order == .lsbFirst)),
                .CPHA = .Leading,
                .CPOL = .ActiveLow,
            }),

            .mode3 => regs.CONFIG.write(.{
                .ORDER = @enumFromInt(@intFromBool(config.bit_order == .lsbFirst)),
                .CPHA = .Trailing,
                .CPOL = .ActiveLow,
            }),
        }

        switch (compatibility.chip) {
            .nrf52 => regs.FREQUENCY.write(.{ .FREQUENCY = switch (config.frequency) {
                .K125 => .K125,
                .K250 => .K250,
                .K500 => .K500,
                .M1 => .M1,
                .M2 => .M2,
                .M4 => .M4,
                .M8 => .M8,
            } }),
            .nrf52840 => regs.FREQUENCY.write(.{ .FREQUENCY = switch (config.frequency) {
                .K125 => .K125,
                .K250 => .K250,
                .K500 => .K500,
                .M1 => .M1,
                .M2 => .M2,
                .M4 => .M4,
                .M8 => .M8,
                .M16 => .M16,
                .M32 => .M32,
            } }),
        }

        regs.ORC.write(.{ .ORC = config.overread_char });

        config.sck_pin.set_direction(.out);
        config.sck_pin.set_drive_strength(config.sck_drive);
        switch (compatibility.chip) {
            .nrf52 => regs.PSEL.SCK.write(.{
                .PIN = config.sck_pin.index(),
                .CONNECT = .Connected,
            }),
            .nrf52840 => regs.PSEL.SCK.write(.{
                .PIN = config.sck_pin.index(),
                .PORT = config.sck_pin.port(),
                .CONNECT = .Connected,
            }),
        }

        regs.ENABLE.write(.{ .ENABLE = .Enabled });
        regs.INTENCLR.write_raw(0xFFFFFFFF);
        // TODO: Enable interrupts
    }

    pub fn write_blocking(spi: SPIM, data: []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
        try spi.inner_tx_rx(data, &.{}, deadline);
    }

    pub fn writev_blocking(spi: SPIM, chunks: []const []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (timeout) |initial_timeout| {
            var remaining_timeout = initial_timeout;
            var start_time = time.get_time_since_boot();

            for (chunks) |chunk| {
                const elapsed_time = time.get_time_since_boot().diff(start_time);
                remaining_timeout = remaining_timeout.minus(elapsed_time);

                try spi.write_blocking(chunk, remaining_timeout);
                start_time = time.get_time_since_boot();
            }
        } else {
            for (chunks) |chunk| {
                try spi.write_blocking(chunk, null);
            }
        }
    }

    pub fn read_blocking(spi: SPIM, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
        try spi.inner_tx_rx(&.{}, dst, deadline);
    }

    pub fn readv_blocking(spi: SPIM, chunks: []const []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (timeout) |initial_timeout| {
            var remaining_timeout = initial_timeout;
            var start_time = time.get_time_since_boot();

            for (chunks) |chunk| {
                const elapsed_time = time.get_time_since_boot().diff(start_time);
                remaining_timeout = remaining_timeout.minus(elapsed_time);

                try spi.read_blocking(chunk, remaining_timeout);
                start_time = time.get_time_since_boot();
            }
        } else {
            for (chunks) |chunk| {
                try spi.read_blocking(chunk, null);
            }
        }
    }

    pub fn transceive_blocking(spi: SPIM, tx: []const u8, rx: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
        try spi.inner_tx_rx(tx, rx, deadline);
    }

    fn prepare_dma_transfer(spi: SPIM, tx: []const u8, rx: []u8) TransactionError!void {
        std.log.info("Transfering {} out and {} in", .{ tx.len, rx.len }); // DELETEME
        const regs = spi.get_regs();
        regs.RXD.PTR.write_raw(@intFromPtr(rx.ptr));
        regs.RXD.MAXCNT.write(.{ .MAXCNT = @truncate(rx.len) });

        regs.TXD.PTR.write_raw(@intFromPtr(tx.ptr));
        regs.TXD.MAXCNT.write(.{ .MAXCNT = @truncate(tx.len) });

        regs.EVENTS_END.write(.{ .EVENTS_END = .NotGenerated });
        regs.INTENSET.modify(.{ .END = .Enabled });

        regs.TASKS_START.write(.{ .TASKS_START = .Trigger });
    }

    fn inner_tx_rx(spi: SPIM, write_data: []const u8, read_data: []u8, deadline: mdf.time.Deadline) TransactionError!void {
        // TODO: DMA won't work if they are trying to copy from Flash (e.g. program memory). In that
        // case we'd have to copy it to RAM before doing this, buf it that's the case, maybe they
        // should just use the non-DMA peripheral? We could return an error in that case.

        // Chunkify into slices that fit in the max length for a DMA transfer
        const xfer_len = @max(write_data.len, read_data.len);
        var offset: usize = 0;
        while (offset < xfer_len) : (offset += EASY_DMA_SIZE) {
            const rx_chunk_start = offset;
            const rx_chunk_end = @min(offset + EASY_DMA_SIZE, read_data.len);
            const rx_chunk = read_data[rx_chunk_start..rx_chunk_end];

            const tx_chunk_start = offset;
            const tx_chunk_end = @min(offset + EASY_DMA_SIZE, write_data.len);
            const tx_chunk = write_data[tx_chunk_start..tx_chunk_end];
            try spi.inner_tx_rx_chunk(tx_chunk, rx_chunk, deadline);
        }
    }

    fn inner_tx_rx_chunk(spi: SPIM, write_data: []const u8, read_data: []u8, deadline: mdf.time.Deadline) TransactionError!void {
        if (deadline.is_reached_by(time.get_time_since_boot())) return TransactionError.Timeout;

        const regs = spi.get_regs();
        try spi.prepare_dma_transfer(write_data, read_data);

        while (true) {
            if (regs.EVENTS_END.read().EVENTS_END == .Generated)
                break;
            if (deadline.is_reached_by(time.get_time_since_boot())) {
                // TODO: Do we have to stop the task on timeout?
                // regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
                return TransactionError.Timeout;
            }
        }
    }
};
