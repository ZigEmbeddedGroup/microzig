const cpu = @import("microzig").cpu;
const regs = @import("registers.zig");

pub const Port = enum(u1) {
    b = 0,

    pub const Regs = extern struct {
        /// Port Input Pins.
        PIN: u8,
        /// Port Data Direction Register.
        DDR: u8,
        /// Port Data Register.
        PORT: u8,
    };

    // ATtiny25/45/85 datasheet section 10.4, page 63: PINB/DDRB/PORTB are
    // I/O-space registers, so constant pins can use SBI/CBI.
    // https://ww1.microchip.com/downloads/en/devicedoc/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf
    pub inline fn get_regs(port: Port) *volatile Regs {
        return switch (port) {
            .b => @ptrFromInt(regs.PINB),
        };
    }
};

pub const Direction = enum {
    input,
    output,
};

pub fn pin(port: Port, num: u3) Pin {
    return .{ .port = port, .num = num };
}

pub const Pin = packed struct(u4) {
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
        p.put(@intFromBool(enabled));
    }
};
