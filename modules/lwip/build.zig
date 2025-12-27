const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("lwip", .{});

    const lwip = b.addModule("lwip", .{
        .target = target,
        .optimize = optimize,
    });

    lwip.addCSourceFiles(.{
        .root = upstream.path("src"),
        .files = &files,
        .flags = &flags,
    });
    lwip.addIncludePath(upstream.path("src/include"));
}

// pub fn setup(b: *std.Build, dst: *std.Build.Module) void {
//     const upstream = b.dependency("lwip", .{});
//     dst.addIncludePath(upstream.path("src/include"));
//     dst.addIncludePath(b.path("src/kernel/components/network/include"));
// }

const flags = [_][]const u8{ "-std=c99", "-fno-sanitize=undefined" };
const files = [_][]const u8{
    // Core files
    "core/init.c",
    "core/udp.c",
    "core/inet_chksum.c",
    "core/altcp_alloc.c",
    "core/stats.c",
    "core/altcp.c",
    "core/mem.c",
    "core/ip.c",
    "core/pbuf.c",
    "core/netif.c",
    "core/tcp_out.c",
    "core/dns.c",
    "core/tcp_in.c",
    "core/memp.c",
    "core/tcp.c",
    "core/sys.c",
    "core/def.c",
    "core/timeouts.c",
    "core/raw.c",
    "core/altcp_tcp.c",

    // IPv4 implementation:
    "core/ipv4/dhcp.c",
    "core/ipv4/autoip.c",
    "core/ipv4/ip4_frag.c",
    "core/ipv4/etharp.c",
    "core/ipv4/ip4.c",
    "core/ipv4/ip4_addr.c",
    "core/ipv4/igmp.c",
    "core/ipv4/icmp.c",

    // IPv6 implementation:
    "core/ipv6/icmp6.c",
    "core/ipv6/ip6_addr.c",
    "core/ipv6/ip6.c",
    "core/ipv6/ip6_frag.c",
    "core/ipv6/mld6.c",
    "core/ipv6/dhcp6.c",
    "core/ipv6/inet6.c",
    "core/ipv6/ethip6.c",
    "core/ipv6/nd6.c",

    // Interfaces:
    "netif/bridgeif.c",
    "netif/ethernet.c",
    // "netif/slipif.c",
    "netif/bridgeif_fdb.c",

    // sequential APIs
    // "api/err.c",
    // "api/api_msg.c",
    // "api/netifapi.c",
    // "api/sockets.c",
    // "api/netbuf.c",
    // "api/api_lib.c",
    // "api/tcpip.c",
    // "api/netdb.c",
    // "api/if_api.c",

    // 6LoWPAN
    "netif/lowpan6.c",
    "netif/lowpan6_ble.c",
    "netif/lowpan6_common.c",
    "netif/zepif.c",

    // PPP
    // "netif/ppp/polarssl/arc4.c",
    // "netif/ppp/polarssl/des.c",
    // "netif/ppp/polarssl/md4.c",
    // "netif/ppp/polarssl/sha1.c",
    // "netif/ppp/polarssl/md5.c",
    // "netif/ppp/ipcp.c",
    // "netif/ppp/magic.c",
    // "netif/ppp/pppoe.c",
    // "netif/ppp/mppe.c",
    // "netif/ppp/multilink.c",
    // "netif/ppp/chap-new.c",
    // "netif/ppp/auth.c",
    // "netif/ppp/chap_ms.c",
    // "netif/ppp/ipv6cp.c",
    // "netif/ppp/chap-md5.c",
    // "netif/ppp/upap.c",
    // "netif/ppp/pppapi.c",
    // "netif/ppp/pppos.c",
    // "netif/ppp/eap.c",
    // "netif/ppp/pppol2tp.c",
    // "netif/ppp/demand.c",
    // "netif/ppp/fsm.c",
    // "netif/ppp/eui64.c",
    // "netif/ppp/ccp.c",
    // "netif/ppp/pppcrypt.c",
    // "netif/ppp/utils.c",
    // "netif/ppp/vj.c",
    // "netif/ppp/lcp.c",
    // "netif/ppp/ppp.c",
    // "netif/ppp/ecp.c",
};
