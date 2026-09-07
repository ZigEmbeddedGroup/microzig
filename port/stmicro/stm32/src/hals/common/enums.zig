const util = @import("util.zig");
const microzig = @import("microzig");

// Any peripheral that must be enable in RCC.
pub const Peripherals = util.create_peripheral_enum();

pub const UART_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{ "USART", "UART", "LPUART" }, null);
pub const I2C_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"I2C"}, null);
pub const SPI_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"SPI"}, null);
pub const DMA_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"DMA"}, null);
pub const TIMGP16_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"TIM"}, "TIM_GP16");
pub const ADC_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"ADC"}, null);
pub const CAN_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"CAN"}, null);
pub const SAL_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"SAL"}, null);
pub const I2S_Type = util.sub_peripheral_enum(Peripherals, &[_][]const u8{"I2S"}, null);

fn is_peripheral(comptime val: anytype) bool {
    inline for ([_]type{ UART_Type, I2C_Type, SPI_Type, DMA_Type, TIMGP16_Type, ADC_Type, CAN_Type, SAL_Type, I2S_Type }) |T| {
        if (@TypeOf(val) == T) {
            return true;
        }
    }
    return false;
}

pub fn to_peripheral(comptime val: anytype) Peripherals {
    if (is_peripheral(val)) {
        return @as(Peripherals, @fromBackingInt(@backingInt(val)));
    }
    @panic("Value must be one of the sur peripheral enum define below");
}

pub fn get_regs(comptime T: type, comptime val: anytype) *volatile T {
    const periph_enum = comptime to_peripheral(val);
    return @field(microzig.chip.peripherals, @tagName(periph_enum));
}

fn is_sub_peripheral(comptime val: anytype) bool {
    inline for ([_]type{ UART_Type, I2C_Type, SPI_Type, DMA_Type, ADC_Type, CAN_Type, SAL_Type, I2S_Type }) |T| {
        if (@TypeOf(val) == T) {
            return true;
        }
    }
    return false;
}

fn get_field_index(comptime T: type, comptime val: T) u32 {
    inline for (0.., @typeInfo(T).@"enum".field_values) |i, value| {
        if (value == @backingInt(val)) {
            return i;
        }
    }
}

// This function is basically useless, it doesn't even give the number of the paripheral
pub fn base_perihperal_index(comptime val: anytype) u32 {
    if (is_sub_peripheral(val)) {
        return get_field_index(@TypeOf(val), val);
    }
    @panic("Index peripheral is only for multiple index peripherals"); // TODO: Whats against implementing this for all?
}
