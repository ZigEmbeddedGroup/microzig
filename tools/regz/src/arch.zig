const std = @import("std");

// concrete arch's that we support in codegen, for stuff like interrupt
// table generation
pub const Arch = enum {
    unknown,

    // arm
    arm_v81_mml,
    arm_v8_mbl,
    arm_v8_mml,
    cortex_a15,
    cortex_a17,
    cortex_a5,
    cortex_a53,
    cortex_a57,
    cortex_a7,
    cortex_a72,
    cortex_a8,
    cortex_a9,
    cortex_m0,
    cortex_m0plus,
    cortex_m1,
    cortex_m23,
    cortex_m3,
    cortex_m33,
    cortex_m35p,
    cortex_m4,
    cortex_m55,
    cortex_m7,
    sc000, // kindof like an m3
    sc300,
    // old
    arm926ej_s,

    // avr
    avr8,
    avr8l,
    avr8x,
    avr8xmega,

    // mips
    mips,

    // riscv
    qingke_v2,
    qingke_v3,
    qingke_v4,
    hazard3,

    msp430,

    pub const BaseType = []const u8;
    pub const default = .unknown;

    pub fn to_string(arch: Arch) []const u8 {
        return @tagName(arch);
    }

    pub fn from_string(arch: []const u8) Arch {
        // Convert ISA string (e.g., "CORTEX_M4", "MSP430") to lowercase and match to Arch enum
        var buf: [32]u8 = undefined;
        // Matches nothing, used to avoid duplicating log statement
        var lower: []u8 = "";

        if (arch.len <= buf.len) {
            lower = std.ascii.lowerString(&buf, arch);
            std.mem.replaceScalar(u8, lower, '-', '_');
        }

        // Try to match against all Arch enum values
        return if (std.meta.stringToEnum(Arch, lower)) |ret|
            ret
        else if (std.mem.eql(u8, "armv8mml", lower))
            .arm_v81_mml
        else if (std.mem.eql(u8, "armv8mbl", lower))
            .arm_v8_mbl
        else if (std.mem.eql(u8, "armv81mml", lower))
            .arm_v8_mml
        else if (std.mem.eql(u8, "avr8x_mega", lower))
            .avr8xmega
        else if (std.mem.eql(u8, "cortex_m0p", lower))
            .cortex_m0plus
        else if (std.mem.eql(u8, "cm0", lower))
            .cortex_m0
        else if (std.mem.eql(u8, "cm0plus", lower))
            .cortex_m0plus
        else if (std.mem.eql(u8, "cm0p", lower))
            .cortex_m0plus
        else if (std.mem.eql(u8, "cm0+", lower))
            .cortex_m0plus
        else if (std.mem.eql(u8, "cm1", lower))
            .cortex_m1
        else if (std.mem.eql(u8, "cm23", lower))
            .cortex_m23
        else if (std.mem.eql(u8, "cm3", lower))
            .cortex_m3
        else if (std.mem.eql(u8, "cm33", lower))
            .cortex_m33
        else if (std.mem.eql(u8, "cm35p", lower))
            .cortex_m35p
        else if (std.mem.eql(u8, "cm4", lower))
            .cortex_m4
        else if (std.mem.eql(u8, "cm55", lower))
            .cortex_m55
        else if (std.mem.eql(u8, "cm7", lower))
            .cortex_m7
        else if (std.mem.eql(u8, "ca5", lower))
            .cortex_a5
        else if (std.mem.eql(u8, "ca7", lower))
            .cortex_a7
        else if (std.mem.eql(u8, "ca8", lower))
            .cortex_a8
        else if (std.mem.eql(u8, "ca9", lower))
            .cortex_a9
        else if (std.mem.eql(u8, "ca15", lower))
            .cortex_a15
        else if (std.mem.eql(u8, "ca17", lower))
            .cortex_a17
        else if (std.mem.eql(u8, "ca53", lower))
            .cortex_a53
        else if (std.mem.eql(u8, "ca57", lower))
            .cortex_a57
        else if (std.mem.eql(u8, "ca72", lower))
            .cortex_a72
        else if (std.mem.eql(u8, "qingkev2", lower))
            .qingke_v2
        else if (std.mem.eql(u8, "qingkev3", lower))
            .qingke_v3
        else if (std.mem.eql(u8, "qingkev4", lower))
            .qingke_v4
        else {
            std.log.warn("Unknown Arch: {s}, defaulting to .unknown", .{arch});
            return .unknown;
        };
    }

    pub fn is_cortex_m(arch: Arch) bool {
        return switch (arch) {
            .cortex_m0,
            .cortex_m0plus,
            .cortex_m1,
            .cortex_m23,
            .cortex_m3,
            .cortex_m33,
            .cortex_m35p,
            .cortex_m4,
            .cortex_m55,
            .cortex_m7,
            => true,
            else => false,
        };
    }

    pub fn is_arm(arch: Arch) bool {
        return switch (arch) {
            .cortex_m0,
            .cortex_m0plus,
            .cortex_m1,
            .sc000, // kindof like an m3
            .cortex_m23,
            .cortex_m3,
            .cortex_m33,
            .cortex_m35p,
            .cortex_m55,
            .sc300,
            .cortex_m4,
            .cortex_m7,
            .arm_v8_mml,
            .arm_v8_mbl,
            .arm_v81_mml,
            .cortex_a5,
            .cortex_a7,
            .cortex_a8,
            .cortex_a9,
            .cortex_a15,
            .cortex_a17,
            .cortex_a53,
            .cortex_a57,
            .cortex_a72,
            .arm926ej_s,
            => true,
            else => false,
        };
    }

    pub fn is_avr(arch: Arch) bool {
        return switch (arch) {
            .avr8,
            .avr8l,
            .avr8x,
            .avr8xmega,
            => true,
            else => false,
        };
    }

    pub fn is_mips(arch: Arch) bool {
        return switch (arch) {
            .mips => true,
            else => false,
        };
    }

    pub fn is_riscv(arch: Arch) bool {
        return switch (arch) {
            .qingke_v2,
            .qingke_v3,
            .qingke_v4,
            .hazard3,
            => true,
            else => false,
        };
    }
};
