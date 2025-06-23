const microzig = @import("microzig");
const chip = microzig.chip;

const CLOCK = chip.peripherals.CLOCK;
const GPIO = chip.peripherals.GPIO;

pub const RchFrequency = enum(u11) {
    @"32768",
    @"38_4K",
    @"4MHz",
    @"8MHz",
    @"16MHz",
    @"22_2MHz",
    @"24MHz",
    _,
};

pub const ClockSource = enum {
    /// RCH
    InternalHighSpeed,
    /// XTH
    ExternalHighSpeed,
    /// RCL
    InternalLowSpeed,
    /// XTL
    ExternalLowSpeed,
};

pub fn set_rch_frequency(frequency: RchFrequency) void {
    const address: usize = switch (frequency) {
        .@"32768" => 0x00100C22,
        .@"38_4K" => 0x00100C20,
        .@"4MHz" => 0x00100C08,
        .@"8MHz" => 0x00100C06,
        .@"16MHz" => 0x00100C04,
        .@"22_2MHz" => 0x00100C02,
        .@"24MHz" => 0x00100C00,
        else => @panic("unsupported frequency"),
    };
    const trim_ptr: *volatile u16 = @ptrFromInt(address);

    CLOCK.RCH_CR.modify(.{
        .TRIM = @as(u11, @truncate(trim_ptr.*)),
    });
}

pub inline fn unlock() void {
    CLOCK.SYSCTRL2.write(.{ .SYSCTRL2 = 0x5A5A });
    CLOCK.SYSCTRL2.write(.{ .SYSCTRL2 = 0xA5A5 });
}

pub fn enable(c: ClockSource, en: bool) void {
    unlock();
    switch (c) {
        .ExternalLowSpeed => {
            CLOCK.PERI_CLKEN.modify(.{
                .GPIO = 1,
            });
            GPIO.P1ADS.modify(.{
                .P14 = @intFromBool(en),
                .P15 = @intFromBool(en),
            });
            CLOCK.XTL_CR.modify(.{
                .DRIVER = 0xf,
            });
            CLOCK.SYSCTRL0.modify(.{
                .XTL_EN = @intFromBool(en),
            });
        },
        .InternalLowSpeed => {
            CLOCK.SYSCTRL0.modify(.{ .RCL_EN = @intFromBool(en) });
        },
        .ExternalHighSpeed => {
            CLOCK.PERI_CLKEN.modify(.{
                .GPIO = 1,
            });
            GPIO.P1ADS.modify(.{
                .P14 = @intFromBool(en),
                .P15 = @intFromBool(en),
            });
            CLOCK.XTH_CR.modify(.{
                .DRIVER = 0xf,
            });
            CLOCK.SYSCTRL0.modify(.{
                .XTH_EN = @intFromBool(en),
            });
        },
        .InternalHighSpeed => {
            CLOCK.SYSCTRL0.modify(.{ .RCH_EN = @intFromBool(en) });
        },
    }
}

pub const gate = struct {
    pub const ClockGate = enum(u5) {
        Uart0 = 0,
        Uart1 = 1,
        LpUart = 2,
        I2c = 4,
        Spi = 6,
        BaseTim = 8,
        LpTim = 9,
        Adt = 10,
        Pca = 14,
        Wdt = 15,
        AdcBgr = 16,
        VcLvd = 17,
        Rtc = 20,
        ClkTrim = 21,
        Tick = 24,
        Crc = 26,
        Gpio = 28,
        Flash = 31,
    };

    pub inline fn enable(clock_gate: ClockGate) void {
        CLOCK.PERI_CLKEN.write_bit(@intFromEnum(clock_gate), 1);
    }

    pub inline fn disable(clock_gate: ClockGate) void {
        CLOCK.PERI_CLKEN.write_bit(@intFromEnum(clock_gate), 0);
    }
};
