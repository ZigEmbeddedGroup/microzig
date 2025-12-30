const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const chip = microzig.chip;

pub const GPIO = enum(u8) {
    _,

	pub fn num(comptime n: u3, comptime pin: u5) GPIO {
		// TODO: check unavailable pins
		return @enumFromInt(@as(u8, n) << 5 | pin);
	}

    pub fn init(comptime gpio: GPIO) void {
        const tag = switch (gpio.get_n()) {
            0 => .GPIO0,
            1 => .GPIO1,
            2 => .GPIO2,
            3 => .GPIO3,
            4 => .GPIO4,
            // 5 => .GPIO5,
            else => unreachable
        };

        syscon.peripheral_reset_release(tag);
        syscon.module_enable_clock(tag);
    }

    pub fn put(gpio: GPIO, output: u1) void {
        const regs = gpio.get_regs();

        const new: u32 = @as(u32, 1) << gpio.get_pin();
        if(output == 1)
            regs.PSOR.write_raw(new)
        else 
            regs.PCOR.write_raw(new);
    }

    pub fn get(gpio: GPIO) bool {
        const regs = gpio.get_regs();

        return regs.PDIR.raw >> gpio.get_pin() & 1 != 0;
    }

    pub fn toggle(gpio: GPIO) void {
        const regs = gpio.get_regs();

        regs.PTOR.write_raw(gpio.get_mask());
    }

    pub fn set_direction(gpio: GPIO, direction: Direction) void {
        const regs = gpio.get_regs();
        const old: u32 = regs.PDDR.raw;
        const new = @as(u32, @intFromEnum(direction)) << gpio.get_pin();

        regs.PDDR.write_raw((old & ~gpio.get_mask()) | new);
    }

	// TODO: check
    pub fn set_interrupt_config(gpio: GPIO, trigger: InterruptConfig) void {
        const regs = gpio.get_regs();
        const irqc = @as(u32, @intFromEnum(trigger)) << 16;
        const isf = @as(u32, 1) << 24;

        regs.ICR[gpio.get_pin()].write_raw(irqc | isf);
    }

	// TODO: check
    pub fn get_interrupt_flag(gpio: GPIO) bool {
        const regs = gpio.get_regs();

        return regs.ISFR0.raw >> gpio.get_pin() & 1 != 0;
    }

	// TODO: check
    pub fn clear_interrupt_flag(gpio: GPIO) void {
        const regs = gpio.get_regs();
        const old: u32 = regs.ISFR0.raw;

        regs.ISFR0.write_raw(old | gpio.get_mask());
    }

    fn get_regs(gpio: GPIO) *volatile chip.types.peripherals.GPIO0 {
		const base: u32 = @intFromPtr(chip.peripherals.GPIO0);
        return switch (gpio.get_n()) {
            0...5 => |i| @ptrFromInt(base + i * @as(u32, 0x2000)),
            else => unreachable
        };
    }

    inline fn get_n(gpio: GPIO) u3 {
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
