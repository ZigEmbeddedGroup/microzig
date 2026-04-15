const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const chip = microzig.chip;

pub const GPIO = enum(u8) {
    _,

    /// Get a GPIO pin. Does not check whether the pin is available.
    // TODO: check unavailable pins
    pub fn num(comptime n: u3, comptime pin: u5) GPIO {
        return @enumFromInt(@as(u8, n) << 5 | pin);
    }

    /// Init the GPIO by releasing an eventual reset and enabling its clock.
    pub fn init(gpio: GPIO) void {
        const module = gpio.get_module();

        syscon.module_reset_release(module);
        syscon.module_enable_clock(module);
    }

    /// Deinit the GPIO by disabling its clock and asserting its reset.
    pub fn deinit(gpio: GPIO) void {
        const module = gpio.get_module();

        syscon.module_disable_clock(module);
        syscon.module_reset_assert(module);
    }

    /// Sets the logical output of the GPIO.
    pub fn put(gpio: GPIO, output: u1) void {
        const regs = gpio.get_regs();

        const new: u32 = @as(u32, 1) << gpio.get_pin();
        if (output == 1)
            regs.PSOR.write_raw(new)
        else
            regs.PCOR.write_raw(new);
    }

    /// Returns the logical input of the GPIO.
    pub fn get(gpio: GPIO) bool {
        const regs = gpio.get_regs();

        return regs.PDIR.raw >> gpio.get_pin() & 1 != 0;
    }

    /// Toggles the logical output of the GPIO.
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

    /// Returns the gpio's control register
    fn get_regs(gpio: GPIO) *volatile chip.types.peripherals.GPIO0 {
        const base: u32 = @intFromPtr(chip.peripherals.GPIO0);

        return switch (gpio.get_n()) {
            0...4 => |i| @ptrFromInt(base + i * @as(u32, 0x2000)),
            5 => @ptrCast(chip.peripherals.GPIO5), // GPIO5 has a different address
            else => unreachable,
        };
    }

    fn get_n(gpio: GPIO) u3 {
        return @intCast(@intFromEnum(gpio) >> 5);
    }

    fn get_pin(gpio: GPIO) u5 {
        return @intCast(@intFromEnum(gpio) & 0x1f);
    }

    fn get_mask(gpio: GPIO) u32 {
        return @as(u32, 1) << gpio.get_pin();
    }

    fn get_module(gpio: GPIO) syscon.Module {
        return @enumFromInt(@intFromEnum(syscon.Module.GPIO0) + gpio.get_n());
    }
};

const Direction = enum(u1) { in, out };
