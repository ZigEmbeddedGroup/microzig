const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const BM192 = enum(u1) {
    /// 256 blocks per line.
    @"256BlocksPerLine" = 0x0,
    /// 192 blocks per line.
    @"192BlocksPerLine" = 0x1,
};

/// GFXMMU.
pub const GFXMMU = extern struct {
    /// GFXMMU configuration register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of BOIE) Buffer overflow interrupt enable. This bit enables the buffer 0 overflow interrupt.
        @"BOIE[0]": u1,
        /// (2/4 of BOIE) Buffer overflow interrupt enable. This bit enables the buffer 0 overflow interrupt.
        @"BOIE[1]": u1,
        /// (3/4 of BOIE) Buffer overflow interrupt enable. This bit enables the buffer 0 overflow interrupt.
        @"BOIE[2]": u1,
        /// (4/4 of BOIE) Buffer overflow interrupt enable. This bit enables the buffer 0 overflow interrupt.
        @"BOIE[3]": u1,
        /// AHB master error interrupt enable. This bit enables the AHB master error interrupt.
        AMEIE: u1,
        reserved6: u1 = 0,
        /// (1/1 of BM) 192 Block mode. This bit defines the number of blocks per line.
        @"BM[0]": BM192,
        padding: u25 = 0,
    }),
    /// GFXMMU status register.
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of BOF) Buffer overflow flag. This bit is set when an overflow occurs during the offset calculation of the buffer 0. It is cleared by writing 1 to CB0OF.
        @"BOF[0]": u1,
        /// (2/4 of BOF) Buffer overflow flag. This bit is set when an overflow occurs during the offset calculation of the buffer 0. It is cleared by writing 1 to CB0OF.
        @"BOF[1]": u1,
        /// (3/4 of BOF) Buffer overflow flag. This bit is set when an overflow occurs during the offset calculation of the buffer 0. It is cleared by writing 1 to CB0OF.
        @"BOF[2]": u1,
        /// (4/4 of BOF) Buffer overflow flag. This bit is set when an overflow occurs during the offset calculation of the buffer 0. It is cleared by writing 1 to CB0OF.
        @"BOF[3]": u1,
        /// AHB master error flag. This bit is set when an AHB error happens during a transaction. It is cleared by writing 1 to CAMEF.
        AMEF: u1,
        padding: u27 = 0,
    }),
    /// GFXMMU flag clear register.
    /// offset: 0x08
    FCR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of CBOF) Clear buffer overflow flag. Writing 1 clears the buffer 0 overflow flag in the GFXMMU_SR register.
        @"CBOF[0]": u1,
        /// (2/4 of CBOF) Clear buffer overflow flag. Writing 1 clears the buffer 0 overflow flag in the GFXMMU_SR register.
        @"CBOF[1]": u1,
        /// (3/4 of CBOF) Clear buffer overflow flag. Writing 1 clears the buffer 0 overflow flag in the GFXMMU_SR register.
        @"CBOF[2]": u1,
        /// (4/4 of CBOF) Clear buffer overflow flag. Writing 1 clears the buffer 0 overflow flag in the GFXMMU_SR register.
        @"CBOF[3]": u1,
        /// Clear AHB master error flag. Writing 1 clears the AHB master error flag in the GFXMMU_SR register.
        CAMEF: u1,
        padding: u27 = 0,
    }),
    /// offset: 0x0c
    reserved12: [4]u8,
    /// GFXMMU default value register.
    /// offset: 0x10
    DVR: mmio.Mmio(packed struct(u32) {
        /// Default value. This field indicates the default 32-bit value which is returned when a master accesses a virtual memory location not physically mapped.
        DV: u32,
    }),
    /// offset: 0x14
    reserved20: [12]u8,
    /// GFXMMU buffer 0 configuration register.
    /// offset: 0x20
    BCR: [4]mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Physical buffer offset. Offset of the physical buffer.
        PBO: u19,
        /// Physical buffer base address. Base address MSB of the physical buffer.
        PBBA: u9,
    }),
    /// offset: 0x30
    reserved48: [4048]u8,
    /// GFXMMU LUT entry 0 low.
    /// offset: 0x1000
    LUTL: mmio.Mmio(packed struct(u32) {
        /// Line enable.
        EN: u1,
        reserved8: u7 = 0,
        /// First Valid Block. Number of the first valid block of line number x.
        FVB: u8,
        /// Last Valid Block. Number of the last valid block of line number X.
        LVB: u8,
        padding: u8 = 0,
    }),
    /// GFXMMU LUT entry 0 high.
    /// offset: 0x1004
    LUTH: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Line offset. Line offset of line number x (i.e. offset of block 0 of line x).
        LO: u18,
        padding: u10 = 0,
    }),
};
