const microzig = @import("microzig");

const chip = microzig.chip;

var clocks: Clock_Frequencies = .{};

pub inline fn unlock_clock_configuration() void {
    chip.peripherals.SYSCON.CLKUNLOCK.write(.{ .UNLOCK = .ENABLE });
}

pub inline fn freeze_clock_configuration() void {
    chip.peripherals.SYSCON.CLKUNLOCK.write(.{ .UNLOCK = .FREEZE });
}

pub fn enable_clock(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_CC0_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC0_SET)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_CC1_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC1_SET)) | peripheral.mask(),
        ),
    }
}

pub fn disable_clock(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_CC0_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC0_CLR)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_CC1_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC1_CLR)) | peripheral.mask(),
        ),
    }
}

pub fn reset_release(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_RST0_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST0_SET)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_RST1_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST1_SET)) | peripheral.mask(),
        ),
    }
}

pub fn reset_assert(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_RST0_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST0_CLR)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_RST1_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST1_CLR)) | peripheral.mask(),
        ),
    }
}

pub const Peripheral = enum {
    // MRCC_GLB_CC0, MRCC_GLB_ACC0, MRCC_GLB_RST0
    INPUTMUX0,
    I3C0,
    CTIMER0,
    CTIMER1,
    CTIMER2,
    CTIMER3,
    CTIMER4,
    FREQME,
    UTICK0,
    DMA,
    AOI0,
    CRC0,
    EIM0,
    ERM0,
    AOI1,
    FLEXIO0,
    LPI2C0,
    LP12C1,
    LPSPI0,
    LPSPI1,
    LPUART0,
    LPUART1,
    LPUART2,
    LPUART3,
    LPUART4,
    USB0,
    QDC0,
    QDC1,
    FLEXPWM0,
    FLEXPWM1,

    // MRCC_GLB_CC1, MRCC_GLB_ACC1, MRCC_GLB_RST1
    OSTIMER0,
    ADC0,
    ADC1,
    CMP1,
    DAC0,
    OPAMP0,

    PORT0,
    PORT1,
    PORT2,
    PORT3,
    PORT4,
    FLEXCAN0,
    LPI2C2,
    LPI2C3,
    GPIO0,
    GPIO1,
    GPIO2,
    GPIO3,
    GPIO4,

    fn cc(comptime peripheral: Peripheral) u1 {
        return switch (peripheral) {
            .INPUTMUX0,
            .I3C0,
            .CTIMER0,
            .CTIMER1,
            .CTIMER2,
            .CTIMER3,
            .CTIMER4,
            .FREQME,
            .UTICK0,
            .DMA,
            .AOI0,
            .CRC0,
            .EIM0,
            .ERM0,
            .AOI1,
            .FLEXIO0,
            .LPI2C0,
            .LP12C1,
            .LPSPI0,
            .LPSPI1,
            .LPUART0,
            .LPUART1,
            .LPUART2,
            .LPUART3,
            .LPUART4,
            .USB0,
            .QDC0,
            .QDC1,
            .FLEXPWM0,
            .FLEXPWM1,
            => 0,

            .OSTIMER0,
            .ADC0,
            .ADC1,
            .CMP1,
            .DAC0,
            .OPAMP0,
            .PORT0,
            .PORT1,
            .PORT2,
            .PORT3,
            .PORT4,
            .FLEXCAN0,
            .LPI2C2,
            .LPI2C3,
            .GPIO0,
            .GPIO1,
            .GPIO2,
            .GPIO3,
            .GPIO4,
            => 1,
        };
    }

    fn mask(comptime peripheral: Peripheral) u32 {
        return switch (peripheral) {
            .INPUTMUX0 => 1,
            .I3C0 => 1 << 1,
            .CTIMER0 => 1 << 2,
            .CTIMER1 => 1 << 3,
            .CTIMER2 => 1 << 4,
            .CTIMER3 => 1 << 5,
            .CTIMER4 => 1 << 6,
            .FREQME => 1 << 7,
            .UTICK0 => 1 << 8,
            .DMA => 1 << 10,
            .AOI0 => 1 << 11,
            .CRC0 => 1 << 12,
            .EIM0 => 1 << 13,
            .ERM0 => 1 << 14,
            .AOI1 => 1 << 16,
            .FLEXIO0 => 1 << 17,
            .LPI2C0 => 1 << 18,
            .LP12C1 => 1 << 19,
            .LPSPI0 => 1 << 20,
            .LPSPI1 => 1 << 21,
            .LPUART0 => 1 << 22,
            .LPUART1 => 1 << 23,
            .LPUART2 => 1 << 24,
            .LPUART3 => 1 << 25,
            .LPUART4 => 1 << 26,
            .USB0 => 1 << 27,
            .QDC0 => 1 << 28,
            .QDC1 => 1 << 29,
            .FLEXPWM0 => 1 << 30,
            .FLEXPWM1 => 1 << 31,
            .OSTIMER0 => 1,
            .ADC0 => 1 << 1,
            .ADC1 => 1 << 2,
            .CMP1 => 1 << 4,
            .DAC0 => 1 << 5,
            .OPAMP0 => 1 << 6,
            .PORT0 => 1 << 7,
            .PORT1 => 1 << 8,
            .PORT2 => 1 << 9,
            .PORT3 => 1 << 10,
            .PORT4 => 1 << 11,
            .FLEXCAN0 => 1 << 12,
            .LPI2C2 => 1 << 13,
            .LPI2C3 => 1 << 14,
            .GPIO0 => 1 << 20,
            .GPIO1 => 1 << 21,
            .GPIO2 => 1 << 22,
            .GPIO3 => 1 << 23,
            .GPIO4 => 1 << 24,
        };
    }
};

const MRCC0 = microzig.chip.peripherals.MRCC0;
const scg0 = microzig.chip.peripherals.SCG0;
const spc0 = microzig.chip.peripherals.SPC0;
const FMU = microzig.chip.peripherals.FMU0;
const syscon = microzig.chip.peripherals.SYSCON;

pub const SOSC_Range = enum(u2) {
    @"8Mhz-16Mhz",
    @"16Mhz-25Mhz",
    @"25Mhz-40Mhz",
    @"40Mhz-50Mhz",
};

///Selects the source for the external reference clock. This bit selects which clock is output from the SOSC
///into the SCG, whether from the crystal oscillator or from an external clock input.
pub const EREFS = enum(u1) {
    ///reference clock selected.
    external,

    ///crystal oscillator of OSC selected.
    internal,
};

pub const System_Clock = enum(u3) {
    SOSC = 1,
    SIRC,
    FRIC,
    ROSC,
};

pub const FIRC_FREQ = enum(u3) {
    @"48Mhz" = 1,
    @"64Mhz" = 3,
    @"96Mhz" = 5,
    @"192Mhz" = 7,
};

pub const Drive_Mode = enum(u2) {
    MidDriver = 1,
    StandartDriver = 2,
};

//TODO add trim config
pub const SOSC_Config = struct {
    freq_hz: usize = 8_000_000,
    erefs: EREFS,
    valid_int_en: bool = false,
    monitor_en: bool = false,
    stop_mode_en: bool = true,
};

//TODO: add trim confg
pub const FROLF_Config = struct {
    en_periph_gate: bool = true,
};

pub const FROHF_Config = struct {
    fro_hf_div: u4 = 0,
    en_slow_periph_gate: bool = true,
    en_fast_periph_gate: bool = true,
    stop_en: bool = true,
    error_int_en: bool = false,
    firc_ready_int_en: bool = false,
    freq: FIRC_FREQ = .@"48Mhz",
};
pub const Power_Config = struct {
    driver: Drive_Mode = .MidDriver,
};

pub const Clock_Config = struct {
    socs: ?SOSC_Config = null,
    frohf: ?FROHF_Config = FROHF_Config{},
    frolf: ?FROLF_Config = FROLF_Config{},
    power: Power_Config = .{},
    clock_source: System_Clock = .FRIC,
    ahb_div: u8 = 0,
    slow_clock_en: bool = true,
};

pub const Clock_Frequencies = struct {
    clk_16k_0: usize = 16_384,
    clk_16k_1: usize = 16_384,
    clk_in: usize = 0,
    fro_hf: usize = 0,
    fro_hf_div: usize = 0,
    clk_48m: usize = 0,
    fro_12m: usize = 0,
    clk_1m: usize = 1_000_000,
    main_clk: usize = 0,
    cpu_clk: usize = 0,
    system_clk: usize = 0,
    slow_clk: usize = 0,

    pub fn maxForMode(mode: Drive_Mode) Clock_Frequencies {
        return switch (mode) {
            .MidDriver => .{
                .clk_16k_0 = 16_384,
                .clk_16k_1 = 16_384,
                .clk_in = 50_000_000,
                .fro_hf = 96_000_000,
                .fro_hf_div = 48_000_000,
                .clk_48m = 48_000_000,
                .fro_12m = 12_000_000,
                .clk_1m = 1_000_000,
                .main_clk = 96_000_000,
                .cpu_clk = 48_000_000,
                .system_clk = 48_000_000,
                .slow_clk = 12_000_000,
            },
            .StandartDriver => .{
                .clk_16k_0 = 16_384,
                .clk_16k_1 = 16_384,
                .clk_in = 50_000_000,
                .fro_hf = 192_000_000,
                .fro_hf_div = 96_000_000,
                .clk_48m = 48_000_000,
                .fro_12m = 12_000_000,
                .clk_1m = 1_000_000,
                .main_clk = 192_000_000,
                .cpu_clk = 96_000_000,
                .system_clk = 96_000_000,
                .slow_clk = 24_000_000,
            },
        };
    }

    pub fn validate(self: Clock_Frequencies, mode: Drive_Mode) !void {
        const max_values = maxForMode(mode);

        inline for (@typeInfo(@This()).@"struct".field_names) |name| {
            const current = @field(self, name);
            const max_allowed = @field(max_values, name);

            if (current > max_allowed) {
                return error.Overflow;
            }
        }
    }
};

pub fn clock_init(comptime config: Clock_Config) !void {
    const inner_clocks = comptime calc_clock(config);
    unlock_clock_configuration();
    inner_init(inner_clocks, config);
    freeze_clock_configuration();
    clocks = inner_clocks;
}

fn calc_clock(comptime config: Clock_Config) Clock_Frequencies {
    var out_clk = Clock_Frequencies{};
    if (config.socs) |ext| {
        out_clk.clk_in = ext.freq_hz;
    }
    if (config.frohf) |hf| {
        out_clk.fro_hf = switch (hf.freq) {
            .@"192Mhz" => 192_000_000,
            .@"96Mhz" => 96_000_000,
            .@"64Mhz" => 64_000_000,
            .@"48Mhz" => 48_000_000,
        };

        if (hf.en_slow_periph_gate) {
            out_clk.clk_48m = 48_000_000;
        }
        out_clk.fro_hf_div = out_clk.fro_hf / (hf.fro_hf_div + 1);
    }

    if (config.socs) |_| {
        @compileError("SOCS IS NOT SUPPORTED YET");
    }

    switch (config.clock_source) {
        .FRIC => {
            if (out_clk.fro_hf == 0) @compileError("MAIN CLOCK USE FRO_HF BUT FRO_HF IS DISABLED IN THIS CONFIG");
            out_clk.main_clk = out_clk.fro_hf;
        },
        .SIRC => {
            if (out_clk.fro_12m == 0) @compileError("MAIN CLOCK USE FRO_LF BUT FRO_LF IS DISABLED IN THIS CONFIG");
            out_clk.main_clk = out_clk.fro_12m;
        },
        else => {
            @compileError("MODE: " ++ @tagName(config.clock_source) ++ " IS NOT SUPPORTED YET");
        },
    }

    out_clk.cpu_clk = out_clk.main_clk / (config.ahb_div + 1);
    out_clk.system_clk = out_clk.cpu_clk;
    out_clk.slow_clk = out_clk.cpu_clk / 4;
    out_clk.validate(config.power.driver) catch @compileError("INVALID CLOCK CONFIG");
    return out_clk;
}

fn inner_init(comptime clks: Clock_Frequencies, config: Clock_Config) void {
    //First put the hardware in a safe state:
    safe_init();
    power_and_flash(clks.cpu_clk, config.power);

    //enable clocks
    enable_clocks(config);

    //set main clk
    syscon.AHBCLKDIV.modify_one("DIV", config.ahb_div);
    while (syscon.AHBCLKDIV.read().UNSTAB == .ONGOING) {}

    scg0.RCCR.modify_one("SCS", @fromBackingInt(@intCast(@backingInt(config.clock_source))));
    while (@backingInt(scg0.CSR.read().SCS) != @backingInt(config.clock_source)) {}
}

fn safe_init() void {
    //set SIRC as the main clk, fro12_hf is always valid no matter the actual flash and power config
    //also, FRO_HF cannot be configured while used as the main_clk
    scg0.SIRCCSR.modify_one("LK", .WRITE_ENABLED);

    scg0.SIRCCSR.modify_one("SIRC_CLK_PERIPH_EN", .ENABLED);

    while (scg0.SIRCCSR.read().SIRCVLD == .DISABLED_OR_NOT_VALID) {}

    if (scg0.SIRCCSR.read().SIRCERR == .ERROR_DETECTED) @panic("CLOCK INIT FAIL");

    scg0.RCCR.modify_one("SCS", .SIRC);
    while (scg0.CSR.read().SCS != .SIRC) {}
    scg0.SIRCCSR.modify_one("LK", .WRITE_DISABLED);
}

//TODO ALLOW FOR LP_CONFG and add bandgap/DS checks
fn power_and_flash(cpu_clk: usize, power_cfg: Power_Config) void {
    //enable bandgap

    //no config for DS and bandgap yet, so force normal mode
    spc0.ACTIVE_CFG.modify_one("BGMODE", .BGMODE01);
    spc0.ACTIVE_CFG.modify_one("CORELDO_VDD_DS", .NORMAL);

    spc0.ACTIVE_CFG.modify_one("CORELDO_VDD_LVL", @fromBackingInt(@intCast(@backingInt(power_cfg.driver))));
    while (spc0.SC.read().BUSY == .BUSY_YES) {}
    FMU.FCTRL.modify_one("RWSC", get_flash_wait_states(power_cfg.driver, cpu_clk));

    spc0.SRAMCTL.modify_one("VSM", @fromBackingInt(@intCast(@backingInt(power_cfg.driver))));
    spc0.SRAMCTL.modify_one("REQ", .REQ_YES);
    while (spc0.SRAMCTL.read().ACK == .ACK_NO) {}
    spc0.SRAMCTL.modify_one("REQ", .REQ_NO);
}

fn enable_clocks(config: Clock_Config) void {
    //SOCS and ROSC not supported yet, SIRC already enabled

    scg0.FIRCCSR.modify_one("LK", .WRITE_ENABLED);
    scg0.FIRCCSR.modify_one("FIRCTREN", .DISABLED);

    if (config.frohf) |hf| {
        scg0.FIRCCSR.write(.{
            .FIRC_FCLK_PERIPH_EN = @fromBackingInt(@intCast(@intFromBool(hf.en_fast_periph_gate))),
            .FIRC_SCLK_PERIPH_EN = @fromBackingInt(@intCast(@intFromBool(hf.en_slow_periph_gate))),
            .FIRCACC_IE = @fromBackingInt(@intCast(@intFromBool(hf.firc_ready_int_en))),
            .FIRCERR_IE = @fromBackingInt(@intCast(@intFromBool(hf.error_int_en))),
            .FIRCSTEN = @fromBackingInt(@intCast(@intFromBool(hf.stop_en))),
            .LK = .WRITE_ENABLED, //leep lk open
            .FIRCACC = .NOT_ENABLED_OR_NOT_VALID, //not modify
        });
        scg0.FIRCCSR.modify_one("FIRCTREN", .ENABLED);
        scg0.FIRCCFG.modify_one("FREQ_SEL", @fromBackingInt(@intCast(@backingInt(hf.freq))));

        while (scg0.FIRCCSR.read().FIRCVLD == .NOT_ENABLED_OR_NOT_VALID) {}
        if (scg0.FIRCCSR.read().FIRCERR == .ERROR_DETECTED) @panic("CLOCK INIT FAIL");

        //apply fro_hf_div
        MRCC0.MRCC_FRO_HF_DIV_CLKDIV.modify_one("DIV", hf.fro_hf_div);
        while (MRCC0.MRCC_FRO_HF_DIV_CLKDIV.read().UNSTAB == .OFF) {}
    }
    scg0.FIRCCSR.modify_one("LK", .WRITE_DISABLED);
}

fn get_flash_wait_states(mode: Drive_Mode, cpu_clk: usize) u4 {
    switch (mode) {
        .MidDriver => return if (cpu_clk >= 24_000_000) 1 else 0,
        .StandartDriver => {
            if (cpu_clk <= 30_000_000) {
                return 0;
            } else if (cpu_clk <= 60_000_000) {
                return 1;
            } else if (cpu_clk <= 90_000_000) {
                return 2;
            } else return 3;
        },
    }
}
