const std = @import("std");
const registers = @import("registers.zig");

const reset_mapper = struct {
    const gpio_: struct { pads_bank0: u1 = 0, io_bank0: u1 = 0 } = .{};

    const uart0_: struct { uart0: u1 = 0 } = .{};
    const uart1_: struct { uart1: u1 = 0 } = .{};

    const spi0_: struct { spi0: u1 = 0 } = .{};
    const spi1_: struct { spi1: u1 = 0 } = .{};

    const pll_sys_: struct { pll_sys: u1 = 0 } = .{};
    const pll_usb_: struct { pll_usb: u1 = 0 } = .{};
};

pub fn reset(comptime peripherals: anytype) void {
    //TODO: reset all peripherals at once
    inline for (peripherals) |peiph| {
        const reset_struct = @field(reset_mapper, @tagName(peiph) ++ "_");
        const reset_struct_set = comptime returnStructWithFieldsSetToValue(reset_struct, 1);

        registers.RESETS.RESET.modify(reset_struct_set);
        registers.RESETS.RESET.modify(reset_struct);

        while (true) {
            const v = registers.RESETS.RESET_DONE.read();
            if (compareStruct(reset_struct_set, v))
                break;
        }
    }
}

fn returnStructWithFieldsSetToValue(comptime s: anytype, comptime value: anytype) @TypeOf(s) {
    var temp = s;
    inline for (std.meta.fieldNames(@TypeOf(s))) |field_name| {
        @field(temp, field_name) = value;
    }
    return temp;
}

fn compareStruct(comptime reset_struct: anytype, reset_done: anytype) bool {
    inline for (comptime std.meta.fieldNames(@TypeOf(reset_struct))) |field_name| {
        if (@field(reset_struct, field_name) != @field(reset_done, field_name))
            return false;
    }

    return true;
}
