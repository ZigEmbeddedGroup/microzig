const helper = @import("utils/peripherals_helper.zig");

pub const All = helper.create_peripheral_enum(&.{
    "AFIO", // should this stay here?
    "GPIO",
    "USART",
    "DMA1",
    "DMA2",
    "SPI",
});

pub const GPIO = helper.sub_peripheral_enum(All, &.{"GPIO"}, null);
pub const USART = helper.sub_peripheral_enum(All, &.{"USART"}, null);

/// SPI1..SPI4. Driven through `spi.SpiRegs`, since SPI1/SPI4 and SPI2/SPI3
/// have different register blocks (the I2S registers); `to_reg` must not be
/// used on this enum.
pub const SPI = helper.sub_peripheral_enum_any_type(All, &.{"SPI"});

pub const to_reg = helper.to_reg;

pub inline fn to_peripheral(id: anytype) All {
    return switch (@TypeOf(id)) {
        All => id,
        else => @fromBackingInt(@backingInt(id)),
    };
}
