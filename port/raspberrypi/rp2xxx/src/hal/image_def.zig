const std = @import("std");
const microzig = @import("microzig");
const app = microzig.app;
const arch = @import("compatibility.zig").arch;

pub const image_def: [5]u32 = if (@hasDecl(app, "image_def")) app.image_def else init(.non_secure);

comptime {
    @export(image_def, .{
        .name = "_image_def",
        .section = ".bootmeta",
        .linkage = .strong,
    });
}

pub const ExeSecurity = enum(u2) {
    unspecified = 0,
    non_secure = 1,
    secure = 2,
};

pub const Cpu = enum(u3) {
    arm = 0,
    riscv = 1,
};

const cpu: Cpu = std.meta.stringToEnum(Cpu, @tagName(arch)).?;

pub fn secure() [5]u32 {
    return init(.secure);
}

pub fn non_secure() [5]u32 {
    return init(.non_secure);
}

fn init(security: ExeSecurity) [5]u32 {
    return .{
        0xffffded3,
        0x10010142 | (@as(u32, @intFromEnum(security)) << 20) | (@as(u32, @intFromEnum(cpu)) << 24),
        0x000001ff,
        0x00000000,
        0xab123579,
    };
}
