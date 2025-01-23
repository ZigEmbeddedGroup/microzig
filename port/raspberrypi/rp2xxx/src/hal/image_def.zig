const std = @import("std");
const microzig = @import("microzig");
const app = microzig.app;
const arch = @import("compatibility.zig").arch;

pub const Security = enum(u2) {
    non_secure = 1,
    secure = 2,
};

const Cpu = enum(u3) {
    arm = 0,
    riscv = 1,
};

const security: Security = if (@hasDecl(app, "image_def_security")) app.image_def_security else .secure;
const cpu: Cpu = std.meta.stringToEnum(Cpu, @tagName(arch)).?;

const image_def = init();

comptime {
    @export(&image_def, .{
        .name = "_image_def",
        .section = ".bootmeta",
        .linkage = .strong,
    });
}

fn init() [5]u32 {
    return .{
        0xffffded3,
        0x10010142 | (@as(u32, @intFromEnum(security)) << 20) | (@as(u32, @intFromEnum(cpu)) << 24),
        0x000001ff,
        0x00000000,
        0xab123579,
    };
}
