//NOTE: this file is only valid for densities: Low, Medium, High, and XL. Connectivity line devices are not supported in this version.

const std = @import("std");
const microzig = @import("microzig");
const find_clocktree = @import("util.zig").find_clock_tree;

const ClockInitError = error{
    HSETimeout,
    LSETimeout,
};

const flash_v1 = microzig.chip.types.peripherals.flash_f1;
const flash = microzig.chip.peripherals.FLASH;
const PLLMUL = microzig.chip.types.peripherals.rcc_f1.PLLMUL;
const PLLSRC = microzig.chip.types.peripherals.rcc_f1.PLLSRC;
const PLLXTPRE = microzig.chip.types.peripherals.rcc_f1.PLLXTPRE;
const PRE = microzig.chip.types.peripherals.rcc_f1.PPRE;
const HPRE = microzig.chip.types.peripherals.rcc_f1.HPRE;
const ADCPRE = microzig.chip.types.peripherals.rcc_f1.ADCPRE;
const USBPRE = microzig.chip.types.peripherals.rcc_f1.USBPRE;
const SW = microzig.chip.types.peripherals.rcc_f1.SW;
const rcc = microzig.chip.peripherals.RCC;

pub const ClockTree = find_clocktree(microzig.config.chip_name);

//TODO: change anytype to the correct clocktype
//NOTE: procedural style or loop through all elements of the struct?
pub fn clock_init(comptime config: ClockTree.Config) ClockInitError!void {
    const sysclck = comptime validate_clocks(config);

    set_flash(sysclck);

    //rest all clock configs
    secure_enable();
    if (@hasField(@TypeOf(config), "HSICalibrationValue")) {
        if (config.HSICalibrationValue) |val| {
            config_HSI(@intFromEnum(val));
        }
    }

    try config_PLL(config);
    config_peripherals(config);
    try config_system_clock(config);
}

//check clocks and return sysclk for flash config
fn validate_clocks(comptime config: ClockTree.Config) usize {
    const tree_values = ClockTree.ClockTree.init_comptime(config);

    //verifica se os clock de perifericos usados são validos
    const sysclk = tree_values.SysCLKOutput.get_comptime();
    _ = tree_values.APB1Output.get_comptime();
    _ = tree_values.APB2Output.get_comptime();
    _ = tree_values.AHBOutput.get_comptime();
    if (@hasField(@TypeOf(config), "USBPrescaler")) {
        if (config.USBPrescaler) |_| {
            _ = tree_values.USBoutput.get_comptime();
        }
    }

    return @intFromFloat(sysclk);
}

fn set_flash(clock: usize) void {
    if (clock <= 24_000_000) {
        flash.ACR.modify(.{
            .LATENCY = flash_v1.LATENCY.WS0,
            .PRFTBE = 0,
        });
    } else if (clock <= 48_000_000) {
        flash.ACR.modify(.{
            .LATENCY = flash_v1.LATENCY.WS1,
            .PRFTBE = 1,
        });
    } else {
        flash.ACR.modify(.{
            .LATENCY = flash_v1.LATENCY.WS2,
            .PRFTBE = 1,
        });
    }
}

//force HSI Clock and clear any clock configs
fn secure_enable() void {
    rcc.CR.modify(.{ .HSION = 1 });
    while (rcc.CR.read().HSIRDY != 1) {
        asm volatile ("" ::: "memory");
    }

    rcc.CFGR.raw = 0;
    while (rcc.CFGR.read().SWS != .HSI) {
        asm volatile ("" ::: "memory");
    }

    rcc.CR.modify(.{
        .PLLON = 0,
        .HSEBYP = 0,
        .HSEON = 0,
        .CSSON = 0,
    });

    //TODO: RESET flash Lat here

}

fn config_HSI(value: usize) void {
    //secure_enable has already started the HSE
    const trim: u5 = @truncate(value);
    rcc.CR.modify(.{ .HSITRIM = trim });

    //wait for the HSI to stabilize
    for (0..16) |_| {
        asm volatile ("" ::: "memory");
    }
}

fn config_HSE(comptime config: ClockTree.Config) ClockInitError!void {
    rcc.CR.modify(.{ .HSEON = 1 });

    const max_wait: u32 = if (config.HSE_Timout) |val| @intFromEnum(val) else std.math.maxInt(u32);
    var ticks: usize = 0;
    while (rcc.CR.read().HSERDY == 0) {
        if (ticks == max_wait - 1) return error.HSETimeout;
        ticks += 1;
        asm volatile ("" ::: "memory");
    }
}

fn config_PLL(comptime config: ClockTree.Config) ClockInitError!void {
    if (config.PLLSource) |src| {
        const s: u1 = @intFromEnum(src);
        const val: PLLSRC = @enumFromInt(s);
        rcc.CFGR.modify(.{ .PLLSRC = val });
        if (val == .HSE_Div_PREDIV) {
            try config_HSE(config);
        }
    }

    if (config.HSEDivPLL) |pre| {
        const p: u1 = @intFromEnum(pre);
        const val: PLLXTPRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PLLXTPRE = val });
    }

    if (config.PLLMUL) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: PLLMUL = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PLLMUL = val });
    }
}

fn config_peripherals(comptime config: ClockTree.Config) void {
    if (config.APB1Prescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: PRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PPRE1 = val });
    }

    if (config.APB2Prescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: PRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PPRE2 = val });
    }

    if (config.AHBPrescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: HPRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .HPRE = val });
    }

    if (config.ADCprescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: ADCPRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .ADCPRE = val });
    }

    if (@hasField(@TypeOf(config), "USBPrescaler")) {
        if (config.USBPrescaler) |pre| {
            const p: u32 = @intFromEnum(pre);
            const val: USBPRE = @enumFromInt(p);
            rcc.CFGR.modify(.{ .USBPRE = val });
        }
    }
}

fn config_system_clock(comptime config: ClockTree.Config) ClockInitError!void {
    if (config.SysClkSource) |src| {
        const val: u2 = @intFromEnum(src);
        const e_val: SW = @enumFromInt(val);
        switch (val) {
            1 => try config_HSE(config),
            2 => init_pll(),
            else => {},
        }

        rcc.CFGR.modify(.{ .SW = e_val });
        while (true) {
            const sws = rcc.CFGR.read().SWS;
            if (sws == e_val) break;
            asm volatile ("" ::: "memory");
        }
    }
}

fn init_pll() void {
    rcc.CR.modify(.{ .PLLON = 1 });
    while (rcc.CR.read().PLLRDY == 0) {
        asm volatile ("" ::: "memory");
    }
}
