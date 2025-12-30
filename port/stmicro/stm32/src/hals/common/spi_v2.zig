const std = @import("std");

const microzig = @import("microzig");
const utils = @import("util.zig");
const hal = microzig.hal;
const Digital_IO = microzig.drivers.base.Digital_IO;
const spi_v2 = microzig.chip.types.peripherals.spi_v2;
const spi_t = spi_v2.SPI;
pub const Instances = hal.enums.SPI_V2_Type;
const Error = error{
    MissingGpioPin,
} || Digital_IO.SetDirError || Digital_IO.SetBiasError || Digital_IO.WriteError || Digital_IO.ReadError;

fn get_regs(comptime instance: Instances) *volatile spi_t {
    return @field(microzig.chip.peripherals, @tagName(instance));
}
const ChipSelect = enum {
    NSS, //hardware slave management using NSS pin
    GPIO, //software slave management using external GPIO
};

pub const Config = struct {
    phase: spi_v2.CPHA = .FirstEdge,
    polarity: spi_v2.CPOL = .IdleLow,
    chip_select: ChipSelect = .NSS,
    frame_format: spi_v2.LSBFIRST = .MSBFirst,
    data_size: spi_v2.DS = .Bits8,
    max_frequency: u32,
};

pub const SPI = struct {
    instance: Instances,
    spi: *volatile spi_t,
    nss: ?*Digital_IO,

    pub fn apply(self: *const SPI, config: Config) Error!void {
        const clk = hal.rcc.get_spi_clk(self.instance);

        const divider = (clk / config.max_frequency) + 1;

        const br: spi_v2.BR = switch (divider) {
            0...2 => .Div2,
            3...4 => .Div4,
            5...8 => .Div8,
            9...16 => .Div16,
            17...32 => .Div32,
            33...64 => .Div64,
            65...128 => .Div128,
            else => .Div256,
        };

        self.spi.CR1.raw = 0; // Disable SPI end clear configs before configuration
        self.spi.CR1.modify(.{
            .CPOL = config.polarity,
            .CPHA = config.phase,
            .LSBFIRST = config.frame_format,
            .BR = br,
            .MSTR = spi_v2.MSTR.Master,
        });

        self.spi.CR2.modify(.{
            .DS = config.data_size,
            .SSOE = 1,
            .FRXTH = .Quarter,
        });

        // for now we only support master mode
        switch (config.chip_select) {
            .GPIO => {
                if (self.nss) |nss| {
                    try nss.set_direction(.output);
                    try nss.set_bias(null);
                    try nss.write(.high);
                } else {
                    return Error.MissingGpioPin;
                }
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

    fn check_tx(self: *const SPI) bool {
        return self.spi.SR.read().TXE != 0;
    }

    fn check_rx(self: *const SPI) bool {
        return self.spi.SR.read().RXNE != 0;
    }

    fn busy_wait(self: *const SPI) void {
        while (self.spi.SR.read().BSY != 0) {}
    }

    fn is_nss_gpio(self: *const SPI) bool {
        return self.spi.CR1.read().SSM == 1;
    }

    pub fn write_blocking(self: *const SPI, out: []const u8) Error!void {
        if (self.nss) |nss| {
            try nss.write(.low);
        }
        defer if (self.nss) |nss| {
            nss.write(.high) catch {
                @panic("NSS pin can not unselect chip");
            };
        };

        for (out) |byte| {
            self.spi.DR8 = byte;
            while (!self.check_tx()) {}
        }
        std.log.info("Status {any}", .{self.spi.SR.read()});

        // Empting the read fifo
        while (self.check_rx()) {
            std.mem.doNotOptimizeAway(self.spi.DR8);
        }

        self.busy_wait();

        std.log.info("Status {any}", .{self.spi.SR.read()});
    }

    ///this function is full-duplex only and does not support 3-wire mode and data burst
    ///if the revice buffer is bigger than the transmit buffer dummy bytes will be sent until the receive buffer is full
    ///if the transmit buffer is bigger than the receive buffer, all additional bytes will be ignored
    pub fn transceive_blocking(self: *const SPI, out: []const u8, in: []u8) Error!void {
        if (self.nss) |nss| {
            try nss.write(.low);
        }
        defer if (self.nss) |nss| {
            nss.write(.high) catch {
                @panic("NSS pin can not unselect chip");
            };
        };
        const out_len = out.len;
        const in_len = in.len;

        var out_remain = out_len - 1;
        // Each byte sent to MOSI is read back as 0x00
        var in_remain = in_len + out_len;

        //  Let's purge the RX fifo
        while (self.check_rx()) {
            std.mem.doNotOptimizeAway(self.spi.DR8);
        }

        //load the first byte
        //the RX value will be loaded into the shift register, and will be loaded into the DR register after the first clock cycle
        self.spi.DR8 = out[0];
        while ((out_remain > 0) or (in_remain > 0)) {
            while (!self.check_tx()) {}
            if (out_remain > 0) {
                self.spi.DR8 = out[out_len - out_remain];
                out_remain -= 1;
            } else {
                // Keep the clock running
                self.spi.DR8 = 0;
            }

            while (!self.check_rx()) {}
            if (in_remain > 0) {
                if (in_remain > in_len) {
                    // Discarding the bytes sent during transmit
                    std.mem.doNotOptimizeAway(self.spi.DR8);
                    in_remain -= 1;
                } else {
                    in[in_len - in_remain] = @intCast(self.spi.DR8);
                    in_remain -= 1;
                }
            }
        }

        self.busy_wait();
    }

    pub fn init(comptime spi_inst: Instances, nss: ?*Digital_IO) SPI {
        hal.rcc.enable_spi(spi_inst);
        return .{ .spi = get_regs(spi_inst), .instance = spi_inst, .nss = nss };
    }
};
