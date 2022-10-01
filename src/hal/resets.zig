const std = @import("std");
const microzig = @import("microzig");

const regs = microzig.chip.registers;
const EnumField = std.builtin.Type.EnumField;
const Mask = @typeInfo(@TypeOf(regs.RESETS.RESET)).Pointer.child.underlying_type;

pub const Module = enum {
    adc,
    busctrl,
    dma,
    i2c0,
    i2c1,
    io_bank0,
    io_qspi,
    jtag,
    pads_bank0,
    pads_qspi,
    pio0,
    pio1,
    pll_sys,
    pll_usb,
    pwm,
    rtc,
    spi0,
    spi1,
    syscfg,
    sysinfo,
    tbman,
    timer,
    uart0,
    uart1,
    usbctrl,
};

pub inline fn reset(comptime modules: []const Module) void {
    comptime var mask = std.mem.zeroes(Mask);

    inline for (modules) |module|
        @field(mask, @tagName(module)) = 1;

    const raw_mask = @bitCast(u32, mask);

    // std.log.info("resets done before: {X:0>8} ", .{regs.RESETS.RESET_DONE.raw});

    // std.log.info("reset on", .{});
    regs.RESETS.RESET.raw = raw_mask;
    // std.log.info("=> {X:0>8}\n", .{regs.RESETS.RESET.raw});
    // std.log.info("reset off", .{});
    asm volatile ("nop" ::: "memory"); // delay at least a bit
    regs.RESETS.RESET.raw = 0;
    // std.log.info("=> {X:0>8}\n", .{regs.RESETS.RESET.raw});

    // std.log.info("reset wait", .{});

    var last: u32 = 0;
    while (true) {
        const raw = regs.RESETS.RESET_DONE.raw;
        if (last != raw) {
            // std.log.info("raw: {X:0>8} {X:0>8}", .{ raw, raw & raw_mask });
            last = raw;
        }
        if ((raw & raw_mask) == raw_mask)
            break;
        asm volatile ("" ::: "memory");
    }

    // std.log.info("resets done after: {X:0>8}", .{regs.RESETS.RESET_DONE.raw});

    // std.log.info("reset done", .{});
}
