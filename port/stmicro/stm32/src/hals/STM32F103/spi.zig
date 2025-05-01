const std = @import("std");
const microzig = @import("microzig");
const util = @import("util.zig");

const spi_f1 = microzig.chip.types.peripherals.spi_f1;
const SpiRegs = *volatile spi_f1.SPI;

const ChipSelect = enum {
    NSS, //hardware slave management using NSS pin
    GPIO, //software slave management using external GPIO
};

const Config = struct {
    phase: spi_f1.CPHA = .FirstEdge,
    polarity: spi_f1.CPOL = .IdleLow,
    //master: spi_f1.MSTR = .Master, slave mode not supported yet
    chip_select: ChipSelect = .NSS,
    frame_format: spi_f1.LSBFIRST = .MSBFirst,
    data_size: spi_f1.DFF = .Bits8,
    prescaler: spi_f1.BR = .Div2,
};

pub const Instances = util.create_peripheral_enum("SPI", "spi_f1");
fn get_regs(instance: Instances) SpiRegs {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

///TODO: 3-Wire mode, Slave mode, bidirectional mode
pub const SPI = struct {
    spi: SpiRegs,

    pub fn apply(self: *const SPI, config: Config) void {
        self.spi.CR1.raw = 0; // Disable SPI end clear configs before configuration
        self.spi.CR1.modify(.{
            .CPOL = config.polarity,
            .CPHA = config.phase,
            .DFF = config.data_size,
            .LSBFIRST = config.frame_format,
            .BR = config.prescaler,
            .MSTR = spi_f1.MSTR.Master,
        });

        // for now we only support master mode
        switch (config.chip_select) {
            .GPIO => {
                self.spi.CR1.modify(.{ .SSM = 1, .SSI = 1 }); // Enable software slave management
                self.spi.CR2.modify(.{ .SSOE = 0 }); // output disable for NSS pin
            },
            .NSS => {
                self.spi.CR1.modify(.{ .SSM = 0, .SSI = 0 }); // Disable software slave management
                self.spi.CR2.modify(.{ .SSOE = 1 }); // output enable for NSS pin
            },
        }

        self.spi.CR1.modify(.{ .SPE = 1 }); // Enable SPI
    }

    fn check_TX(self: *const SPI) bool {
        return self.spi.SR.read().TXE != 0;
    }

    fn check_RX(self: *const SPI) bool {
        return self.spi.SR.read().RXNE != 0;
    }

    fn busy_wait(self: *const SPI) void {
        while (self.spi.SR.read().BSY != 0) {}
    }

    //trasmite only procedure | RM008 page 721
    pub fn write_blocking(self: *const SPI, data: []const u8) void {
        for (data) |byte| {
            self.spi.DR.raw = byte;
            while (!self.check_TX()) {}
        }
        self.busy_wait();

        //clear flags
        std.mem.doNotOptimizeAway(self.spi.DR.read());
        std.mem.doNotOptimizeAway(self.spi.SR.read());
    }

    pub fn read_blocking(self: *const SPI, data: []u8) void {
        self.spi.DR.raw = 0;
        for (data) |*byte| {
            //send dummy byte to generate clock
            while (!(self.check_TX())) {}
            self.spi.DR.raw = 0; // send dummy byte

            //wait for data to be received
            while (!(self.check_RX())) {}
            byte.* = @intCast(self.spi.DR.raw & 0xFF);
        }
        self.busy_wait();

        std.mem.doNotOptimizeAway(self.spi.DR.read());
        std.mem.doNotOptimizeAway(self.spi.SR.read());
    }

    ///this function is full-duplex only and does not support 3-wire mode and data burst
    /// if the revice buffer is bigger than the transmit buffer dummy bytes will be sent until the receive buffer is full
    /// if the transmit buffer is bigger than the receive buffer, all additional bytes will be ignored
    pub fn transceive_blocking(self: *const SPI, out: []const u8, in: []u8) void {
        const out_len = out.len;
        const in_len = in.len;
        if (out_len == 0) {
            self.read_blocking(in);
        } else if (in_len == 0) {
            self.write_blocking(out);
        }

        var out_remain = out_len - 1;
        var in_remain = in_len;

        //load the first byte
        //the RX value will be loaded into the shift register, and will be loaded into the DR register after the first clock cycle
        self.spi.DR.raw = out[0];
        while ((out_remain > 0) or (in_remain > 0)) {
            while (!check_TX(self)) {}
            if (out_remain > 0) {
                self.spi.DR.raw = out[out_len - out_remain];
                out_remain -= 1;
            } else {
                self.spi.DR.raw = 0; // send dummy byte
            }

            while (!check_RX(self)) {}
            if (in_remain > 0) {
                in[in_len - in_remain] = @intCast(self.spi.DR.raw & 0xFF);
                in_remain -= 1;
            }
        }

        self.busy_wait();
    }

    pub fn init(spi_inst: Instances) SPI {
        return .{ .spi = get_regs(spi_inst) };
    }
};
