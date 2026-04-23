// SoftDevice variant definitions — feature flags and SVC offset tables.
//
// S112/S113/S132/S140 share identical SVC offsets for common GAP functions.
// S122 has different offsets because it omits central/observer functions,
// causing subsequent entries to pack into lower positions.

pub const Variant = enum {
    s112,
    s113,
    s122,
    s132,
    s140,

    /// Central role support (initiating connections, encrypting as central).
    pub fn has_central(comptime self: Variant) bool {
        return self == .s132 or self == .s140;
    }

    /// Observer role support (scanning).
    pub fn has_observer(comptime self: Variant) bool {
        return self == .s113 or self == .s132 or self == .s140;
    }

    /// L2CAP Connection-Oriented Channels.
    pub fn has_l2cap_coc(comptime self: Variant) bool {
        return self == .s132 or self == .s140;
    }

    /// QoS channel survey.
    pub fn has_qos_survey(comptime self: Variant) bool {
        return self == .s122 or self == .s132 or self == .s140;
    }

    /// Resolve a GAP function to its full SVC number.
    pub fn gap_svc(comptime self: Variant, comptime func: GapFunc) u32 {
        const base: u32 = 0x6C;
        if (self == .s122) {
            return base + s122_gap_offsets[@intFromEnum(func)];
        }
        return base + @intFromEnum(func);
    }
};

/// GAP SVC function identifiers. Enum values match the standard
/// (S112/S113/S132/S140) offsets from GAP SVC base (0x6C).
pub const GapFunc = enum(u8) {
    addr_set = 0,
    addr_get = 1,
    whitelist_set = 2,
    device_identities_set = 3,
    privacy_set = 4,
    privacy_get = 5,
    adv_set_configure = 6,
    adv_start = 7,
    adv_stop = 8,
    conn_param_update = 9,
    disconnect = 10,
    tx_power_set = 11,
    appearance_set = 12,
    appearance_get = 13,
    ppcp_set = 14,
    ppcp_get = 15,
    device_name_set = 16,
    device_name_get = 17,
    authenticate = 18,
    sec_params_reply = 19,
    auth_key_reply = 20,
    lesc_dhkey_reply = 21,
    keypress_notify = 22,
    lesc_oob_data_get = 23,
    lesc_oob_data_set = 24,
    encrypt = 25,
    sec_info_reply = 26,
    conn_sec_get = 27,
    rssi_start = 28,
    rssi_stop = 29,
    scan_start = 30,
    scan_stop = 31,
    connect = 32,
    connect_cancel = 33,
    rssi_get = 34,
    phy_update = 35,
    data_length_update = 36,
    qos_channel_survey_start = 37,
    qos_channel_survey_stop = 38,
    adv_addr_get = 39,
    next_conn_evt_counter_get = 40,
    conn_evt_trigger_start = 41,
    conn_evt_trigger_stop = 42,
};

/// S122 GAP SVC offsets. Functions absent on S122 (encrypt, scan_start/stop,
/// connect/cancel) are omitted, causing all subsequent functions to shift
/// into lower positions.
const s122_gap_offsets: [43]u8 = blk: {
    var t: [43]u8 = .{0} ** 43;
    // 0–24: identical to standard offsets
    for (0..25) |i| t[i] = @intCast(i);
    // 25 onward: skip encrypt (std 25), scan_start/stop (std 30-31),
    // connect/cancel (std 32-33)
    t[@intFromEnum(GapFunc.sec_info_reply)] = 25;
    t[@intFromEnum(GapFunc.conn_sec_get)] = 26;
    t[@intFromEnum(GapFunc.rssi_start)] = 27;
    t[@intFromEnum(GapFunc.rssi_stop)] = 28;
    t[@intFromEnum(GapFunc.rssi_get)] = 29;
    t[@intFromEnum(GapFunc.phy_update)] = 30;
    t[@intFromEnum(GapFunc.data_length_update)] = 31;
    t[@intFromEnum(GapFunc.qos_channel_survey_start)] = 32;
    t[@intFromEnum(GapFunc.qos_channel_survey_stop)] = 33;
    t[@intFromEnum(GapFunc.adv_addr_get)] = 34;
    t[@intFromEnum(GapFunc.next_conn_evt_counter_get)] = 35;
    t[@intFromEnum(GapFunc.conn_evt_trigger_start)] = 36;
    t[@intFromEnum(GapFunc.conn_evt_trigger_stop)] = 37;
    break :blk t;
};
