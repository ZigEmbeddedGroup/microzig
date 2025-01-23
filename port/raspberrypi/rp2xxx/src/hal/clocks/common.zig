const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const CLOCKS = peripherals.CLOCKS;
const XOSC = peripherals.XOSC;

/// The current HAL requires XOSC configuration with the RP2xxx chip, although this isn't
/// strictly neccessary as the system could be driven from an external clock.
/// TODO: Find a way to allow this to be "null" as it's not explicitly required as long
///       as a user isn't using XOSC functionality in their clock setup.
pub const xosc_freq = microzig.board.xosc_freq;

/// Nominal value of built-in relaxation oscillator, very imprecise and prone to drift over time
pub const rosc_freq = 6_500_000;

pub const xosc = struct {
    const startup_delay_ms = 1;

    const startup_delay_value = xosc_freq * startup_delay_ms / 1000 / 256;
    comptime {
        assert(startup_delay_value < (1 << 13));
    }
    pub fn init() void {
        if (xosc_freq <= 15_000_000 and xosc_freq >= 1_000_000) {
            XOSC.CTRL.modify(.{ .FREQ_RANGE = .@"1_15MHZ" });
        } else if (xosc_freq <= 30_000_000 and xosc_freq >= 10_000_000) {
            XOSC.CTRL.modify(.{ .FREQ_RANGE = .@"10_30MHZ" });
        } else if (xosc_freq <= 60_000_000 and xosc_freq >= 25_000_000) {
            XOSC.CTRL.modify(.{ .FREQ_RANGE = .@"25_60MHZ" });
        } else if (xosc_freq <= 100_000_000 and xosc_freq >= 40_000_000) {
            XOSC.CTRL.modify(.{ .FREQ_RANGE = .@"40_100MHZ" });
        } else {
            unreachable;
        }

        XOSC.STARTUP.modify(.{ .DELAY = startup_delay_value });
        XOSC.CTRL.modify(.{ .ENABLE = .ENABLE });

        // wait for xosc startup to complete:
        while (XOSC.STATUS.read().STABLE == 0) {}
    }

    pub fn wait_cycles(value: u8) void {
        assert(is_enabled: {
            const status = XOSC.STATUS.read();
            break :is_enabled status.STABLE != 0 and status.ENABLED != 0;
        });

        XOSC.COUNT.modify(value);
        while (XOSC.COUNT.read() != 0) {}
    }
};

/// Defines a clock generator's desired output frequency given an input source +
/// input frequency
pub fn GeneratorConfig(Source: type, IntegerDivisorType: type) type {
    return struct {
        input: struct {
            source: Source,
            freq: u32,
        },
        /// TODO: Currently we don't support non-integer division to avoid any
        ///       headaches with clock jitter.
        integer_divisor: IntegerDivisorType,

        pub fn frequency(cfg: @This()) u32 {
            return cfg.input.freq / cfg.integer_divisor;
        }
    };
}

/// Integer value to write to the glitchless SRC register to select the "AUX_SRC" source
pub const AUX_SRC_SETTING_SRC_REG = 1;

/// Common implementation for clock generator methods, independent of the
/// clock generator/source enum fields which differ between chips.
///
/// Note here that a single type handles all the clock generators, despite each
/// individual generator having *slightly* different settings and configuration
/// options. This is primarily in the interest of reducing code size, and leads
/// to lots of checks and asserts that fortunately all take place at
/// comptime.
pub fn GeneratorImpl(Generator: type, Source: type, IntegerDivisorType: type) type {
    return struct {

        // We can pretend the Generators are a homogenous array of
        // register clusters for the sake of smaller codegen. Special
        // care needs to be taken when writing these values to account
        // for different bitfield patterns!
        pub const Regs = extern struct {
            ctrl: u32,
            div: u32,
            selected: u32,
        };

        comptime {
            assert(12 == @sizeOf(Regs));
            assert(24 == @sizeOf([2]Regs));
        }

        const generators = @as(*volatile [@typeInfo(Generator).@"enum".fields.len]Regs, @ptrCast(CLOCKS));

        const CTRL_ENABLE_MASK = @as(u32, 1 << 11);
        const CTRL_SRC_MASK = @as(u32, 0x3);
        const CTRL_AUX_SRC_MASK = @as(u32, 0x1e0);

        pub fn get_regs(generator: Generator) *volatile Regs {
            return &generators[@intFromEnum(generator)];
        }

        pub fn has_glitchless_mux(generator: Generator) bool {
            return switch (generator) {
                .sys, .ref => true,
                else => false,
            };
        }

        pub fn enable(comptime generator: Generator) void {
            switch (generator) {
                .sys, .ref => {
                    @compileError("Can't enable/disable sys or ref clocks");
                },
                else => generator.get_regs().ctrl |= CTRL_ENABLE_MASK,
            }
        }

        // The bitfields for the *_SELECTED registers are actually a mask of which
        // source is selected. While switching sources it may read as 0, and that's
        // what this function is indended for: checking if the new source has
        // switched over yet.
        //
        // Some mention that this is only for the glitchless mux, so if it is non-glitchless then return true
        pub fn selected(comptime generator: Generator) bool {
            comptime assert(generator.has_glitchless_mux());
            return (0 != generator.get_regs().selected);
        }

        // Clears out the glitchless mux SRC register to 0, to ensure
        // SRC_AUX is not selected as the SRC.
        pub fn clear_source(generator: Generator) void {
            generator.get_regs().ctrl &= ~CTRL_SRC_MASK;
        }

        pub fn disable(comptime generator: Generator) void {
            switch (generator) {
                .sys, .ref => {
                    @compileError("Can't disable sys or ref clocks");
                },
                else => generator.get_regs().ctrl &= ~@as(u32, CTRL_ENABLE_MASK),
            }
        }

        pub fn set_source(comptime generator: Generator, comptime source: Source) void {
            comptime assert(generator.has_glitchless_mux());
            const gen_regs = generator.get_regs();
            const ctrl_value = gen_regs.ctrl;
            gen_regs.ctrl = (ctrl_value & ~CTRL_SRC_MASK) | (comptime source.src_for(generator));
        }

        pub fn set_aux_source(comptime generator: Generator, comptime source: Source) void {
            const gen_regs = generator.get_regs();
            const ctrl_value = gen_regs.ctrl;
            gen_regs.ctrl = (ctrl_value & ~CTRL_AUX_SRC_MASK) | (comptime source.aux_src_for(generator) << 5);
        }

        /// Configures a clock generator with setting validation.
        ///
        /// clk_sys frequency is required to be known for purposes of waiting for disable/enable
        /// to occur when switching non-glitchless sources.
        pub fn apply(comptime generator: Generator, comptime config: GeneratorConfig(Source, IntegerDivisorType), comptime sys_frequency: u32) void {
            const input = config.input;

            // Annoyingly RP2040 and RP2350 have different integer divisor bit positions, so
            // so do some checking to prevent bad footguns.
            comptime {
                assert(@bitSizeOf(u32) > @bitSizeOf(IntegerDivisorType));
                assert(@bitSizeOf(IntegerDivisorType) % 8 == 0);
            }
            const bitshift_amt = @bitSizeOf(u32) - @bitSizeOf(IntegerDivisorType);

            // TODO: Currently leave all fractional bits 0 to only support integer divisors
            const div: u32 = @as(u32, @intCast(config.integer_divisor)) << bitshift_amt;
            if (div > generator.get_div())
                generator.set_div(div);

            // Different types of switching (glitchless SRC switching vs glitch prone SRC_AUX switching) require different treatment
            const scenario: enum { GlitchlessWithAux, Glitchless, Standard } =
                comptime if (generator.has_glitchless_mux() and input.source.is_aux_src_for(generator)) .GlitchlessWithAux else if (generator.has_glitchless_mux()) .Glitchless else .Standard;

            switch (scenario) {
                .GlitchlessWithAux => {
                    // Ensure glitchless mux is switched away from AUX input
                    generator.clear_source();
                    while (!generator.selected()) {}

                    // Change AUX now that it isn't actively used by glitchless mux
                    generator.set_aux_source(input.source);

                    // Switch glitchless MUX to AUX
                    generator.set_source(input.source);
                    while (!generator.selected()) {}
                },
                .Glitchless => {
                    // If we're just changing the glitchless MUX to a non "AUX" input,
                    // it's as simple as changing + waiting for it to complete.
                    generator.set_source(input.source);
                    while (!generator.selected()) {}
                },
                .Standard => {
                    generator.disable();
                    // This CPU delay cycle count is taken directly from the datasheet.
                    // It's ugly, but per the datasheet this is the only way to gaurantee
                    // waiting long enough for the clock to be disabled properly.
                    // Switching the AUX on an active clock before it's fully disabled can lead to
                    // undefined behavior since clock glitches would propagate to the peripheral
                    // that is using the clock.
                    const delay_cycles: u32 = sys_frequency / config.frequency() + 1;

                    // From the pico SDK, spin waits for at LEAST delay_cycles amount of
                    // system clocks.
                    // TODO: should use `compatibility.arch` but for some reason it breaks the code.
                    busy_wait_at_least(delay_cycles);

                    generator.set_aux_source(input.source);
                    generator.enable();
                },
            }

            generator.set_div(div);
        }
    };
}

pub fn calculate_integer_divisor(comptime input_freq: u32, comptime output_freq: u32, IntegerDivisorType: type) IntegerDivisorType {
    // source frequency has to be faster because dividing will always reduce.
    comptime assert(input_freq >= output_freq);

    const fixed_divisor: IntegerDivisorType = @intCast(input_freq / output_freq);
    // We operate under the assumptions elsewhere the output frequency will be EXACTLY the requested value,
    // so error if we can't get the exact requested value.
    comptime if ((input_freq % output_freq) != 0)
        @compileError(std.fmt.comptimePrint("Unable to integer divide input frequency: {d} evenly into requested output frequency: {d}. Closest valid frequency is: {d}", .{ input_freq, output_freq, input_freq / fixed_divisor }));

    return fixed_divisor;
}

fn busy_wait_at_least(delay_cycles: u32) void {
    var _cycles = delay_cycles * 3;

    const arch = microzig.hal.compatibility.arch;
    asm volatile (switch (arch) {
            .arm =>
            \\1: subs %[cycles], #3
            \\bcs 1b
            ,
            .riscv =>
            \\1:
            \\addi %[cycles], %[cycles], -2
            \\bgez %[cycles], 1b
            ,
        }
        : [cycles] "+r" (_cycles),
        :
        : "cc", "memory"
    );
}
