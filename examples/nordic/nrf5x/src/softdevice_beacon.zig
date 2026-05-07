// BLE beacon example for PCA10040.
//
// Enables the SoftDevice, configures BLE advertising, and broadcasts a
// non-connectable beacon with a device name. LED1 blinks while advertising.
// LED4 is lit on fault or error.
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;
const sd = nrf.softdevice;
const time = nrf.time;

const gap = sd.gap;
const ble = sd.ble;
const sdm = sd.sdm;

pub fn main() void {
    board.init();

    // 1. Enable SoftDevice
    const clock_cfg: sdm.ClockLfCfg = .{
        .source = .rc,
        .rc_ctiv = 16,
        .rc_temp_ctiv = 2,
        .accuracy = .ppm_500,
    };
    sdm.enable(&clock_cfg, fault_handler) catch return signal_error();

    // 2. Enable BLE stack
    var ram_base: u32 = 0x20002800; // must match SoftDevice profile ram_start
    ble.enable(&ram_base) catch return signal_error();

    // 3. Set device name
    const name = "nRF52 Beacon";
    var perm = gap.ConnSecMode.open();
    gap.device_name_set(&perm, name, name.len) catch return signal_error();

    // 4. Build advertising data: flags + complete local name
    var adv_buf = build_adv_data(name);

    // 5. Configure advertising set
    var adv_handle: u8 = 0xFF; // BLE_GAP_ADV_SET_HANDLE_NOT_SET
    var adv_data: gap.AdvData = .{
        .adv_data = gap.Data.from_slice(&adv_buf),
    };
    const adv_params: gap.AdvParams = .{
        .properties = .{
            .type_ = .nonconnectable_nonscannable_undirected,
        },
        .interval = 160, // 100ms (units of 0.625ms)
        .duration = 0, // advertise indefinitely
    };
    gap.adv_set_configure(&adv_handle, &adv_data, &adv_params) catch return signal_error();

    // 6. Start advertising
    gap.adv_start(adv_handle, ble.conn_cfg_tag_default) catch return signal_error();

    // 7. Blink LED1 while advertising
    while (true) {
        board.led1.toggle();
        time.sleep_ms(1000);
    }
}

fn build_adv_data(name: []const u8) [31]u8 {
    var buf: [31]u8 = .{0} ** 31;
    var pos: usize = 0;

    // AD structure: flags
    buf[pos] = 2; // length
    buf[pos + 1] = gap.ad_type.flags;
    buf[pos + 2] = gap.adv_flag.le_only_general_disc_mode;
    pos += 3;

    // AD structure: complete local name
    const name_len: u8 = @intCast(name.len);
    buf[pos] = name_len + 1; // length (type byte + name)
    buf[pos + 1] = gap.ad_type.complete_local_name;
    @memcpy(buf[pos + 2 .. pos + 2 + name_len], name);

    return buf;
}

fn signal_error() void {
    board.led4.put(board.led_active_state);
    while (true) {}
}

fn fault_handler(_: sdm.FaultId, _: u32, _: u32) callconv(.c) void {
    signal_error();
}
