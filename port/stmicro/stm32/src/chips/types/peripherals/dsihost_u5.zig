const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// DSI Host.
pub const DSIHOST = extern struct {
    /// DSI Host version register.
    /// offset: 0x00
    VR: mmio.Mmio(packed struct(u32) {
        /// Version of the DSI Host This read-only register contains the version of the DSI Host.
        VERSION: u32,
    }),
    /// DSI Host control register.
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// Enable This bit configures the DSI Host in either power-up mode or to reset.
        EN: u1,
        padding: u31 = 0,
    }),
    /// DSI Host clock control register.
    /// offset: 0x08
    CCR: mmio.Mmio(packed struct(u32) {
        /// TX escape clock division This field indicates the division factor for the TX escape clock source (lanebyteclk). The values 0 and 1 stop the TX_ESC clock generation.
        TXECKDIV: u8,
        /// Timeout clock division This field indicates the division factor for the timeout clock used as the timing unit in the configuration of HS to LP and LP to HS transition error.
        TOCKDIV: u8,
        padding: u16 = 0,
    }),
    /// DSI Host LTDC VCID register.
    /// offset: 0x0c
    LVCIDR: mmio.Mmio(packed struct(u32) {
        /// Virtual channel ID These bits configure the virtual channel ID for the LTDC interface traffic.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host LTDC color coding register.
    /// offset: 0x10
    LCOLCR: mmio.Mmio(packed struct(u32) {
        /// Color coding This field configures the DPI color coding. Others: Reserved.
        COLC: u4,
        reserved8: u4 = 0,
        /// Loosely packet enable This bit enables the loosely packed variant to 18-bit configuration.
        LPE: u1,
        padding: u23 = 0,
    }),
    /// DSI Host LTDC polarity configuration register.
    /// offset: 0x14
    LPCR: mmio.Mmio(packed struct(u32) {
        /// Data enable polarity This bit configures the polarity of data enable pin.
        DEP: u1,
        /// VSYNC polarity This bit configures the polarity of VSYNC pin.
        VSP: u1,
        /// HSYNC polarity This bit configures the polarity of HSYNC pin.
        HSP: u1,
        padding: u29 = 0,
    }),
    /// DSI Host low-power mode configuration register.
    /// offset: 0x18
    LPMCR: mmio.Mmio(packed struct(u32) {
        /// VACT largest packet size This field is used for the transmission of commands in low-power mode. It defines the size, in bytes, of the largest packet that can fit in a line during VACT regions.
        VLPSIZE: u8,
        reserved16: u8 = 0,
        /// Largest packet size This field is used for the transmission of commands in low-power mode. It defines the size, in bytes, of the largest packet that can fit in a line during VSA, VBP and VFP regions.
        LPSIZE: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x1c
    reserved28: [16]u8,
    /// DSI Host protocol configuration register.
    /// offset: 0x2c
    PCR: mmio.Mmio(packed struct(u32) {
        /// EoTp transmission enable This bit enables the EoTP transmission.
        ETTXE: u1,
        /// EoTp reception enable This bit enables the EoTp reception.
        ETRXE: u1,
        /// Bus-turn-around enable This bit enables the bus-turn-around (BTA) request.
        BTAE: u1,
        /// ECC reception enable This bit enables the ECC reception, error correction and reporting.
        ECCRXE: u1,
        /// CRC reception enable This bit enables the CRC reception and error reporting.
        CRCRXE: u1,
        /// EoTp transmission in low-power enable This bit enables the EoTP transmission in low-power.
        ETTXLPE: u1,
        padding: u26 = 0,
    }),
    /// DSI Host generic VCID register.
    /// offset: 0x30
    GVCIDR: mmio.Mmio(packed struct(u32) {
        /// Virtual channel ID for reception This field indicates the generic interface read-back virtual channel identification.
        VCIDRX: u2,
        reserved16: u14 = 0,
        /// Virtual channel ID for transmission This field indicates the generic interface virtual channel identification where the generic packet is automatically generated and transmitted.
        VCIDTX: u2,
        padding: u14 = 0,
    }),
    /// DSI Host mode configuration register.
    /// offset: 0x34
    MCR: mmio.Mmio(packed struct(u32) {
        /// Command mode This bit configures the DSI Host in either video or command mode.
        CMDM: u1,
        padding: u31 = 0,
    }),
    /// DSI Host video mode configuration register.
    /// offset: 0x38
    VMCR: mmio.Mmio(packed struct(u32) {
        /// Video mode type This field configures the video mode transmission type : 1x: Burst mode.
        VMT: u2,
        reserved8: u6 = 0,
        /// Low-power vertical sync active enable This bit enables to return to low-power inside the vertical sync time (VSA) period when timing allows.
        LPVSAE: u1,
        /// Low-power vertical back-porch enable This bit enables to return to low-power inside the vertical back-porch (VBP) period when timing allows.
        LPVBPE: u1,
        /// Low-power vertical front-porch enable This bit enables to return to low-power inside the vertical front-porch (VFP) period when timing allows.
        LPVFPE: u1,
        /// Low-power vertical active enable This bit enables to return to low-power inside the vertical active (VACT) period when timing allows.
        LPVAE: u1,
        /// Low-power horizontal back-porch enable This bit enables the return to low-power inside the horizontal back-porch (HBP) period when timing allows.
        LPHBPE: u1,
        /// Low-power horizontal front-porch enable This bit enables the return to low-power inside the horizontal front-porch (HFP) period when timing allows.
        LPHFPE: u1,
        /// Frame bus-turn-around acknowledge enable This bit enables the request for an acknowledge response at the end of a frame.
        FBTAAE: u1,
        /// Low-power command enable This bit enables the command transmission only in low-power mode.
        LPCE: u1,
        /// Pattern generator enable This bit enables the video mode pattern generator.
        PGE: u1,
        reserved20: u3 = 0,
        /// Pattern generator mode This bit configures the pattern generator mode.
        PGM: u1,
        reserved24: u3 = 0,
        /// Pattern generator orientation This bit configures the color bar orientation.
        PGO: u1,
        padding: u7 = 0,
    }),
    /// DSI Host video packet configuration register.
    /// offset: 0x3c
    VPCR: mmio.Mmio(packed struct(u32) {
        /// Video packet size This field configures the number of pixels in a single video packet. For 18-bit not loosely packed data types, this number must be a multiple of 4. For YCbCr data types, it must be a multiple of 2 as described in the DSI specification.
        VPSIZE: u14,
        padding: u18 = 0,
    }),
    /// DSI Host video chunks configuration register.
    /// offset: 0x40
    VCCR: mmio.Mmio(packed struct(u32) {
        /// Number of chunks This register configures the number of chunks to be transmitted during a line period (a chunk consists of a video packet and a null packet). If set to 0 or 1, the video line is transmitted in a single packet. If set to 1, the packet is part of a chunk, so a null packet follows it if NPSIZE > 0. Otherwise, multiple chunks are used to transmit each video line.
        NUMC: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video null packet configuration register.
    /// offset: 0x44
    VNPCR: mmio.Mmio(packed struct(u32) {
        /// Null packet size This field configures the number of bytes inside a null packet. Setting to 0 disables the null packets.
        NPSIZE: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video HSA configuration register.
    /// offset: 0x48
    VHSACR: mmio.Mmio(packed struct(u32) {
        /// Horizontal synchronism active duration This fields configures the horizontal synchronism active period in lane byte clock cycles.
        HSA: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video HBP configuration register.
    /// offset: 0x4c
    VHBPCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal back-porch duration This fields configures the horizontal back-porch period in lane byte clock cycles.
        HBP: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video line configuration register.
    /// offset: 0x50
    VLCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal line duration This fields configures the total of the horizontal line period (HSA+HBP+HACT+HFP) counted in lane byte clock cycles.
        HLINE: u15,
        padding: u17 = 0,
    }),
    /// DSI Host video VSA configuration register.
    /// offset: 0x54
    VVSACR: mmio.Mmio(packed struct(u32) {
        /// Vertical synchronism active duration This fields configures the vertical synchronism active period measured in number of horizontal lines.
        VSA: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VBP configuration register.
    /// offset: 0x58
    VVBPCR: mmio.Mmio(packed struct(u32) {
        /// Vertical back-porch duration This fields configures the vertical back-porch period measured in number of horizontal lines.
        VBP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VFP configuration register.
    /// offset: 0x5c
    VVFPCR: mmio.Mmio(packed struct(u32) {
        /// Vertical front-porch duration This fields configures the vertical front-porch period measured in number of horizontal lines.
        VFP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VA configuration register.
    /// offset: 0x60
    VVACR: mmio.Mmio(packed struct(u32) {
        /// Vertical active duration This fields configures the vertical active period measured in number of horizontal lines.
        VA: u14,
        padding: u18 = 0,
    }),
    /// DSI Host LTDC command configuration register.
    /// offset: 0x64
    LCCR: mmio.Mmio(packed struct(u32) {
        /// Command size This field configures the maximum allowed size for an LTDC write memory command, measured in pixels. Automatic partitioning of data obtained from LTDC is permanently enabled.
        CMDSIZE: u16,
        padding: u16 = 0,
    }),
    /// DSI Host command mode configuration register.
    /// offset: 0x68
    CMCR: mmio.Mmio(packed struct(u32) {
        /// Tearing effect acknowledge request enable This bit enables the tearing effect acknowledge request:.
        TEARE: u1,
        /// Acknowledge request enable This bit enables the acknowledge request after each packet transmission:.
        ARE: u1,
        reserved8: u6 = 0,
        /// Generic short write zero parameters transmission This bit configures the generic short write packet with zero parameters command transmission type:.
        GSW0TX: u1,
        /// Generic short write one parameters transmission This bit configures the generic short write packet with one parameters command transmission type:.
        GSW1TX: u1,
        /// Generic short write two parameters transmission This bit configures the generic short write packet with two parameters command transmission type:.
        GSW2TX: u1,
        /// Generic short read zero parameters transmission This bit configures the generic short read packet with zero parameters command transmission type:.
        GSR0TX: u1,
        /// Generic short read one parameters transmission This bit configures the generic short read packet with one parameters command transmission type:.
        GSR1TX: u1,
        /// Generic short read two parameters transmission This bit configures the generic short read packet with two parameters command transmission type:.
        GSR2TX: u1,
        /// Generic long write transmission This bit configures the generic long write packet command transmission type :.
        GLWTX: u1,
        reserved16: u1 = 0,
        /// DCS short write zero parameter transmission This bit configures the DCS short write packet with zero parameter command transmission type:.
        DSW0TX: u1,
        /// DCS short read one parameter transmission This bit configures the DCS short read packet with one parameter command transmission type:.
        DSW1TX: u1,
        /// DCS short read zero parameter transmission This bit configures the DCS short read packet with zero parameter command transmission type:.
        DSR0TX: u1,
        /// DCS long write transmission This bit configures the DCS long write packet command transmission type:.
        DLWTX: u1,
        reserved24: u4 = 0,
        /// Maximum read packet size This bit configures the maximum read packet size command transmission type:.
        MRDPS: u1,
        padding: u7 = 0,
    }),
    /// DSI Host generic header configuration register.
    /// offset: 0x6c
    GHCR: mmio.Mmio(packed struct(u32) {
        /// Type This field configures the packet data type of the header packet.
        DT: u6,
        /// Channel This field configures the virtual channel ID of the header packet.
        VCID: u2,
        /// WordCount LSB This field configures the less significant byte of the header packet word count for long packets, or data 0 for short packets.
        WCLSB: u8,
        /// WordCount MSB This field configures the most significant byte of the header packet's word count for long packets, or data 1 for short packets.
        WCMSB: u8,
        padding: u8 = 0,
    }),
    /// DSI Host generic payload data register.
    /// offset: 0x70
    GPDR: mmio.Mmio(packed struct(u32) {
        /// Payload byte 1 This field indicates the byte 1 of the packet payload.
        DATA1: u8,
        /// Payload byte 2 This field indicates the byte 2 of the packet payload.
        DATA2: u8,
        /// Payload byte 3 This field indicates the byte 3 of the packet payload.
        DATA3: u8,
        /// Payload byte 4 This field indicates the byte 4 of the packet payload.
        DATA4: u8,
    }),
    /// DSI Host generic packet status register.
    /// offset: 0x74
    GPSR: mmio.Mmio(packed struct(u32) {
        /// Command FIFO empty This bit indicates the empty status of the generic command FIFO:.
        CMDFE: u1,
        /// Command FIFO full This bit indicates the full status of the generic command FIFO:.
        CMDFF: u1,
        /// Payload write FIFO empty This bit indicates the empty status of the generic write payload FIFO:.
        PWRFE: u1,
        /// Payload write FIFO full This bit indicates the full status of the generic write payload FIFO:.
        PWRFF: u1,
        /// Payload read FIFO empty This bit indicates the empty status of the generic read payload FIFO:.
        PRDFE: u1,
        /// Payload read FIFO full This bit indicates the full status of the generic read payload FIFO:.
        PRDFF: u1,
        /// Read command busy This bit is set when a read command is issued and cleared when the entire response is stored in the FIFO:.
        RCB: u1,
        reserved16: u9 = 0,
        /// Command buffer empty This bit indicates the empty status of the generic payload internal buffer:.
        CMDBE: u1,
        /// Command buffer full This bit indicates the full status of the generic command internal buffer:.
        CMDBF: u1,
        /// Payload buffer empty This bit indicates the empty status of the generic payload internal buffer:.
        PBE: u1,
        /// Payload buffer full This bit indicates the full status of the generic payload internal buffer:.
        PBF: u1,
        padding: u12 = 0,
    }),
    /// DSI Host timeout counter configuration register 0.
    /// offset: 0x78
    TCCR0: mmio.Mmio(packed struct(u32) {
        /// Low-power reception timeout counter This field configures the timeout counter that triggers a low-power reception timeout contention detection (measured in TOCKDIV cycles).
        LPRX_TOCNT: u16,
        /// High-speed transmission timeout counter This field configures the timeout counter that triggers a high-speed transmission timeout contention detection (measured in TOCKDIV cycles). If using the non-burst mode and there is no enough time to switch from high-speed to low-power and back in the period from one line data finishing to the next line sync start, the DSI link returns the low-power state once per frame, then configure the TOCKDIV and HSTX_TOCNT to be in accordance with: HSTX_TOCNT * lanebyteclkperiod * TOCKDIV â¥ the time of one FRAME data transmission *Â (1 + 10%) In burst mode, RGB pixel packets are time-compressed, leaving more time during a scan line. Therefore, if in burst mode and there is enough time to switch from high-speed to low-power and back in the period from one line data finishing to the next line sync start, the DSI link can return low-power mode and back in this time interval to save power. For this, configure the TOCKDIV and HSTX_TOCNT to be in accordance with: HSTX_TOCNT * lanebyteclkperiod * TOCKDIV â¥ the time of one LINE data transmission *Â (1Â +Â 10%).
        HSTX_TOCNT: u16,
    }),
    /// DSI Host timeout counter configuration register 1.
    /// offset: 0x7c
    TCCR1: mmio.Mmio(packed struct(u32) {
        /// High-speed read timeout counter This field sets a period for which the DSI Host keeps the link still, after sending a high-speed read operation. This period is measured in cycles of lanebyteclk. The counting starts when the D-PHY enters the Stop state and causes no interrupts.
        HSRD_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host timeout counter configuration register 2.
    /// offset: 0x80
    TCCR2: mmio.Mmio(packed struct(u32) {
        /// Low-power read timeout counter This field sets a period for which the DSI Host keeps the link still, after sending a low-power read operation. This period is measured in cycles of lanebyteclk. The counting starts when the D-PHY enters the Stop state and causes no interrupts.
        LPRD_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host timeout counter configuration register 3.
    /// offset: 0x84
    TCCR3: mmio.Mmio(packed struct(u32) {
        /// High-speed write timeout counter This field sets a period for which the DSI Host keeps the link inactive after sending a high-speed write operation. This period is measured in cycles of lanebyteclk. The counting starts when the D-PHY enters the Stop state and causes no interrupts.
        HSWR_TOCNT: u16,
        reserved24: u8 = 0,
        /// Presp mode When set to 1, this bit ensures that the peripheral response timeout caused by HSWR_TOCNT is used only once per LTDC frame in command mode, when both the following conditions are met: dpivsync_edpiwms has risen and fallen. Packets originated from LTDC in command mode have been transmitted and its FIFO is empty again. In this scenario no non-LTDC command requests are sent to the D-PHY, even if there is traffic from generic interface ready to be sent, making it return to stop state. When it does so, PRESP_TO counter is activated and only when it finishes does the controller send any other traffic that is ready.
        PM: u1,
        padding: u7 = 0,
    }),
    /// DSI Host timeout counter configuration register 4.
    /// offset: 0x88
    TCCR4: mmio.Mmio(packed struct(u32) {
        /// Low-power write timeout counter This field sets a period for which the DSI Host keeps the link still, after sending a low-power write operation. This period is measured in cycles of lanebyteclk. The counting starts when the D-PHY enters the Stop state and causes no interrupts.
        LPWR_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host timeout counter configuration register 5.
    /// offset: 0x8c
    TCCR5: mmio.Mmio(packed struct(u32) {
        /// Bus-turn-around timeout counter This field sets a period for which the DSI Host keeps the link still, after completing a bus-turn-around. This period is measured in cycles of lanebyteclk. The counting starts when the DâPHY enters the Stop state and causes no interrupts.
        BTA_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x90
    reserved144: [4]u8,
    /// DSI Host clock lane configuration register.
    /// offset: 0x94
    CLCR: mmio.Mmio(packed struct(u32) {
        /// D-PHY clock control This bit controls the D-PHY clock state:.
        DPCC: u1,
        /// Automatic clock lane control This bit enables the automatic mechanism to stop providing clock in the clock lane when time allows.
        ACR: u1,
        padding: u30 = 0,
    }),
    /// DSI Host clock lane timer configuration register.
    /// offset: 0x98
    CLTCR: mmio.Mmio(packed struct(u32) {
        /// Low-power to high-speed time This field configures the maximum time that the D-PHY clock lane takes to go from lowâpower to high-speed transmission measured in lane byte clock cycles.
        LP2HS_TIME: u10,
        reserved16: u6 = 0,
        /// High-speed to low-power time This field configures the maximum time that the D-PHY clock lane takes to go from highâspeed to low-power transmission measured in lane byte clock cycles.
        HS2LP_TIME: u10,
        padding: u6 = 0,
    }),
    /// DSI Host data lane timer configuration register.
    /// offset: 0x9c
    DLTCR: mmio.Mmio(packed struct(u32) {
        /// Low-power to high-speed time This field configures the maximum time that the D-PHY data lanes take to go from low-power to high-speed transmission measured in lane byte clock cycles.
        LP2HS_TIME: u10,
        reserved16: u6 = 0,
        /// High-speed to low-power time This field configures the maximum time that the D-PHY data lanes take to go from high-speed to low-power transmission measured in lane byte clock cycles.
        HS2LP_TIME: u10,
        padding: u6 = 0,
    }),
    /// DSI Host PHY control register.
    /// offset: 0xa0
    PCTLR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Digital enable When set to 0, this bit places the digital section of the D-PHY in the reset state.
        DEN: u1,
        /// Clock enable This bit enables the D-PHY clock lane module:.
        CKE: u1,
        padding: u29 = 0,
    }),
    /// DSI Host PHY configuration register.
    /// offset: 0xa4
    PCONFR: mmio.Mmio(packed struct(u32) {
        /// Number of lanes This field configures the number of active data lanes: Others: Reserved.
        NL: u2,
        reserved8: u6 = 0,
        /// Stop wait time This field configures the minimum wait period to request a high-speed transmission after the Stop state.
        SW_TIME: u8,
        padding: u16 = 0,
    }),
    /// DSI Host PHY ULPS control register.
    /// offset: 0xa8
    PUCR: mmio.Mmio(packed struct(u32) {
        /// ULPS request on clock lane ULPS mode request on clock lane.
        URCL: u1,
        /// ULPS exit on clock lane ULPS mode exit on clock lane.
        UECL: u1,
        /// ULPS request on data lane ULPS mode request on all active data lanes.
        URDL: u1,
        /// ULPS exit on data lane ULPS mode exit on all active data lanes.
        UEDL: u1,
        padding: u28 = 0,
    }),
    /// DSI Host PHY TX triggers configuration register.
    /// offset: 0xac
    PTTCR: mmio.Mmio(packed struct(u32) {
        /// Transmission trigger Escape mode transmit trigger 0-3. Only one bit of TX_TRIG is asserted at any given time.
        TX_TRIG: u4,
        padding: u28 = 0,
    }),
    /// DSI Host PHY status register.
    /// offset: 0xb0
    PSR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// PHY direction This bit indicates the status of phydirection D-PHY signal.
        PD: u1,
        /// PHY stop state clock lane This bit indicates the status of phystopstateclklane D-PHY signal.
        PSSC: u1,
        /// ULPS active not clock lane This bit indicates the status of ulpsactivenotclklane D-PHY signal.
        UANC: u1,
        /// PHY stop state lane 0 This bit indicates the status of phystopstate0lane D-PHY signal.
        PSS0: u1,
        /// ULPS active not lane 1 This bit indicates the status of ulpsactivenot0lane D-PHY signal.
        UAN0: u1,
        /// RX ULPS escape lane 0 This bit indicates the status of rxulpsesc0lane D-PHY signal.
        RUE0: u1,
        /// PHY stop state lane 1 This bit indicates the status of phystopstate1lane D-PHY signal.
        PSS1: u1,
        /// ULPS active not lane 1 This bit indicates the status of ulpsactivenot1lane D-PHY signal.
        UAN1: u1,
        padding: u23 = 0,
    }),
    /// offset: 0xb4
    reserved180: [8]u8,
    /// DSI Host interrupt and status register 0.
    /// offset: 0xbc
    ISR0: mmio.Mmio(packed struct(u32) {
        /// Acknowledge error 0 This bit retrieves the SoT error from the acknowledge error report.
        AE0: u1,
        /// Acknowledge error 1 This bit retrieves the SoT sync error from the acknowledge error report.
        AE1: u1,
        /// Acknowledge error 2 This bit retrieves the EoT sync error from the acknowledge error report.
        AE2: u1,
        /// Acknowledge error 3 This bit retrieves the escape mode entry command error from the acknowledge error report.
        AE3: u1,
        /// Acknowledge error 4 This bit retrieves the LP transmit sync error from the acknowledge error report.
        AE4: u1,
        /// Acknowledge error 5 This bit retrieves the peripheral timeout error from the acknowledge error report.
        AE5: u1,
        /// Acknowledge error 6 This bit retrieves the false control error from the acknowledge error report.
        AE6: u1,
        /// Acknowledge error 7 This bit retrieves the reserved (specific to the device) from the acknowledge error report.
        AE7: u1,
        /// Acknowledge error 8 This bit retrieves the ECC error, single-bit (detected and corrected) from the acknowledge error report.
        AE8: u1,
        /// Acknowledge error 9 This bit retrieves the ECC error, multi-bit (detected, not corrected) from the acknowledge error report.
        AE9: u1,
        /// Acknowledge error 10 This bit retrieves the checksum error (long packet only) from the acknowledge error report.
        AE10: u1,
        /// Acknowledge error 11 This bit retrieves the not recognized DSI data type from the acknowledge error report.
        AE11: u1,
        /// Acknowledge error 12 This bit retrieves the DSI VC ID Invalid from the acknowledge error report.
        AE12: u1,
        /// Acknowledge error 13 This bit retrieves the invalid transmission length from the acknowledge error report.
        AE13: u1,
        /// Acknowledge error 14 This bit retrieves the reserved (specific to the device) from the acknowledge error report.
        AE14: u1,
        /// Acknowledge error 15 This bit retrieves the DSI protocol violation from the acknowledge error report.
        AE15: u1,
        /// PHY error 0 This bit indicates the ErrEsc escape entry error from lane 0.
        PE0: u1,
        /// PHY error 1 This bit indicates the ErrSyncEsc low-power transmission synchronization error from lane 0.
        PE1: u1,
        /// PHY error 2 This bit indicates the ErrControl error from lane 0.
        PE2: u1,
        /// PHY error 3 This bit indicates the LP0 contention error ErrContentionLP0 from lane 0.
        PE3: u1,
        /// PHY error 4 This bit indicates the LP1 contention error ErrContentionLP1 from lane 0.
        PE4: u1,
        padding: u11 = 0,
    }),
    /// DSI Host interrupt and status register 1.
    /// offset: 0xc0
    ISR1: mmio.Mmio(packed struct(u32) {
        /// Timeout high-speed transmission This bit indicates that the high-speed transmission timeout counter reached the end and contention is detected.
        TOHSTX: u1,
        /// Timeout low-power reception This bit indicates that the low-power reception timeout counter reached the end and contention is detected.
        TOLPRX: u1,
        /// ECC single-bit error This bit indicates that the ECC single error is detected and corrected in a received packet.
        ECCSE: u1,
        /// ECC multi-bit error This bit indicates that the ECC multiple error is detected in a received packet.
        ECCME: u1,
        /// CRC error This bit indicates that the CRC error is detected in the received packet payload.
        CRCE: u1,
        /// Packet size error This bit indicates that the packet size error is detected during the packet reception.
        PSE: u1,
        /// EoTp error This bit indicates that the EoTp packet is not received at the end of the incoming peripheral transmission.
        EOTPE: u1,
        /// LTDC payload write error This bit indicates that during a DPI pixel line storage, the payload FIFO becomes full and the data stored is corrupted.
        LPWRE: u1,
        /// Generic command write error This bit indicates that the system tried to write a command through the generic interface and the FIFO is full. Therefore, the command is not written.
        GCWRE: u1,
        /// Generic payload write error This bit indicates that the system tried to write a payload data through the generic interface and the FIFO is full. Therefore, the payload is not written.
        GPWRE: u1,
        /// Generic payload transmit error This bit indicates that during a generic interface packet build, the payload FIFO becomes empty and corrupt data is sent.
        GPTXE: u1,
        /// Generic payload read error This bit indicates that during a DCS read data, the payload FIFO becomes empty and the data sent to the interface is corrupted.
        GPRDE: u1,
        /// Generic payload receive error This bit indicates that during a generic interface packet read back, the payload FIFO becomes full and the received data is corrupted.
        GPRXE: u1,
        reserved19: u6 = 0,
        /// Payload buffer underflow error This bit indicates that underflow has occurred when reading payload to build DSI packet for video mode.
        PBUE: u1,
        padding: u12 = 0,
    }),
    /// DSI Host interrupt enable register 0.
    /// offset: 0xc4
    IER0: mmio.Mmio(packed struct(u32) {
        /// Acknowledge error 0 interrupt enable This bit enables the interrupt generation on acknowledge error 0.
        AE0IE: u1,
        /// Acknowledge error 1 interrupt enable This bit enables the interrupt generation on acknowledge error 1.
        AE1IE: u1,
        /// Acknowledge error 2 interrupt enable This bit enables the interrupt generation on acknowledge error 2.
        AE2IE: u1,
        /// Acknowledge error 3 interrupt enable This bit enables the interrupt generation on acknowledge error 3.
        AE3IE: u1,
        /// Acknowledge error 4 interrupt enable This bit enables the interrupt generation on acknowledge error 4.
        AE4IE: u1,
        /// Acknowledge error 5 interrupt enable This bit enables the interrupt generation on acknowledge error 5.
        AE5IE: u1,
        /// Acknowledge error 6 interrupt enable This bit enables the interrupt generation on acknowledge error 6.
        AE6IE: u1,
        /// Acknowledge error 7 interrupt enable This bit enables the interrupt generation on acknowledge error 7.
        AE7IE: u1,
        /// Acknowledge error 8 interrupt enable This bit enables the interrupt generation on acknowledge error 8.
        AE8IE: u1,
        /// Acknowledge error 9 interrupt enable This bit enables the interrupt generation on acknowledge error 9.
        AE9IE: u1,
        /// Acknowledge error 10 interrupt enable This bit enables the interrupt generation on acknowledge error 10.
        AE10IE: u1,
        /// Acknowledge error 11 interrupt enable This bit enables the interrupt generation on acknowledge error 11.
        AE11IE: u1,
        /// Acknowledge error 12 interrupt enable This bit enables the interrupt generation on acknowledge error 12.
        AE12IE: u1,
        /// Acknowledge error 13 interrupt enable This bit enables the interrupt generation on acknowledge error 13.
        AE13IE: u1,
        /// Acknowledge error 14 interrupt enable This bit enables the interrupt generation on acknowledge error 14.
        AE14IE: u1,
        /// Acknowledge error 15 interrupt enable This bit enables the interrupt generation on acknowledge error 15.
        AE15IE: u1,
        /// PHY error 0 interrupt enable This bit enables the interrupt generation on PHY error 0.
        PE0IE: u1,
        /// PHY error 1 interrupt enable This bit enables the interrupt generation on PHY error 1.
        PE1IE: u1,
        /// PHY error 2 interrupt enable This bit enables the interrupt generation on PHY error 2.
        PE2IE: u1,
        /// PHY error 3 interrupt enable This bit enables the interrupt generation on PHY error 4.
        PE3IE: u1,
        /// PHY error 4 interrupt enable This bit enables the interrupt generation on PHY error 4.
        PE4IE: u1,
        padding: u11 = 0,
    }),
    /// DSI Host interrupt enable register 1.
    /// offset: 0xc8
    IER1: mmio.Mmio(packed struct(u32) {
        /// Timeout high-speed transmission interrupt enable This bit enables the interrupt generation on timeout high-speed transmission.
        TOHSTXIE: u1,
        /// Timeout low-power reception interrupt enable This bit enables the interrupt generation on timeout low-power reception.
        TOLPRXIE: u1,
        /// ECC single-bit error interrupt enable This bit enables the interrupt generation on ECC single-bit error.
        ECCSEIE: u1,
        /// ECC multi-bit error interrupt enable This bit enables the interrupt generation on ECC multi-bit error.
        ECCMEIE: u1,
        /// CRC error interrupt enable This bit enables the interrupt generation on CRC error.
        CRCEIE: u1,
        /// Packet size error interrupt enable This bit enables the interrupt generation on packet size error.
        PSEIE: u1,
        /// EoTp error interrupt enable This bit enables the interrupt generation on EoTp error.
        EOTPEIE: u1,
        /// LTDC payload write error interrupt enable This bit enables the interrupt generation on LTDC payload write error.
        LPWREIE: u1,
        /// Generic command write error interrupt enable This bit enables the interrupt generation on generic command write error.
        GCWREIE: u1,
        /// Generic payload write error interrupt enable This bit enables the interrupt generation on generic payload write error.
        GPWREIE: u1,
        /// Generic payload transmit error interrupt enable This bit enables the interrupt generation on generic payload transmit error.
        GPTXEIE: u1,
        /// Generic payload read error interrupt enable This bit enables the interrupt generation on generic payload read error.
        GPRDEIE: u1,
        /// Generic payload receive error interrupt enable This bit enables the interrupt generation on generic payload receive error.
        GPRXEIE: u1,
        reserved19: u6 = 0,
        /// Payload buffer underflow error interrupt enable This bit enables the interrupt generation on payload buffer underflow error.
        PBUEIE: u1,
        padding: u12 = 0,
    }),
    /// offset: 0xcc
    reserved204: [12]u8,
    /// DSI Host force interrupt register 0.
    /// offset: 0xd8
    FIR0: mmio.Mmio(packed struct(u32) {
        /// Force acknowledge error 0 Writing one to this bit forces an acknowledge error 0.
        FAE0: u1,
        /// Force acknowledge error 1 Writing one to this bit forces an acknowledge error 1.
        FAE1: u1,
        /// Force acknowledge error 2 Writing one to this bit forces an acknowledge error 2.
        FAE2: u1,
        /// Force acknowledge error 3 Writing one to this bit forces an acknowledge error 3.
        FAE3: u1,
        /// Force acknowledge error 4 Writing one to this bit forces an acknowledge error 4.
        FAE4: u1,
        /// Force acknowledge error 5 Writing one to this bit forces an acknowledge error 5.
        FAE5: u1,
        /// Force acknowledge error 6 Writing one to this bit forces an acknowledge error 6.
        FAE6: u1,
        /// Force acknowledge error 7 Writing one to this bit forces an acknowledge error 7.
        FAE7: u1,
        /// Force acknowledge error 8 Writing one to this bit forces an acknowledge error 8.
        FAE8: u1,
        /// Force acknowledge error 9 Writing one to this bit forces an acknowledge error 9.
        FAE9: u1,
        /// Force acknowledge error 10 Writing one to this bit forces an acknowledge error 10.
        FAE10: u1,
        /// Force acknowledge error 11 Writing one to this bit forces an acknowledge error 11.
        FAE11: u1,
        /// Force acknowledge error 12 Writing one to this bit forces an acknowledge error 12.
        FAE12: u1,
        /// Force acknowledge error 13 Writing one to this bit forces an acknowledge error 13.
        FAE13: u1,
        /// Force acknowledge error 14 Writing one to this bit forces an acknowledge error 14.
        FAE14: u1,
        /// Force acknowledge error 15 Writing one to this bit forces an acknowledge error 15.
        FAE15: u1,
        /// Force PHY error 0 Writing one to this bit forces a PHY error 0.
        FPE0: u1,
        /// Force PHY error 1 Writing one to this bit forces a PHY error 1.
        FPE1: u1,
        /// Force PHY error 2 Writing one to this bit forces a PHY error 2.
        FPE2: u1,
        /// Force PHY error 3 Writing one to this bit forces a PHY error 3.
        FPE3: u1,
        /// Force PHY error 4 Writing one to this bit forces a PHY error 4.
        FPE4: u1,
        padding: u11 = 0,
    }),
    /// DSI Host force interrupt register 1.
    /// offset: 0xdc
    FIR1: mmio.Mmio(packed struct(u32) {
        /// Force timeout high-speed transmission Writing one to this bit forces a timeout high-speed transmission.
        FTOHSTX: u1,
        /// Force timeout low-power reception Writing one to this bit forces a timeout low-power reception.
        FTOLPRX: u1,
        /// Force ECC single-bit error Writing one to this bit forces a ECC single-bit error.
        FECCSE: u1,
        /// Force ECC multi-bit error Writing one to this bit forces a ECC multi-bit error.
        FECCME: u1,
        /// Force CRC error Writing one to this bit forces a CRC error.
        FCRCE: u1,
        /// Force packet size error Writing one to this bit forces a packet size error.
        FPSE: u1,
        /// Force EoTp error Writing one to this bit forces a EoTp error.
        FEOTPE: u1,
        /// Force LTDC payload write error Writing one to this bit forces a LTDC payload write error.
        FLPWRE: u1,
        /// Force generic command write error Writing one to this bit forces a generic command write error.
        FGCWRE: u1,
        /// Force generic payload write error Writing one to this bit forces a generic payload write error.
        FGPWRE: u1,
        /// Force generic payload transmit error Writing one to this bit forces a generic payload transmit error.
        FGPTXE: u1,
        /// Force generic payload read error Writing one to this bit forces a generic payload read error.
        FGPRDE: u1,
        /// Force generic payload receive error Writing one to this bit forces a generic payload receive error.
        FGPRXE: u1,
        reserved19: u6 = 0,
        /// Force payload buffer underflow error Writing one to this bit forces a payload undrflow error.
        FPBUE: u1,
        padding: u12 = 0,
    }),
    /// offset: 0xe0
    reserved224: [20]u8,
    /// DSI Host data lane timer read configuration register.
    /// offset: 0xf4
    DLTRCR: mmio.Mmio(packed struct(u32) {
        /// Maximum read time This field configures the maximum time required to perform a read command in lane byte clock cycles. This register can only be modified when no read command is in progress.
        MRD_TIME: u15,
        padding: u17 = 0,
    }),
    /// offset: 0xf8
    reserved248: [8]u8,
    /// DSI Host video shadow control register.
    /// offset: 0x100
    VSCR: mmio.Mmio(packed struct(u32) {
        /// Enable When set to 1, DSI Host LTDC interface receives the active configuration from the auxiliary registers. When this bit is set along with the UR bit, the auxiliary registers are automatically updated.
        EN: u1,
        reserved8: u7 = 0,
        /// Update register When set to 1, the LTDC registers are copied to the auxiliary registers. After copying, this bit is auto cleared.
        UR: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x104
    reserved260: [8]u8,
    /// DSI Host LTDC current VCID register.
    /// offset: 0x10c
    LCVCIDR: mmio.Mmio(packed struct(u32) {
        /// Virtual channel ID This field returns the virtual channel ID for the LTDC interface.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host LTDC current color coding register.
    /// offset: 0x110
    LCCCR: mmio.Mmio(packed struct(u32) {
        /// Color coding This field returns the current LTDC interface color coding. 0110-1111: reserved If LTDC interface in command mode is chosen and currently works in the command mode (CMDM=1), then 0110-1111: 24-bit.
        COLC: u4,
        reserved8: u4 = 0,
        /// Loosely packed enable This bit returns the current state of the loosely packed variant to 18-bit configurations.
        LPE: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x114
    reserved276: [4]u8,
    /// DSI Host low-power mode current configuration register.
    /// offset: 0x118
    LPMCCR: mmio.Mmio(packed struct(u32) {
        /// VACT largest packet size This field returns the current size, in bytes, of the largest packet that can fit in a line during VACT regions, for the transmission of commands in low-power mode.
        VLPSIZE: u8,
        reserved16: u8 = 0,
        /// Largest packet size This field is returns the current size, in bytes, of the largest packet that can fit in a line during VSA, VBP and VFP regions, for the transmission of commands in low-power mode.
        LPSIZE: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x11c
    reserved284: [28]u8,
    /// DSI Host video mode current configuration register.
    /// offset: 0x138
    VMCCR: mmio.Mmio(packed struct(u32) {
        /// Video mode type This field returns the current video mode transmission type: 1x: Burst mode.
        VMT: u2,
        /// Low-power vertical sync time enable This bit returns the current state of return to low-power inside the vertical sync time (VSA) period when timing allows.
        LPVSAE: u1,
        /// Low-power vertical back-porch enable This bit returns the current state of return to low-power inside the vertical back-porch (VBP) period when timing allows.
        LPVBPE: u1,
        /// Low-power vertical front-porch enable This bit returns the current state of return to low-power inside the vertical front-porch (VFP) period when timing allows.
        LPVFPE: u1,
        /// Low-power vertical active enable This bit returns the current state of return to low-power inside the vertical active (VACT) period when timing allows.
        LPVAE: u1,
        /// Low-power horizontal back-porch enable This bit returns the current state of return to low-power inside the horizontal back-porch (HBP) period when timing allows.
        LPHBPE: u1,
        /// Low-power horizontal front-porch enable This bit returns the current state of return to low-power inside the horizontal front-porch (HFP) period when timing allows.
        LPHFE: u1,
        /// Frame BTA acknowledge enable This bit returns the current state of request for an acknowledge response at the end of a frame.
        FBTAAE: u1,
        /// Low-power command enable This bit returns the current command transmission state in low-power mode.
        LPCE: u1,
        padding: u22 = 0,
    }),
    /// DSI Host video packet current configuration register.
    /// offset: 0x13c
    VPCCR: mmio.Mmio(packed struct(u32) {
        /// Video packet size This field returns the number of pixels in a single video packet.
        VPSIZE: u14,
        padding: u18 = 0,
    }),
    /// DSI Host video chunks current configuration register.
    /// offset: 0x140
    VCCCR: mmio.Mmio(packed struct(u32) {
        /// Number of chunks This field returns the number of chunks being transmitted during a line period.
        NUMC: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video null packet current configuration register.
    /// offset: 0x144
    VNPCCR: mmio.Mmio(packed struct(u32) {
        /// Null packet size This field returns the number of bytes inside a null packet.
        NPSIZE: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video HSA current configuration register.
    /// offset: 0x148
    VHSACCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal synchronism active duration This fields returns the horizontal synchronism active period in lane byte clock cycles.
        HSA: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video HBP current configuration register.
    /// offset: 0x14c
    VHBPCCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal back-porch duration This field returns the horizontal back-porch period in lane byte clock cycles.
        HBP: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video line current configuration register.
    /// offset: 0x150
    VLCCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal line duration This field returns the current total of the horizontal line period (HSA+HBP+HACT+HFP) counted in lane byte clock cycles.
        HLINE: u15,
        padding: u17 = 0,
    }),
    /// DSI Host video VSA current configuration register.
    /// offset: 0x154
    VVSACCR: mmio.Mmio(packed struct(u32) {
        /// Vertical synchronism active duration This field returns the current vertical synchronism active period measured in number of horizontal lines.
        VSA: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VBP current configuration register.
    /// offset: 0x158
    VVBPCCR: mmio.Mmio(packed struct(u32) {
        /// Vertical back-porch duration This field returns the current vertical back-porch period measured in number of horizontal lines.
        VBP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VFP current configuration register.
    /// offset: 0x15c
    VVFPCCR: mmio.Mmio(packed struct(u32) {
        /// Vertical front-porch duration This field returns the current vertical front-porch period measured in number of horizontal lines.
        VFP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VA current configuration register.
    /// offset: 0x160
    VVACCR: mmio.Mmio(packed struct(u32) {
        /// Vertical active duration This field returns the current vertical active period measured in number of horizontal lines.
        VA: u14,
        padding: u18 = 0,
    }),
    /// offset: 0x164
    reserved356: [4]u8,
    /// DSI Host FIFO and buffer status register.
    /// offset: 0x168
    FBSR: mmio.Mmio(packed struct(u32) {
        /// Video mode command write FIFO empty This bit indicates the empty status of the video mode write command FIFO:.
        VCWFE: u1,
        /// Video mode command write FIFO full This bit indicates the full status of the video mode write command FIFO:.
        VCWFF: u1,
        /// Video mode payload write FIFO empty This bit indicates the empty status of the video mode write payload FIFO:.
        VPWFE: u1,
        /// Video mode payload write FIFO full This bit indicates the full status of the video mode write payload FIFO:.
        VPWFF: u1,
        /// Adapted command mode command write FIFO empty This bit indicates the empty status of the adapted command mode write command FIFO:.
        ACWFE: u1,
        /// Adapted command mode command write FIFO full This bit indicates the full status of the adapted command mode write command FIFO:.
        ACWFF: u1,
        /// Adapted command mode payload write FIFO empty This bit indicates the empty status of the adapted command mode write payload FIFO:.
        APWFE: u1,
        /// Adapted command mode payload write FIFO full This bit indicates the full status of the adapted command mode write payload FIFO:.
        APWFF: u1,
        reserved16: u8 = 0,
        /// Video mode payload buffer empty This bit indicates the empty status of the video mode payload internal buffer:.
        VPBE: u1,
        /// Video mode payload buffer full This bit indicates the full status of the video mode payload internal buffer:.
        VPBF: u1,
        reserved20: u2 = 0,
        /// Adapted command mode command buffer empty This bit indicates the empty status of the adapted command mode command internal buffer:.
        ACBE: u1,
        /// Adapted command mode command buffer full This bit indicates the full status of the adapted command mode command internal buffer:.
        ACBF: u1,
        /// Adapted command mode payload buffer empty This bit indicates the empty status of the adapted command mode payload internal buffer:.
        APBE: u1,
        /// Adapted command mode payload buffer full This bit indicates the full status of the adapted command mode payload internal buffer:.
        APBF: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x16c
    reserved364: [660]u8,
    /// DSI Wrapper configuration register.
    /// offset: 0x400
    WCFGR: mmio.Mmio(packed struct(u32) {
        /// DSI mode This bit selects the mode for the video transmission. This bit must only be changed when DSI Host is stopped (CR.EN = 0).
        DSIM: u1,
        /// Color multiplexing This bit selects the color multiplexing used by DSI Host. This field must only be changed when DSI is stopped (WCR.DSIEN = 0 and CR.ENÂ =Â 0).
        COLMUX: u3,
        /// TE source This bit selects the tearing effect (TE) source. This bit must only be changed when DSI Host is stopped (CR.EN = 0).
        TESRC: u1,
        /// TE polarity This bit selects the polarity of the external pin tearing effect (TE) source. This bit must only be changed when DSI Host is stopped (CR.EN = 0).
        TEPOL: u1,
        /// Automatic refresh This bit selects the refresh mode in DBI mode. This bit must only be changed when DSI Host is stopped (CR.EN = 0).
        AR: u1,
        /// VSync polarity This bit selects the VSync edge on which the LTDC is halted. This bit must only be changed when DSI is stopped (WCR.DSIEN = 0 and CR.ENÂ =Â 0).
        VSPOL: u1,
        padding: u24 = 0,
    }),
    /// DSI Wrapper control register.
    /// offset: 0x404
    WCR: mmio.Mmio(packed struct(u32) {
        /// Color mode This bit controls the display color mode in video mode.
        COLM: u1,
        /// Shutdown This bit controls the display shutdown in video mode.
        SHTDN: u1,
        /// LTDC enable This bit enables the LTDC for a frame transfer in adapted command mode.
        LTDCEN: u1,
        /// DSI enable This bit enables the DSI Wrapper.
        DSIEN: u1,
        padding: u28 = 0,
    }),
    /// DSI Wrapper interrupt enable register.
    /// offset: 0x408
    WIER: mmio.Mmio(packed struct(u32) {
        /// Tearing effect interrupt enable This bit enables the tearing effect interrupt.
        TEIE: u1,
        /// End of refresh interrupt enable This bit enables the end of refresh interrupt.
        ERIE: u1,
        reserved9: u7 = 0,
        /// PLL lock interrupt enable This bit enables the PLL lock interrupt.
        PLLLIE: u1,
        /// PLL unlock interrupt enable This bit enables the PLL unlock interrupt.
        PLLUIE: u1,
        padding: u21 = 0,
    }),
    /// DSI Wrapper interrupt and status register.
    /// offset: 0x40c
    WISR: mmio.Mmio(packed struct(u32) {
        /// Tearing effect interrupt flag This bit is set when a tearing effect event occurs.
        TEIF: u1,
        /// End of refresh interrupt flag This bit is set when the transfer of a frame in adapted command mode is finished.
        ERIF: u1,
        /// Busy flag This bit is set when the transfer of a frame in adapted command mode is ongoing.
        BUSY: u1,
        reserved8: u5 = 0,
        /// PLL lock status This bit is set when the PLL is locked and cleared when it is unlocked.
        PLLLS: u1,
        /// PLL lock interrupt flag This bit is set when the PLL becomes locked.
        PLLLIF: u1,
        /// PLL unlock interrupt flag This bit is set when the PLL becomes unlocked.
        PLLUIF: u1,
        padding: u21 = 0,
    }),
    /// DSI Wrapper interrupt flag clear register.
    /// offset: 0x410
    WIFCR: mmio.Mmio(packed struct(u32) {
        /// Clear tearing effect interrupt flag Write 1 clears the TEIF flag in the WSR register.
        CTEIF: u1,
        /// Clear end of refresh interrupt flag Write 1 clears the ERIF flag in the WSR register.
        CERIF: u1,
        reserved9: u7 = 0,
        /// Clear PLL lock interrupt flag Write 1 clears the PLLLIF flag in the WSR register.
        CPLLLIF: u1,
        /// Clear PLL unlock interrupt flag Write 1 clears the PLLUIF flag in the WSR register.
        CPLLUIF: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x414
    reserved1044: [4]u8,
    /// DSI Wrapper PHY configuration register 0.
    /// offset: 0x418
    WPCR0: mmio.Mmio(packed struct(u32) {
        reserved6: u6 = 0,
        /// Swap clock lane pins This bit swaps the pins on clock lane.
        SWCL: u1,
        /// Swap data lane 0 pins This bit swaps the pins on data lane 0.
        SWDL0: u1,
        /// Swap data lane 1 pins This bit swaps the pins on clock lane.
        SWDL1: u1,
        reserved12: u3 = 0,
        /// Force in TX Stop mode the clock lane This bit forces the clock lane in TX stop mode. It is used to initialize a lane module in transmit mode. It causes the lane module to immediately jump to transmit control mode and to begin transmitting a stop state (LP-11). It can be used to go back in TX mode after a wrong BTA sequence.
        FTXSMCL: u1,
        /// Force in TX Stop mode the data lanes This bit forces the data lanes in TX stop mode. It is used to initialize a lane module in transmit mode. It causes the lane module to immediately jump to transmit control mode and to begin transmitting a stop state (LP-11). It can be used to go back in TX mode after a wrong BTA sequence.
        FTXSMDL: u1,
        padding: u18 = 0,
    }),
    /// offset: 0x41c
    reserved1052: [20]u8,
    /// DSI Wrapper regulator and PLL control register.
    /// offset: 0x430
    WRPCR: mmio.Mmio(packed struct(u32) {
        /// PLL enable This bit enables the D-PHY PLL.
        PLLEN: u1,
        reserved2: u1 = 0,
        /// PLL loop division factor This field configures the PLL loop division factor. 2: PLL loop divided by 2x2 ... 511: PLL loop divided by 511x2.
        NDIV: u9,
        /// PLL input division factor This field configures the PLL input division factor. 2: PLL input divided by 2 ... 511: PLL input divided by 511.
        IDF: u9,
        /// PLL output division factor This field configures the PLL output division factor. 2: PLL output divided by 2 ... 511: PLL output divided by 511.
        ODF: u9,
        padding: u3 = 0,
    }),
    /// offset: 0x434
    reserved1076: [980]u8,
    /// DSI bias configuration register.
    /// offset: 0x808
    BCFGR: mmio.Mmio(packed struct(u32) {
        reserved6: u6 = 0,
        /// Power-up This bit powers-up the reference bias for the MIPI D-PHY.
        PWRUP: u1,
        padding: u25 = 0,
    }),
    /// offset: 0x80c
    reserved2060: [1016]u8,
    /// DSI D-PHY clock band control register.
    /// offset: 0xc04
    DPCBCR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Band control This field selects the frequency band used by the D-PHY. Others: Reserved.
        BC: u5,
        padding: u24 = 0,
    }),
    /// offset: 0xc08
    reserved3080: [44]u8,
    /// DSI D-PHY clock skew rate control register.
    /// offset: 0xc34
    DPCSRCR: mmio.Mmio(packed struct(u32) {
        /// Slew rate control This field selects the slew rate for HS-TX speed. Others: Reserved.
        SRC: u8,
        padding: u24 = 0,
    }),
    /// offset: 0xc38
    reserved3128: [56]u8,
    /// DSI D-PHY data lane 0 band control register.
    /// offset: 0xc70
    DPDL0BCR: mmio.Mmio(packed struct(u32) {
        /// Band control This field selects the frequency band used by the D-PHY. Others: Reserved.
        BC: u5,
        padding: u27 = 0,
    }),
    /// offset: 0xc74
    reserved3188: [44]u8,
    /// DSI D-PHY data lane 0 skew rate control register.
    /// offset: 0xca0
    DPDL0SRCR: mmio.Mmio(packed struct(u32) {
        /// Slew rate control This field selects the slew rate for HS-TX speed. Others: Reserved.
        SRC: u8,
        padding: u24 = 0,
    }),
    /// offset: 0xca4
    reserved3236: [100]u8,
    /// DSI D-PHY data lane 1 band control register.
    /// offset: 0xd08
    DPDL1BCR: mmio.Mmio(packed struct(u32) {
        /// Band control This field selects the frequency band used by the D-PHY. Others: Reserved.
        BC: u5,
        padding: u27 = 0,
    }),
    /// offset: 0xd0c
    reserved3340: [44]u8,
    /// DSI D-PHY data lane 1 skew rate control register.
    /// offset: 0xd38
    DPDL1SRCR: mmio.Mmio(packed struct(u32) {
        /// Slew rate control This field selects the slew rate for HS-TX speed. Others: Reserved.
        SRC: u8,
        padding: u24 = 0,
    }),
};
