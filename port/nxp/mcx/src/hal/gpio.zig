const microzig = @import("microzig");
const syscon = @import("./syscon.zig");

const chip = microzig.chip;

pub fn init(comptime n: u2, comptime pin: u5) GPIO {
    return @enumFromInt(@as(u7, n) << 5 | pin);
}

pub const GPIO = enum(u7) {
    _,

    pub fn init(comptime gpio: GPIO) void {
        const tag = switch (gpio.get_n()) {
            0 => .GPIO0,
            1 => .GPIO1,
            2 => .GPIO2,
            3 => .GPIO3,
        };

        syscon.reset_release(tag);
        syscon.enable_clock(tag);
    }

    pub fn put(gpio: GPIO, output: u1) void {
        const registers = gpio.get_registers();
        const old: u32 = registers.PDOR.raw;
        const new = @as(u32, output) << gpio.get_pin();

        registers.PDOR.write_raw(old & ~gpio.get_mask() | new);
    }

    pub fn get(gpio: GPIO) bool {
        const registers = gpio.get_registers();

        return registers.PDIR.raw >> gpio.get_pin() & 1 != 0;
    }

    pub fn toggle(gpio: GPIO) void {
        const registers = gpio.get_registers();
        const old: u32 = registers.PTOR.raw;

        registers.PTOR.write_raw(old | gpio.get_mask());
    }

    pub fn set_direction(gpio: GPIO, direction: Direction) void {
        const registers = gpio.get_registers();
        const old: u32 = registers.PDDR.raw;
        const new = @as(u32, @intFromEnum(direction)) << gpio.get_pin();

        registers.PDDR.write_raw(old & ~gpio.get_mask() | new);
    }

    pub fn set_interrupt_config(gpio: GPIO, trigger: InterruptConfig) void {
        const registers = gpio.get_registers();
        const irqc = @as(u32, @intFromEnum(trigger)) << 16;
        const isf = @as(u32, 1) << 24;

        registers.ICR[gpio.get_pin()].write_raw(irqc | isf);
    }

    pub fn get_interrupt_flag(gpio: GPIO) bool {
        const registers = gpio.get_registers();

        return registers.ISFR0.raw >> gpio.get_pin() & 1 != 0;
    }

    pub fn clear_interrupt_flag(gpio: GPIO) void {
        const registers = gpio.get_registers();
        const old: u32 = registers.ISFR0.raw;

        registers.ISFR0.write_raw(old | gpio.get_mask());
    }

    fn get_registers(gpio: GPIO) *volatile chip.types.peripherals.GPIO0 {
        return switch (gpio.get_n()) {
            0 => chip.peripherals.GPIO0,
            1 => chip.peripherals.GPIO1,
            2 => chip.peripherals.GPIO2,
            3 => chip.peripherals.GPIO3,
        };
    }

    inline fn get_n(gpio: GPIO) u2 {
        return @intCast(@intFromEnum(gpio) >> 5);
    }

    inline fn get_pin(gpio: GPIO) u5 {
        return @intCast(@intFromEnum(gpio) & 0x1f);
    }

    inline fn get_mask(gpio: GPIO) u32 {
        return @as(u32, 1) << gpio.get_pin();
    }
};

const Direction = enum(u1) { in, out };

const InterruptConfig = enum(u4) {
    disabled = 0,
    dma_rising_edge = 1,
    dma_falling_edge = 2,
    dma_either_edge = 3,
    flag_rising_edge = 5,
    flag_falling_edge = 6,
    flag_either_edge = 7,
    interrupt_logic_zero = 8,
    interrupt_rising_edge = 9,
    interrupt_falling_edge = 10,
    interrupt_either_edge = 11,
    interrupt_logic_one = 12,
    active_high_trigger_output_enable = 13,
    active_low_trigger_output_enable = 14,
};
