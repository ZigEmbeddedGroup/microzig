//!
//! Driver for the Melexis MLX90640 32x24 IR array (thermal camera)
//!
//! Datasheet:
//! * MLX90640: https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90640
//!
//! Not all functionality from the datasheet is exposed in this driver
//!
//! The calculations were copied from https://github.com/netzbasteln/MLX90640-Thermocam
//!
const std = @import("std");
const mdf = @import("../framework.zig");

const Mlx90649Error = error{
    BadPixels,
};

pub const MLX90640_Config = struct {
    i2c: mdf.base.Datagram_Device,
    clock: mdf.base.Clock_Device,
    open_air_shift: f32 = 8,
    emissivity: f32 = 0.95,
};

pub const MLX90640 = struct {
    const Self = @This();

    const control_register = packed struct {
        enable_subpages_mode: u1,
        reserved: u1,
        enable_data_hold: u1,
        enable_subpages_repeat: u1,
        select_subpage: u3,
        refresh_rate: u3,
        resolution: u2,
        reading_pattern: u1,
        reserved2: u3,
    };

    const parameters = struct {
        kVdd: i16 = 0,
        vdd25: i16 = 0,
        KvPTAT: f32 = 0,
        KtPTAT: f32 = 0,
        vPTAT25: i16 = 0,
        alphaPTAT: f32 = 0,
        gainEE: i16 = 0,
        tgc: f32 = 0,
        cpKv: f32 = 0,
        cpKta: f32 = 0,
        resolutionEE: u8 = 0,
        calibrationModeEE: u8 = 0,
        KsTa: f32 = 0,
        ksTo: [5]f32 = undefined,
        ct: [5]i16 = undefined,
        alpha: [768]u16 = undefined,
        alphaScale: u8 = 0,
        offset: [768]i32 = undefined,
        kta: [768]i8 = undefined,
        ktaScale: u8 = 0,
        kv: [768]i8 = undefined,
        kvScale: u8 = 0,
        cpAlpha: [2]f32 = undefined,
        cpOffset: [2]i16 = undefined,
        ilChessC: [3]f32 = undefined,
        brokenPixels: [5]u16 = undefined,
        outlierPixels: [5]u16 = undefined,
    };

    const registers = enum(u16) {
        control = 0x800D,
        status = 0x8000,
        ram = 0x0400,
        eeprom = 0x2400,
        device_id = 0x2407,
    };

    eeprom: [832]u16 = undefined,
    frame: [834]u16 = undefined,
    frame_data: [834 * 2]u8 = undefined,
    scratch_data: [768]f32 = undefined,
    i2c: mdf.base.Datagram_Device,
    clock_device: mdf.base.Clock_Device,
    params: parameters,
    emissivity: f32,
    open_air_shift: f32,

    scale_alpha: f32 = 0.000001,

    frame_loop: [2]u1 = [2]u1{ 0, 1 },
    refresh_rate_mask: u16 = 0b111 << 7,

    pub fn init(cfg: MLX90640_Config) !Self {
        return Self{
            .i2c = cfg.i2c,
            .clock_device = cfg.clock,
            .open_air_shift = cfg.open_air_shift,
            .emissivity = cfg.emissivity,
            .params = parameters{},
        };
    }

    fn write(self: *Self, reg: Self.registers, val: u16) !void {
        const addr: u16 = @intFromEnum(reg);
        var req = [4]u8{
            @as(u8, @truncate(addr >> 8)),
            @as(u8, @truncate(addr & 0xFF)),
            @as(u8, @truncate(val >> 8)),
            @as(u8, @truncate(val & 0xFF)),
        };

        try self.i2c.write(&req);
        self.clock_device.sleep_ms(100);
    }

    fn write_then_read(self: *Self, reg: Self.registers, buf: []u16) !void {
        const addr: u16 = std.mem.nativeToBig(u16, @intFromEnum(reg));
        const req = std.mem.asBytes(&addr);
        try self.i2c.write_then_read(req, self.frame_data[0 .. buf.len * 2]);
        for (0.., buf) |i, _| {
            buf[i] = std.mem.readInt(u16, self.frame_data[i * 2 .. (i * 2) + 2][0..2], .big);
        }
    }

    fn read_control_register(self: *Self) !control_register {
        try self.write_then_read(Self.registers.control, self.frame[0..1]);
        const val: control_register = @bitCast(self.frame[0]);
        return val;
    }

    pub fn serial_number(self: *Self) !u48 {
        try self.write_then_read(Self.registers.control, self.frame[0..3]);
        return @as(u48, self.frame[0]) << 32 |
            @as(u48, self.frame[1]) << 16 |
            @as(u48, self.frame[2]);
    }

    pub fn set_refresh_rate(self: *Self, rate: u3) !void {
        var val = try self.read_control_register();
        val.refresh_rate = rate;
        const bytes: u16 = @bitCast(val);
        try self.write(Self.registers.control, bytes);
    }

    pub fn refresh_rate(self: *Self) !u3 {
        const val = try self.read_control_register();
        return val.refresh_rate;
    }

    pub fn resolution(self: *Self) !u2 {
        const val = try self.read_control_register();
        return val.resolution;
    }

    pub fn temperature(self: *Self, result: []f32) !void {
        if (self.params.kVdd == 0) {
            try self.extract_parameters();

            // the initial frame load results in bad data upon restart, so get that bad data out of the way
            try self.load_frame();
        }

        try self.load_frame();

        const subPage: u16 = self.frame[833] & 0x0001;
        const vdd = self.getVdd();
        const ta = self.getTa(vdd);
        const tr = ta - self.open_air_shift;

        var ta4: f32 = (ta + 273.15);
        ta4 = ta4 * ta4;
        ta4 = ta4 * ta4;
        var tr4: f32 = (tr + 273.15);
        tr4 = tr4 * tr4;
        tr4 = tr4 * tr4;
        const taTr: f32 = tr4 - (tr4 - ta4) / self.emissivity;

        const ktaScale: f32 = @floatFromInt(std.math.pow(u16, 2, self.params.ktaScale));
        const kvScale: f32 = @floatFromInt(std.math.pow(u16, 2, self.params.kvScale));
        const alphaScale: f32 = @floatFromInt(std.math.pow(u16, 2, self.params.alphaScale));

        var alphaCorrR: [4]f32 = undefined;
        alphaCorrR[0] = 1 / (1 + self.params.ksTo[0] * 40);
        alphaCorrR[1] = 1;
        var ct: f32 = @floatFromInt(self.params.ct[2]);
        alphaCorrR[2] = (1 + self.params.ksTo[1] * ct);
        ct = @floatFromInt(self.params.ct[3] - self.params.ct[2]);
        alphaCorrR[3] = alphaCorrR[2] * (1 + self.params.ksTo[2] * (ct));

        var gain: f32 = @floatFromInt(self.frame[778]);
        if (gain > 32767) {
            gain = gain - 65536;
        }

        const gee: f32 = @floatFromInt(self.params.gainEE);
        gain = gee / gain;

        const mode: f32 = @floatFromInt((self.frame[832] & 0x1000) >> 5);

        var irDataCP = [2]f32{
            @floatFromInt(self.frame[776]),
            @floatFromInt(self.frame[808]),
        };

        for (0..2) |i| {
            if (irDataCP[i] > 32767) {
                irDataCP[i] = irDataCP[i] - 65536;
            }
            irDataCP[i] = irDataCP[i] * gain;
        }

        var cpo: f32 = @floatFromInt(self.params.cpOffset[0]);
        irDataCP[0] = irDataCP[0] - cpo * (1 + self.params.cpKta * (ta - 25)) * (1 + self.params.cpKv * (vdd - 3.3));

        const cmee: f32 = @floatFromInt(self.params.calibrationModeEE);
        cpo = @floatFromInt(self.params.cpOffset[1]);
        if (mode == cmee) {
            irDataCP[1] = irDataCP[1] - cpo * (1 + self.params.cpKta * (ta - 25)) * (1 + self.params.cpKv * (vdd - 3.3));
        } else {
            irDataCP[1] = irDataCP[1] - (cpo + self.params.ilChessC[0]) * (1 + self.params.cpKta * (ta - 25)) * (1 + self.params.cpKv * (vdd - 3.3));
        }

        var range: u8 = 0;
        var pattern: i32 = 0;
        var pixelNumber: i32 = 0;
        for (0..768) |i| {
            pixelNumber = @intCast(i);
            const ilPattern: i32 = @divTrunc(pixelNumber, 32) - @divTrunc(pixelNumber, 64) * 2;
            const chessPattern: i32 = ilPattern ^ (pixelNumber - @divTrunc(pixelNumber, 2) * 2);
            const conversionPattern: i32 = (@divTrunc((pixelNumber + 2), 4) - @divTrunc((pixelNumber + 3), 4) + @divTrunc((pixelNumber + 1), 4) - @divTrunc(pixelNumber, 4)) * (1 - 2 * ilPattern);

            if (mode == 0) {
                pattern = ilPattern;
            } else {
                pattern = chessPattern;
            }

            var irData: f32 = @floatFromInt(self.frame[i]);
            if (irData > 32767) {
                irData = irData - 65536;
            }

            irData = irData * gain;

            const ktax: f32 = @floatFromInt(self.params.kta[i]);
            const kta: f32 = ktax / ktaScale;
            const kvx: f32 = @floatFromInt(self.params.kv[i]);
            const kv: f32 = kvx / kvScale;
            const offsetx: f32 = @floatFromInt(self.params.offset[i]);
            irData = irData - offsetx * (1 + kta * (ta - 25)) * (1 + kv * (vdd - 3.3));

            if (mode != cmee) {
                const x: f32 = @floatFromInt(ilPattern);
                const y: f32 = @floatFromInt(conversionPattern);
                irData = irData + self.params.ilChessC[2] * (2 * x - 1) - self.params.ilChessC[1] * y;
            }

            irData = irData - self.params.tgc * irDataCP[subPage];
            irData = irData / self.emissivity;

            const alphax: f32 = @floatFromInt(self.params.alpha[i]);
            var alphaCompensated: f32 = self.scale_alpha * alphaScale / alphax;
            alphaCompensated = alphaCompensated * (1 + self.params.KsTa * (ta - 25));

            var Sx: f32 = alphaCompensated * alphaCompensated * alphaCompensated * (irData + alphaCompensated * taTr);
            Sx = std.math.sqrt(std.math.sqrt(Sx)) * self.params.ksTo[1];

            var To: f32 = std.math.sqrt(std.math.sqrt(irData / (alphaCompensated * (1 - self.params.ksTo[1] * 273.15) + Sx) + taTr)) - 273.15;
            const x: i16 = @intFromFloat(To);
            if (x < self.params.ct[1]) {
                range = 0;
            } else if (x < self.params.ct[2]) {
                range = 1;
            } else if (x < self.params.ct[3]) {
                range = 2;
            } else {
                range = 3;
            }

            const y: f32 = @floatFromInt(self.params.ct[range]);
            To = std.math.sqrt(std.math.sqrt(irData / (alphaCompensated * alphaCorrR[range] * (1 + self.params.ksTo[range] * (To - y))) + taTr)) - 273.15;
            result[i] = To;
        }
    }

    pub fn load_frame(self: *Self) !void {
        var ready: bool = false;
        for (self.frame_loop) |i| {
            while (!ready) {
                try self.write_then_read(Self.registers.status, self.frame[833..834]);
                ready = self.is_ready(i, self.frame[833]);
                self.clock_device.sleep_ms(10);
            }

            try self.write_then_read(Self.registers.ram, self.frame[0..832]);
            ready = false;
        }

        try self.write_then_read(Self.registers.control, self.frame[832..833]);
    }

    fn getVdd(self: *Self) f32 {
        var vdd: f32 = @floatFromInt(self.frame[810]);
        if (vdd > 32767) {
            vdd -= 65536;
        }

        const resolutionRAM: f32 = @floatFromInt((self.frame[832] & 0x0C00) >> 10);
        const resolutionCorrection = std.math.pow(f32, 2, @floatFromInt(self.params.resolutionEE)) / std.math.pow(f32, 2, resolutionRAM);
        const vdd25: f32 = @floatFromInt(self.params.vdd25);
        const kvdd: f32 = @floatFromInt(self.params.kVdd);
        vdd = (resolutionCorrection * vdd - vdd25) / kvdd + 3.3;

        return vdd;
    }

    fn getTa(self: *Self, vdd: f32) f32 {
        var ptat: f32 = @floatFromInt(self.frame[800]);
        if (ptat > 32767) {
            ptat = ptat - 65536;
        }

        var ptatArt: f32 = @floatFromInt(self.frame[768]);
        if (ptatArt > 32767) {
            ptatArt = ptatArt - 65536;
        }

        const vPTA25: f32 = @floatFromInt(self.params.vPTAT25);

        ptatArt = (ptat / (ptat * self.params.alphaPTAT + ptatArt)) * std.math.pow(f32, 2, 18);
        var ta: f32 = (ptatArt / (1 + self.params.KvPTAT * (vdd - 3.3)) - vPTA25);
        ta = ta / self.params.KtPTAT + 25;

        return ta;
    }

    fn is_ready(_: *Self, i: u1, status: u16) bool {
        return @as(u1, @truncate(status & 0b1)) == i and @as(u1, @truncate((status >> 3) & 0b1)) == 1;
    }

    pub fn extract_parameters(self: *Self) !void {
        try self.write_then_read(Self.registers.eeprom, &self.eeprom);
        self.extract_vdd();
        self.extract_ptat();
        self.extact_gain();
        self.extract_tgc();
        self.extract_resolution();
        self.extract_kta();
        self.extract_ksto();
        self.extract_cp();
        self.extract_alpha();
        self.extract_offset();
        self.extract_kta_pixel();
        self.extract_ky_pixel();
        self.extract_cilc();
        const err: i16 = self.extract_deviating_pixels();
        if (err > 0) {
            return Mlx90649Error.BadPixels;
        }
    }

    fn extract_vdd(self: *Self) void {
        self.params.kVdd = @intCast((self.eeprom[51] & 0xFF00) >> 8);
        if (self.params.kVdd > 127) {
            self.params.kVdd = (self.params.kVdd - 256);
        }

        self.params.kVdd *= 32;

        var vdd25: i32 = self.eeprom[51] & 0x00FF;
        vdd25 = ((vdd25 - 256) << 5) - 8192;
        self.params.vdd25 = @intCast(vdd25);
    }

    fn extract_ptat(self: *Self) void {
        self.params.KvPTAT = @floatFromInt((self.eeprom[50] & 0xFC00) >> 10);
        if (self.params.KvPTAT > 31) {
            self.params.KvPTAT = self.params.KvPTAT - 64;
        }
        self.params.KvPTAT = self.params.KvPTAT / 4096;

        self.params.KtPTAT = @floatFromInt(self.eeprom[50] & 0x03FF);
        if (self.params.KtPTAT > 511) {
            self.params.KtPTAT = self.params.KtPTAT - 1024;
        }

        self.params.KtPTAT = self.params.KtPTAT / 8;

        self.params.vPTAT25 = @intCast(self.eeprom[49]);

        const x: f32 = @floatFromInt(self.eeprom[16] & 0xF000);
        const y: f32 = std.math.pow(f32, 2, 14);
        self.params.alphaPTAT = (x / y) + 8.0;
    }

    fn extact_gain(self: *Self) void {
        self.params.gainEE = @intCast(self.eeprom[48]);
        if (self.params.gainEE > 32767) {
            self.params.gainEE -= -65536;
        }
    }

    fn extract_tgc(self: *Self) void {
        self.params.tgc = @floatFromInt(self.eeprom[60] & 0x00FF);
        if (self.params.tgc > 127) {
            self.params.tgc -= -256;
        }
        self.params.tgc /= 32.0;
    }

    fn extract_resolution(self: *Self) void {
        self.params.resolutionEE = @truncate((self.eeprom[56] & 0x3000) >> 12);
    }

    fn extract_kta(self: *Self) void {
        self.params.KsTa = @floatFromInt((self.eeprom[60] & 0xFF00) >> 8);
        if (self.params.KsTa > 127) {
            self.params.KsTa -= 256;
        }
        self.params.KsTa /= 8192.0;
    }

    fn extract_ksto(self: *Self) void {
        const step: i16 = @intCast(((self.eeprom[63] & 0x3000) >> 12) * 10);
        self.params.ct[0] = -40;
        self.params.ct[1] = 0;
        self.params.ct[2] = @intCast((self.eeprom[63] & 0x00F0) >> 4);
        self.params.ct[2] *= step;
        self.params.ct[3] = @intCast((self.eeprom[63] & 0x0F00) >> 8);
        self.params.ct[3] *= step;

        self.params.ksTo[0] = @floatFromInt(self.eeprom[61] & 0x00FF);
        self.params.ksTo[1] = @floatFromInt((self.eeprom[61] & 0xFF00) >> 8);
        self.params.ksTo[2] = @floatFromInt(self.eeprom[62] & 0x00FF);
        self.params.ksTo[3] = @floatFromInt((self.eeprom[62] & 0xFF00) >> 8);

        const x: u5 = @intCast((self.eeprom[63] & 0x000F) + 8);
        const y: u32 = @as(u32, 1) << x;
        const KsToScale: f32 = @floatFromInt(y);

        for (0..4) |i| {
            if (self.params.ksTo[i] > 127) {
                self.params.ksTo[i] -= 256;
            }
            self.params.ksTo[i] /= KsToScale;
        }
        self.params.ksTo[4] = -0.0002;
    }

    fn extract_cp(self: *Self) void {
        const alphaScale: u16 = ((self.eeprom[32] & 0xF000) >> 12) + 27;

        self.params.cpOffset[0] = @intCast(self.eeprom[58] & 0x03FF);
        if (self.params.cpOffset[0] > 511) {
            self.params.cpOffset[0] = self.params.cpOffset[0] - 1024;
        }

        self.params.cpOffset[1] = @intCast((self.eeprom[58] & 0xFC00) >> 10);
        if (self.params.cpOffset[1] > 31) {
            self.params.cpOffset[1] = self.params.cpOffset[1] - 64;
        }

        self.params.cpAlpha[0] = @floatFromInt(self.eeprom[57] & 0x03FF);
        if (self.params.cpAlpha[0] > 511) {
            self.params.cpAlpha[0] -= 1024;
        }

        self.params.cpAlpha[0] /= (std.math.pow(f32, 2, @floatFromInt(alphaScale)));

        self.params.cpAlpha[1] = @floatFromInt((self.eeprom[57] & 0xFC00) >> 10);
        if (self.params.cpAlpha[1] > 31) {
            self.params.cpAlpha[1] -= 64;
        }

        self.params.cpAlpha[1] = (1 + self.params.cpAlpha[1] / 128) * self.params.cpAlpha[0];

        self.params.cpKta = @floatFromInt(self.eeprom[59] & 0x00FF);
        if (self.params.cpKta > 127) {
            self.params.cpKta -= 256;
        }

        const ktaScale1: f32 = @floatFromInt(((self.eeprom[56] & 0x00F0) >> 4) + 8);
        self.params.cpKta /= std.math.pow(f32, 2, ktaScale1);

        self.params.cpKv = @floatFromInt((self.eeprom[59] & 0xFF00) >> 8);
        if (self.params.cpKv > 127) {
            self.params.cpKv -= 256;
        }

        const kvScale: f32 = @floatFromInt((self.eeprom[56] & 0x0F00) >> 8);
        self.params.cpKv /= std.math.pow(f32, 2, kvScale);
    }

    fn extract_alpha(self: *Self) void {
        const accRemScale: u3 = @intCast(self.eeprom[32] & 0x0F);
        const accColumnScale: u4 = @intCast((self.eeprom[32] & 0x00F0) >> 4);
        const accRowScale: u4 = @intCast((self.eeprom[32] & 0x0F00) >> 8);
        var alphaScale: f32 = @floatFromInt(((self.eeprom[32] & 0xF000) >> 12) + 30);
        const alphaRef: i32 = @intCast(self.eeprom[33]);

        var accRow: [24]i16 = undefined;
        var accColumn: [32]i16 = undefined;

        for (0..6) |i| {
            const p = i * 4;
            accRow[p + 0] = @intCast(self.eeprom[34 + i] & 0x000F);
            accRow[p + 1] = @intCast((self.eeprom[34 + i] & 0x00F0) >> 4);
            accRow[p + 2] = @intCast((self.eeprom[34 + i] & 0x0F00) >> 8);
            accRow[p + 3] = @intCast((self.eeprom[34 + i] & 0xF000) >> 12);
        }

        for (0..24) |i| {
            if (accRow[i] > 7) {
                accRow[i] = accRow[i] - 16;
            }
        }

        for (0..8) |i| {
            const p = i * 4;
            accColumn[p + 0] = @intCast(self.eeprom[40 + i] & 0x000F);
            accColumn[p + 1] = @intCast((self.eeprom[40 + i] & 0x00F0) >> 4);
            accColumn[p + 2] = @intCast((self.eeprom[40 + i] & 0x0F00) >> 8);
            accColumn[p + 3] = @intCast((self.eeprom[40 + i] & 0xF000) >> 12);
        }

        for (0..32) |i| {
            if (accColumn[i] > 7) {
                accColumn[i] = accColumn[i] - 16;
            }
        }

        for (0..24) |i| {
            for (0..32) |j| {
                const p = 32 * i + j;
                self.scratch_data[p] = @floatFromInt((self.eeprom[64 + p] & 0x03F0) >> 4);
                if (self.scratch_data[p] > 31) {
                    self.scratch_data[p] = self.scratch_data[p] - 64;
                }
                const x: f32 = @floatFromInt(@as(u8, 1) << accRemScale);
                self.scratch_data[p] = self.scratch_data[p] * x;
                const y: f32 = @floatFromInt((alphaRef + (accRow[i] << accRowScale) + (accColumn[j] << accColumnScale)));
                self.scratch_data[p] = y + self.scratch_data[p];
                self.scratch_data[p] /= std.math.pow(f32, 2, alphaScale);
                self.scratch_data[p] = self.scratch_data[p] - self.params.tgc * (self.params.cpAlpha[0] + self.params.cpAlpha[1]) / 2;
                self.scratch_data[p] = self.scale_alpha / self.scratch_data[p];
            }
        }

        var temp = self.scratch_data[0];
        for (1..768) |i| {
            if (self.scratch_data[i] > temp) {
                temp = self.scratch_data[i];
            }
        }

        alphaScale = 0;
        while (temp < 32768) {
            temp *= 2;
            alphaScale += alphaScale;
        }

        for (0..768) |i| {
            temp = self.scratch_data[i] * std.math.pow(f32, 2, alphaScale);
            self.params.alpha[i] = @intFromFloat(temp + 0.5);
        }

        self.params.alphaScale = @intFromFloat(alphaScale);
    }

    fn extract_offset(self: *Self) void {
        var occRow: [24]i16 = undefined;
        var occColumn: [32]i16 = undefined;
        const occRemScale: u3 = @intCast(self.eeprom[16] & 0x000F);
        const occColumnScale: u4 = @intCast((self.eeprom[16] & 0x00F0) >> 4);
        const occRowScale: u4 = @intCast((self.eeprom[16] & 0x0F00) >> 8);
        var offsetRef: i32 = @intCast(self.eeprom[17]);

        if (offsetRef > 32767) {
            offsetRef -= 65536;
        }

        for (0..6) |i| {
            const p = i * 4;
            occRow[p + 0] = @intCast(self.eeprom[18 + i] & 0x000F);
            occRow[p + 1] = @intCast((self.eeprom[18 + i] & 0x00F0) >> 4);
            occRow[p + 2] = @intCast((self.eeprom[18 + i] & 0x0F00) >> 8);
            occRow[p + 3] = @intCast((self.eeprom[18 + i] & 0xF000) >> 12);
        }

        for (0..24) |i| {
            if (occRow[i] > 7) {
                occRow[i] -= 16;
            }
        }

        for (0..8) |i| {
            const p = i * 4;
            occColumn[p + 0] = @intCast(self.eeprom[24 + i] & 0x000F);
            occColumn[p + 1] = @intCast((self.eeprom[24 + i] & 0x00F0) >> 4);
            occColumn[p + 2] = @intCast((self.eeprom[24 + i] & 0x0F00) >> 8);
            occColumn[p + 3] = @intCast((self.eeprom[24 + i] & 0xF000) >> 12);
        }

        for (0..32) |i| {
            if (occColumn[i] > 7) {
                occColumn[i] = occColumn[i] - 16;
            }
        }

        for (0..24) |i| {
            for (0..32) |j| {
                const p = 32 * i + j;
                self.params.offset[p] = @intCast((self.eeprom[64 + p] & 0xFC00) >> 10);
                if (self.params.offset[p] > 31) {
                    self.params.offset[p] = self.params.offset[p] - 64;
                }
                self.params.offset[p] = self.params.offset[p] * (@as(u8, 1) << occRemScale);

                const x: i32 = offsetRef + @as(i32, (occRow[i] << occRowScale));
                const y: i32 = (occColumn[j] << occColumnScale);
                const z: i32 = self.params.offset[p];
                self.params.offset[p] = x + y + z;
            }
        }
    }

    fn extract_kta_pixel(self: *Self) void {
        var ktaRC: [4]i8 = undefined;
        var ktaRoCo: i8 = @intCast((self.eeprom[54] & 0xFF00) >> 8);
        if (ktaRoCo > 127) {
            ktaRoCo = ktaRoCo - 256;
        }
        ktaRC[0] = ktaRoCo;

        var ktaReCo: i8 = @intCast(self.eeprom[54] & 0xFF);
        if (ktaReCo > 127) {
            ktaReCo = ktaReCo - 256;
        }
        ktaRC[2] = ktaReCo;

        var ktaRoCe: i8 = @intCast((self.eeprom[55] & 0xFF00) >> 8);
        if (ktaRoCe > 127) {
            ktaRoCe = ktaRoCe - 256;
        }
        ktaRC[1] = ktaRoCe;

        var ktaReCe: i8 = @intCast((self.eeprom[55] & 0xFF));
        if (ktaReCe > 127) {
            ktaReCe = ktaReCe - 256;
        }
        ktaRC[3] = ktaReCe;

        var ktaScale1: u8 = @intCast(((self.eeprom[56] & 0x00F0) >> 4) + 8);
        const ktaScale2: u3 = @intCast(self.eeprom[56] & 0x000F);

        for (0..24) |i| {
            for (0..32) |j| {
                const p = 32 * i + j;
                const split = 2 * (p / 32 - (p / 64) * 2) + p % 2;
                self.scratch_data[p] = @floatFromInt((self.eeprom[64 + p] & 0x000E) >> 1);
                if (self.scratch_data[p] > 3) {
                    self.scratch_data[p] = self.scratch_data[p] - 8;
                }
                const x: f32 = @floatFromInt(@as(u8, 1) << ktaScale2);
                self.scratch_data[p] = self.scratch_data[p] * x;
                const y: f32 = @floatFromInt(ktaRC[split]);
                self.scratch_data[p] = y + self.scratch_data[p];
                self.scratch_data[p] = self.scratch_data[p] / std.math.pow(f32, 2, @floatFromInt(ktaScale1));
                //self.scratch_data[p] = self.scratch_data[p] * self.params.offset[p];
            }
        }

        var temp: f32 = @abs(self.scratch_data[0]);
        for (1..768) |i| {
            if (@abs(self.scratch_data[i]) > temp) {
                temp = @abs(self.scratch_data[i]);
            }
        }

        ktaScale1 = 0;
        while (temp < 64) {
            temp = temp * 2;
            ktaScale1 = ktaScale1 + 1;
        }

        for (0..768) |i| {
            temp = self.scratch_data[i] * std.math.pow(f32, 2, @floatFromInt(ktaScale1));
            if (temp < 0) {
                self.params.kta[i] = @intFromFloat(temp - 0.5);
            } else {
                self.params.kta[i] = @intFromFloat(temp + 0.5);
            }
        }

        self.params.ktaScale = ktaScale1;
    }

    fn extract_ky_pixel(self: *Self) void {
        var KvT: [4]u8 = undefined;
        var KvRoCo: i8 = @intCast((self.eeprom[52] & 0xF000) >> 12);
        if (KvRoCo > 7) {
            KvRoCo = KvRoCo - 16;
        }
        KvT[0] = @intCast(KvRoCo);

        var KvReCo: i8 = @intCast((self.eeprom[52] & 0x0F00) >> 8);
        if (KvReCo > 7) {
            KvReCo = KvReCo - 16;
        }
        KvT[2] = @intCast(KvReCo);

        var KvRoCe: i8 = @intCast((self.eeprom[52] & 0x00F0) >> 4);
        if (KvRoCe > 7) {
            KvRoCe = KvRoCe - 16;
        }
        KvT[1] = @intCast(KvRoCe);

        var KvReCe: i8 = @intCast(self.eeprom[52] & 0x000F);
        if (KvReCe > 7) {
            KvReCe = KvReCe - 16;
        }
        KvT[3] = @intCast(KvReCe);

        var kvScale: u8 = @intCast((self.eeprom[56] & 0x0F00) >> 8);

        for (0..24) |i| {
            for (0..32) |j| {
                const p = 32 * i + j;
                const split = 2 * (p / 32 - (p / 64) * 2) + p % 2;
                self.scratch_data[p] = @floatFromInt(KvT[split]);
                self.scratch_data[p] = self.scratch_data[p] / std.math.pow(f32, 2, @floatFromInt(kvScale));
                //self.scratch_data[p] = self.scratch_data[p] * mlx90640->offset[p];
            }
        }

        var temp: f32 = @abs(self.scratch_data[0]);
        for (1..768) |i| {
            if (@abs(self.scratch_data[i]) > temp) {
                temp = @abs(self.scratch_data[i]);
            }
        }

        kvScale = 0;
        while (temp < 64) {
            temp = temp * 2;
            kvScale = kvScale + 1;
        }

        for (0..768) |i| {
            temp = self.scratch_data[i] * std.math.pow(f32, 2, @floatFromInt(kvScale));
            if (temp < 0) {
                self.params.kv[i] = @intFromFloat(temp - 0.5);
            } else {
                self.params.kv[i] = @intFromFloat(temp + 0.5);
            }
        }

        self.params.kvScale = kvScale;
    }

    fn extract_cilc(self: *Self) void {
        var offsetSP: [2]i16 = undefined;
        var alphaSP: [2]f32 = undefined;
        const alphaScale: u8 = @intCast(((self.eeprom[32] & 0xF000) >> 12) + 27);

        offsetSP[0] = @intCast(self.eeprom[58] & 0x03FF);
        if (offsetSP[0] > 511) {
            offsetSP[0] = offsetSP[0] - 1024;
        }

        offsetSP[1] = @intCast((self.eeprom[58] & 0xFC00) >> 10);
        if (offsetSP[1] > 31) {
            offsetSP[1] = offsetSP[1] - 64;
        }
        offsetSP[1] = offsetSP[1] + offsetSP[0];

        alphaSP[0] = @floatFromInt(self.eeprom[57] & 0x03FF);
        if (alphaSP[0] > 511) {
            alphaSP[0] = alphaSP[0] - 1024;
        }
        alphaSP[0] = alphaSP[0] / std.math.pow(f32, 2, @floatFromInt(alphaScale));

        alphaSP[1] = @floatFromInt((self.eeprom[57] & 0xFC00) >> 10);
        if (alphaSP[1] > 31) {
            alphaSP[1] = alphaSP[1] - 64;
        }
        alphaSP[1] = (1 + alphaSP[1] / 128) * alphaSP[0];

        self.params.cpKta = @floatFromInt(self.eeprom[59] & 0x00FF);
        if (self.params.cpKta > 127) {
            self.params.cpKta = self.params.cpKta - 256;
        }
        const ktaScale1: u8 = @intCast(((self.eeprom[56] & 0x00F0) >> 4) + 8);
        self.params.cpKta /= std.math.pow(f32, 2, @floatFromInt(ktaScale1));

        var cpKv: f32 = @floatFromInt((self.eeprom[59] & 0xFF00) >> 8);
        if (cpKv > 127) {
            cpKv = cpKv - 256;
        }
        const kvScale: u8 = @intCast((self.eeprom[56] & 0x0F00) >> 8);
        self.params.cpKv = cpKv / std.math.pow(f32, 2, @floatFromInt(kvScale));

        self.params.cpAlpha[0] = alphaSP[0];
        self.params.cpAlpha[1] = alphaSP[1];
        self.params.cpOffset[0] = offsetSP[0];
        self.params.cpOffset[1] = offsetSP[1];
    }

    fn extract_deviating_pixels(self: *Self) i16 {
        var pixCnt: u32 = 0;
        for (0..5) |i| {
            pixCnt = @intCast(i);
            self.params.brokenPixels[pixCnt] = 0xFFFF;
            self.params.outlierPixels[pixCnt] = 0xFFFF;
        }

        var brokenPixCnt: u16 = 0;
        var outlierPixCnt: u16 = 0;
        pixCnt = 0;
        while (pixCnt < 768 and brokenPixCnt < 5 and outlierPixCnt < 5) {
            if (self.eeprom[pixCnt + 64] == 0) {
                self.params.brokenPixels[brokenPixCnt] = @intCast(pixCnt);
                brokenPixCnt = brokenPixCnt + 1;
            } else if ((self.eeprom[pixCnt + 64] & 0x0001) != 0) {
                self.params.outlierPixels[outlierPixCnt] = @intCast(pixCnt);
                outlierPixCnt = outlierPixCnt + 1;
            }

            pixCnt = pixCnt + 1;
        }

        var warn: i16 = 0;
        if (brokenPixCnt > 4) {
            warn = -3;
        } else if (outlierPixCnt > 4) {
            warn = -4;
        } else if ((brokenPixCnt + outlierPixCnt) > 4) {
            warn = -5;
        } else {
            for (0..brokenPixCnt) |x| {
                pixCnt = @intCast(x);
                for (pixCnt + 1..brokenPixCnt) |i| {
                    warn = self.check_adjacent_pixels(self.params.brokenPixels[pixCnt], self.params.brokenPixels[i]);
                    if (warn != 0) {
                        return warn;
                    }
                }
            }

            for (0..outlierPixCnt) |x| {
                pixCnt = @intCast(x);
                for (pixCnt + 1..outlierPixCnt) |i| {
                    warn = self.check_adjacent_pixels(self.params.outlierPixels[pixCnt], self.params.outlierPixels[i]);
                    if (warn != 0) {
                        return warn;
                    }
                }
            }

            for (0..brokenPixCnt) |x| {
                pixCnt = @intCast(x);
                for (0..outlierPixCnt) |i| {
                    warn = self.check_adjacent_pixels(self.params.brokenPixels[pixCnt], self.params.outlierPixels[i]);
                    if (warn != 0) {
                        return warn;
                    }
                }
            }
        }

        return warn;
    }

    fn check_adjacent_pixels(_: *Self, pix1: u16, pix2: u16) i16 {
        var pixPosDif: i32 = 0;

        pixPosDif = pix1 - pix2;
        if (pixPosDif > -34 and pixPosDif < -30) {
            return -6;
        }
        if (pixPosDif > -2 and pixPosDif < 2) {
            return -6;
        }
        if (pixPosDif > 30 and pixPosDif < 34) {
            return -6;
        }

        return 0;
    }
};

test "control_register_values" {
    const Test_Datagram = mdf.base.Datagram_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;
    const control_register_data = [_][]const u8{
        &.{ 0b00000010, 0b10000000 }, //refresh rate data
        &.{ 0b00000010, 0b10000000 }, //refresh rate data that is fetched before set_refresh_rate
        &.{ 0b00001100, 0b00000000 }, //resolution data
    };

    var td = Test_Datagram.init(&control_register_data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var camera = try MLX90640.init(.{ .i2c = td.datagram_device(), .clock = tc.clock_device() });

    const rr = try camera.refresh_rate();
    try std.testing.expectEqual(5, rr);

    try camera.set_refresh_rate(3);
    const sent = [_][]const u8{
        &.{ 0x80, 0x0D }, // control register request from first refresh_rate() call
        &.{ 0x80, 0x0D }, // control register request from set_refresh_rate() calling refresh_rate()
        &.{ 0x80, 0x0D, 0b00000001, 0b10000000 },
    };
    try td.expect_sent(&sent);

    const rez = try camera.resolution();
    try std.testing.expectEqual(3, rez);
}
