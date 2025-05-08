const std = @import("std");
const microzig = @import("microzig");
const CounterDevice = @import("drivers.zig").CounterDevice;
const create_peripheral_enum = @import("util.zig").create_peripheral_enum;

const periferals = microzig.chip.peripherals;

const TIM_GP16 = *volatile microzig.chip.types.peripherals.timer_v1.TIM_GP16;
const DIR = microzig.chip.types.peripherals.timer_v1.DIR;
const URS = microzig.chip.types.peripherals.timer_v1.URS;

pub const Instances = create_peripheral_enum("TIM", "TIM_GP16");
fn get_regs(instance: Instances) TIM_GP16 {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

pub const GPTimer = struct {
    regs: TIM_GP16,

    pub fn into_counter(self: *const GPTimer, pclk: u32) CounterDevice {
        const regs = self.regs;
        //clear timer configs end pending events
        regs.CR1.raw = 0;
        regs.CR2.raw = 0;
        regs.SR.raw = 0;

        //downcounter, one-pulse, UG UVE source disable
        regs.CR1.modify(.{
            .DIR = DIR.Down,
            .OPM = 1,
            .URS = URS.CounterOnly,
            .ARPE = 1,
        });

        return CounterDevice{
            .ns_per_tick = 1_000_000_000 / pclk,
            .us_psc = pclk / 1_000_000,
            .ms_psc = pclk / 1_000,
            .load_and_start = load_and_start,
            .check_event = check_event,
            .busy_wait_fn = busy_wait_fn,
            .ctx = self,
        };
    }

    fn load_and_start(ctx: *const anyopaque, psc: u32, arr: u16) void {
        const self: *const GPTimer = @alignCast(@ptrCast(ctx));
        const regs = self.regs;
        regs.CR1.modify(.{ .CEN = 0 });
        regs.SR.raw = 0;
        regs.PSC = psc;
        regs.ARR.modify(.{ .ARR = arr - 1 });
        regs.EGR.modify(.{ .UG = 1 });
        regs.CR1.modify(.{ .CEN = 1 });
    }

    fn check_event(ctx: *const anyopaque) bool {
        const self: *const GPTimer = @alignCast(@ptrCast(ctx));
        const regs = self.regs;
        return regs.SR.read().UIF == 1;
    }

    fn busy_wait_fn(ctx: *const anyopaque, time: u64) void {
        const self: *const GPTimer = @alignCast(@ptrCast(ctx));
        const regs = self.regs;
        const full_ticks: usize = @intCast(time / std.math.maxInt(u16));
        const partial_ticks: u16 = @intCast(time % std.math.maxInt(u16));

        //set initial counter to partial_ticks then wait for full_ticks
        //this will set timer to partial_ticks then after underflow the ARPE will automatically reload the timer
        //and start counting down from std.math.maxInt(u16) to 0
        regs.SR.raw = 0;
        regs.PSC = 0;
        regs.ARR.modify(.{ .ARR = partial_ticks });
        regs.EGR.modify(.{ .UG = 1 });
        regs.ARR.modify(.{ .ARR = std.math.maxInt(u16) });

        //start counting down
        regs.CR1.modify(.{ .CEN = 1 });

        //wait for all ticks to finish
        //we need to wait for full_ticks + 1 because the first tick is already started
        for (0..full_ticks + 1) |_| {
            //wait for underflow
            while (regs.SR.read().UIF == 0) {}
            //clear UIF flag
            regs.SR.raw = 0;
            //reenable timer (becuse we are in OPM mode)
            regs.CR1.modify(.{ .CEN = 1 });
        }
    }

    pub fn init(instance: Instances) GPTimer {
        return .{ .regs = get_regs(instance) };
    }
};
