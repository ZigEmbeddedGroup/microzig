const std = @import("std");
const util = @import("util.zig");
const microzig = @import("microzig");

// Any peripheral that must be enable in RCC.
pub const Peripherals = util.create_peripheral_enum();

pub const UART_Type = util.sub_peripheral_enum(Peripherals, .{ "USART", "UART", "LPUART" }, null);
pub const I2C_Type = util.sub_peripheral_enum(Peripherals, .{"I2C"}, null);
pub const SPI_Type = util.sub_peripheral_enum(Peripherals, .{"SPI"}, null);
pub const DMA_Type = util.sub_peripheral_enum(Peripherals, .{"DMA"}, null);
pub const TIMGP16_Type = util.sub_peripheral_enum(Peripherals, .{"TIM"}, "TIM_GP16");
pub const ADC_Type = util.sub_peripheral_enum(Peripherals, .{"ADC"}, null);
pub const CAN_Type = util.sub_peripheral_enum(Peripherals, .{"CAN"}, null);
pub const SAL_Type = util.sub_peripheral_enum(Peripherals, .{"SAL"}, null);
pub const I2S_Type = util.sub_peripheral_enum(Peripherals, .{"I2S"}, null);

pub fn to_peripheral(comptime val: anytype) Peripherals {
    return switch (@TypeOf(val)) {
        UART_Type,
        I2C_Type,
        SPI_Type,
        DMA_Type,
        TIMGP16_Type,
        ADC_Type,
        CAN_Type,
        SAL_Type,
        I2S_Type,
        => @as(Peripherals, @enumFromInt(@intFromEnum(val))),
        else => @panic("Value must be one of the sur peripheral enum define below"),
    };
}

pub fn get_regs(comptime T: type, comptime val: anytype) *volatile T {
    const periph_enum = comptime to_peripheral(val);
    return @field(microzig.chip.peripherals, @tagName(periph_enum));
}

fn get_field_index(comptime T: type, comptime val: T) u32 {
    inline for (0.., @typeInfo(T).@"enum".fields) |i, field| {
        if (field.value == @intFromEnum(val)) {
            return i;
        }
    }
}

// This function is basically useless, it doesn't even give the number of the paripheral
pub fn base_perihperal_index(comptime val: anytype) u32 {
    return switch (@TypeOf(val)) {
        UART_Type => get_field_index(UART_Type, val),
        I2C_Type => get_field_index(I2C_Type, val),
        SPI_Type => get_field_index(I2C_Type, val),
        DMA_Type => get_field_index(I2C_Type, val),
        ADC_Type => get_field_index(I2C_Type, val),
        CAN_Type => get_field_index(I2C_Type, val),
        SAL_Type => get_field_index(I2C_Type, val),
        I2S_Type => get_field_index(I2C_Type, val),
        else => @panic("Index peripheral is only for multiple index peripherals"), // TODO: Whats against implementing this for all?
    };
}
