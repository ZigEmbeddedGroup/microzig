const std = @import("std");
const bus = @import("bus.zig");
const consts = @import("consts.zig");
const nvram = @import("nvram.zig");

/// Callback for microsecond delays
pub const delayus_callback = fn (delay: u32) void;

pub const Cyw43_Runner = struct {
    const Self = @This();
    const log = std.log.scoped(.cyw43_runner);
    const chip_log = std.log.scoped(.cyw43_chip);
    chip_log_state: LogState = .{},

    bus: *bus.Cyw43_Bus,
    internal_delay_ms: *const delayus_callback,

    pub fn init(self: *Self) !void {
        try self.bus.init_bus();

        // Init ALP (Active Low Power) clock
        log.debug("init alp", .{});
        _ = self.bus.write8(.backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR, consts.BACKPLANE_ALP_AVAIL_REQ);

        log.debug("set f2 watermark", .{});
        _ = self.bus.write8(.backplane, consts.REG_BACKPLANE_FUNCTION2_WATERMARK, 0x10);
        const watermark = self.bus.read8(.backplane, consts.REG_BACKPLANE_FUNCTION2_WATERMARK);
        log.debug("watermark = 0x{X}", .{watermark});
        std.debug.assert(watermark == 0x10);

        log.debug("waiting for clock...", .{});
        while (self.bus.read8(.backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR) & consts.BACKPLANE_ALP_AVAIL == 0) {}
        log.debug("clock ok", .{});

        // clear request for ALP
        log.debug("clear request for ALP", .{});
        self.bus.write8(.backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR, 0);

        const chip_id = self.bus.bp_read16(0x1800_0000);
        log.debug("chip ID: 0x{X}", .{chip_id});

        // Upload firmware
        self.core_disable(.wlan);
        self.core_disable(.socram); // TODO: is this needed if we reset right after?
        self.core_reset(.socram);

        // this is 4343x specific stuff: Disable remap for SRAM_3
        self.bus.bp_write32(CYW43439_Chip.socsram_base_address + 0x10, 3);
        self.bus.bp_write32(CYW43439_Chip.socsram_base_address + 0x44, 0);

        const ram_addr = CYW43439_Chip.atcm_ram_base_address;

        log.debug("loading fw", .{});
        const firmware = @embedFile("firmware/43439A0_7_95_61.bin")[0..];
        self.bus.bp_write(ram_addr, firmware);

        log.debug("loading nvram", .{});
        // Round up to 4 bytes.
        const nvram_len = (nvram.NVRAM.len + 3) / 4 * 4;
        self.bus.bp_write(ram_addr + CYW43439_Chip.chip_ram_size - 4 - nvram_len, nvram.NVRAM);

        const nvram_len_words = nvram_len / 4;
        const nvram_len_magic = (~nvram_len_words << 16) | nvram_len_words;
        self.bus.bp_write32(ram_addr + CYW43439_Chip.chip_ram_size - 4, nvram_len_magic);

        log.debug("starting up core...", .{});
        self.core_reset(.wlan);
        std.debug.assert(self.core_is_up(.wlan));

        // wait until HT clock is available; takes about 29ms
        log.debug("wait for HT clock", .{});
        while (self.bus.read8(.backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR) & 0x80 == 0) {}

        // "Set up the interrupt mask and enable interrupts"
        log.debug("setup interrupt mask", .{});
        self.bus.bp_write32(CYW43439_Chip.sdiod_core_base_address + consts.SDIO_INT_HOST_MASK, consts.I_HMB_SW_MASK);

        // Set up the interrupt mask and enable interrupts
        // TODO - bluetooth interrupts

        self.bus.write16(.bus, consts.REG_BUS_INTERRUPT_ENABLE, consts.IRQ_F2_PACKET_AVAILABLE);

        // "Lower F2 Watermark to avoid DMA Hang in F2 when SD Clock is stopped."
        // Sounds scary...
        self.bus.write8(.backplane, consts.REG_BACKPLANE_FUNCTION2_WATERMARK, consts.SPI_F2_WATERMARK);

        log.debug("waiting for F2 to be ready...", .{});
        while (self.bus.read32(.bus, consts.REG_BUS_STATUS) & consts.STATUS_F2_RX_READY == 0) {}

        log.debug("clear pad pulls", .{});
        self.bus.write8(.backplane, consts.REG_BACKPLANE_PULL_UP, 0);
        _ = self.bus.read8(.backplane, consts.REG_BACKPLANE_PULL_UP);

        // start HT clock
        self.bus.write8(.backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR, 0x10);
        log.debug("waiting for HT clock...", .{});
        while (self.bus.read8(.backplane, consts.REG_BACKPLANE_CHIP_CLOCK_CSR) & 0x80 == 0) {}
        log.debug("clock ok", .{});

        self.log_init();

        // TODO: bluetooth setup

        log.debug("cyw43 runner init done", .{});
    }

    fn core_disable(self: *Self, core: Core) void {
        const base = core.base_addr();

        // Dummy read?
        _ = self.bus.bp_read8(base + consts.AI_RESETCTRL_OFFSET);

        // Check it isn't already reset
        const r = self.bus.bp_read8(base + consts.AI_RESETCTRL_OFFSET);
        if (r & consts.AI_RESETCTRL_BIT_RESET != 0) {
            return;
        }

        self.bus.bp_write8(base + consts.AI_IOCTRL_OFFSET, 0);
        _ = self.bus.bp_read8(base + consts.AI_IOCTRL_OFFSET);

        self.internal_delay_ms(1);

        self.bus.bp_write8(base + consts.AI_RESETCTRL_OFFSET, consts.AI_RESETCTRL_BIT_RESET);
        _ = self.bus.bp_read8(base + consts.AI_RESETCTRL_OFFSET);
    }

    fn core_reset(self: *Self, core: Core) void {
        self.core_disable(core);

        const base = core.base_addr();

        self.bus.bp_write8(base + consts.AI_IOCTRL_OFFSET, consts.AI_IOCTRL_BIT_FGC | consts.AI_IOCTRL_BIT_CLOCK_EN);
        _ = self.bus.bp_read8(base + consts.AI_IOCTRL_OFFSET);

        self.bus.bp_write8(base + consts.AI_RESETCTRL_OFFSET, 0);

        self.internal_delay_ms(1);

        self.bus.bp_write8(base + consts.AI_IOCTRL_OFFSET, consts.AI_IOCTRL_BIT_CLOCK_EN);
        _ = self.bus.bp_read8(base + consts.AI_IOCTRL_OFFSET);

        self.internal_delay_ms(1);
    }

    fn core_is_up(self: *Self, core: Core) bool {
        const base = core.base_addr();

        const io = self.bus.bp_read8(base + consts.AI_IOCTRL_OFFSET);

        if (io & (consts.AI_IOCTRL_BIT_FGC | consts.AI_IOCTRL_BIT_CLOCK_EN) != consts.AI_IOCTRL_BIT_CLOCK_EN) {
            log.debug("core_is_up: returning false due to bad ioctrl 0x{X}", .{io});
            return false;
        }

        const r = self.bus.bp_read8(base + consts.AI_RESETCTRL_OFFSET);
        if (r & (consts.AI_RESETCTRL_BIT_RESET) != 0) {
            log.debug("core_is_up: returning false due to bad resetctrl 0x{X}", .{r});
            return false;
        }

        return true;
    }

    fn log_init(self: *Self) void {
        const addr = CYW43439_Chip.atcm_ram_base_address + CYW43439_Chip.chip_ram_size - 4 - CYW43439_Chip.socram_srmem_size;
        const shared_addr = self.bus.bp_read32(addr);
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

    pub fn run(self: *Self) void {
        while (true) {
            self.log_read();
        }
    }
};

pub const Chip = struct {
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

const WRAPPER_REGISTER_OFFSET: u32 = 0x100000;

const CYW43439_Chip: Chip = .{
    .arm_core_base_address = 0x18003000 + WRAPPER_REGISTER_OFFSET,
    .socsram_base_address = 0x18004000,
    .bluetooth_base_address = 0x19000000,
    .socsram_wrapper_base_address = 0x18004000 + WRAPPER_REGISTER_OFFSET,
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
            .wlan => CYW43439_Chip.arm_core_base_address,
            .socram => CYW43439_Chip.socsram_wrapper_base_address,
            .sdiod => CYW43439_Chip.sdiod_core_base_address,
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
