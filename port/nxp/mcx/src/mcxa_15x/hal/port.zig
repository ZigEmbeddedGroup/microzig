const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const gpio = @import("./gpio.zig");
const mapper = @import("mapper.zig");

const PORT_T = microzig.chip.types.peripherals.PORT0;

pub const Drive_Strength = enum(u1) {
    low = 0,
    high = 1,
};

pub const slew_rate = enum(u1) {
    fast = 0,
    slow = 1,
};

pub const Pull_Select = enum(u1) {
    down = 0,
    up = 1,
};

pub const Pull_Value = enum(u1) {
    low = 0,
    high = 1,
};

pub const Pull_Resistor = struct {
    select: Pull_Select,
    //value: Pull_Value = .low, //TODO: fix MMIO register access to support this.
};

//TODO ADD ALL PIN CONFG
pub const PinConfig = struct {
    input_buffer_enabled: bool = true,
    invert_input: bool = false,
    drive_strength: Drive_Strength = .low,
    //drive_strength_1: Drive_Strength = .low, // TODO: fix MMIO register access to support this.
    open_drain: bool = false,
    passive_filter: bool = false,
    slew_rate: slew_rate = .fast,
    pull_resistor: ?Pull_Resistor = null,

    MUX: u3,
};

const PIN_T = @FieldType(microzig.chip.types.peripherals.PORT0, "PCR0");

pub fn num(comptime n: u2) Port {
    return @fromBackingInt(n);
}

pub const Port = enum(u3) {
    _,

    pub fn init(comptime port: Port) void {
        const tag = switch (@backingInt(port)) {
            0 => .PORT0,
            1 => .PORT1,
            2 => .PORT2,
            3 => .PORT3,
            4 => .PORT4,
            else => @panic("INVALID PORT"),
        };

        syscon.reset_release(tag);
        syscon.enable_clock(tag);
    }

    pub fn get_regs(self: Port) *volatile PORT_T {
        const val: u3 = @backingInt(self);

        if (val > 4) @panic("INVALID PORT");

        return switch (val) {
            0 => microzig.chip.peripherals.PORT0,
            1 => @ptrCast(microzig.chip.peripherals.PORT1),
            2 => @ptrCast(microzig.chip.peripherals.PORT2),
            3 => @ptrCast(microzig.chip.peripherals.PORT3),
            4 => @ptrCast(microzig.chip.peripherals.PORT4),
            else => unreachable,
        };
    }

    pub fn configure_pin(pin: mapper.PIN, config: PinConfig) void {
        const map = pin.map();
        const regs = get_regs(@fromBackingInt(@intCast(map.port)));
        const pin_regs: *volatile PIN_T = @ptrFromInt(@as(usize, @intFromPtr(regs)) + (0x80 + (4 * @as(usize, map.pin))));

        pin_regs.modify_one("LK", .lk0);
        defer pin_regs.modify_one("LK", .lk1);
        var pcr = pin_regs.read();
        if (config.pull_resistor) |pr| {
            pcr.PE = @fromBackingInt(1);
            pcr.PS = @fromBackingInt(@backingInt(pr.select));
        } else {
            pcr.PE = @fromBackingInt(0);
        }
        pcr.SRE = @fromBackingInt(@backingInt(config.slew_rate));
        pcr.ODE = @fromBackingInt(@intFromBool(config.open_drain));
        pcr.DSE = @fromBackingInt(@backingInt(config.drive_strength));
        pcr.MUX = @fromBackingInt(config.MUX);
        pcr.IBE = @fromBackingInt(@intFromBool(config.input_buffer_enabled));
        pcr.INV = @fromBackingInt(@intFromBool(config.invert_input));
        -pin_regs.write(pcr);
    }
};
