/// Numbered hardware types.
/// Bassed on RFC 1700. Avalable at: https://www.rfc-editor.org/info/rfc1700/
pub const HardwareType = enum(u8) {
    ethernet = 1,
    experimental_ethernet,
    ax_25,
    token_ring,
    chaos,
    ieee_802,
    arcnet,
    hyperchannel,
    lanstar,
    _,
};

/// DHCP option and BOOTP vendor codes
/// Bassed on RFC 2132. Avalable at: https://www.rfc-editor.org/info/rfc2132/
pub const OptionCode = enum(u8) {
    subnet_mask = 1,
    requested_ip_address = 50,
    lease_time = 51,
    dhcp_message_type = 53,
    dhcp_server_id = 54,
    end = 0xff,
    _,
};

/// DHCP message type codes
/// Bassed on RFC 2132. Avalable at: https://www.rfc-editor.org/info/rfc2132/
pub const DHCPMessageType = enum(u8) {
    discover = 1,
    offor,
    request,
    decline,
    acknowledge,
    no_acknowledge,
    release,
    inform,
    _,

    pub fn int(self: @This()) u8 {
        return @backingInt(self);
    }
};

/// DHCP fixed length payload.
/// Bassed on RFC 2131. Avalable at: www.rfc-editor.org/info/rfc2131/
pub const DHCPPayload = extern struct {
    const Flags = packed struct(u16) { reserved: u15 = 0, broadcast: u1 = 1 };
    const OpCode = enum(u8) { request = 1, reply, _ };
    const IpAddress = [4]u8;
    op: OpCode,
    htype: HardwareType,
    /// Hardware address length.
    hlen: u8,
    hops: u8,
    /// Transaction id. Set by client.
    xid: u32,
    /// Seconds since beinging of transaction. Set by client.
    secs: u16,
    flags: Flags = .{},
    /// Client IP address.
    ciaddr: IpAddress,
    /// Your offered IP address.
    yiaddr: IpAddress,
    /// Server IP addresss. Set by server.
    siaddr: IpAddress,
    /// Gateway IP address. Used when booting via relay agent.
    giaddr: IpAddress,
    /// Client hardware address. Typically the MAC address.
    chaddr: [16]u8,
    /// Optional server host name. Can be null for modern DHCP
    sname: [64]u8 = @splat(0),
    /// Boot file name. Can be null for modern DHCP.
    file: [128]u8 = @splat(0),
};
