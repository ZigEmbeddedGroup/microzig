const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const reg_def = b.addWriteFiles().add("chip.zig",
        \\const microzig = @import("microzig");
        \\
        \\pub const Properties = struct {
        \\    has_vtor: ?bool = null,
        \\    has_mpu: ?bool = null,
        \\    has_fpu: ?bool = null,
        \\    interrupt_priority_bits: ?u8 = null,
        \\    dma_channel_count: ?u32 = null,
        \\};
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const properties: Properties = .{
        \\    .has_vtor = null,
        \\    .has_mpu = null,
        \\    .has_fpu = false,
        \\    .interrupt_priority_bits = null,
        \\    .dma_channel_count = null,
        \\};
        \\
        \\pub const raw_properties = struct {
        \\    pub const @"cpu.fpuPresent" = "false";
        \\};
        \\
        \\pub const interrupts: []const Interrupt = &.{
        \\    .{ .name = "NMI", .index = -14, .description = null },
        \\    .{ .name = "HardFault", .index = -13, .description = null },
        \\    .{ .name = "SVCall", .index = -5, .description = null },
        \\    .{ .name = "PendSV", .index = -2, .description = null },
        \\    .{ .name = "SysTick", .index = -1, .description = null },
        \\};
        \\
        \\pub const VectorTable = extern struct {
        \\    const Handler = microzig.interrupt.Handler;
        \\    const unhandled = microzig.interrupt.unhandled;
        \\
        \\    initial_stack_pointer: *const anyopaque,
        \\    Reset: Handler,
        \\    NMI: Handler = unhandled,
        \\    HardFault: Handler = unhandled,
        \\    reserved2: [7]u32 = undefined,
        \\    SVCall: Handler = unhandled,
        \\    reserved10: [2]u32 = undefined,
        \\    PendSV: Handler = unhandled,
        \\    SysTick: Handler = unhandled,
        \\};
        \\
    );

    const chip = b.allocator.create(microzig.Target) catch @panic("OOM");
    chip.* = .{
        .dep = mz_dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "MSPM0C110X",
            .register_definition = .{ .zig = reg_def },
            .memory_regions = comptime &.{
                .{ .tag = .flash, .offset = 0x0000_0000, .length = 8 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x2000_0000, .length = 1 * 1024, .access = .rwx },
            },
        },
    };

    const raw_blinky = mb.add_firmware(.{
        .name = "raw_blinky_mspm0c110x",
        .target = chip,
        .optimize = optimize,
        .root_source_file = b.path("src/raw_blinky.zig"),
    });

    mb.install_firmware(raw_blinky, .{});
}
