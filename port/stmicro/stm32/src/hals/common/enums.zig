const util = @import("util.zig");

pub const UART_V3_Type = util.create_peripheral_enum_from_type("usart_v3");

pub const I2C_V2_Type = util.create_peripheral_enum("I2C", "i2c_v2");

pub const SPI_V2_Type = util.create_peripheral_enum("SPI", "spi_v2");
