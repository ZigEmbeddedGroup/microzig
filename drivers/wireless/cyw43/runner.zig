const std = @import("std");
const consts = @import("consts.zig");
const NVRAM = @import("nvram.zig").NVRAM;
const Bus = @import("bus.zig").Bus;
const ioctl = @import("ioctl.zig");

const log = std.log.scoped(.cyw43_runner);

pub const Runner = struct {
    const Self = @This();
    const chip_log = std.log.scoped(.cyw43_chip);
    chip_log_state: LogState = .{},

    bus: Bus,

    pub fn init(self: *Self) !void {
        try self.bus.init();

        // Init ALP (Active Low Power) clock
        {
            _ = self.bus.write_int(u8, .backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR, consts.BACKPLANE_ALP_AVAIL_REQ);
            _ = self.bus.write_int(u8, .backplane, consts.REG_BACKPLANE_FUNCTION2_WATERMARK, 0x10);
            const watermark = self.bus.read_int(u8, .backplane, consts.REG_BACKPLANE_FUNCTION2_WATERMARK);
            if (watermark != 0x10) {
                log.err("unexpected watermark {x}", .{watermark});
                return error.Cyw43Watermark;
            }
            // waiting for clock...
            while (self.bus.read_int(u8, .backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR) & consts.BACKPLANE_ALP_AVAIL == 0) {}
            // clear request for ALP
            self.bus.write_int(u8, .backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR, 0);

            // const chip_id = self.bus.bp_read_int(u16, chip.pmu_base_address);
            // log.debug("chip ID: 0x{X}", .{chip_id});
        }
        // Upload firmware
        {
            self.core_disable(.wlan);
            self.core_disable(.socram); // TODO: is this needed if we reset right after?
            self.core_reset(.socram);

            // this is 4343x specific stuff: Disable remap for SRAM_3
            self.bus.bp_write_int(u32, chip.socsram_base_address + 0x10, 3);
            self.bus.bp_write_int(u32, chip.socsram_base_address + 0x44, 0);

            const firmware = @embedFile("firmware/43439A0_7_95_61.bin");
            self.bus.bp_write(chip.atcm_ram_base_address, firmware);
        }
        // Load nvram
        {
            const nvram_len = (NVRAM.len + 3) / 4 * 4; // Round up to 4 bytes.
            const addr_magic = chip.atcm_ram_base_address + chip.chip_ram_size - 4;
            const addr = addr_magic - nvram_len;
            self.bus.bp_write(addr, NVRAM);

            const nvram_len_words = nvram_len / 4;
            const nvram_len_magic = (~nvram_len_words << 16) | nvram_len_words;
            self.bus.bp_write_int(u32, addr_magic, nvram_len_magic);
        }
        // starting up core...
        self.core_reset(.wlan);
        try self.core_is_up(.wlan);

        // wait until HT clock is available; takes about 29ms
        while (self.bus.read_int(u8, .backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR) & 0x80 == 0) {}

        // "Set up the interrupt mask and enable interrupts"
        self.bus.bp_write_int(u32, chip.sdiod_core_base_address + consts.SDIO_INT_HOST_MASK, consts.I_HMB_SW_MASK);

        self.bus.write_int(u16, .bus, consts.REG_BUS_INTERRUPT_ENABLE, consts.IRQ_F2_PACKET_AVAILABLE);

        // "Lower F2 Watermark to avoid DMA Hang in F2 when SD Clock is stopped."
        self.bus.write_int(u8, .backplane, consts.REG_BACKPLANE_FUNCTION2_WATERMARK, consts.SPI_F2_WATERMARK);

        // waiting for F2 to be ready...
        while (self.bus.read_int(u32, .bus, consts.REG_BUS_STATUS) & consts.STATUS_F2_RX_READY == 0) {}

        // clear pad pulls
        self.bus.write_int(u8, .backplane, consts.REG_BACKPLANE_PULL_UP, 0);
        _ = self.bus.read_int(u8, .backplane, consts.REG_BACKPLANE_PULL_UP);

        // start HT clock
        self.bus.write_int(u8, .backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR, 0x10);
        while (self.bus.read_int(u8, .backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR) & 0x80 == 0) {}

        // Load Country Locale Matrix (CLM)
        {
            const data = @embedFile("firmware/43439A0_clm.bin");
            const chunk_len = 512;

            var clr: extern struct {
                name: [8]u8 = "clmload\x00".*,
                flag: u16 = 0,
                typ: u16 = 2,
                len: u32 = 0,
                crc: u32 = 0,
            } = .{};

            var nbytes: usize = 0;
            while (nbytes < data.len) {
                const n = @min(chunk_len, data.len - nbytes);
                clr.flag = 1 << 12 | (if (nbytes > 0) @as(u16, 0) else 2) | (if (nbytes + n >= data.len) @as(u16, 4) else 0);
                clr.len = n;
                const cmd_name = std.mem.asBytes(&clr);
                // HACK: remove 1 byte from name, set_var adds sentinel, works because crc is always 0
                try self.set_var(cmd_name[0 .. cmd_name.len - 1], data[nbytes..][0..n]);
                nbytes += n;
            }
        }

        self.log_init();
    }

    fn core_disable(self: *Self, core: Core) void {
        const base = core.base_addr();

        // Dummy read?
        _ = self.bus.bp_read_int(u8, base + consts.AI_RESETCTRL_OFFSET);

        // Check it isn't already reset
        const r = self.bus.bp_read_int(u8, base + consts.AI_RESETCTRL_OFFSET);
        if (r & consts.AI_RESETCTRL_BIT_RESET != 0) {
            return;
        }

        self.bus.bp_write_int(u8, base + consts.AI_IOCTRL_OFFSET, 0);
        _ = self.bus.bp_read_int(u8, base + consts.AI_IOCTRL_OFFSET);

        self.sleep_ms(1);

        self.bus.bp_write_int(u8, base + consts.AI_RESETCTRL_OFFSET, consts.AI_RESETCTRL_BIT_RESET);
        _ = self.bus.bp_read_int(u8, base + consts.AI_RESETCTRL_OFFSET);
    }

    fn core_reset(self: *Self, core: Core) void {
        self.core_disable(core);

        const base = core.base_addr();

        self.bus.bp_write_int(u8, base + consts.AI_IOCTRL_OFFSET, consts.AI_IOCTRL_BIT_FGC | consts.AI_IOCTRL_BIT_CLOCK_EN);
        _ = self.bus.bp_read_int(u8, base + consts.AI_IOCTRL_OFFSET);

        self.bus.bp_write_int(u8, base + consts.AI_RESETCTRL_OFFSET, 0);

        self.sleep_ms(1);

        self.bus.bp_write_int(u8, base + consts.AI_IOCTRL_OFFSET, consts.AI_IOCTRL_BIT_CLOCK_EN);
        _ = self.bus.bp_read_int(u8, base + consts.AI_IOCTRL_OFFSET);

        self.sleep_ms(1);
    }

    fn core_is_up(self: *Self, core: Core) !void {
        const base = core.base_addr();

        const io = self.bus.bp_read_int(u8, base + consts.AI_IOCTRL_OFFSET);

        if (io & (consts.AI_IOCTRL_BIT_FGC | consts.AI_IOCTRL_BIT_CLOCK_EN) != consts.AI_IOCTRL_BIT_CLOCK_EN) {
            log.err("core_is_up fail due to bad ioctrl 0x{X}", .{io});
            return error.Cyw43CoreIsUp;
        }

        const r = self.bus.bp_read_int(u8, base + consts.AI_RESETCTRL_OFFSET);
        if (r & (consts.AI_RESETCTRL_BIT_RESET) != 0) {
            log.err("core_is_up fail due to bad resetctrl 0x{X}", .{r});
            return error.Cyw43CoreIsUp;
        }
    }

    fn log_init(self: *Self) void {
        const addr = chip.atcm_ram_base_address + chip.chip_ram_size - 4 - chip.socram_srmem_size;
        const shared_addr = self.bus.bp_read_int(u32, addr);
        log.debug("shared_addr 0x{X}", .{shared_addr});

        var shared: SharedMemData = undefined;
        self.bus.bp_read(shared_addr, std.mem.asBytes(&shared));

        self.chip_log_state.addr = shared.console_addr + 8;
    }

    fn log_read(self: *Self) void {
        var chip_log_mem: SharedMemLog = undefined;
        self.bus.bp_read(self.chip_log_state.addr, std.mem.asBytes(&chip_log_mem));

        const idx = chip_log_mem.idx;

        // If pointer hasn't moved, no need to do anything.
        if (idx == self.chip_log_state.last_idx) {
            return;
        }

        // Read entire buf for now. We could read only what we need, but then we
        // run into annoying alignment issues in `bp_read`.
        var buf: [1024]u8 = undefined;
        self.bus.bp_read(chip_log_mem.buf, &buf);

        while (self.chip_log_state.last_idx != idx) {
            const b = buf[self.chip_log_state.last_idx];
            if (b == '\r' or b == '\n') {
                if (self.chip_log_state.buf_count != 0) {
                    chip_log.debug("{s}", .{self.chip_log_state.buf[0..self.chip_log_state.buf_count]});
                    self.chip_log_state.buf_count = 0;
                }
            } else if (self.chip_log_state.buf_count < self.chip_log_state.buf.len) {
                self.chip_log_state.buf[self.chip_log_state.buf_count] = b;
                self.chip_log_state.buf_count += 1;
            }

            self.chip_log_state.last_idx += 1;
            if (self.chip_log_state.last_idx == 1024) {
                self.chip_log_state.last_idx = 0;
            }
        }
    }

    pub fn event_get_rsp(self: *Self, data: []u32) u32 {
        const status: Status = @bitCast(self.bus.read_int(u32, .bus, consts.REG_BUS_STATUS));
        //log.debug("event_get_rsp {any}", .{status});
        if (!status.f2_packet_available) return 0;
        if (status.packet_length > 0) {
            // Read event data if present
            const bytes_len: usize = @min(status.packet_length, data.len * 4);
            const words_len: usize = (@as(usize, @intCast(bytes_len)) + 3) / 4;
            const rsp = self.bus.read_words(.wlan, 0, @intCast(bytes_len), data[0..words_len]);
            _ = rsp;
            //log.debug("event_get_rsp read_words status: {x} rxlen: {} bytes_len: {} data.len: {} words_len: {}", .{ rsp, rxlen, bytes_len, data.len, words_len });
            // for (data[0..words_len], 0..) |w, i| {
            //     log.debug("response word {} {x}", .{ i, w });
            // }
        } else {
            // // ..or clear interrupt, and discard data
            // self.bus.write_int(u8, .backplane, consts.REG_BACKPLANE_FRAME_CONTROL, 0x01);
            // const v = self.bus.read_int(u16, .bus, consts.REG_BUS_INTERRUPT);
            // self.bus.write_int(u16, .bus, consts.REG_BUS_INTERRUPT, v);
        }
        return status.packet_length;
    }

    pub fn read_clmver(self: *Self) !void {
        const data: [300]u8 = undefined;
        var req = ioctl.Request.init(.get_var, "clmver", false, &data);
        self.bus.write_words(.wlan, 0, req.as_slice());
        try self.wait_response(.get_var);
        //self.read_response(300);
    }

    pub fn read_mac(self: *Self) !void {
        const mac: [6]u8 = undefined;

        var req = ioctl.Request.init(.get_var, "cur_etheraddr", false, &mac);
        self.bus.write_words(.wlan, 0, req.as_slice());
        try self.wait_response(.get_var);
        //self.read_response(6);
    }

    pub fn led_on(self: *Self, on: bool) !void {
        var data: [8]u8 = @splat(0);
        data[0] = 1;
        if (on) {
            data[4] = 1;
        }
        try self.set_var("gpioout", &data);

        // var req = ioctl.Request.init(.set_var, "gpioout", true, &data);
        // self.bus.write_words(.wlan, 0, req.as_slice());
        // self.read_response(0);
    }

    fn set_var(self: *Self, name: []const u8, data: []const u8) !void {
        var req = ioctl.Request.init(.set_var, name, true, data);
        self.bus.write_words(.wlan, 0, req.as_slice());
        try self.wait_response(.set_var);
    }

    fn set_var32(self: *Self, name: []const u8, value: u32) !void {
        var req = ioctl.Request.init(.set_var, name, true, std.mem.asBytes(&value));
        self.bus.write_words(.wlan, 0, req.as_slice());
        try self.wait_response(.set_var);
    }

    fn ioctl_wr_int32(self: *Self, cmd: ioctl.Cmd, value: u32) !void {
        try self.ioctl_wr_data(cmd, std.mem.asBytes(&value));
    }

    fn ioctl_wr_data(self: *Self, cmd: ioctl.Cmd, data: []const u8) !void {
        var req = ioctl.Request.init(cmd, "", true, data);
        self.bus.write_words(.wlan, 0, req.as_slice());
        try self.wait_response(cmd);
    }

    pub fn wait_response(self: *Self, cmd: ioctl.Cmd) !void {
        var sleeps: usize = 0;
        while (sleeps < 8) {
            var rsp: ioctl.Response = .empty;
            const len = self.event_get_rsp(rsp.as_slice());
            //log.debug("wait_response len:    {}", .{len});
            if (len == 0) {
                self.sleep_ms(10);
                sleeps += 1;
                continue;
            }

            if (rsp.bus.len ^ rsp.bus.notlen != 0xffff) {
                log.err("ioctl: invalid reponse len {x} {x}", .{ rsp.bus.len, rsp.bus.notlen });
                return error.IoctlInvalidBusLen;
            }
            if (rsp.bus.chan == .control) {
                const ctl = rsp.ioctl();
                if (ctl.cmd == cmd) {
                    // apsta, ampdu_rx_factor commands are returing status 0xFFFFFFFB
                    if (ctl.status == 0 or ctl.status == 0xFFFFFFFB) {
                        return;
                    }
                    log.err("bus: {}", .{rsp.bus});
                    log.err("clt: {}", .{ctl});
                    log.err("data: {x}", .{rsp.data(255)});
                    log.err("data: '{s}'", .{rsp.data(255)});
                    return error.IoctlInvalicCommandStatus;
                }
            } else {
                // TODO handle event
                log.debug("EVENT in wait_reponse {} {}", .{ sleeps, cmd });
                log.debug("bus: {}", .{rsp.bus});
                log.debug("bdc: {}", .{rsp.bdc()});
                log.debug("data: {x}", .{rsp.data(255)});
            }
        }
        log.err("ioctl: missing response in wait_response", .{});
        return error.IoctlNoResponse;
    }

    pub fn read_response(self: *Self, data_len: usize) void {
        var rsp: ioctl.Response = .empty;

        while (true) {
            rsp = .empty;
            const len = self.event_get_rsp(rsp.as_slice());
            log.debug("read_response len:    {}", .{len});
            if (len == 0) {
                break;
            }
            //log.debug("read_response buffer: {x}", .{std.mem.asBytes(&rsp)[0..len]});
            log.debug("read_response bus:    {}", .{rsp.bus});
            if (rsp.bus.len ^ rsp.bus.notlen != 0xffff) {
                log.err("invalid reponse len {} {}", .{ rsp.bus.len, rsp.bus.notlen });
                break;
            }
            log.debug("read_response ioctl: {}", .{rsp.ioctl()});
            log.debug("read_response data:  '{x}'", .{rsp.data(data_len)});
            break;
            //self.sleep_ms(10);
        }
    }

    pub fn join(self: *Self, ssid: []const u8, pwd: []const u8) !void {
        _ = ssid;
        _ = pwd;
        const bus = &self.bus;

        // Clear pullups
        {
            bus.write_int(u8, .backplane, consts.REG_BACKPLANE_PULL_UP, 0xf);
            bus.write_int(u8, .backplane, consts.REG_BACKPLANE_PULL_UP, 0);
            const val = self.bus.read_int(u8, .backplane, consts.REG_BACKPLANE_PULL_UP);
            log.debug("REG_BACKPLANE_PULL_UP value: {}", .{val});
        }
        // Clear data unavail error
        {
            const val = self.bus.read_int(u16, .bus, consts.REG_BUS_INTERRUPT);
            if (val & 1 > 0)
                self.bus.write_int(u16, .bus, consts.REG_BUS_INTERRUPT, val);
        }
        // Set sleep KSO (should poll to check for success)
        {
            bus.write_int(u8, .backplane, consts.REG_BACKPLANE_SLEEP_CSR, 1);
            bus.write_int(u8, .backplane, consts.REG_BACKPLANE_SLEEP_CSR, 1);
            const val = self.bus.read_int(u8, .backplane, consts.REG_BACKPLANE_PULL_UP);
            log.debug("REG_BACKPLANE_SLEEP_CSR value: {}", .{val});
        }
        // Set country
        {
            // ref: https://github.com/embassy-rs/embassy/blob/96a026c73bad2ebb8dfc78e88c9690611bf2cb97/cyw43/src/structs.rs#L371
            // abbrev++rev++code in u32
            const buf = "XX\x00\x00" ++ "\xFF\xFF\xFF\xFF" ++ "XX\x00\x00";
            //const buf = ioctl.hexToBytes("58580000FFFFFFFF585800000000000000000000");
            //const buf = ioctl.hexToBytes("58580000FFFFFFFF58580000");
            //const buf = "HR\x00\x00" ++ "\xFF\xFF\xFF\xFF" ++ "HR\x00\x00";
            try self.set_var("country", buf);
        }
        try self.ioctl_wr_int32(.set_antdiv, 0);
        // Data aggregation
        {
            try self.set_var32("bus:txglom", 0x00);
            try self.set_var32("apsta", 0x01);
            try self.set_var32("ampdu_ba_wsize", 0x08);
            try self.set_var32("ampdu_mpdu", 0x04);
            try self.set_var32("ampdu_rx_factor", 0x00);
            self.sleep_ms(150);
        }
        // Enable events
        {
            // using events list from: https://github.com/jbentham/picowi/blob/bb33b1e7a15a685f06dda6764b79e429ce9b325e/lib/picowi_join.c#L38
            // ref: https://github.com/jbentham/picowi/blob/bb33b1e7a15a685f06dda6764b79e429ce9b325e/lib/picowi_join.c#L74
            // can be something like:
            // ref: https://github.com/embassy-rs/embassy/blob/96a026c73bad2ebb8dfc78e88c9690611bf2cb97/cyw43/src/control.rs#L242
            const buf = ioctl.hexToBytes("000000008B120102004000000000800100000000000000000000");
            //const buf = ioctl.hexToBytes("00000000ffffffffffffffffffffffffffffffffffffffffffffffff");
            try self.set_var("bsscfg:event_msgs", &buf);
            self.sleep_ms(50);
        }
        // Enable multicast
        {
            var buf: [64]u8 = @splat(0); // space for 10 addresses
            @memcpy(buf[0..4], &[_]u8{ 0x01, 0x00, 0x00, 0x00 }); // number of addresses
            @memcpy(buf[4..][0..6], &[_]u8{ 0x01, 0x00, 0x5E, 0x00, 0x00, 0xFB }); // address
            try self.set_var("mcast_list", &buf);
            self.sleep_ms(50);
        }
        // join_restart function
        {
            try self.ioctl_wr_data(.up, &.{});
            try self.ioctl_wr_int32(.set_gmode, 1);
            try self.ioctl_wr_int32(.set_band, 0);
            try self.set_var32("pm2_sleep_ret", 0xc8);
            try self.set_var32("bcn_li_bcn", 1);
            try self.set_var32("bcn_li_dtim", 1);
            try self.set_var32("assoc_listen", 0x0a);

            try self.ioctl_wr_int32(.set_infra, 1);
            try self.ioctl_wr_int32(.set_auth, 0);
            try self.ioctl_wr_int32(.set_wsec, 6); // wpa security

            try self.set_var("bsscfg:sup_wpa", "\x00\x00\x00\x00\x01\x00\x00\x00");
            try self.set_var("bsscfg:sup_wpa2_eapver", "\x00\x00\x00\x00\xFF\xFF\xFF\xFF");
            try self.set_var("bsscfg:sup_wpa_tmo", "\x00\x00\x00\x00\xC4\x09\x00\x00");
            self.sleep_ms(2);

            // TODO hardcoded pwd
            try self.ioctl_wr_data(.set_wsec_pmk, &ioctl.hexToBytes("0A0001005065726F5A6465726F31"));
            try self.ioctl_wr_int32(.set_infra, 1);
            try self.ioctl_wr_int32(.set_auth, 0);
            try self.ioctl_wr_int32(.set_wpa_auth, 0x80); // wpa

            // TODO hardcoded ssid
            try self.ioctl_wr_data(.set_ssid, &ioctl.hexToBytes("080000006E696E617A617261"));
        }

        for (0..100 * 60) |i| {
            var rsp: ioctl.Response = .empty;
            const len = self.event_get_rsp(rsp.as_slice());
            if (len > 0) {
                if (rsp.bus.len ^ rsp.bus.notlen != 0xffff) {
                    log.err("ioctl: invalid reponse len {x} {x}", .{ rsp.bus.len, rsp.bus.notlen });
                    return error.IoctlInvalidBusLen;
                }
                if (rsp.bus.chan == .control) {
                    log.debug("loop control {}", .{i});
                    log.debug("bus: {}", .{rsp.bus});
                    log.debug("clt: {}", .{rsp.ioctl()});
                } else {
                    log.debug("loop for event {}", .{i});
                    log.debug("bus: {}", .{rsp.bus});
                    log.debug("bdc: {}", .{rsp.bdc()});
                    log.debug("data: {x}", .{rsp.data(255)});
                }
            }
            self.sleep_ms(10);
        }
    }

    fn sleep_ms(self: *Self, delay: u32) void {
        self.bus.sleep_ms(delay);
    }

    pub fn run(self: *Self) void {
        while (true) {
            self.log_read();
        }
    }
};

pub const Chip = struct {
    const WRAPPER_REGISTER_OFFSET: u32 = 0x100000;

    arm_core_base_address: u32,
    socsram_base_address: u32,
    bluetooth_base_address: u32,
    socsram_wrapper_base_address: u32,
    sdiod_core_base_address: u32,
    pmu_base_address: u32,
    chip_ram_size: u32,
    atcm_ram_base_address: u32,
    socram_srmem_size: u32,
    chanspec_band_mask: u32,
    chanspec_band_2g: u32,
    chanspec_band_5g: u32,
    chanspec_band_shift: u32,
    chanspec_bw_10: u32,
    chanspec_bw_20: u32,
    chanspec_bw_40: u32,
    chanspec_bw_mask: u32,
    chanspec_bw_shift: u32,
    chanspec_ctl_sb_lower: u32,
    chanspec_ctl_sb_upper: u32,
    chanspec_ctl_sb_none: u32,
    chanspec_ctl_sb_mask: u32,
};

// CYW43439 chip values
const chip: Chip = .{
    .arm_core_base_address = 0x18003000 + Chip.WRAPPER_REGISTER_OFFSET,
    .socsram_base_address = 0x18004000,
    .bluetooth_base_address = 0x19000000,
    .socsram_wrapper_base_address = 0x18004000 + Chip.WRAPPER_REGISTER_OFFSET,
    .sdiod_core_base_address = 0x18002000,
    .pmu_base_address = 0x18000000,
    .chip_ram_size = 512 * 1024,
    .atcm_ram_base_address = 0,
    .socram_srmem_size = 64 * 1024,
    .chanspec_band_mask = 0xc000,
    .chanspec_band_2g = 0x0000,
    .chanspec_band_5g = 0xc000,
    .chanspec_band_shift = 14,
    .chanspec_bw_10 = 0x0800,
    .chanspec_bw_20 = 0x1000,
    .chanspec_bw_40 = 0x1800,
    .chanspec_bw_mask = 0x3800,
    .chanspec_bw_shift = 11,
    .chanspec_ctl_sb_lower = 0x0000,
    .chanspec_ctl_sb_upper = 0x0100,
    .chanspec_ctl_sb_none = 0x0000,
    .chanspec_ctl_sb_mask = 0x0700,
};

const LogState = struct {
    addr: u32 = 0,
    last_idx: usize = 0,
    buf: [256]u8 = undefined,
    buf_count: usize = 0,
};

const Core = enum(u2) {
    wlan = 0,
    socram = 1,
    sdiod = 2,

    fn base_addr(self: Core) u32 {
        return switch (self) {
            .wlan => chip.arm_core_base_address,
            .socram => chip.socsram_wrapper_base_address,
            .sdiod => chip.sdiod_core_base_address,
        };
    }
};

pub const SharedMemData = extern struct {
    flags: u32,
    trap_addr: u32,
    assert_exp_addr: u32,
    assert_file_addr: u32,
    assert_line: u32,
    console_addr: u32,
    msgtrace_addr: u32,
    fwid: u32,
};

pub const SharedMemLog = extern struct {
    buf: u32,
    buf_size: u32,
    idx: u32,
    out_idx: u32,
};

// ref: datasheet 'Table 5. gSPI Status Field Details'
const Status = packed struct {
    data_not_available: bool, //  The requested read data is not available.
    underflow: bool, //           FIFO underflow occurred due to current (F2, F3) read command.
    overflow: bool, //            FIFO overflow occurred due to current (F1, F2, F3) write command.
    f2_interrupt: bool, //        F2 channel interrupt.
    _reserved1: u1,
    f2_rx_ready: bool, //         F2 FIFO is ready to receive data (FIFO empty).
    _reserved2: u2,
    f2_packet_available: bool, // Packet is available/ready in F2 TX FIFO.
    packet_length: u11, //        Length of packet available in F2 FIFO,
    _reserved3: u12,
};
