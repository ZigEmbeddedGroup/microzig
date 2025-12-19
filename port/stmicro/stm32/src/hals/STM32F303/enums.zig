const util = @import("../common/util.zig");
pub const UARTType = enum(usize) {
    USART1,
    USART2,
    USART3,
    UART4,
    UART5,
};

pub const I2CType = enum(usize) {
    I2C1,
    I2C2,
};

pub const SPIType = util.create_peripheral_enum("SPI", "spi_v2");
