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
        return inline for (@typeInfo(Arch).@"enum".fields) |field| {
            if (@field(Arch, field.name) == arch)
                break field.name;
        } else unreachable;
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
