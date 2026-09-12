const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

const GPIOA = peripherals.GPIOA;
const GPIOB = peripherals.GPIOB;
const GPIOC = peripherals.GPIOC;
const GPIOD = peripherals.GPIOD;
const GPIOE = peripherals.GPIOE;
const GPIOF = peripherals.GPIOF;

pub const Port = enum {
    A,
    B,
    C,
    D,
    E,
    F,

    pub fn to_mem(self: @This()) @TypeOf(GPIOA) {
        return switch (self) {
            .A => GPIOA,
            .B => GPIOB,
            .C => GPIOC,
            .D => GPIOD,
            .E => GPIOE,
            .F => GPIOF,
        };
    }
};

// pub inline fn

pub inline fn write(port: Port, pin: u4, level: u1) void {
    const mem = port.to_mem();

    if (level == 1) {
        mem.BSHR.raw = @as(u32, 1) << pin;
    } else {
        mem.BCR.raw = @as(u32, 1) << pin;
    }
}
