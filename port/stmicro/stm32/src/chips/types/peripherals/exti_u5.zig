const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// External interrupt/event controller
pub const EXTI = extern struct {
    /// Rising Trigger selection register
    /// offset: 0x00
    RTSR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of LINE) EXTI line
        @"LINE[0]": u1,
        /// (2/32 of LINE) EXTI line
        @"LINE[1]": u1,
        /// (3/32 of LINE) EXTI line
        @"LINE[2]": u1,
        /// (4/32 of LINE) EXTI line
        @"LINE[3]": u1,
        /// (5/32 of LINE) EXTI line
        @"LINE[4]": u1,
        /// (6/32 of LINE) EXTI line
        @"LINE[5]": u1,
        /// (7/32 of LINE) EXTI line
        @"LINE[6]": u1,
        /// (8/32 of LINE) EXTI line
        @"LINE[7]": u1,
        /// (9/32 of LINE) EXTI line
        @"LINE[8]": u1,
        /// (10/32 of LINE) EXTI line
        @"LINE[9]": u1,
        /// (11/32 of LINE) EXTI line
        @"LINE[10]": u1,
        /// (12/32 of LINE) EXTI line
        @"LINE[11]": u1,
        /// (13/32 of LINE) EXTI line
        @"LINE[12]": u1,
        /// (14/32 of LINE) EXTI line
        @"LINE[13]": u1,
        /// (15/32 of LINE) EXTI line
        @"LINE[14]": u1,
        /// (16/32 of LINE) EXTI line
        @"LINE[15]": u1,
        /// (17/32 of LINE) EXTI line
        @"LINE[16]": u1,
        /// (18/32 of LINE) EXTI line
        @"LINE[17]": u1,
        /// (19/32 of LINE) EXTI line
        @"LINE[18]": u1,
        /// (20/32 of LINE) EXTI line
        @"LINE[19]": u1,
        /// (21/32 of LINE) EXTI line
        @"LINE[20]": u1,
        /// (22/32 of LINE) EXTI line
        @"LINE[21]": u1,
        /// (23/32 of LINE) EXTI line
        @"LINE[22]": u1,
        /// (24/32 of LINE) EXTI line
        @"LINE[23]": u1,
        /// (25/32 of LINE) EXTI line
        @"LINE[24]": u1,
        /// (26/32 of LINE) EXTI line
        @"LINE[25]": u1,
        /// (27/32 of LINE) EXTI line
        @"LINE[26]": u1,
        /// (28/32 of LINE) EXTI line
        @"LINE[27]": u1,
        /// (29/32 of LINE) EXTI line
        @"LINE[28]": u1,
        /// (30/32 of LINE) EXTI line
        @"LINE[29]": u1,
        /// (31/32 of LINE) EXTI line
        @"LINE[30]": u1,
        /// (32/32 of LINE) EXTI line
        @"LINE[31]": u1,
    }),
    /// Falling Trigger selection register
    /// offset: 0x04
    FTSR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of LINE) EXTI line
        @"LINE[0]": u1,
        /// (2/32 of LINE) EXTI line
        @"LINE[1]": u1,
        /// (3/32 of LINE) EXTI line
        @"LINE[2]": u1,
        /// (4/32 of LINE) EXTI line
        @"LINE[3]": u1,
        /// (5/32 of LINE) EXTI line
        @"LINE[4]": u1,
        /// (6/32 of LINE) EXTI line
        @"LINE[5]": u1,
        /// (7/32 of LINE) EXTI line
        @"LINE[6]": u1,
        /// (8/32 of LINE) EXTI line
        @"LINE[7]": u1,
        /// (9/32 of LINE) EXTI line
        @"LINE[8]": u1,
        /// (10/32 of LINE) EXTI line
        @"LINE[9]": u1,
        /// (11/32 of LINE) EXTI line
        @"LINE[10]": u1,
        /// (12/32 of LINE) EXTI line
        @"LINE[11]": u1,
        /// (13/32 of LINE) EXTI line
        @"LINE[12]": u1,
        /// (14/32 of LINE) EXTI line
        @"LINE[13]": u1,
        /// (15/32 of LINE) EXTI line
        @"LINE[14]": u1,
        /// (16/32 of LINE) EXTI line
        @"LINE[15]": u1,
        /// (17/32 of LINE) EXTI line
        @"LINE[16]": u1,
        /// (18/32 of LINE) EXTI line
        @"LINE[17]": u1,
        /// (19/32 of LINE) EXTI line
        @"LINE[18]": u1,
        /// (20/32 of LINE) EXTI line
        @"LINE[19]": u1,
        /// (21/32 of LINE) EXTI line
        @"LINE[20]": u1,
        /// (22/32 of LINE) EXTI line
        @"LINE[21]": u1,
        /// (23/32 of LINE) EXTI line
        @"LINE[22]": u1,
        /// (24/32 of LINE) EXTI line
        @"LINE[23]": u1,
        /// (25/32 of LINE) EXTI line
        @"LINE[24]": u1,
        /// (26/32 of LINE) EXTI line
        @"LINE[25]": u1,
        /// (27/32 of LINE) EXTI line
        @"LINE[26]": u1,
        /// (28/32 of LINE) EXTI line
        @"LINE[27]": u1,
        /// (29/32 of LINE) EXTI line
        @"LINE[28]": u1,
        /// (30/32 of LINE) EXTI line
        @"LINE[29]": u1,
        /// (31/32 of LINE) EXTI line
        @"LINE[30]": u1,
        /// (32/32 of LINE) EXTI line
        @"LINE[31]": u1,
    }),
    /// Software interrupt event register
    /// offset: 0x08
    SWIER: mmio.Mmio(packed struct(u32) {
        /// (1/32 of LINE) EXTI line
        @"LINE[0]": u1,
        /// (2/32 of LINE) EXTI line
        @"LINE[1]": u1,
        /// (3/32 of LINE) EXTI line
        @"LINE[2]": u1,
        /// (4/32 of LINE) EXTI line
        @"LINE[3]": u1,
        /// (5/32 of LINE) EXTI line
        @"LINE[4]": u1,
        /// (6/32 of LINE) EXTI line
        @"LINE[5]": u1,
        /// (7/32 of LINE) EXTI line
        @"LINE[6]": u1,
        /// (8/32 of LINE) EXTI line
        @"LINE[7]": u1,
        /// (9/32 of LINE) EXTI line
        @"LINE[8]": u1,
        /// (10/32 of LINE) EXTI line
        @"LINE[9]": u1,
        /// (11/32 of LINE) EXTI line
        @"LINE[10]": u1,
        /// (12/32 of LINE) EXTI line
        @"LINE[11]": u1,
        /// (13/32 of LINE) EXTI line
        @"LINE[12]": u1,
        /// (14/32 of LINE) EXTI line
        @"LINE[13]": u1,
        /// (15/32 of LINE) EXTI line
        @"LINE[14]": u1,
        /// (16/32 of LINE) EXTI line
        @"LINE[15]": u1,
        /// (17/32 of LINE) EXTI line
        @"LINE[16]": u1,
        /// (18/32 of LINE) EXTI line
        @"LINE[17]": u1,
        /// (19/32 of LINE) EXTI line
        @"LINE[18]": u1,
        /// (20/32 of LINE) EXTI line
        @"LINE[19]": u1,
        /// (21/32 of LINE) EXTI line
        @"LINE[20]": u1,
        /// (22/32 of LINE) EXTI line
        @"LINE[21]": u1,
        /// (23/32 of LINE) EXTI line
        @"LINE[22]": u1,
        /// (24/32 of LINE) EXTI line
        @"LINE[23]": u1,
        /// (25/32 of LINE) EXTI line
        @"LINE[24]": u1,
        /// (26/32 of LINE) EXTI line
        @"LINE[25]": u1,
        /// (27/32 of LINE) EXTI line
        @"LINE[26]": u1,
        /// (28/32 of LINE) EXTI line
        @"LINE[27]": u1,
        /// (29/32 of LINE) EXTI line
        @"LINE[28]": u1,
        /// (30/32 of LINE) EXTI line
        @"LINE[29]": u1,
        /// (31/32 of LINE) EXTI line
        @"LINE[30]": u1,
        /// (32/32 of LINE) EXTI line
        @"LINE[31]": u1,
    }),
    /// Rising pending register
    /// offset: 0x0c
    RPR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of LINE) EXTI line
        @"LINE[0]": u1,
        /// (2/32 of LINE) EXTI line
        @"LINE[1]": u1,
        /// (3/32 of LINE) EXTI line
        @"LINE[2]": u1,
        /// (4/32 of LINE) EXTI line
        @"LINE[3]": u1,
        /// (5/32 of LINE) EXTI line
        @"LINE[4]": u1,
        /// (6/32 of LINE) EXTI line
        @"LINE[5]": u1,
        /// (7/32 of LINE) EXTI line
        @"LINE[6]": u1,
        /// (8/32 of LINE) EXTI line
        @"LINE[7]": u1,
        /// (9/32 of LINE) EXTI line
        @"LINE[8]": u1,
        /// (10/32 of LINE) EXTI line
        @"LINE[9]": u1,
        /// (11/32 of LINE) EXTI line
        @"LINE[10]": u1,
        /// (12/32 of LINE) EXTI line
        @"LINE[11]": u1,
        /// (13/32 of LINE) EXTI line
        @"LINE[12]": u1,
        /// (14/32 of LINE) EXTI line
        @"LINE[13]": u1,
        /// (15/32 of LINE) EXTI line
        @"LINE[14]": u1,
        /// (16/32 of LINE) EXTI line
        @"LINE[15]": u1,
        /// (17/32 of LINE) EXTI line
        @"LINE[16]": u1,
        /// (18/32 of LINE) EXTI line
        @"LINE[17]": u1,
        /// (19/32 of LINE) EXTI line
        @"LINE[18]": u1,
        /// (20/32 of LINE) EXTI line
        @"LINE[19]": u1,
        /// (21/32 of LINE) EXTI line
        @"LINE[20]": u1,
        /// (22/32 of LINE) EXTI line
        @"LINE[21]": u1,
        /// (23/32 of LINE) EXTI line
        @"LINE[22]": u1,
        /// (24/32 of LINE) EXTI line
        @"LINE[23]": u1,
        /// (25/32 of LINE) EXTI line
        @"LINE[24]": u1,
        /// (26/32 of LINE) EXTI line
        @"LINE[25]": u1,
        /// (27/32 of LINE) EXTI line
        @"LINE[26]": u1,
        /// (28/32 of LINE) EXTI line
        @"LINE[27]": u1,
        /// (29/32 of LINE) EXTI line
        @"LINE[28]": u1,
        /// (30/32 of LINE) EXTI line
        @"LINE[29]": u1,
        /// (31/32 of LINE) EXTI line
        @"LINE[30]": u1,
        /// (32/32 of LINE) EXTI line
        @"LINE[31]": u1,
    }),
    /// Falling pending register
    /// offset: 0x10
    FPR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of LINE) EXTI line
        @"LINE[0]": u1,
        /// (2/32 of LINE) EXTI line
        @"LINE[1]": u1,
        /// (3/32 of LINE) EXTI line
        @"LINE[2]": u1,
        /// (4/32 of LINE) EXTI line
        @"LINE[3]": u1,
        /// (5/32 of LINE) EXTI line
        @"LINE[4]": u1,
        /// (6/32 of LINE) EXTI line
        @"LINE[5]": u1,
        /// (7/32 of LINE) EXTI line
        @"LINE[6]": u1,
        /// (8/32 of LINE) EXTI line
        @"LINE[7]": u1,
        /// (9/32 of LINE) EXTI line
        @"LINE[8]": u1,
        /// (10/32 of LINE) EXTI line
        @"LINE[9]": u1,
        /// (11/32 of LINE) EXTI line
        @"LINE[10]": u1,
        /// (12/32 of LINE) EXTI line
        @"LINE[11]": u1,
        /// (13/32 of LINE) EXTI line
        @"LINE[12]": u1,
        /// (14/32 of LINE) EXTI line
        @"LINE[13]": u1,
        /// (15/32 of LINE) EXTI line
        @"LINE[14]": u1,
        /// (16/32 of LINE) EXTI line
        @"LINE[15]": u1,
        /// (17/32 of LINE) EXTI line
        @"LINE[16]": u1,
        /// (18/32 of LINE) EXTI line
        @"LINE[17]": u1,
        /// (19/32 of LINE) EXTI line
        @"LINE[18]": u1,
        /// (20/32 of LINE) EXTI line
        @"LINE[19]": u1,
        /// (21/32 of LINE) EXTI line
        @"LINE[20]": u1,
        /// (22/32 of LINE) EXTI line
        @"LINE[21]": u1,
        /// (23/32 of LINE) EXTI line
        @"LINE[22]": u1,
        /// (24/32 of LINE) EXTI line
        @"LINE[23]": u1,
        /// (25/32 of LINE) EXTI line
        @"LINE[24]": u1,
        /// (26/32 of LINE) EXTI line
        @"LINE[25]": u1,
        /// (27/32 of LINE) EXTI line
        @"LINE[26]": u1,
        /// (28/32 of LINE) EXTI line
        @"LINE[27]": u1,
        /// (29/32 of LINE) EXTI line
        @"LINE[28]": u1,
        /// (30/32 of LINE) EXTI line
        @"LINE[29]": u1,
        /// (31/32 of LINE) EXTI line
        @"LINE[30]": u1,
        /// (32/32 of LINE) EXTI line
        @"LINE[31]": u1,
    }),
    /// Security configuration register
    /// offset: 0x14
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of SEC) Security enable on event input x
        @"SEC[0]": u1,
        /// (2/32 of SEC) Security enable on event input x
        @"SEC[1]": u1,
        /// (3/32 of SEC) Security enable on event input x
        @"SEC[2]": u1,
        /// (4/32 of SEC) Security enable on event input x
        @"SEC[3]": u1,
        /// (5/32 of SEC) Security enable on event input x
        @"SEC[4]": u1,
        /// (6/32 of SEC) Security enable on event input x
        @"SEC[5]": u1,
        /// (7/32 of SEC) Security enable on event input x
        @"SEC[6]": u1,
        /// (8/32 of SEC) Security enable on event input x
        @"SEC[7]": u1,
        /// (9/32 of SEC) Security enable on event input x
        @"SEC[8]": u1,
        /// (10/32 of SEC) Security enable on event input x
        @"SEC[9]": u1,
        /// (11/32 of SEC) Security enable on event input x
        @"SEC[10]": u1,
        /// (12/32 of SEC) Security enable on event input x
        @"SEC[11]": u1,
        /// (13/32 of SEC) Security enable on event input x
        @"SEC[12]": u1,
        /// (14/32 of SEC) Security enable on event input x
        @"SEC[13]": u1,
        /// (15/32 of SEC) Security enable on event input x
        @"SEC[14]": u1,
        /// (16/32 of SEC) Security enable on event input x
        @"SEC[15]": u1,
        /// (17/32 of SEC) Security enable on event input x
        @"SEC[16]": u1,
        /// (18/32 of SEC) Security enable on event input x
        @"SEC[17]": u1,
        /// (19/32 of SEC) Security enable on event input x
        @"SEC[18]": u1,
        /// (20/32 of SEC) Security enable on event input x
        @"SEC[19]": u1,
        /// (21/32 of SEC) Security enable on event input x
        @"SEC[20]": u1,
        /// (22/32 of SEC) Security enable on event input x
        @"SEC[21]": u1,
        /// (23/32 of SEC) Security enable on event input x
        @"SEC[22]": u1,
        /// (24/32 of SEC) Security enable on event input x
        @"SEC[23]": u1,
        /// (25/32 of SEC) Security enable on event input x
        @"SEC[24]": u1,
        /// (26/32 of SEC) Security enable on event input x
        @"SEC[25]": u1,
        /// (27/32 of SEC) Security enable on event input x
        @"SEC[26]": u1,
        /// (28/32 of SEC) Security enable on event input x
        @"SEC[27]": u1,
        /// (29/32 of SEC) Security enable on event input x
        @"SEC[28]": u1,
        /// (30/32 of SEC) Security enable on event input x
        @"SEC[29]": u1,
        /// (31/32 of SEC) Security enable on event input x
        @"SEC[30]": u1,
        /// (32/32 of SEC) Security enable on event input x
        @"SEC[31]": u1,
    }),
    /// Privilege configuration register
    /// offset: 0x18
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of PRIV) Security enable on event input x
        @"PRIV[0]": u1,
        /// (2/32 of PRIV) Security enable on event input x
        @"PRIV[1]": u1,
        /// (3/32 of PRIV) Security enable on event input x
        @"PRIV[2]": u1,
        /// (4/32 of PRIV) Security enable on event input x
        @"PRIV[3]": u1,
        /// (5/32 of PRIV) Security enable on event input x
        @"PRIV[4]": u1,
        /// (6/32 of PRIV) Security enable on event input x
        @"PRIV[5]": u1,
        /// (7/32 of PRIV) Security enable on event input x
        @"PRIV[6]": u1,
        /// (8/32 of PRIV) Security enable on event input x
        @"PRIV[7]": u1,
        /// (9/32 of PRIV) Security enable on event input x
        @"PRIV[8]": u1,
        /// (10/32 of PRIV) Security enable on event input x
        @"PRIV[9]": u1,
        /// (11/32 of PRIV) Security enable on event input x
        @"PRIV[10]": u1,
        /// (12/32 of PRIV) Security enable on event input x
        @"PRIV[11]": u1,
        /// (13/32 of PRIV) Security enable on event input x
        @"PRIV[12]": u1,
        /// (14/32 of PRIV) Security enable on event input x
        @"PRIV[13]": u1,
        /// (15/32 of PRIV) Security enable on event input x
        @"PRIV[14]": u1,
        /// (16/32 of PRIV) Security enable on event input x
        @"PRIV[15]": u1,
        /// (17/32 of PRIV) Security enable on event input x
        @"PRIV[16]": u1,
        /// (18/32 of PRIV) Security enable on event input x
        @"PRIV[17]": u1,
        /// (19/32 of PRIV) Security enable on event input x
        @"PRIV[18]": u1,
        /// (20/32 of PRIV) Security enable on event input x
        @"PRIV[19]": u1,
        /// (21/32 of PRIV) Security enable on event input x
        @"PRIV[20]": u1,
        /// (22/32 of PRIV) Security enable on event input x
        @"PRIV[21]": u1,
        /// (23/32 of PRIV) Security enable on event input x
        @"PRIV[22]": u1,
        /// (24/32 of PRIV) Security enable on event input x
        @"PRIV[23]": u1,
        /// (25/32 of PRIV) Security enable on event input x
        @"PRIV[24]": u1,
        /// (26/32 of PRIV) Security enable on event input x
        @"PRIV[25]": u1,
        /// (27/32 of PRIV) Security enable on event input x
        @"PRIV[26]": u1,
        /// (28/32 of PRIV) Security enable on event input x
        @"PRIV[27]": u1,
        /// (29/32 of PRIV) Security enable on event input x
        @"PRIV[28]": u1,
        /// (30/32 of PRIV) Security enable on event input x
        @"PRIV[29]": u1,
        /// (31/32 of PRIV) Security enable on event input x
        @"PRIV[30]": u1,
        /// (32/32 of PRIV) Security enable on event input x
        @"PRIV[31]": u1,
    }),
    /// offset: 0x1c
    reserved28: [68]u8,
    /// Configuration register
    /// offset: 0x60
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI configuration bits
        @"EXTI[0]": u8,
        /// (2/4 of EXTI) EXTI configuration bits
        @"EXTI[1]": u8,
        /// (3/4 of EXTI) EXTI configuration bits
        @"EXTI[2]": u8,
        /// (4/4 of EXTI) EXTI configuration bits
        @"EXTI[3]": u8,
    }),
    /// EXTI lock register
    /// offset: 0x70
    LOCKRG: mmio.Mmio(packed struct(u32) {
        /// LOCK
        LOCK: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x74
    reserved116: [12]u8,
    /// Interrupt mask register
    /// offset: 0x80
    IMR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of LINE) EXTI line
        @"LINE[0]": u1,
        /// (2/32 of LINE) EXTI line
        @"LINE[1]": u1,
        /// (3/32 of LINE) EXTI line
        @"LINE[2]": u1,
        /// (4/32 of LINE) EXTI line
        @"LINE[3]": u1,
        /// (5/32 of LINE) EXTI line
        @"LINE[4]": u1,
        /// (6/32 of LINE) EXTI line
        @"LINE[5]": u1,
        /// (7/32 of LINE) EXTI line
        @"LINE[6]": u1,
        /// (8/32 of LINE) EXTI line
        @"LINE[7]": u1,
        /// (9/32 of LINE) EXTI line
        @"LINE[8]": u1,
        /// (10/32 of LINE) EXTI line
        @"LINE[9]": u1,
        /// (11/32 of LINE) EXTI line
        @"LINE[10]": u1,
        /// (12/32 of LINE) EXTI line
        @"LINE[11]": u1,
        /// (13/32 of LINE) EXTI line
        @"LINE[12]": u1,
        /// (14/32 of LINE) EXTI line
        @"LINE[13]": u1,
        /// (15/32 of LINE) EXTI line
        @"LINE[14]": u1,
        /// (16/32 of LINE) EXTI line
        @"LINE[15]": u1,
        /// (17/32 of LINE) EXTI line
        @"LINE[16]": u1,
        /// (18/32 of LINE) EXTI line
        @"LINE[17]": u1,
        /// (19/32 of LINE) EXTI line
        @"LINE[18]": u1,
        /// (20/32 of LINE) EXTI line
        @"LINE[19]": u1,
        /// (21/32 of LINE) EXTI line
        @"LINE[20]": u1,
        /// (22/32 of LINE) EXTI line
        @"LINE[21]": u1,
        /// (23/32 of LINE) EXTI line
        @"LINE[22]": u1,
        /// (24/32 of LINE) EXTI line
        @"LINE[23]": u1,
        /// (25/32 of LINE) EXTI line
        @"LINE[24]": u1,
        /// (26/32 of LINE) EXTI line
        @"LINE[25]": u1,
        /// (27/32 of LINE) EXTI line
        @"LINE[26]": u1,
        /// (28/32 of LINE) EXTI line
        @"LINE[27]": u1,
        /// (29/32 of LINE) EXTI line
        @"LINE[28]": u1,
        /// (30/32 of LINE) EXTI line
        @"LINE[29]": u1,
        /// (31/32 of LINE) EXTI line
        @"LINE[30]": u1,
        /// (32/32 of LINE) EXTI line
        @"LINE[31]": u1,
    }),
    /// Event mask register
    /// offset: 0x84
    EMR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of LINE) EXTI line
        @"LINE[0]": u1,
        /// (2/32 of LINE) EXTI line
        @"LINE[1]": u1,
        /// (3/32 of LINE) EXTI line
        @"LINE[2]": u1,
        /// (4/32 of LINE) EXTI line
        @"LINE[3]": u1,
        /// (5/32 of LINE) EXTI line
        @"LINE[4]": u1,
        /// (6/32 of LINE) EXTI line
        @"LINE[5]": u1,
        /// (7/32 of LINE) EXTI line
        @"LINE[6]": u1,
        /// (8/32 of LINE) EXTI line
        @"LINE[7]": u1,
        /// (9/32 of LINE) EXTI line
        @"LINE[8]": u1,
        /// (10/32 of LINE) EXTI line
        @"LINE[9]": u1,
        /// (11/32 of LINE) EXTI line
        @"LINE[10]": u1,
        /// (12/32 of LINE) EXTI line
        @"LINE[11]": u1,
        /// (13/32 of LINE) EXTI line
        @"LINE[12]": u1,
        /// (14/32 of LINE) EXTI line
        @"LINE[13]": u1,
        /// (15/32 of LINE) EXTI line
        @"LINE[14]": u1,
        /// (16/32 of LINE) EXTI line
        @"LINE[15]": u1,
        /// (17/32 of LINE) EXTI line
        @"LINE[16]": u1,
        /// (18/32 of LINE) EXTI line
        @"LINE[17]": u1,
        /// (19/32 of LINE) EXTI line
        @"LINE[18]": u1,
        /// (20/32 of LINE) EXTI line
        @"LINE[19]": u1,
        /// (21/32 of LINE) EXTI line
        @"LINE[20]": u1,
        /// (22/32 of LINE) EXTI line
        @"LINE[21]": u1,
        /// (23/32 of LINE) EXTI line
        @"LINE[22]": u1,
        /// (24/32 of LINE) EXTI line
        @"LINE[23]": u1,
        /// (25/32 of LINE) EXTI line
        @"LINE[24]": u1,
        /// (26/32 of LINE) EXTI line
        @"LINE[25]": u1,
        /// (27/32 of LINE) EXTI line
        @"LINE[26]": u1,
        /// (28/32 of LINE) EXTI line
        @"LINE[27]": u1,
        /// (29/32 of LINE) EXTI line
        @"LINE[28]": u1,
        /// (30/32 of LINE) EXTI line
        @"LINE[29]": u1,
        /// (31/32 of LINE) EXTI line
        @"LINE[30]": u1,
        /// (32/32 of LINE) EXTI line
        @"LINE[31]": u1,
    }),
};
