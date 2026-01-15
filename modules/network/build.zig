const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const ethernet_header = 14;

    // Configurable options
    const mem_size = b.option(
        usize,
        "mem_size",
        "The size of the heap memory",
    ) orelse 16 * 1024;
    const pbuf_pool_size = b.option(
        usize,
        "pbuf_pool_size",
        "The number of buffers in the packet buffer pool",
    ) orelse 32;
    const mtu = b.option(
        u16,
        "mtu",
        "Layer 3 MTU, includes TCP/UDP and IP headers, don't include layer 2 Ethernet header",
    ) orelse 1500;
    const pbuf_header_length = b.option(
        u16,
        "pbuf_header_length",
        "The number of bytes allocated in packet buffer before Ethernet header for use in the underlying link driver",
    ) orelse 0;
    const pbuf_length = b.option(
        u16,
        "pbuf_length",
        "The size of each packet buffer in the pool",
    ) orelse mtu + ethernet_header + pbuf_header_length;

    if (pbuf_length < mtu + ethernet_header + pbuf_header_length) {
        @panic("Invalid lwip packet buffer length");
    }

    const lwip_mod = brk: {
        var buf: [32]u8 = undefined;

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

        // MEM_ALIGNMENT of 4 bytes allows us to use packet buffers in u32 dma.
        lwip_mod.addCMacro("MEM_ALIGNMENT", "4");
        lwip_mod.addCMacro("MEM_SIZE", to_s(&buf, mem_size));
        lwip_mod.addCMacro("PBUF_POOL_SIZE", to_s(&buf, pbuf_pool_size));
        lwip_mod.addCMacro("PBUF_LINK_HLEN", to_s(&buf, ethernet_header));
        lwip_mod.addCMacro("PBUF_POOL_BUFSIZE", to_s(&buf, pbuf_length));
        lwip_mod.addCMacro("PBUF_LINK_ENCAPSULATION_HLEN", to_s(&buf, pbuf_header_length));
        // 40 bytes IPv6 header, 20 bytes TCP header
        lwip_mod.addCMacro("TCP_MSS", to_s(&buf, mtu - 40 - 20));

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
    const options = b.addOptions();
    options.addOption(u16, "mtu", mtu);
    options.addOption(u16, "pbuf_length", pbuf_length);
    options.addOption(u16, "pbuf_header_length", pbuf_header_length);
    net_mod.addOptions("config", options);
}

fn to_s(buf: []u8, value: usize) []const u8 {
    return std.fmt.bufPrint(buf, "{d}", .{value}) catch @panic("insufficient to_s buffer");
}
