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

// TODO: Chip specific. Take from svd? e.g. type of @Field(TXD.MAXCNT, "MAXCNT")
const EASY_DMA_SIZE = std.math.maxInt(u16);

// Registers
// TASKS_START 0x010 Start SPI transaction
// TASKS_STOP 0x014 Stop SPI transaction
// TASKS_SUSPEND 0x01C Suspend SPI transaction
// TASKS_RESUME 0x020 Resume SPI transaction
// EVENTS_STOPPED 0x104 SPI transaction has stopped
// EVENTS_ENDRX 0x110 End of RXD buffer reached
// EVENTS_END 0x118 End of RXD buffer and TXD buffer reached
// EVENTS_ENDTX 0x120 End of TXD buffer reached
// EVENTS_STARTED 0x14C Transaction started
// SHORTS 0x200 Shortcuts between local events and tasks
// INTENSET 0x304 Enable interrupt
// INTENCLR 0x308 Disable interrupt
// STALLSTAT 0x400 Stall status for EasyDMA RAM accesses. The fields in this register are set to STALL by hardware
// whenever a stall occurs and can be cleared (set to NOSTALL) by the CPU.
// ENABLE 0x500 Enable SPIM
// PSEL.SCK 0x508 Pin select for SCK
// PSEL.MOSI 0x50C Pin select for MOSI signal
// PSEL.MISO 0x510 Pin select for MISO signal
// PSEL.CSN 0x514 Pin select for CSN
// FREQUENCY 0x524 SPI frequency. Accuracy depends on the HFCLK source selected.
// RXD.PTR 0x534 Data pointer
// RXD.MAXCNT 0x538 Maximum number of bytes in receive buffer
// RXD.AMOUNT 0x53C Number of bytes transferred in the last transaction
// RXD.LIST 0x540 EasyDMA list type
// TXD.PTR 0x544 Data pointer
// TXD.MAXCNT 0x548 Number of bytes in transmit buffer
// TXD.AMOUNT 0x54C Number of bytes transferred in the last transaction
// TXD.LIST 0x550 EasyDMA list type
// CONFIG 0x554 Configuration register
// IFTIMING.RXDELAY 0x560 Sample delay for input serial data on MISO
// IFTIMING.CSNDUR 0x564 Minimum duration between edge of CSN and edge of SCK at the start and the end of a transaction,
// and minimum duration CSN will stay high between transactions if END-START shortcut is used
// CSNPOL 0x568 Polarity of CSN output
// PSELDCX 0x56C Pin select for DCX signal
// DCXCNT 0x570 DCX configuration
// ORC 0x5C0 Byte transmitted after TXD.MAXCNT bytes have been transmitted in the case when RXD.MAXCNT is
// greater than TXD.MAXCNT

const Config = struct {
    sck_pin: gpio.Pin,
    miso_pin: ?gpio.Pin,
    mosi_pin: ?gpio.Pin,
    frequency: enum { K125, K250, K500, M16, M1, M2, M4, M8, M32 },
    mode: enum { mode0, mode1, mode2, mode3 } = .mode0,
    bit_order: enum(u1) { msbFirst = 0, lsbFirst = 1 } = .msbFirst,
    overread_char: u8 = 0x00,
    sck_drive: gpio.DriveStrength = .SOS1,
    mosi_drive: gpio.DriveStrength = .SOS1,
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
            regs.PSEL.MISO.write(.{
                .PIN = miso.index(),
                .PORT = miso.port(),
                .CONNECT = .Connected,
            });
        } else regs.PSEL.MISO.modify(.{
            .CONNECT = .Disconnected,
        });
        if (config.mosi_pin) |mosi| {
            mosi.set_direction(.out);
            mosi.set_drive_strength(config.mosi_drive);
            regs.PSEL.MOSI.write(.{
                .PIN = mosi.index(),
                .PORT = mosi.port(),
                .CONNECT = .Connected,
            });
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

        // TODO: Could export the type in a patch to avoid this mapping
        regs.FREQUENCY.write(.{ .FREQUENCY = switch (config.frequency) {
            .K125 => .K125,
            .K250 => .K250,
            .K500 => .K500,
            .M1 => .M1,
            .M2 => .M2,
            .M4 => .M4,
            .M8 => .M8,
            .M16 => .M16,
            .M32 => .M32,
        } });

        regs.ORC.write(.{ .ORC = config.overread_char });

        config.sck_pin.set_direction(.out);
        config.sck_pin.set_drive_strength(config.sck_drive);
        regs.PSEL.SCK.write(.{
            .PIN = config.sck_pin.index(),
            .PORT = config.sck_pin.port(),
            .CONNECT = .Connected,
        });

        regs.ENABLE.write(.{ .ENABLE = .Enabled });
        regs.INTENCLR.write_raw(0xFFFFFFFF);
        // TODO: Enable interrupts
    }

    /// Wait until the task is stopped or suspended, there's an error, or we timeout.
    fn wait(spi: SPIM, deadline: mdf.time.Deadline) TransactionError!void {
        const regs = spi.get_regs();
        while (true) {
            if (regs.EVENTS_SUSPENDED.read().EVENTS_SUSPENDED == .Generated or
                regs.EVENTS_STOPPED.read().EVENTS_STOPPED == .Generated)
            {
                regs.EVENTS_STOPPED.raw = 0;
                break;
            }
            // Stop the task on error, but we need to keep waiting until the stop event
            if (regs.EVENTS_ERROR.read().EVENTS_ERROR == .Generated) {
                regs.EVENTS_ERROR.raw = 0;
                regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
            }
            if (deadline.is_reached_by(time.get_time_since_boot())) {
                regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
                return TransactionError.Timeout;
            }
        }
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

    pub fn write_blocking(spi: SPIM, data: []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
        try spi.inner_tx_rx(data, &.{}, deadline);
    }

    pub fn writev_blocking(spi: SPIM, chunks: []const []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        // TODO: Adjust duration after each iteration
        for (chunks) |chunk| {
            try spi.write_blocking(chunk, timeout);
        }
    }

    pub fn read_blocking(spi: SPIM, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
        try spi.inner_tx_rx(&.{}, dst, deadline);
    }

    pub fn readv_blocking(spi: SPIM, chunks: []const []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        // TODO: Adjust duration after each iteration
        for (chunks) |chunk| {
            try spi.read_blocking(chunk, timeout);
        }
    }

    pub fn transceivev_blocking(spi: SPIM, write_chunks: []const []const u8, read_chunks: []const []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        // TODO: Adjust duration after each iteration
        // TODO: Make sure different num of chunks for tx/rx works
        for (write_chunks, read_chunks) |tx_chunk, rx_chunk| {
            try spi.transceive_blocking(tx_chunk, rx_chunk, timeout);
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
};
