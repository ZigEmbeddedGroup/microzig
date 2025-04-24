const std = @import("std");
const microzig = @import("microzig");
const util = @import("util.zig");

const spi_f1 = microzig.chip.types.peripherals.spi_f1;
const SpiRegs = *volatile spi_f1.SPI;
//NOTE: style test number 2:
//create a peripheral enum for SPI based on the microzig.chip.peripherals
//in this way we can use the same code for all STM32F1xx chips
//avoid selecting invalid peripherals
//avoid using panic on invalid peripherals
pub const SPI_instance = util.create_peripheral_enum("SPI");

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

fn get_regs(instance: SPI_instance) SpiRegs {
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

    ///trasmite only procedure | RM008 page 721
    pub fn write_blocking(self: *const SPI, data: []const u8) void {
        for (data) |byte| {
            self.spi.DR.raw = byte;
            while (self.spi.SR.read().TXE == 0) {}
        }
        while (self.spi.SR.read().BSY != 0) {}

        //clear OVF flag
        std.mem.doNotOptimizeAway(self.spi.DR.read());
        std.mem.doNotOptimizeAway(self.spi.SR.read());
    }
};

pub fn get_SPI(spi_inst: SPI_instance) SPI {
    return .{ .spi = get_regs(spi_inst) };
}
