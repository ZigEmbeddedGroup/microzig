const std = @import("std");
const microzig = @import("microzig");
const FlexComm = @import("../flexcomm.zig").FlexComm;
const SliceVector = microzig.utilities.SliceVector;

const I2C_Device = microzig.drivers.base.I2C_Device;

const assert = std.debug.assert;
const chip = microzig.chip;
const peripherals = chip.peripherals;

// Controller (master) only
// TODO: target (slave)
// TODO: 10 bit addressing
// TODO: better receive (with matching)
// TODO: SMBus
pub const LP_I2C = enum(u4) {
    _,

    pub const RegTy = *volatile chip.types.peripherals.LPI2C0;
    const Registers: [10]RegTy = .{
        peripherals.LPI2C0,
        peripherals.LPI2C1,
        peripherals.LPI2C2,
        peripherals.LPI2C3,
        peripherals.LPI2C4,
        peripherals.LPI2C5,
        peripherals.LPI2C6,
        peripherals.LPI2C7,
        peripherals.LPI2C8,
        peripherals.LPI2C9,
    };

    pub const Config = struct {
        baudrate: u32,
        mode: OperatingMode,
        relaxed: bool,
        enabled: bool,
        debug: bool,
        enable_doze: bool,
        ignore_nack: bool,
        pin_config: void = {},
        // TODO: is u32 overkill ?
        bus_idle_timeout: ?u32, // in ns
        pin_low_timeout: ?u32,
        sda_glitch_filter: ?u32, // in ns
        scl_glitch_filter: ?u32, // in ns
        // TODO: host request

        pub const OperatingMode = enum { standard, fast, fastplus, highspeed, ultrafast };

        pub const Default = Config{ .baudrate = 100_000, .mode = .standard, .relaxed = false, .enabled = true, .debug = false, .enable_doze = false, .ignore_nack = false, .bus_idle_timeout = null, .pin_low_timeout = null, .sda_glitch_filter = null, .scl_glitch_filter = null };
    };

    pub const Error = error{ UnexpectedNack, ArbitrationLost, FifoError, PinLowTimeout, BusBusy };

    pub const ConfigError = error{UnsupportedBaudRate};

    /// Initializes the I2C controller.
    pub fn init(interface: u4, config: Config) ConfigError!LP_I2C {
        FlexComm.num(interface).init(.I2C);

        const i2c: LP_I2C = @enumFromInt(interface);
        const regs = i2c.get_regs();
        i2c.reset();

        regs.MCFGR0.write(.{
            .HREN = .DISABLED, // TODO: host request
            .HRPOL = .ACTIVE_LOW,
            .HRSEL = .DISABLED,
            .HRDIR = .INPUT,

            .CIRFIFO = .DISABLED,
            .RDMO = .DISABLED, // TODO: address match
            .RELAX = @enumFromInt(@intFromBool(config.relaxed)),
            .ABORT = .DISABLED,
        });
        regs.MCFGR1.write(.{
            .PRESCALE = .DIVIDE_BY_1,
            .AUTOSTOP = .DISABLED,
            .IGNACK = @enumFromInt(@intFromBool(config.ignore_nack)),
            .TIMECFG = .IF_SCL_LOW,
            .STARTCFG = .BOTH_I2C_AND_LPI2C_IDLE,
            .STOPCFG = .ANY_STOP,
            .MATCFG = .DISABLED, // TODO
            .PINCFG = .OPEN_DRAIN_2_PIN, // TODO
        });
        const ns_per_cycle = 1_000_000_000 / i2c.get_flexcomm().get_clock();
        regs.MCFGR2.write(.{
            .BUSIDLE = 0, // set later since it depends on `prescale`
            .FILTSCL = if (config.scl_glitch_filter) |t| @intCast(t / ns_per_cycle) else 0,
            .FILTSDA = if (config.sda_glitch_filter) |t| @intCast(t / ns_per_cycle) else 0,
        });

        if (config.pin_low_timeout != null) @panic("TODO");
        // regs.MCFGR3.write(.{
        // .PINLOW =
        // });

        try i2c.set_baudrate(config.mode, config.baudrate);
        if (config.bus_idle_timeout) |t| {
            const prescaler: u8 = @as(u8, 1) << @intFromEnum(regs.MCFGR1.read().PRESCALE);
            regs.MCFGR2.modify_one("BUSIDLE", @intCast(t / ns_per_cycle / prescaler));
        }

        if (config.enabled) i2c.set_enabled(true);

        return i2c;
    }

    /// Resets the I2C interface and deinit the corresponding FlexComm interface.
    pub fn deinit(i2c: LP_I2C) void {
        i2c.reset();
        FlexComm.num(i2c.get_n()).deinit();
    }

    /// Resets the I2C interface.
    pub fn reset(i2c: LP_I2C) void {
        i2c.get_regs().MCR.write(.{ .RST = .RESET, .MEN = .DISABLED, .DBGEN = .DISABLED, .DOZEN = .DISABLED, .RRF = .RESET, .RTF = .RESET });
        i2c.get_regs().MCR.modify_one("RST", .NOT_RESET);
    }

    pub fn is_bus_busy(i2c: LP_I2C) bool {
        return i2c.get_regs().MSR.read().BBF == .BUSY;
    }

    /// Returns an error if any is indicated by the status register.
    pub fn check_flags(i2c: LP_I2C) Error!void {
        const MSR = i2c.get_regs().MSR.read();
        const NDF: bool = MSR.NDF == .INT_YES;
        const ALF: bool = MSR.ALF == .INT_YES;
        const FEF: bool = MSR.FEF == .INT_YES;
        const PLTF: bool = MSR.PLTF == .INT_YES;
        if (NDF or ALF or FEF or PLTF) {
            // note: this may not clear FLTF flag (see reference manual)
            i2c.clear_flags();

            // The sdk resets the fifos for some reason
            // i2c.reset_fifos();

            if (NDF) return error.UnexpectedNack;
            if (ALF) return error.ArbitrationLost;
            if (FEF) return error.FifoError;
            if (PLTF) return error.PinLowTimeout;
        }
        return;
    }

    pub fn clear_flags(i2c: LP_I2C) void {
        i2c.get_regs().MSR.write_raw(0);
    }

    fn reset_fifos(i2c: LP_I2C) void {
        i2c.get_regs().MCR.modify(.{ .RRF = .NOW_EMPTY, .RTF = .NOW_EMPTY });
    }

    fn get_n(i2c: LP_I2C) u4 {
        return @intFromEnum(i2c);
    }

    pub fn get_regs(i2c: LP_I2C) RegTy {
        return LP_I2C.Registers[i2c.get_n()];
    }

    fn get_flexcomm(i2c: LP_I2C) FlexComm {
        return FlexComm.num(i2c.get_n());
    }

    /// Sets the baudrate for the controller (master).
    /// `highspeed` and `ultrafast` modes are currently unimplemented.
    ///
    /// Note that the baudrate depends on the flexcomm's interface clock: changing the clock will change the baudrate.
    pub fn set_baudrate(i2c: LP_I2C, mode: Config.OperatingMode, baudrate: u32) ConfigError!void {
        const lpi2c_clk_f = i2c.get_flexcomm().get_clock();
        const regs = i2c.get_regs();
        // We currently assume these are negligible, but it could be useful
        // to make them configurable
        const scl_risetime: u8 = 0;
        const sda_risetime: u8 = 0;

        // time constraints from I2C's specification (UM10204)
        // we use the unit of 10ns to avoid floats
        //
        // see the comments above the definition of `sethold` below for more details
        const max_baudrate: u32, const min_sethold: u32, const min_clk_low: u32, const min_clk_high: u32 = switch (mode) {
            //               baudrate (Hz), sethold (10ns), clk_lo (10ns), clk_hi (10ns)
            .standard => .{ 100_000, 470, 470, 400 },
            .fast => .{ 400_000, 60, 130, 60 },
            .fastplus => .{ 1_000_000, 260, 50, 26 },
            else => @panic("Invalid mode"),
        };
        // to convert from 10ns to 1s, we divide by 10^8
        const conv_factor = std.math.pow(u32, 10, 8);
        if (baudrate > max_baudrate) return error.UnsupportedBaudRate;

        // The variables used here correspond to the ones in NXP's reference manual
        // of the LPI2C module, plus a few others

        // baudrate = 1/t_SCL
        // t_SCL = (clk_hi + clk_lo + 2 + scl_latency) * 2^prescale   *  lpi2c_clk_t = 1/baudrate
        // scl_latency = floor((2 + filt_scl + scl_risetime) / 2^prescale)
        //
        // => clk_hi + clk_lo = lpi2c_clk_f / baudrate / 2^prescale - 2 - scl_latency
        //
        //
        // 1/baudrate >= 1/limits[0]
        // clk_hi + clk_lo + 2 + scl_latency >= (lpi2c_clk_f / 2^prescale) / limits[0] >= 1 / limits[0]

        // TODO: maybe use the config provided by the user so the remaining has the chance to be done at comptime ?
        const filt_scl, const filt_sda = blk: {
            const mcfgr2 = regs.MCFGR2.read();
            break :blk .{ mcfgr2.FILTSCL, mcfgr2.FILTSDA };
        };
        var best_prescale: ?u3 = 0;
        var @"best clk_hi + clk_lo": u7 = 0;
        var best_err: u32 = std.math.maxInt(u32);

        for (0..8) |p| {
            const prescale: u3 = @intCast(p);
            const scl_latency: u8 = (2 + filt_scl + scl_risetime) >> prescale;

            if ((lpi2c_clk_f / baudrate) >> prescale < 2 + scl_latency) break;

            const @"clk_hi + clk_lo": u32 = ((lpi2c_clk_f / baudrate) >> prescale) - 2 - scl_latency;
            // the max available for clk_hi and clk_lo is both 63
            if (@"clk_hi + clk_lo" > 126) continue; // we need a bigger prescaler

            const computed_baudrate = lpi2c_clk_f / (@"clk_hi + clk_lo" + 2 + scl_latency) << prescale;
            const err = if (computed_baudrate > baudrate) computed_baudrate - baudrate else baudrate - computed_baudrate;
            if (computed_baudrate > max_baudrate) continue;
            // TODO: do we want the smallest or the largest prescaler ?
            if (err < best_err) {
                best_err = err;
                best_prescale = @intCast(prescale);
                @"best clk_hi + clk_lo" = @intCast(@"clk_hi + clk_lo");
                if (err == 0) break;
            }
        }

        if (best_prescale == null) return error.UnsupportedBaudRate;

        const prescale = best_prescale.?;
        const sda_latency: u8 = (2 + filt_sda + scl_risetime) >> prescale;
        const scl_latency: u8 = (2 + filt_scl + sda_risetime) >> prescale;

        // We want clk_lo >= clk_hi to let more time for the signal to settle
        // we start from a duty cycle of ~50% and then adjust the timings
        // because we are guaranteed that (clk_hi + clk_lo + 2 + scl_latency) >= 1/limits[0] >= t_low_min + t_high_min >= 2 × t_high_min
        // ...
        var clk_lo: u6 = @intCast(std.math.divCeil(u7, @"best clk_hi + clk_lo", 2) catch unreachable);

        // t_low = (clk_lo + 1) × 2^prescale  × lpi2c_clk_t >= min_clk_low
        // <=>                   (clk_lo + 1) × 2^prescale  >= min_clk_low × lpi2c_clk_f  (with `min_clk_low` in seconds)
        const min_low_cycle_count: u32 = @intCast(std.math.divCeil(u64, @as(u64, min_clk_low) * lpi2c_clk_f, conv_factor) catch unreachable);
        while (((clk_lo + 1) << prescale) < min_low_cycle_count) {
            clk_lo += 1;
        }
        const clk_hi: u6 = @intCast(@"best clk_hi + clk_lo" - clk_lo);

        assert(((clk_hi + 1 + scl_latency) << prescale) >= @as(u64, min_clk_high) * lpi2c_clk_f / conv_factor);
        assert(((clk_lo + 1) << prescale) >= @as(u64, min_clk_low) * lpi2c_clk_f / conv_factor);

        // corresponds somewhat to t_HD;STA, t_SU;STA and t_SU;STO
        // per I2C spec, we must have
        // t_HD;STA >= 4.0µs, 0.6µs, 0.26µs (in standard, fast, fast+ mode)
        // t_SU;STA >= 4.7µs, 0.6µs, 0.26µs (in standard, fast, fast+ mode)
        // t_SU;STO >= 4.0µs, 0.6µs, 0.26µs (in standard, fast, fast+ mode)
        // `min_sethold` is the max of that
        //
        // we need t_hold = (sethold + 1 + scl_latency) × 2^prescale × lpi2c_clk_t >= min_sethold (s)
        // => sethold >= min_sethold (s) × lpi2c_clk_f / 2^prescale - scl_latency - 1
        const sethold = ((@as(u64, min_sethold) * lpi2c_clk_f / conv_factor) >> prescale) - scl_latency;

        // corresponds to t_HD;DAT, t_VD;DAT and t_VD;ACK
        // min: 0
        // max: t_low
        //
        // I am not sure about what value to chose, so I take the highest possible
        // to maximize the time the value in the data bus is available
        const datavd = clk_lo - sda_latency - 1; // given by NXP's doc

        // minimize time disabled by disabling here
        const enabled = i2c.disable();
        defer i2c.set_enabled(enabled);
        regs.MCCR0.write(.{ .CLKLO = clk_lo, .CLKHI = clk_hi, .SETHOLD = @intCast(sethold), .DATAVD = @intCast(datavd) });

        regs.MCFGR1.modify_one("PRESCALE", @enumFromInt(prescale));
    }

    /// Computes the current baudrate.
    /// Depends on the flexcomm's interface clock.
    /// Changing the clock will change the baudrate.
    pub fn get_actual_baudrate(i2c: LP_I2C) f32 {
        const regs = i2c.get_regs();
        const MCCR0 = regs.MCCR0.read();
        const MCFGR1 = regs.MCFGR1.read();
        const prescale = @intFromEnum(MCFGR1.PRESCALE);
        const clk = i2c.get_flexcomm().get_clock();

        const filt_scl: u8 = regs.MCFGR2.read().FILTSCL;
        const scl_risetime = 0;
        const scl_latency: u8 = (2 + filt_scl + scl_risetime) >> prescale;
        var computed_baudrate: f32 = @floatFromInt(clk);
        computed_baudrate /= @floatFromInt(@as(u8, MCCR0.CLKLO) + MCCR0.CLKHI + 2 + scl_latency);
        computed_baudrate /= std.math.pow(f32, 2, @floatFromInt(prescale));

        return computed_baudrate;
    }

    /// Disables the I2C interface and return whether it was enabled.
    pub fn disable(i2c: LP_I2C) bool {
        const regs = i2c.get_regs();
        var MCR = regs.MCR.read();
        const enabled = MCR.MEN == .ENABLED;

        MCR.MEN = .DISABLED;
        regs.MCR.write(MCR);
        return enabled;
    }

    pub fn set_enabled(i2c: LP_I2C, enabled: bool) void {
        i2c.get_regs().MCR.modify_one("MEN", if (enabled) .ENABLED else .DISABLED);
    }

    //
    // Read / Write functions
    //

    fn can_read(i2c: LP_I2C) bool {
        return i2c.get_fifo_counts().rx > 0;
    }

    pub fn can_write(i2c: LP_I2C) bool {
        return i2c.get_fifo_counts().tx < i2c.get_fifo_sizes().tx;
    }

    // The `PARAM` register is readonly with default value of 3
    // for `MTXFIFO` and `MRXFIFO`
    pub fn get_fifo_sizes(i2c: LP_I2C) struct { tx: u16, rx: u16 } {
        _ = i2c;
        // const param = i2c.get_regs().PARAM.read();
        // return .{ @as(u16, 1) << param.MTXFIFO, @as(u16, 1) << param.MRXFIFO };
        return .{ .tx = 8, .rx = 8 };
    }

    pub fn get_fifo_counts(i2c: LP_I2C) struct { tx: u8, rx: u8 } {
        const MFSR = i2c.get_regs().MFSR.read();
        return .{ .tx = MFSR.TXCOUNT, .rx = MFSR.RXCOUNT };
    }

    /// Sends a I2C start. Blocks until the start command can be written in the tx fifo.
    /// Does not block until the start has been sent.
    pub fn send_start_blocking(i2c: LP_I2C, address: u7, mode: enum(u2) { write = 0, read = 1 }) Error!void {
        try i2c.wait_for_tx_space();

        i2c.get_regs().MTDR.write(.{ .DATA = (@as(u8, address) << 1) | @intFromEnum(mode), .CMD = .GENERATE_START_AND_TRANSMIT_ADDRESS_IN_DATA_7_THROUGH_0 });
    }

    /// Sends a I2C stop. Blocks until the stop command has been sent.
    pub fn send_stop_blocking(i2c: LP_I2C) Error!void {
        try i2c.wait_for_tx_space();

        i2c.get_regs().MTDR.write(.{ .DATA = 0, .CMD = .GENERATE_STOP_CONDITION });

        // wait for the tx fifo to be empty and stop be sent
        var flags = i2c.get_regs().MSR.read();
        try i2c.check_flags();
        while (flags.SDF != .INT_YES and flags.TDF != .ENABLED) {
            flags = i2c.get_regs().MSR.read();
            try i2c.check_flags();
        }
        i2c.get_regs().MSR.write_raw(1 << 9);
    }

    fn wait_for_tx_space(i2c: LP_I2C) Error!void {
        while (!i2c.can_write()) try i2c.check_flags();
    }

    pub fn send_blocking(i2c: LP_I2C, address: u7, data: []const u8) Error!void {
        const MTDR: *volatile u8 = @ptrCast(&i2c.get_regs().MTDR);

        if (i2c.is_bus_busy()) return error.BusBusy;
        i2c.clear_flags();

        try i2c.send_start_blocking(address, .write);

        for (data) |c| {
            try i2c.wait_for_tx_space();
            MTDR.* = c;
        }
        try i2c.send_stop_blocking();
    }

    // Follows the linux kernel's approach
    pub const I2C_Msg = struct {
        flags: packed struct(u8) {
            direction: enum(u1) { write = 0, read = 1 },
            padding: u7 = 0,
            // ten_bit: bool = false
        },
        address: u16,
        chunks: union { read: []const []u8, write: []const []const u8 },
    };

    pub fn transfer_blocking(i2c: LP_I2C, messages: []const I2C_Msg) Error!void {
        // TODO: retries
        if (i2c.is_bus_busy()) return error.BusBusy;
        i2c.clear_flags();

        for (messages) |message| {
            switch (message.flags.direction) {
                .read => try i2c.readv_blocking(message),
                .write => try i2c.writev_blocking(message),
            }
        }

        try i2c.send_stop_blocking();
    }

    /// Sends `START` and the bytes to the given address.
    /// Skips empty datagrams.
    /// Does not send `STOP` afterwards.
    /// Does not check if the bus is busy and does not clear flags beforehand.
    pub fn writev_blocking(i2c: LP_I2C, msg: I2C_Msg) Error!void {
        assert(msg.flags.direction == .write);
        const MTDR: *volatile u8 = @ptrCast(&i2c.get_regs().MTDR);

        const write_vec = SliceVector([]const u8).init(msg.chunks.write);
        if (write_vec.size() == 0) return; // other impls return error.NoData

        // TODO: 10 bit addresses support
        try i2c.send_start_blocking(@truncate(msg.address), .write);

        var iter = write_vec.iterator();
        while (iter.next_element()) |element| {
            try i2c.wait_for_tx_space();
            MTDR.* = element.value;
        }
    }

    /// Sends `START` and the bytes to the give address
    /// Does not send `STOP` afterwards.
    /// Does not check if the bus is busy and does not clear flags beforehand.
    ///
    /// Currently, msg.buffer must be less than `8 × 256`.
    pub fn readv_blocking(i2c: LP_I2C, msg: I2C_Msg) Error!void {
        assert(msg.flags.direction == .read);

        const read_vec = SliceVector([]u8).init(msg.chunks.read);
        var len = read_vec.size();
        if (len == 0) return; // other impls return error.NoData
        assert(len <= i2c.get_fifo_sizes().tx * 256); // see comments above the loop below

        // TODO: 10 bit addresses support
        try i2c.send_start_blocking(@truncate(msg.address), .read);

        // Because the tx fifo has a size of 8
        // we can issue at most eight 256 bytes read at once.
        // It is possible to issue other read commands after we started reading, but
        // note that the controller will send a NACK after the last read command
        // if it is not followed by an other read.
        // Reading more than 8 × 256 bytes is therefore currently unimplemented.
        while (len > 0) {
            const chunk_len = @min(256, len);
            len -= chunk_len;

            try i2c.wait_for_tx_space();
            i2c.get_regs().MTDR.write(.{ .DATA = @intCast(chunk_len - 1), .CMD = .RECEIVE_DATA_7_THROUGH_0_PLUS_ONE });
        }

        var iter = read_vec.iterator();
        while (iter.next_element_ptr()) |element| {
            try i2c.check_flags();
            var mrdr = i2c.get_regs().MRDR.read();
            while (mrdr.RXEMPTY == .EMPTY) {
                try i2c.check_flags();
                mrdr = i2c.get_regs().MRDR.read();
            }
            element.value_ptr.* = mrdr.DATA;
        }
    }

    pub fn i2c_device(i2c: LP_I2C) I2C_Device {
        return .{ .ptr = @ptrFromInt(@intFromEnum(i2c)), .vtable = &.{ .readv_fn = readv, .writev_fn = writev, .writev_then_readv_fn = writev_then_readv } };
    }
};

// TODO: check for reserved addresses
fn writev(d: *anyopaque, addr: I2C_Device.Address, datagrams: []const []const u8) I2C_Device.Error!void {
    const dev: LP_I2C = @enumFromInt(@intFromPtr(d));
    const message: LP_I2C.I2C_Msg = .{ .address = @intFromEnum(addr), .flags = .{ .direction = .write }, .chunks = .{ .write = datagrams } };
    dev.transfer_blocking(&.{message}) catch |err| switch (err) {
        LP_I2C.Error.UnexpectedNack, LP_I2C.Error.FifoError, LP_I2C.Error.BusBusy, LP_I2C.Error.ArbitrationLost => {
            std.log.debug("ew: {}\n", .{err});
            return I2C_Device.Error.UnknownAbort;
        },
        LP_I2C.Error.PinLowTimeout => return I2C_Device.Error.Timeout,
    };
}
fn readv(d: *anyopaque, addr: I2C_Device.Address, datagrams: []const []u8) I2C_Device.Error!usize {
    const dev: LP_I2C = @enumFromInt(@intFromPtr(d));
    const message: LP_I2C.I2C_Msg = .{ .address = @intFromEnum(addr), .flags = .{ .direction = .write }, .chunks = .{ .write = datagrams } };
    dev.transfer_blocking(&.{message}) catch |err| switch (err) {
        LP_I2C.Error.UnexpectedNack, LP_I2C.Error.FifoError, LP_I2C.Error.BusBusy, LP_I2C.Error.ArbitrationLost => {
            std.log.debug("er: {}\n", .{err});
            return I2C_Device.Error.UnknownAbort;
        },
        LP_I2C.Error.PinLowTimeout => return I2C_Device.Error.Timeout,
    };

    return SliceVector([]u8).init(datagrams).size();
}

fn writev_then_readv(
    d: *anyopaque,
    addr: I2C_Device.Address,
    write_chunks: []const []const u8,
    read_chunks: []const []u8,
) I2C_Device.Error!void {
    const dev: LP_I2C = @enumFromInt(@intFromPtr(d));
    const messages: []const LP_I2C.I2C_Msg = &.{ .{ .address = @intFromEnum(addr), .flags = .{ .direction = .write }, .chunks = .{ .write = write_chunks } }, .{ .address = @intFromEnum(addr), .flags = .{ .direction = .read }, .chunks = .{ .read = read_chunks } } };
    dev.transfer_blocking(messages) catch |err| switch (err) {
        LP_I2C.Error.UnexpectedNack, LP_I2C.Error.FifoError, LP_I2C.Error.BusBusy, LP_I2C.Error.ArbitrationLost => {
            std.log.debug("erw: {}\n", .{err});
            return I2C_Device.Error.UnknownAbort;
        },
        LP_I2C.Error.PinLowTimeout => return I2C_Device.Error.Timeout,
    };
}

// TODO: use the register VERID to check the presence of controller mode
