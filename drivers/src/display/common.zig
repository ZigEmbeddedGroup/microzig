const std = @import("std");

pub const I2C_ControlByte = packed struct(u8) {
    zero: u6 = 0,

    /// The D/C# bit determines the next data byte is acted as a command or a data. If the D/C# bit is
    /// set to logic “0”, it defines the following data byte as a command. If the D/C# bit is set to
    /// logic “1”, it defines the following data byte as a data which will be stored at the GDDRAM.
    /// The GDDRAM column address pointer will be increased by one automatically after each
    /// data write.
    mode: enum(u1) { command = 0, data = 1 },

    /// If the Co bit is set as logic “0”, the transmission of the following information will contain data bytes only.
    co_bit: u1,

    pub const command: u8 = @bitCast(I2C_ControlByte{
        .mode = .command,
        .co_bit = 0,
    });

    pub const data_byte: u8 = @bitCast(I2C_ControlByte{
        .mode = .data,
        .co_bit = 1,
    });

    pub const data_stream: u8 = @bitCast(I2C_ControlByte{
        .mode = .data,
        .co_bit = 0,
    });
};

comptime {
    std.debug.assert(I2C_ControlByte.command == 0x00);
    std.debug.assert(I2C_ControlByte.data_byte == 0xC0);
    std.debug.assert(I2C_ControlByte.data_stream == 0x40);
}
