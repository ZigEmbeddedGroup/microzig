const microzig = @import("microzig");

const SPI2 = microzig.chip.peripherals.SPI2;

pub const SPI = enum(u2) {
    spi2,

    pub fn apply(_: SPI) void {
        SPI2.USER.modify(.{
            .DOUTIN = 1,
            .USR_MISO_HIGHPART = 0,
            .USR_MOSI_HIGHPART = 0,
            .USR_MISO = 1,
            .USR_MOSI = 1,
            .CS_HOLD = 1,
            .USR_DUMMY_IDLE = 1,
            .USR_ADDR = 0,
            .USR_COMMAND = 0,
        });

        SPI2.SLAVE.write_raw(0);
    }
};
