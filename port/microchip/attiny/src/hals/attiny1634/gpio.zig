const cpu = @import("microzig").cpu;
const regs = @import("registers.zig");

pub const Port = enum(u2) {
    a,
    b,
    c,

    pub const Regs = extern struct {
        PIN: u8,
        DDR: u8,
        PORT: u8,
        PUE: u8,
    };

    pub inline fn get_regs(port: Port) *volatile Regs {
        return switch (port) {
            .c => @ptrFromInt(regs.PINC),
            .b => @ptrFromInt(regs.PINB),
            .a => @ptrFromInt(regs.PINA),
        };
    }
};

pub const Direction = enum { input, output };

pub fn pin(port: Port, num: u3) Pin {
    return .{ .port = port, .num = num };
}

pub const Pin = packed struct(u5) {
    port: Port,
    num: u3,

    pub inline fn set_direction(p: Pin, dir: Direction) void {
        const dir_addr: *volatile u8 = &p.port.get_regs().DDR;
        switch (dir) {
            .input => cpu.cbi(@intFromPtr(dir_addr), p.num),
            .output => cpu.sbi(@intFromPtr(dir_addr), p.num),
        }
    }

    pub inline fn read(p: Pin) u1 {
        const pin_addr: *volatile u8 = &p.port.get_regs().PIN;
        return @truncate((pin_addr.* >> p.num) & 0x01);
    }

    pub inline fn put(p: Pin, value: u1) void {
        const port_addr: *volatile u8 = &p.port.get_regs().PORT;
        switch (value) {
            1 => cpu.sbi(@intFromPtr(port_addr), p.num),
            0 => cpu.cbi(@intFromPtr(port_addr), p.num),
        }
    }

    pub inline fn toggle(p: Pin) void {
        const pin_addr: *volatile u8 = &p.port.get_regs().PIN;
        cpu.sbi(@intFromPtr(pin_addr), p.num);
    }

    pub inline fn set_pullup(p: Pin, enabled: bool) void {
        const pue_addr: *volatile u8 = &p.port.get_regs().PUE;
        switch (enabled) {
            true => cpu.sbi(@intFromPtr(pue_addr), p.num),
            false => cpu.cbi(@intFromPtr(pue_addr), p.num),
        }
    }
};
