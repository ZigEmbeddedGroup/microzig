const std = @import("std");

pub const Format = enum {
    /// Standard DFU 1.1 format (simple binary + suffix)
    standard,
    /// STMicroelectronics DfuSe format with address information
    dfuse,
};

pub const Options = struct {
    /// DFU format to use
    format: Format = .dfuse,
    /// USB Vendor ID (default: STMicroelectronics)
    vendor_id: u16 = 0x0483,
    /// USB Product ID (default: ST DFU device)
    product_id: u16 = 0xdf11,
    /// Device version (0xFFFF = ignore, or BCD firmware version)
    device_id: u16 = 0xffff,
};

const Suffix = struct {
    bcd_device: u16,
    id_product: u16,
    id_vendor: u16,
    bcd_dfu: u16,
    signature: [3]u8 = "UFD".*,
    length: u8 = 16,

    fn write_to(self: *const Suffix, writer: *std.Io.Writer) !void {
        try writer.writeInt(u16, self.bcd_device, .little);
        try writer.writeInt(u16, self.id_product, .little);
        try writer.writeInt(u16, self.id_vendor, .little);
        try writer.writeInt(u16, self.bcd_dfu, .little);
        try writer.writeAll(&self.signature);
        try writer.writeByte(self.length);
    }
};

/// A writer wrapper that calculates CRC32 of all written data.
/// Writes the DFU suffix and CRC when `finalize()` is called.
///
/// Note: When using this, the underlying writer is best unbuffered
/// because all writes are passed on directly to it.
pub const DfuWriter = struct {
    const Self = @This();

    // The CRC algorithm used in DFU.
    // Like "standard" Crc32 but without the final xor with 0xffffffff.
    const Hasher = std.hash.crc.Crc32Jamcrc;

    out: *std.Io.Writer,
    hashed: std.Io.Writer.Hashed(Hasher),
    opts: Options,

    pub fn init(out: *std.Io.Writer, buffer: []u8, opts: Options) Self {
        return .{
            .out = out,
            .hashed = out.hashed(Hasher.init(), buffer),
            .opts = opts,
        };
    }

    /// Returns the underlying writer.
    pub fn writer(self: *Self) *std.Io.Writer {
        return &self.hashed.writer;
    }

    /// Flush the hashed writer, write the DFU suffix and final CRC.
    pub fn finalize(self: *Self) !void {
        // Write DFU suffix based on format (part of CRC'd content)
        const bcd_dfu: u16 = switch (self.opts.format) {
            .standard => 0x0100,
            .dfuse => 0x011a,
        };

        const suffix: Suffix = .{
            .bcd_device = self.opts.device_id,
            .id_product = self.opts.product_id,
            .id_vendor = self.opts.vendor_id,
            .bcd_dfu = bcd_dfu,
        };
        try suffix.write_to(self.writer());
        try self.writer().flush();

        // Extract final CRC and write it to underlying writer (not hashed)
        const final_crc = self.hashed.hasher.final();
        try self.out.writeInt(u32, final_crc, .little);
        try self.out.flush();
    }
};

/// Write binary data from `reader` as a standard DFU file with suffix and CRC.
pub fn from_bin(reader: *std.Io.Reader, writer: *std.Io.Writer, opts: Options) !void {
    var buffer: [4096]u8 = undefined;
    var dfu_writer = DfuWriter.init(writer, &buffer, opts);

    _ = try reader.streamRemaining(dfu_writer.writer());
    try dfu_writer.finalize();
}
