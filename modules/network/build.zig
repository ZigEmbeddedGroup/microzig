const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lwip_mod = brk: {
        var buf: [32]u8 = undefined;

        // Configurable options
        const lwip_mem_size = b.option(usize, "lwip_mem_size", "The size of the heap memory") orelse 16 * 1024;
        const lwip_pbuf_pool_size = b.option(usize, "lwip_pbuf_pool_size", "The number of buffers in the packet buffers pool") orelse 32;

        const foundation_dep = b.dependency("foundationlibc", .{
            .target = target,
            .optimize = optimize,
            .single_threaded = true,
        });
        const lwip_dep = b.dependency("lwip", .{
            .target = target,
            .optimize = optimize,
        });
        const lwip_mod = lwip_dep.module("lwip");
        // Link libc
        lwip_mod.linkLibrary(foundation_dep.artifact("foundation"));

        // Configurable memory parameters.
        lwip_mod.addCMacro("MEM_SIZE", to_s(&buf, lwip_mem_size));
        lwip_mod.addCMacro("PBUF_POOL_SIZE", to_s(&buf, lwip_pbuf_pool_size));

        // Fixed memory parameters.
        //
        // MEM_ALIGNMENT of 4 bytes allows us to use packet buffers in u32 dma.
        //
        // Assuming 1500 MTU of layer 3 payload, lwip will add 14 bytes of ethernet
        // header resulting in max 1514 bytes. PBUF_LINK_ENCAPSULATION_HLEN reserves
        // 22 bytes *at the front of each packet buffer*. lwip will write ethernet
        // header at position 22, and leave leading 22 bytes for use in the wifi
        // link interface.
        //
        lwip_mod.addCMacro("MEM_ALIGNMENT", "4"); // 4 bytes, u32 alignment
        lwip_mod.addCMacro("PBUF_POOL_BUFSIZE", "1540"); // 1500 MTU + headers (14 + 22 + 4)
        lwip_mod.addCMacro("PBUF_LINK_HLEN", "14"); // ethernet header len
        lwip_mod.addCMacro("PBUF_LINK_ENCAPSULATION_HLEN", "22"); // WiFi chip header space

        // Path to lwipopts.h
        lwip_mod.addIncludePath(b.path("src/include"));
        break :brk lwip_mod;
    };

    const net_mod = b.addModule("net", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/root.zig"),
    });
    net_mod.addImport("lwip", lwip_mod);
    // Copy macros and include dirs from lwip to net, so we have same values
    // when calling translate-c from cImport.
    for (lwip_mod.c_macros.items) |m| {
        net_mod.c_macros.append(b.allocator, m) catch @panic("out of memory");
    }
    for (lwip_mod.include_dirs.items) |dir| {
        net_mod.include_dirs.append(b.allocator, dir) catch @panic("out of memory");
    }
}

fn to_s(buf: []u8, value: usize) []const u8 {
    return std.fmt.bufPrint(buf, "{d}", .{value}) catch @panic("insufficient to_s buffer");
}
