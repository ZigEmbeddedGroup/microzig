const std = @import("std");
const microzig = @import("microzig");
const periferals = microzig.chip.peripherals;
const CounterDevice = microzig.hal.driver.CounterDevice;

const TIM_GP16 = *volatile microzig.chip.types.peripherals.timer_v1.TIM_GP16;
const DIR = microzig.chip.types.peripherals.timer_v1.DIR;
const URS = microzig.chip.types.peripherals.timer_v1.URS;

pub const CounterConfig = struct {
    pclk: u32,
    max_resolution: bool = false,
};

pub const GPTimer = enum {
    //TIM1 is a advanced timer
    TIM2,
    TIM3,
    TIM4,
    TIM5,
    //TIM 6 and 7 are basic timers
    //TIM 8 is a advanced timer

    //XL-density devices only.
    TIM9,
    TIM10,
    TIM11,
    TIM12,
    TIM13,
    TIM14,

    fn get_regs(self: GPTimer) TIM_GP16 {
        switch (self) {
            .TIM2 => if (@hasDecl(periferals, "TIM2")) return periferals.TIM2 else @panic("TIM2 not available"),
            .TIM3 => if (@hasDecl(periferals, "TIM3")) return periferals.TIM3 else @panic("TIM3 not available"),
            .TIM4 => if (@hasDecl(periferals, "TIM4")) return periferals.TIM4 else @panic("TIM4 not available"),
            .TIM5 => if (@hasDecl(periferals, "TIM5")) return periferals.TIM5 else @panic("TIM5 not available"),
            .TIM9 => if (@hasDecl(periferals, "TIM9")) return periferals.TIM9 else @panic("TIM9 not available"),
            .TIM10 => if (@hasDecl(periferals, "TIM10")) return periferals.TIM10 else @panic("TIM10 not available"),
            .TIM11 => if (@hasDecl(periferals, "TIM11")) return periferals.TIM11 else @panic("TIM11 not available"),
            .TIM12 => if (@hasDecl(periferals, "TIM12")) return periferals.TIM12 else @panic("TIM12 not available"),
            .TIM13 => if (@hasDecl(periferals, "TIM13")) return periferals.TIM13 else @panic("TIM13 not available"),
            .TIM14 => if (@hasDecl(periferals, "TIM14")) return periferals.TIM14 else @panic("TIM14 not available"),
        }
    }

    pub fn into_counter(self: *const GPTimer, config: CounterConfig) CounterDevice {
        const regs = self.get_regs();

        const ns_per_tick: u32 = if (config.max_resolution) 1_000_000_000 / config.pclk else 1000; //set 1uS per tick by default

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
        regs.PSC = if (config.max_resolution) 0 else (config.pclk / 1_000_000) - 1;

        return CounterDevice{
            .ticks_per_ns = ns_per_tick,
            .busy_wait_fn = busy_wait_fn,
            .ctx = self,
        };
    }

    fn busy_wait_fn(ctx: ?*const anyopaque, time: u64) void {
        const timer: *const GPTimer = @ptrCast(ctx);
        const regs = timer.get_regs();
        const full_ticks: usize = @intCast(time / std.math.maxInt(u16));
        const partial_ticks: u16 = @intCast(time % std.math.maxInt(u16));

        //set initial counter to partial_ticks then wait for full_ticks
        //this will set timer to partial_ticks then after underflow the ARPE will automatically reload the timer
        //and start counting down from std.math.maxInt(u16) to 0
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
};
