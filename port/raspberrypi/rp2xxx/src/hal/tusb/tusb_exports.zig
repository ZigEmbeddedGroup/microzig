const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const peripherals = microzig.chip.peripherals;

var charbuf: [128]u8 = undefined;
var char_index: usize = 0;
const tusb_logger = std.log.scoped(.tusb);

export fn _putchar(char: u8) void {
    if (char_index < charbuf.len and char != '\n') {
        if (char == '\r') {
            return;
        }
        charbuf[char_index] = char;
        char_index += 1;
    } else {
        tusb_logger.debug("{s}", .{charbuf[0..char_index]});
        char_index = 0;
    }
}

// TODO: not sure why this is needed or if it's really right but seems to work.
export const _ctype_: u8 = undefined;

export fn panic(format: [*c]const u8, ...) void {
    const z_str: []const u8 = std.mem.span(format);
    std.log.info("{s}", .{std.mem.trim(u8, z_str, "\n\n")});
}

export fn strlen(str: [*c]const u8) c_uint {
    return std.mem.len(str);
}
export fn tusb_time_millis_api() c_uint {
    return @truncate(time.get_time_since_boot().to_us() * 1000);
}

export fn rp2040_chip_version() c_uint {
    const chip_id = peripherals.SYSINFO.CHIP_ID.read();
    // TODO: should be able to switch to clear API?
    return @intCast(chip_id.REVISION);
}

pub fn irq_handler() linksection(".ram_text") callconv(.c) void {
    if (handler_p) |h|
        h();
}

//void irq_add_shared_handler(uint num, irq_handler_t handler, uint8_t order_priority);
const hdlr = *const fn () callconv(.c) void;

var handler_p: ?hdlr = null;

export fn irq_add_shared_handler(num: c_uint, handler: hdlr, order_priority: u8) callconv(.c) void {
    _ = num;
    handler_p = handler;
    _ = order_priority;
}

// void irq_remove_handler(uint num, irq_handler_t handler);
export fn irq_remove_handler(num: c_uint, handler: hdlr) void {
    _ = num;
    _ = handler;
    handler_p = null;
}

//void irq_set_enabled(uint num, bool enabled);
export fn irq_set_enabled(num: c_uint, enabled: bool) void {
    _ = num; // TODO: Num should represent .usbctrl_irq
    if (enabled) {
        microzig.interrupt.enable(.USBCTRL_IRQ);
    } else {
        microzig.interrupt.disable(.USBCTRL_IRQ);
    }
}

// void __weak hard_assertion_failure(void) {
export fn hard_assertion_failure() void {
    std.log.err("Probably hw_endpoint_alloc failed", .{});
    @panic("TUSB: Hard assertion Failed!");
}
