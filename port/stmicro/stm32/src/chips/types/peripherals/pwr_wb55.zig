const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const VOS = enum(u2) {
    /// Range 1
    Range1 = 0x1,
    /// Range 2
    Range2 = 0x2,
    _,
};

/// Power control
pub const PWR = extern struct {
    /// Power control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection for CPU1
        LPMS: u3,
        reserved4: u1 = 0,
        /// Flash power down mode during LPRun for CPU1
        FPDR: u1,
        /// Flash power down mode during LPsSleep for CPU1
        FPDS: u1,
        reserved8: u2 = 0,
        /// Disable backup domain write protection
        DBP: u1,
        /// Voltage scaling range selection
        VOS: VOS,
        reserved14: u3 = 0,
        /// Low-power run
        LPR: u1,
        padding: u17 = 0,
    }),
    /// Power control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Power voltage detector enable
        PVDE: u1,
        /// Power voltage detector level selection
        PLS: u3,
        /// Peripheral voltage monitoring 1 enable: VDDUSB vs. 1.2V
        PVME1: u1,
        reserved6: u1 = 0,
        /// Peripheral voltage monitoring 3 enable: VDDA vs. 1.62V
        PVME3: u1,
        reserved10: u3 = 0,
        /// VDDUSB USB supply valid
        USV: u1,
        padding: u21 = 0,
    }),
    /// Power control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// (1/5 of EWUP) Enable Wakeup pin
        @"EWUP[0]": u1,
        /// (2/5 of EWUP) Enable Wakeup pin
        @"EWUP[1]": u1,
        /// (3/5 of EWUP) Enable Wakeup pin
        @"EWUP[2]": u1,
        /// (4/5 of EWUP) Enable Wakeup pin
        @"EWUP[3]": u1,
        /// (5/5 of EWUP) Enable Wakeup pin
        @"EWUP[4]": u1,
        reserved8: u3 = 0,
        /// Enable BORH and Step Down counverter forced in Bypass interrups for CPU1
        EBORHSDFB: u1,
        /// SRAM2a retention in Standby mode
        RRS: u1,
        /// Apply pull-up and pull-down configuration
        APC: u1,
        /// Enable BLE end of activity interrupt for CPU1
        EBLEA: u1,
        /// Enable critical radio phase end of activity interrupt for CPU1
        ECRPE: u1,
        /// Enable end of activity interrupt for CPU1
        E802A: u1,
        /// Enable CPU2 Hold interrupt for CPU1
        EC2H: u1,
        /// Enable internal wakeup line for CPU1
        EIWUL: u1,
        padding: u16 = 0,
    }),
    /// Power control register 4
    /// offset: 0x0c
    CR4: mmio.Mmio(packed struct(u32) {
        /// (1/5 of WP1) Wakeup pin WKUP1 polarity
        @"WP1[0]": u1,
        /// (2/5 of WP1) Wakeup pin WKUP1 polarity
        @"WP1[1]": u1,
        /// (3/5 of WP1) Wakeup pin WKUP1 polarity
        @"WP1[2]": u1,
        /// (4/5 of WP1) Wakeup pin WKUP1 polarity
        @"WP1[3]": u1,
        /// (5/5 of WP1) Wakeup pin WKUP1 polarity
        @"WP1[4]": u1,
        reserved8: u3 = 0,
        /// VBAT battery charging enable
        VBE: u1,
        /// VBAT battery charging resistor selection
        VBRS: u1,
        reserved15: u5 = 0,
        /// BOOT CPU2 after reset or wakeup from Stop or Standby modes
        C2BOOT: u1,
        padding: u16 = 0,
    }),
    /// Power status register 1
    /// offset: 0x10
    SR1: mmio.Mmio(packed struct(u32) {
        /// (1/5 of CWUF) Wakeup flag 1
        @"CWUF[0]": u1,
        /// (2/5 of CWUF) Wakeup flag 1
        @"CWUF[1]": u1,
        /// (3/5 of CWUF) Wakeup flag 1
        @"CWUF[2]": u1,
        /// (4/5 of CWUF) Wakeup flag 1
        @"CWUF[3]": u1,
        /// (5/5 of CWUF) Wakeup flag 1
        @"CWUF[4]": u1,
        reserved7: u2 = 0,
        /// Step Down converter forced in Bypass interrupt flag
        SDFBF: u1,
        /// BORH interrupt flag
        BORHF: u1,
        /// BLE wakeup interrupt flag
        BLEWUF: u1,
        /// 802.15.4 wakeup interrupt flag
        _802WUF: u1,
        /// Enable critical radio phase end of activity interrupt flag
        CRPEF: u1,
        /// BLE end of activity interrupt flag
        BLEAF: u1,
        /// 802.15.4 end of activity interrupt flag
        AF802: u1,
        /// CPU2 Hold interrupt flag
        C2HF: u1,
        /// Internal Wakeup interrupt flag
        WUFI: u1,
        padding: u16 = 0,
    }),
    /// Power status register 2
    /// offset: 0x14
    SR2: mmio.Mmio(packed struct(u32) {
        /// Step Down converter Bypass mode flag
        SDBF: u1,
        /// Step Down converter SMPS mode flag
        SDSMPSF: u1,
        reserved8: u6 = 0,
        /// Low-power regulator started
        REGLPS: u1,
        /// Low-power regulator flag
        REGLPF: u1,
        /// Voltage scaling flag
        VOSF: u1,
        /// Power voltage detector output
        PVDO: u1,
        /// Peripheral voltage monitoring output: VDDUSB vs. 1.2 V
        PVMO1: u1,
        reserved14: u1 = 0,
        /// Peripheral voltage monitoring output: VDDA vs. 1.62 V
        PVMO3: u1,
        padding: u17 = 0,
    }),
    /// Power status clear register
    /// offset: 0x18
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/5 of CWUF) Clear wakeup flag 1
        @"CWUF[0]": u1,
        /// (2/5 of CWUF) Clear wakeup flag 1
        @"CWUF[1]": u1,
        /// (3/5 of CWUF) Clear wakeup flag 1
        @"CWUF[2]": u1,
        /// (4/5 of CWUF) Clear wakeup flag 1
        @"CWUF[3]": u1,
        /// (5/5 of CWUF) Clear wakeup flag 1
        @"CWUF[4]": u1,
        reserved7: u2 = 0,
        /// Clear SMPS Step Down converter forced in Bypass interrupt flag
        CSMPSFBF: u1,
        /// Clear BORH interrupt flag
        CBORHF: u1,
        /// Clear BLE wakeup interrupt flag
        CBLEWUF: u1,
        /// Clear 802.15.4 wakeup interrupt flag
        C802WUF: u1,
        /// Clear critical radio phase end of activity interrupt flag
        CCRPEF: u1,
        /// Clear BLE end of activity interrupt flag
        CBLEAF: u1,
        /// Clear 802.15.4 end of activity interrupt flag
        C802AF: u1,
        /// Clear CPU2 Hold interrupt flag
        CC2HF: u1,
        padding: u17 = 0,
    }),
    /// Power control register 5
    /// offset: 0x1c
    CR5: mmio.Mmio(packed struct(u32) {
        /// Step Down converter voltage output scaling
        SDVOS: u4,
        /// Step Down converter supplt startup current selection
        SDSC: u3,
        reserved8: u1 = 0,
        /// BORH configuration selection
        BORHC: u1,
        /// VOS configuration selection (non user)
        SMPSCFG: u1,
        reserved14: u4 = 0,
        /// Enable Step Down converter Bypass mode enabled
        SDBEN: u1,
        /// Enable Step Down converter SMPS mode enabled
        SDEB: u1,
        padding: u16 = 0,
    }),
    /// Power Port A pull-up control register
    /// offset: 0x20
    PUCRA: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port A pull-down control register
    /// offset: 0x24
    PDCRA: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port B pull-up control register
    /// offset: 0x28
    PUCRB: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port B pull-down control register
    /// offset: 0x2c
    PDCRB: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port C pull-up control register
    /// offset: 0x30
    PUCRC: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port C pull-down control register
    /// offset: 0x34
    PDCRC: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port D pull-up control register
    /// offset: 0x38
    PUCRD: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port D pull-down control register
    /// offset: 0x3c
    PDCRD: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port E pull-up control register
    /// offset: 0x40
    PUCRE: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port E pull-down control register
    /// offset: 0x44
    PDCRE: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// offset: 0x48
    reserved72: [16]u8,
    /// Power Port H pull-up control register
    /// offset: 0x58
    PUCRH: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port H pull-down control register
    /// offset: 0x5c
    PDCRH: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[0]": u1,
        /// (2/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[1]": u1,
        /// (3/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[2]": u1,
        /// (4/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[3]": u1,
        /// (5/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[4]": u1,
        /// (6/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[5]": u1,
        /// (7/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[6]": u1,
        /// (8/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[7]": u1,
        /// (9/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[8]": u1,
        /// (10/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[9]": u1,
        /// (11/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[10]": u1,
        /// (12/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[11]": u1,
        /// (13/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[12]": u1,
        /// (14/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[13]": u1,
        /// (15/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[14]": u1,
        /// (16/16 of PD) Port A pull-up/down bit y (y=0..15)
        @"PD[15]": u1,
        padding: u16 = 0,
    }),
    /// offset: 0x60
    reserved96: [32]u8,
    /// CPU2 Power control register 1
    /// offset: 0x80
    C2CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection for CPU2
        LPMS: u3,
        reserved4: u1 = 0,
        /// Flash power down mode during LPRun for CPU2
        FPDR: u1,
        /// Flash power down mode during LPSleep for CPU2
        FPDS: u1,
        reserved14: u8 = 0,
        /// BLE external wakeup signal
        BLEEWKUP: u1,
        /// 802.15.4 external wakeup signal
        _802EWKUP: u1,
        padding: u16 = 0,
    }),
    /// CPU2 Power control register 3
    /// offset: 0x84
    C2CR3: mmio.Mmio(packed struct(u32) {
        /// (1/5 of EWUP) Enable Wakeup pin
        @"EWUP[0]": u1,
        /// (2/5 of EWUP) Enable Wakeup pin
        @"EWUP[1]": u1,
        /// (3/5 of EWUP) Enable Wakeup pin
        @"EWUP[2]": u1,
        /// (4/5 of EWUP) Enable Wakeup pin
        @"EWUP[3]": u1,
        /// (5/5 of EWUP) Enable Wakeup pin
        @"EWUP[4]": u1,
        reserved9: u4 = 0,
        /// Enable BLE host wakeup interrupt for CPU2
        EBLEWUP: u1,
        /// Enable 802.15.4 host wakeup interrupt for CPU2
        E802WUP: u1,
        reserved12: u1 = 0,
        /// Apply pull-up and pull-down configuration for CPU2
        APC: u1,
        reserved15: u2 = 0,
        /// Enable internal wakeup line for CPU2
        EIWUL: u1,
        padding: u16 = 0,
    }),
    /// Power status clear register
    /// offset: 0x88
    EXTSCR: mmio.Mmio(packed struct(u32) {
        /// Clear CPU1 Stop Standby flags
        C1CSSF: u1,
        /// Clear CPU2 Stop Standby flags
        C2CSSF: u1,
        /// Clear Critical Radio system phase
        CCRPF: u1,
        reserved8: u5 = 0,
        /// System Standby flag for CPU1
        C1SBF: u1,
        /// System Stop flag for CPU1
        C1STOPF: u1,
        /// System Standby flag for CPU2
        C2SBF: u1,
        /// System Stop flag for CPU2
        C2STOPF: u1,
        reserved13: u1 = 0,
        /// Critical Radio system phase
        CRPF: u1,
        /// CPU1 deepsleep mode
        C1DS: u1,
        /// CPU2 deepsleep mode
        C2DS: u1,
        padding: u16 = 0,
    }),
};
