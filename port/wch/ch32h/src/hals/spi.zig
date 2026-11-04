const microzig = @import("microzig");

const afio = microzig.hal.afio;
const clocks = microzig.hal.clocks;
const gpio = microzig.hal.gpio;
const Peripherals = microzig.hal.Peripherals;

const SpiBase = microzig.chip.types.peripherals.SPI1;

/// Common SPI register view shared by SPI1..SPI4. SPI2/SPI3 additionally have
/// the I2S registers at 0x1c..0x23; those are stripped here (reserved) so all
/// four instances share one layout.
const SpiRegs = extern struct {
    CTLR1: @FieldType(SpiBase, "CTLR1"),
    reserved2: [2]u8,
    CTLR2: @FieldType(SpiBase, "CTLR2"),
    reserved6: [2]u8,
    STATR: @FieldType(SpiBase, "STATR"),
    reserved10: [2]u8,
    DATAR: @FieldType(SpiBase, "DATAR"),
    reserved14: [2]u8,
    CRCR: @FieldType(SpiBase, "CRCR"),
    reserved18: [2]u8,
    RCRCR: @FieldType(SpiBase, "RCRCR"),
    reserved22: [2]u8,
    TCRCR: @FieldType(SpiBase, "TCRCR"),
    reserved28: [8]u8,
    HSCR: @FieldType(SpiBase, "HSCR"),
};

comptime {
    if (@offsetOf(SpiRegs, "TCRCR") != 0x18 or
        @offsetOf(SpiRegs, "HSCR") != 0x24 or
        @sizeOf(SpiRegs) != 0x28)
        @compileError("spi: SpiRegs layout drift; recheck common SPI register offsets");
}

const Function = enum { nss, sck, mosi, miso };
const Group = afio.Group(Peripherals.SPI, Function);

/// Pin alternate-function mapping, see `CH32H417DS0.pdf` Table 2-2-8.
/// Only the SPI functions are listed; the shared I2S functions (WS/CK/SD/MCK)
/// are intentionally omitted until I2S is supported.
const af_table = [_]Group{
    // SPI1
    .{ .instance = .SPI1, .function = .nss, .pins = &.{
        afio.pin(.GPIOA, 4, 5), afio.pin(.GPIOA, 15, 5), afio.pin(.GPIOF, 4, 5), afio.pin(.GPIOF, 6, 3),
    } },
    .{ .instance = .SPI1, .function = .sck, .pins = &.{
        afio.pin(.GPIOA, 5, 5), afio.pin(.GPIOB, 3, 5), afio.pin(.GPIOF, 5, 5), afio.pin(.GPIOF, 7, 3),
    } },
    .{ .instance = .SPI1, .function = .mosi, .pins = &.{
        afio.pin(.GPIOA, 7, 5), afio.pin(.GPIOB, 5, 5), afio.pin(.GPIOD, 7, 5), afio.pin(.GPIOF, 8, 3),
    } },
    .{ .instance = .SPI1, .function = .miso, .pins = &.{
        afio.pin(.GPIOA, 6, 5), afio.pin(.GPIOB, 4, 5), afio.pin(.GPIOF, 3, 5), afio.pin(.GPIOF, 9, 3),
    } },

    // SPI2
    .{ .instance = .SPI2, .function = .nss, .pins = &.{
        afio.pin(.GPIOB, 12, 5), afio.pin(.GPIOB, 9, 5), afio.pin(.GPIOA, 11, 5), afio.pin(.GPIOB, 4, 7),
    } },
    .{ .instance = .SPI2, .function = .sck, .pins = &.{
        afio.pin(.GPIOB, 13, 5), afio.pin(.GPIOB, 10, 5), afio.pin(.GPIOA, 9, 5), afio.pin(.GPIOA, 12, 5), afio.pin(.GPIOD, 3, 5),
    } },
    .{ .instance = .SPI2, .function = .mosi, .pins = &.{
        afio.pin(.GPIOB, 15, 5), afio.pin(.GPIOC, 1, 5), afio.pin(.GPIOC, 3, 5),
    } },
    .{ .instance = .SPI2, .function = .miso, .pins = &.{
        afio.pin(.GPIOB, 14, 5), afio.pin(.GPIOC, 2, 5),
    } },

    // SPI3
    .{ .instance = .SPI3, .function = .nss, .pins = &.{
        afio.pin(.GPIOA, 4, 6), afio.pin(.GPIOA, 15, 6),
    } },
    .{ .instance = .SPI3, .function = .sck, .pins = &.{
        afio.pin(.GPIOB, 3, 6), afio.pin(.GPIOC, 10, 6), afio.pin(.GPIOA, 14, 1),
    } },
    .{ .instance = .SPI3, .function = .mosi, .pins = &.{
        afio.pin(.GPIOB, 2, 7), afio.pin(.GPIOB, 5, 7), afio.pin(.GPIOC, 12, 6), afio.pin(.GPIOD, 6, 5), afio.pin(.GPIOA, 13, 1),
    } },
    .{ .instance = .SPI3, .function = .miso, .pins = &.{
        afio.pin(.GPIOB, 4, 6), afio.pin(.GPIOC, 11, 6), afio.pin(.GPIOC, 9, 5),
    } },

    // SPI4
    .{ .instance = .SPI4, .function = .nss, .pins = &.{
        afio.pin(.GPIOE, 4, 5), afio.pin(.GPIOE, 11, 5),
    } },
    .{ .instance = .SPI4, .function = .sck, .pins = &.{
        afio.pin(.GPIOE, 2, 5), afio.pin(.GPIOE, 12, 5),
    } },
    .{ .instance = .SPI4, .function = .mosi, .pins = &.{
        afio.pin(.GPIOE, 6, 5), afio.pin(.GPIOE, 14, 5),
    } },
    .{ .instance = .SPI4, .function = .miso, .pins = &.{
        afio.pin(.GPIOE, 5, 5), afio.pin(.GPIOE, 13, 5),
    } },
};

fn af_for(comptime instance: Peripherals.SPI, comptime pin: gpio.Pin, comptime function: Function) u4 {
    return afio.af_for(&af_table, instance, pin, function);
}

pub const Spi = struct {
    instance: Peripherals.SPI,

    /// BR[2:0] prescaler, dividing the peripheral clock by 2..256.
    pub const Prescaler = enum(u3) {
        div2,
        div4,
        div8,
        div16,
        div32,
        div64,
        div128,
        div256,
    };

    pub const Mode = enum { slave, master };
    pub const DataFrameFormat = enum { eight_bit, sixteen_bit };

    pub const Config = struct {
        mosi_pin: gpio.Pin,
        miso_pin: gpio.Pin,
        sck_pin: gpio.Pin,
        /// When null, software NSS management is used (SSM=1, SSI=1).
        nss_pin: ?gpio.Pin = null,

        mode: Mode = .master,
        prescaler: Prescaler = .div2,
        clock_polarity: enum { idle_low, idle_high } = .idle_low,
        clock_phase: enum { first_edge, second_edge } = .first_edge,
        data_frame_format: DataFrameFormat = .eight_bit,
    };

    fn regs(self: Spi) *volatile SpiRegs {
        return switch (self.instance) {
            .SPI1 => @ptrCast(microzig.chip.peripherals.SPI1),
            .SPI2 => @ptrCast(microzig.chip.peripherals.SPI2),
            .SPI3 => @ptrCast(microzig.chip.peripherals.SPI3),
            .SPI4 => @ptrCast(microzig.chip.peripherals.SPI4),
        };
    }

    pub fn apply(comptime self: Spi, comptime cfg: Config) void {
        clocks.enable(Peripherals.to_peripheral(self.instance));

        switch (cfg.mode) {
            .master => {
                cfg.sck_pin.apply(.{
                    .mode = .{ .output = .alternate_function_push_pull },
                    .speed = .max_100MHz,
                    .pull = .disabled,
                    .alternate_function = af_for(self.instance, cfg.sck_pin, .sck),
                });
                cfg.mosi_pin.apply(.{
                    .mode = .{ .output = .alternate_function_push_pull },
                    .speed = .max_100MHz,
                    .pull = .disabled,
                    .alternate_function = af_for(self.instance, cfg.mosi_pin, .mosi),
                });
                cfg.miso_pin.apply(.{
                    .mode = .{ .input = .floating },
                    .speed = .max_100MHz,
                    .pull = .up,
                    .alternate_function = af_for(self.instance, cfg.miso_pin, .miso),
                });
                if (cfg.nss_pin) |nss| nss.apply(.{
                    .mode = .{ .output = .alternate_function_push_pull },
                    .speed = .max_100MHz,
                    .pull = .disabled,
                    .alternate_function = af_for(self.instance, nss, .nss),
                });
            },
            .slave => @compileError("spi: slave mode unimplemented"),
        }

        const spi_regs = self.regs();
        spi_regs.CTLR1.modify(.{ .SPE = 0 });

        const software_nss = (cfg.nss_pin == null);
        spi_regs.CTLR1.modify(.{
            .MSTR = @backingInt(cfg.mode),
            .CPOL = @backingInt(cfg.clock_polarity),
            .CPHA = @backingInt(cfg.clock_phase),
            .BR = @backingInt(cfg.prescaler),
            .DFF = @backingInt(cfg.data_frame_format),
            .LSBFIRST = 0,
            .SSM = @intFromBool(software_nss),
            .SSI = 0,
            .SPE = 0,
        });
    }

    pub inline fn start(comptime self: Spi) void {
        self.regs().CTLR1.modify(.{ .SPE = 1 });
    }

    pub inline fn stop(comptime self: Spi) void {
        self.regs().CTLR1.modify(.{ .SPE = 0 });
    }
};

pub const spi1 = Spi{ .instance = .SPI1 };
