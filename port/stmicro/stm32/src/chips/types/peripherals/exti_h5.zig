const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Extended interrupt and event controller
pub const EXTI = extern struct {
    /// rising trigger selection register
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
    /// falling trigger selection register
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
    /// software interrupt event register
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
    /// rising edge pending register
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
    /// falling edge pending register
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
    /// security configuration register
    /// offset: 0x14
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[0]": u1,
        /// (2/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[1]": u1,
        /// (3/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[2]": u1,
        /// (4/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[3]": u1,
        /// (5/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[4]": u1,
        /// (6/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[5]": u1,
        /// (7/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[6]": u1,
        /// (8/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[7]": u1,
        /// (9/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[8]": u1,
        /// (10/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[9]": u1,
        /// (11/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[10]": u1,
        /// (12/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[11]": u1,
        /// (13/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[12]": u1,
        /// (14/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[13]": u1,
        /// (15/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[14]": u1,
        /// (16/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[15]": u1,
        /// (17/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[16]": u1,
        /// (18/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[17]": u1,
        /// (19/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[18]": u1,
        /// (20/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[19]": u1,
        /// (21/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[20]": u1,
        /// (22/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[21]": u1,
        /// (23/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[22]": u1,
        /// (24/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[23]": u1,
        /// (25/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[24]": u1,
        /// (26/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[25]": u1,
        /// (27/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[26]": u1,
        /// (28/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[27]": u1,
        /// (29/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[28]": u1,
        /// (30/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[29]": u1,
        /// (31/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[30]": u1,
        /// (32/32 of SEC) Security enable on event input x When EXTI_PRIVCFGR.PRIVx is disabled, SECx can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIVx is enabled, SECx can only be written with privileged access. Unprivileged write to this SECx is discarded.
        @"SEC[31]": u1,
    }),
    /// privilege configuration register
    /// offset: 0x18
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[0]": u1,
        /// (2/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[1]": u1,
        /// (3/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[2]": u1,
        /// (4/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[3]": u1,
        /// (5/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[4]": u1,
        /// (6/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[5]": u1,
        /// (7/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[6]": u1,
        /// (8/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[7]": u1,
        /// (9/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[8]": u1,
        /// (10/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[9]": u1,
        /// (11/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[10]": u1,
        /// (12/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[11]": u1,
        /// (13/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[12]": u1,
        /// (14/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[13]": u1,
        /// (15/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[14]": u1,
        /// (16/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[15]": u1,
        /// (17/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[16]": u1,
        /// (18/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[17]": u1,
        /// (19/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[18]": u1,
        /// (20/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[19]": u1,
        /// (21/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[20]": u1,
        /// (22/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[21]": u1,
        /// (23/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[22]": u1,
        /// (24/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[23]": u1,
        /// (25/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[24]": u1,
        /// (26/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[25]": u1,
        /// (27/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[26]": u1,
        /// (28/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[27]": u1,
        /// (29/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[28]": u1,
        /// (30/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[29]": u1,
        /// (31/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[30]": u1,
        /// (32/32 of PRIV) Security enable on event input x When EXTI_SECCFGR.SECx is disabled, PRIVx can be accessed with secure and non-secure access. When EXTI_SECCFGR.SECx is enabled, PRIVx can only be written with secure access. Non-secure write to this PRIVx is discarded.
        @"PRIV[31]": u1,
    }),
    /// offset: 0x1c
    reserved28: [68]u8,
    /// external interrupt selection register
    /// offset: 0x60
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI12 GPIO port selection These bits are written by software to select the source input for EXTI12 external interrupt. When EXTI_PRIVCFGR.PRIV12 is disabled, EXTI12 can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIV12 is enabled, EXTI12 can only be accessed with privileged access. Unprivileged write to this bit is discarded. Others: reserved
        @"EXTI[0]": u8,
        /// (2/4 of EXTI) EXTI12 GPIO port selection These bits are written by software to select the source input for EXTI12 external interrupt. When EXTI_PRIVCFGR.PRIV12 is disabled, EXTI12 can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIV12 is enabled, EXTI12 can only be accessed with privileged access. Unprivileged write to this bit is discarded. Others: reserved
        @"EXTI[1]": u8,
        /// (3/4 of EXTI) EXTI12 GPIO port selection These bits are written by software to select the source input for EXTI12 external interrupt. When EXTI_PRIVCFGR.PRIV12 is disabled, EXTI12 can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIV12 is enabled, EXTI12 can only be accessed with privileged access. Unprivileged write to this bit is discarded. Others: reserved
        @"EXTI[2]": u8,
        /// (4/4 of EXTI) EXTI12 GPIO port selection These bits are written by software to select the source input for EXTI12 external interrupt. When EXTI_PRIVCFGR.PRIV12 is disabled, EXTI12 can be accessed with privileged and unprivileged access. When EXTI_PRIVCFGR.PRIV12 is enabled, EXTI12 can only be accessed with privileged access. Unprivileged write to this bit is discarded. Others: reserved
        @"EXTI[3]": u8,
    }),
    /// lock register
    /// offset: 0x70
    LOCKR: mmio.Mmio(packed struct(u32) {
        /// Global security and privilege configuration registers (EXTI_SECCFGR and EXTI_PRIVCFGR) lock This bit is written once after reset.
        LOCK: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x74
    reserved116: [12]u8,
    /// CPU wakeup with interrupt mask register
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
    /// CPU wakeup with event mask register
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
