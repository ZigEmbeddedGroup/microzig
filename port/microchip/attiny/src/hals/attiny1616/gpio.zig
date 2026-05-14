const regs = @import("registers.zig");

pub const Port = enum(u2) {
    a,
    b,
    c,
};

pub const Direction = enum {
    input,
    output,
};

pub const Sense = enum(u3) {
    interrupt_disabled = 0x0,
    both_edges = 0x1,
    rising = 0x2,
    falling = 0x3,
    input_disable = 0x4,
    level = 0x5,
};

pub const Pin = packed struct(u5) {
    index: u3,
    port: Port,

    pub fn init(comptime port: Port, comptime index: u3) Pin {
        return .{ .port = port, .index = index };
    }

    pub inline fn set_direction(p: Pin, direction: Direction) void {
        gpio.set_direction(p, direction);
    }

    pub inline fn read(p: Pin) bool {
        return gpio.read(p);
    }

    pub inline fn put(p: Pin, value: bool) void {
        gpio.put(p, value);
    }

    pub inline fn toggle(p: Pin) void {
        gpio.toggle(p);
    }
};

const gpio = @This();

pub fn pin(comptime port: Port, comptime index: u3) Pin {
    return Pin.init(port, index);
}

const PortRegisters = struct {
    vdir: u16,
    vout: u16,
    vin: u16,
    vintflags: u16,
    pinctrl: u16,
};

fn portRegisters(port: Port) PortRegisters {
    return switch (port) {
        .a => .{ .vdir = regs.vporta_dir, .vout = regs.vporta_out, .vin = regs.vporta_in, .vintflags = regs.vporta_intflags, .pinctrl = regs.porta_pinctrl },
        .b => .{ .vdir = regs.vportb_dir, .vout = regs.vportb_out, .vin = regs.vportb_in, .vintflags = regs.vportb_intflags, .pinctrl = regs.portb_pinctrl },
        .c => .{ .vdir = regs.vportc_dir, .vout = regs.vportc_out, .vin = regs.vportc_in, .vintflags = regs.vportc_intflags, .pinctrl = regs.portc_pinctrl },
    };
}

pub inline fn mask(gpio_pin: Pin) u8 {
    return regs.bit(gpio_pin.index);
}

pub fn set_direction(gpio_pin: Pin, direction: Direction) void {
    const r = portRegisters(gpio_pin.port);
    switch (direction) {
        .input => regs.clearBits(r.vdir, mask(gpio_pin)),
        .output => regs.setBits(r.vdir, mask(gpio_pin)),
    }
}

pub fn read(gpio_pin: Pin) bool {
    return (regs.read(portRegisters(gpio_pin.port).vin) & mask(gpio_pin)) != 0;
}

pub fn put(gpio_pin: Pin, value: bool) void {
    const r = portRegisters(gpio_pin.port);
    if (value) {
        regs.setBits(r.vout, mask(gpio_pin));
    } else {
        regs.clearBits(r.vout, mask(gpio_pin));
    }
}

pub fn toggle(gpio_pin: Pin) void {
    regs.write(portRegisters(gpio_pin.port).vout, regs.read(portRegisters(gpio_pin.port).vout) ^ mask(gpio_pin));
}

pub fn configure_input(gpio_pin: Pin, pullup: bool, sense: Sense) void {
    // ATtiny1614/1616/1617 DS40002204A section 16.3.3.1, page 134:
    // PORT PINnCTRL selects the per-pin input/sense mode used for pin interrupts.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny1614-16-17-DataSheet-DS40002204A.pdf
    set_direction(gpio_pin, .input);
    var value: u8 = @intFromEnum(sense);
    if (pullup) value |= regs.bit(regs.port_bits.pullupen);
    regs.write(portRegisters(gpio_pin.port).pinctrl + gpio_pin.index, value);
}

pub fn clearInterrupt(gpio_pin: Pin) void {
    regs.write(portRegisters(gpio_pin.port).vintflags, mask(gpio_pin));
}
