// GATT common types and constants shared between GATTC and GATTS.

pub const att_mtu_default: u16 = 23;
pub const handle_invalid: u16 = 0x0000;
pub const handle_start: u16 = 0x0001;
pub const handle_end: u16 = 0xFFFF;

pub const TimeoutSrc = enum(u8) {
    protocol = 0x00,
};

pub const WriteOp = enum(u8) {
    invalid = 0x00,
    write_req = 0x01,
    write_cmd = 0x02,
    sign_write_cmd = 0x03,
    prep_write_req = 0x04,
    exec_write_req = 0x05,
};

pub const ExecWriteFlag = enum(u8) {
    prepared_cancel = 0x00,
    prepared_write = 0x01,
};

pub const HvxType = enum(u8) {
    invalid = 0x00,
    notification = 0x01,
    indication = 0x02,
};

pub const ConnCfg = extern struct {
    att_mtu: u16,
};

pub const CharProps = packed struct(u8) {
    broadcast: u1 = 0,
    read: u1 = 0,
    write_wo_resp: u1 = 0,
    write: u1 = 0,
    notify: u1 = 0,
    indicate: u1 = 0,
    auth_signed_wr: u1 = 0,
    _pad: u1 = 0,
};

pub const CharExtProps = packed struct(u8) {
    reliable_wr: u1 = 0,
    wr_aux: u1 = 0,
    _pad: u6 = 0,
};

pub const StatusCode = enum(u16) {
    success = 0x0000,
    unknown = 0x0001,
    atterr_invalid = 0x0100,
    atterr_invalid_handle = 0x0101,
    atterr_read_not_permitted = 0x0102,
    atterr_write_not_permitted = 0x0103,
    atterr_invalid_pdu = 0x0104,
    atterr_insuf_authentication = 0x0105,
    atterr_request_not_supported = 0x0106,
    atterr_invalid_offset = 0x0107,
    atterr_insuf_authorization = 0x0108,
    atterr_prepare_queue_full = 0x0109,
    atterr_attribute_not_found = 0x010A,
    atterr_attribute_not_long = 0x010B,
    atterr_insuf_enc_key_size = 0x010C,
    atterr_invalid_att_val_length = 0x010D,
    atterr_unlikely_error = 0x010E,
    atterr_insuf_encryption = 0x010F,
    atterr_unsupported_group_type = 0x0110,
    atterr_insuf_resources = 0x0111,
    _,
};

pub const CpfFormat = enum(u8) {
    rfu = 0x00,
    boolean = 0x01,
    two_bit = 0x02,
    nibble = 0x03,
    uint8 = 0x04,
    uint12 = 0x05,
    uint16 = 0x06,
    uint24 = 0x07,
    uint32 = 0x08,
    uint48 = 0x09,
    uint64 = 0x0A,
    uint128 = 0x0B,
    sint8 = 0x0C,
    sint12 = 0x0D,
    sint16 = 0x0E,
    sint24 = 0x0F,
    sint32 = 0x10,
    sint48 = 0x11,
    sint64 = 0x12,
    sint128 = 0x13,
    float32 = 0x14,
    float64 = 0x15,
    sfloat = 0x16,
    float_ = 0x17,
    duint16 = 0x18,
    utf8s = 0x19,
    utf16s = 0x1A,
    struct_ = 0x1B,
    _,
};
