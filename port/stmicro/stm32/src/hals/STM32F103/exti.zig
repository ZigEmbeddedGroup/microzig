//External Interrupts and Events for STM32F1xx
//This module provides basic functions to configure and manage external interrupts and events

const microzig = @import("microzig");
const gpio = @import("gpio.zig");
const AFIO = microzig.chip.peripherals.AFIO;
const EXTI = microzig.chip.peripherals.EXTI;

pub const TriggerEdge = enum {
    None,
    rising,
    falling,
    both,
};

pub const pendingLine = packed struct(u20) {
    line_0: u1 = 0,
    line_1: u1 = 0,
    line_2: u1 = 0,
    line_3: u1 = 0,
    line_4: u1 = 0,
    line_5: u1 = 0,
    line_6: u1 = 0,
    line_7: u1 = 0,
    line_8: u1 = 0,
    line_9: u1 = 0,
    line_10: u1 = 0,
    line_11: u1 = 0,
    line_12: u1 = 0,
    line_13: u1 = 0,
    line_14: u1 = 0,
    line_15: u1 = 0,
    line_16: u1 = 0,
    line_17: u1 = 0,
    line_18: u1 = 0,
    line_19: u1 = 0,
};

pub const Config = struct {
    line: u5,
    port: ?gpio.Port, //not used in line >= 16
    trigger: TriggerEdge = .None,

    // Interrupts and events can be configured manually at any time
    // these fields only define if they should be enabled immediately
    interrupt: bool = false,
    event: bool = false,
};

pub fn apply_line(config: Config) void {
    const line = config.line;
    if (line <= 15) {
        set_line(@intCast(line), config.port orelse @panic("line >= 16 requires a port"));
    }
    set_line_edge(line, config.trigger);
    set_event(line, config.event);
    set_interrupt(line, config.interrupt);
}

pub fn set_line(line: u4, port: gpio.Port) void {
    const reg_idx: usize = line / 4;
    const shift = (@as(u5, line) % 4) * 4;
    const port_sel: u32 = @intFromEnum(port);

    AFIO.EXTICR[reg_idx].raw &= ~(@as(u32, 0xF) << shift); //clear the current value
    AFIO.EXTICR[reg_idx].raw |= (port_sel << shift); //set the port value
}

pub fn set_line_edge(line: u5, edge: TriggerEdge) void {
    switch (edge) {
        .None => {
            EXTI.RTSR.raw &= ~(@as(u32, 1) << line);
            EXTI.FTSR.raw &= ~(@as(u32, 1) << line);
        },
        .rising => {
            EXTI.RTSR.raw |= (@as(u32, 1) << line);
            EXTI.FTSR.raw &= ~(@as(u32, 1) << line);
        },
        .falling => {
            EXTI.RTSR.raw &= ~(@as(u32, 1) << line);
            EXTI.FTSR.raw |= (@as(u32, 1) << line);
        },
        .both => {
            EXTI.RTSR.raw |= (@as(u32, 1) << line);
            EXTI.FTSR.raw |= (@as(u32, 1) << line);
        },
    }
}

pub fn set_event(line: u5, enable: bool) void {
    if (enable) {
        EXTI.EMR.raw |= (@as(u32, 1) << line);
    } else {
        EXTI.EMR.raw &= ~(@as(u32, 1) << line);
    }
}

pub fn set_interrupt(line: u5, enable: bool) void {
    if (enable) {
        EXTI.IMR.raw |= (@as(u32, 1) << line);
    } else {
        EXTI.IMR.raw &= ~(@as(u32, 1) << line);
    }
}

///force a software trigger on the given line
/// this trigger is cleared by `clear_pending()`
pub inline fn software_trigger(line: u5) void {
    EXTI.SWIER.raw |= (@as(u32, 1) << line);
}

///check for pending lines (for both events and interrupts)
pub inline fn pending() pendingLine {
    return @bitCast(@as(u20, @intCast(EXTI.PR.raw)));
}
///clears all pending lines returned by: `pending()`.
pub inline fn clear_pending(pendings: pendingLine) void {
    EXTI.PR.raw = @as(u20, @bitCast(pendings));
}
