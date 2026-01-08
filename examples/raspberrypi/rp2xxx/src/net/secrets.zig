const net = @import("lwip/net.zig");
const microzig = @import("microzig");
const JoinOptions = microzig.hal.drivers.WiFi.Chip.JoinOptions;

// wifi credentials
pub const ssid = "...";
pub const pwd = "...";
pub const join_opt: JoinOptions = .{ .security = .wpa2_psk };

pub fn nic_options() !net.Interface.Options {
    // to use dhcp assigned ip addres
    return .{};

    // // to use fixed ip change to something like:
    // return .{
    //     .fixed = try .init(
    //         "192.168.190.50", // fixed ip
    //         "255.255.255.0", // subnet mask
    //         "192.168.190.1", // gateway
    //     ),
    // };
}

// IP address of the desktop host computer.
// Some examples will send to that host.
pub const host_ip = "192.168.190.235";
