const peripherals = @import("../cortex_m.zig").peripherals;

pub fn init_swo(config: struct {
    /// Implementation defined. In Hz
    tpiu_clock: u32,
    /// SWO output frequency. Used to calculate the prescaler.
    swo_output_target_hz: u32 = 2_000_000,
    /// Protocol for trace output from the TPIU
    tx_mode: enum(u2) {
        pararell_trace_port = 0b00,
        swo_manchester_encoding = 0b01,
        swo_nrz_encoding = 0b10,
    } = .swo_nrz_encoding,
    /// Stimulus port to enable
    stim_port: u5 = 0,
    /// Identifier for multi-source trace stream formatting.
    /// If multi-source trace is in use, the debugger must write a non-zero value to this field.
    trace_bus_id: u7 = 0,
}) !void {
    // Enable trace in core debug:
    peripherals.dbg.DEMCR.modify(.{ .TRCENA = 1 }); // Enable debugging & monitoring

    // Enable ITM:
    peripherals.itm.TCR.modify(.{
        .ITMENA = 1, // Enable ITM
        .TXENA = 1, // Enable DWT packets
        .TraceBusID = config.trace_bus_id, // Unique ID for multi-source trace
    });

    // Enable stimulus port 0:
    peripherals.itm.TER[config.stim_port].modify(.{ .STIMENA = 1 });

    // Configure Serial Wire Output (SWO):
    peripherals.tpiu.SPPR.modify(.{ .TXMODE = @intFromEnum(config.tx_mode) });

    // SWO output clock = Asynchronous_Reference_Clock/(SWOSCALAR +1)\
    // SWOSCALAR = (Asynchronous_Reference_Clock)/(SWO output clock) - 1
    if (config.swo_output_target_hz > config.tpiu_clock)
        return error.SwoTargetFreqTooHigh; // would cause int underflow

    peripherals.tpiu.ACPR.modify(.{
        .SWOSCALER = @as(u16, @intCast((config.tpiu_clock / config.swo_output_target_hz) - 1)),
    });
}

pub fn write_byte_itm(ch: u8, stim_port: u5) void {
    // Wait until stimulus port is ready
    while (peripherals.itm.STIM[stim_port].read().READ.FIFOREADY == 0) {}

    // Write character
    const stim: *volatile u8 = @ptrCast(&peripherals.itm.STIM[stim_port].raw);
    stim.* = ch;
}

pub fn write_bytes_itm(str: []const u8, stim_port: u5) void {
    for (str) |ch| {
        write_byte_itm(ch, stim_port);
    }
}
