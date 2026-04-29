//! For now we keep all clock settings on the chip defaults.
//! This code should work with all the STM32F42xx line
//!
//! Specifically, TIM6 is running on a 16 MHz clock,
//! HSI = 16 MHz is the SYSCLK after reset
//! default AHB prescaler = /1 (= values 0..7):
//!
//! ```
//! RCC.CFGR.modify(.{ .HPRE = .Div1 });
//! ```
//!
//! so also HCLK = 16 MHz.
//! And with the default APB1 prescaler = /1:
//!
//! ```
//! RCC.CFGR.modify(.{ .PPRE1 = .Div1 });
//! ```
//!
//! results in PCLK1 = 16 MHz.
//!
//! TODO: add more clock calculations when adding Uart

const std = @import("std");
const microzig = @import("microzig");
const mmio = microzig.mmio;
const peripherals = microzig.chip.peripherals;
const RCC = peripherals.RCC;

const Digital_IO = microzig.drivers.base.Digital_IO;

const State = Digital_IO.State;

pub const pins = @import("./common/pins_v2.zig").get_pins(.{
    .portcount = 11,
});

pub const clock = struct {
    pub const Domain = enum {
        cpu,
        ahb,
        apb1,
        apb2,
    };
};

// Default clock frequencies after reset, see top comment for calculation
pub const clock_frequencies = .{
    .cpu = 16_000_000,
    .ahb = 16_000_000,
    .apb1 = 16_000_000,
    .apb2 = 16_000_000,
};

// TODO: There should be a common rcc with stuff like this, just like pins_v2.zig
pub const rcc = struct {
    const util = @import("common/util.zig");
    const _rcc = microzig.chip.peripherals.RCC;

    // Any peripheral that must be enable in RCC.
    pub const Peripherals = util.create_peripheral_enum(&.{
        "GPIO",
    });

    ///configure the power and clock registers before enabling the RTC
    ///this function also can be called from `rtc.enable()`
    pub fn enable_rtc(on: bool) void {
        _rcc.BDCR.modify(.{ .RTCEN = @intFromBool(on) });
    }

    pub fn set_clock(comptime peri: Peripherals, state: u1) void {
        const peri_name = @tagName(peri);
        const field = peri_name ++ "EN";
        if (util.match_name(peri_name, &.{"RTC"})) {
            enable_rtc(state != 0);
            return;
        }
        const rcc_register_name = comptime if (util.match_name(peri_name, &.{
            "OTGHSULPI",
            "OTGHS",
            "ETHMACPTP",
            "ETHMACRX",
            "ETHMACTX",
            "ETHMAC",
            "DMA2D",
            "DMA2",
            "DMA1",
            "CCMDATARAM",
            "BKPSRAM",
            "CRC",
            "GPIOK",
            "GPIOJ",
            "GPIOI",
            "GPIOH",
            "GPIOG",
            "GPIOF",
            "GPIOE",
            "GPIOD",
            "GPIOC",
            "GPIOB",
            "GPIOA",
        })) "AHB1ENR" else "AHB1ENR";

        @field(_rcc, rcc_register_name).modify_one(field, state);
    }

    pub fn enable_clock(comptime peri: Peripherals) void {
        set_clock(peri, 1);
    }

    pub fn disable_clock(comptime peri: Peripherals) void {
        set_clock(peri, 0);
    }
};
