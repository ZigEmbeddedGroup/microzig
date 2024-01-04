//! Random number generator (RNG) using the Ascon CSPRNG

const std = @import("std");
const assert = std.debug.assert;
const Random = std.rand.Random;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

/// Wrapper around the Ascon CSPRNG with automatic reseed using the ROSC
///
/// ## Usage
///
/// ```zig
/// var ascon = Ascon.init();
/// var rng = ascon.random();
/// ```
///
/// _WARNING_: This might not meet the requirements of randomness
/// for security systems because the ROSC as entropy source can be
/// compromised. However, it promises at least equal distribution.
pub const Ascon = struct {
    state: std.rand.Ascon,
    counter: usize = 0,

    const reseed_threshold = 4096;
    const secret_seed_length = std.rand.Ascon.secret_seed_length;

    pub fn init() @This() {
        // Ensure that the system clocks run from the XOSC and/or PLLs
        const ref_src = peripherals.CLOCKS.CLK_REF_CTRL.read().SRC.value;
        const sys_clk_src = peripherals.CLOCKS.CLK_SYS_CTRL.read().SRC.value;
        const aux_src = peripherals.CLOCKS.CLK_SYS_CTRL.read().AUXSRC.value;
        assert((ref_src != .rosc_clksrc_ph and sys_clk_src == .clk_ref) or
            (sys_clk_src == .clksrc_clk_sys_aux and aux_src != .rosc_clksrc));

        // Get `secret_seed_length` random bytes from the ROSC ...
        var b: [secret_seed_length]u8 = undefined;
        rosc(&b);

        return @This(){ .state = std.rand.Ascon.init(b) };
    }

    /// Returns a `std.rand.Random` structure backed by the current RNG
    pub fn random(self: *@This()) Random {
        return Random.init(self, fill);
    }

    /// Fills the buffer with random bytes
    pub fn fill(self: *@This(), buf: []u8) void {
        // Reseed every `secret_seed_length` bytes
        if (self.counter > reseed_threshold) {
            var b: [secret_seed_length]u8 = undefined;
            rosc(&b);
            self.state.addEntropy(&b);
            self.counter = 0;
        }
        self.state.fill(buf);
        self.counter += buf.len;
    }

    /// Fill the buffer with up to buffer.len random bytes
    ///
    /// rand uses the RANDOMBIT register of the ROSC as its source, i. e.,
    /// the system clocks _MUST_ run from the XOSC and/or PLLs.
    ///
    /// _WARNING_: This function does not meet the requirements of randomness
    /// for security systems because it can be compromised, but it may be useful
    /// in less critical applications.
    fn rosc(buffer: []u8) void {
        const rosc_state = peripherals.ROSC.CTRL.read().ENABLE.value;
        // Enable the ROSC so it generates random bits for us
        peripherals.ROSC.CTRL.modify(.{ .ENABLE = .{ .value = .ENABLE } });
        defer peripherals.ROSC.CTRL.modify(.{ .ENABLE = .{ .value = rosc_state } });

        var i: usize = 0;
        while (i < buffer.len) : (i += 1) {
            // We poll RANDOMBIT eight times per cycle to build a random byte
            var r: u8 = @as(u8, @intCast(peripherals.ROSC.RANDOMBIT.read().RANDOMBIT));
            var j: usize = 0;
            while (j < 7) : (j += 1) {
                r = (r << 1) | @as(u8, @intCast(peripherals.ROSC.RANDOMBIT.read().RANDOMBIT));
            }
            buffer[i] = r;
        }
    }
};
