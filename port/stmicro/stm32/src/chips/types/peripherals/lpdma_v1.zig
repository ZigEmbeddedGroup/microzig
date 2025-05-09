const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const BREQ = enum(u1) {
    /// the selected hardware request is driven by a peripheral with a hardware request/acknowledge protocol at a burst level.
    Burst = 0x0,
    /// the selected hardware request is driven by a peripheral with a hardware request/acknowledge protocol at a block level (see ).
    Block = 0x1,
};

pub const DEC = enum(u1) {
    /// The address is incremented by the programmed offset.
    Add = 0x0,
    /// The address is decremented by the programmed offset.
    Subtract = 0x1,
};

pub const DREQ = enum(u1) {
    /// selected hardware request driven by a source peripheral (request signal taken into account by the LPDMA transfer scheduler over the source/read port)
    SourcePeripheral = 0x0,
    /// selected hardware request driven by a destination peripheral (request signal taken into account by the LPDMA transfer scheduler over the destination/write port)
    DestinationPeripheral = 0x1,
};

pub const DW = enum(u2) {
    /// byte
    Byte = 0x0,
    /// half-word (2 bytes)
    HalfWord = 0x1,
    /// word (4 bytes)
    Word = 0x2,
    _,
};

pub const LSM = enum(u1) {
    /// channel executed for the full linked-list and completed at the end of the last LLI (CH[x].LLR = 0). The 16 low-significant bits of the link address are null (LA[15:0] = 0) and all the update bits are null (UT1 =UB1 = UT2 = USA = UDA = ULL = 0 and UT3 = UB2 = 0 if present). Then CH[x].BR1.BNDT[15:0] = 0 and CH[x].BR1.BRC[10:0] = 0 if present.
    RunToCompletion = 0x0,
    /// channel executed once for the current LLI
    LinkStep = 0x1,
};

pub const PAM = enum(u2) {
    /// If destination is wider: source data is transferred as right aligned, padded with 0s up to the destination data width If source is wider: source data is transferred as right aligned, left-truncated down to the destination data width
    ZeroExtendOrLeftTruncate = 0x0,
    /// If destination is wider: source data is transferred as right aligned, sign extended up to the destination data width If source is wider: source data is transferred as left-aligned, right-truncated down to the destination data width
    SignExtendOrRightTruncate = 0x1,
    /// source data is FIFO queued and packed/unpacked at the destination data width, to be transferred in a left (LSB) to right (MSB) order (named little endian) to the destination
    Pack = 0x2,
    _,
};

pub const PRIO = enum(u2) {
    /// low priority, low weight
    LowWithLowhWeight = 0x0,
    /// low priority, mid weight
    LowWithMidWeight = 0x1,
    /// low priority, high weight
    LowWithHighWeight = 0x2,
    /// high priority
    High = 0x3,
};

pub const SWREQ = enum(u1) {
    /// no software request. The selected hardware request REQSEL[6:0] is taken into account.
    Hardware = 0x0,
    /// software request for a memory-to-memory transfer. The default selected hardware request as per REQSEL[6:0] is ignored.
    Software = 0x1,
};

pub const TCEM = enum(u2) {
    /// at block level (when CH[x].BR1.BNDT[15:0] = 0): the complete (and the half) transfer event is generated at the (respectively half of the) end of a block.
    EachBlock = 0x0,
    /// channel x = 0 to 11, same as 00; channel x=12 to 15, at 2D/repeated block level (when CH[x].BR1.BRC[10:0] = 0 and CH[x].BR1.BNDT[15:0] = 0), the complete (and the half) transfer event is generated at the end (respectively half of the end) of the 2D/repeated block.
    Each2DBlock = 0x1,
    /// at LLI level: the complete transfer event is generated at the end of the LLI transfer, including the update of the LLI if any. The half transfer event is generated at the half of the LLI data transfer (the LLI data transfer being a block transfer or a 2D/repeated block transfer for channel x = 12 to 15), if any data transfer.
    EachLinkedListItem = 0x2,
    /// at channel level: the complete transfer event is generated at the end of the last LLI transfer. The half transfer event is generated at the half of the data transfer of the last LLI. The last LLI updates the link address CH[x].LLR.LA[15:2] to zero and clears all the CH[x].LLR update bits (UT1, UT2, UB1, USA, UDA and ULL, plus UT3 and UB2 if present). If the channel transfer is continuous/infinite, no event is generated.
    LastLinkedListItem = 0x3,
};

pub const TRIGM = enum(u2) {
    /// at block level: the first burst read of each block transfer is conditioned by one hit trigger (channel x = 12 to 15, for each block if a 2D/repeated block is configured with CH[x].BR1.BRC[10:0] ≠ 0).
    Block = 0x0,
    /// channel x = 0 to 11, same as 00; channel x=12 to 15, at 2D/repeated block level, the
    @"2DBlock" = 0x1,
    /// at link level: a LLI link transfer is conditioned by one hit trigger. The LLI data transfer (if any) is not conditioned.
    LinkedListItem = 0x2,
    /// at programmed burst level: If SWREQ = 1, each programmed burst read is conditioned by one hit trigger. If SWREQ = 0, each programmed burst that is requested by the selected peripheral, is conditioned by one hit trigger.
    Burst = 0x3,
};

pub const TRIGPOL = enum(u2) {
    /// no trigger (masked trigger event)
    None = 0x0,
    /// trigger on the rising edge
    RisingEdge = 0x1,
    /// trigger on the falling edge
    FallingEdge = 0x2,
    /// same as 00
    NoneAlt = 0x3,
};

pub const Channel = extern struct {
    /// LPDMA channel 15 linked-list base address register
    /// offset: 0x00
    LBAR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// linked-list base address of LPDMA channel x
        LBA: u16,
    }),
    /// offset: 0x04
    reserved4: [8]u8,
    /// LPDMA channel 15 flag clear register
    /// offset: 0x0c
    FCR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// transfer complete flag clear
        TCF: u1,
        /// half transfer flag clear
        HTF: u1,
        /// data transfer error flag clear
        DTEF: u1,
        /// update link transfer error flag clear
        ULEF: u1,
        /// user setting error flag clear
        USEF: u1,
        /// completed suspension flag clear
        SUSPF: u1,
        /// trigger overrun flag clear
        TOF: u1,
        padding: u17 = 0,
    }),
    /// LPDMA channel 15 status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// idle flag. This idle flag is de-asserted by hardware when the channel is enabled (CH[x].CR.EN = 1) with a valid channel configuration (no USEF to be immediately reported). This idle flag is asserted after hard reset or by hardware when the channel is back in idle state (in suspended or disabled state).
        IDLEF: u1,
        reserved8: u7 = 0,
        /// transfer complete flag. A transfer complete event is either a block transfer complete, a 2D/repeated block transfer complete, a LLI transfer complete including the upload of the next LLI if any, or the full linked-list completion, depending on the transfer complete event mode (CH[x].TR2.TCEM[1:0]).
        TCF: u1,
        /// half transfer flag. An half transfer event is either an half block transfer or an half 2D/repeated block transfer, depending on the transfer complete event mode (CH[x].TR2.TCEM[1:0]). An half block transfer occurs when half of the bytes of the source block size (rounded up integer of CH[x].BR1.BNDT[15:0]/2) has been transferred to the destination. An half 2D/repeated block transfer occurs when half of the repeated blocks (rounded up integer of (CH[x].BR1.BRC[10:0]+1)/2)) has been transferred to the destination.
        HTF: u1,
        /// data transfer error flag
        DTEF: u1,
        /// update link transfer error flag
        ULEF: u1,
        /// user setting error flag
        USEF: u1,
        /// completed suspension flag
        SUSPF: u1,
        /// trigger overrun flag
        TOF: u1,
        padding: u17 = 0,
    }),
    /// LPDMA channel 15 control register
    /// offset: 0x14
    CR: mmio.Mmio(packed struct(u32) {
        /// enable. Writing 1 into the field RESET (bit 1) causes the hardware to de-assert this bit, whatever is written into this bit 0. Else: this bit is de-asserted by hardware when there is a transfer error (master bus error or user setting error) or when there is a channel transfer complete (channel ready to be configured, e.g. if LSM=1 at the end of a single execution of the LLI). Else, this bit can be asserted by software. Writing 0 into this EN bit is ignored.
        EN: u1,
        /// reset. This bit is write only. Writing 0 has no impact. Writing 1 implies the reset of the following: the FIFO, the channel internal state, SUSP and EN bits (whatever is written receptively in bit 2 and bit 0). The reset is effective when the channel is in steady state, meaning one of the following: - active channel in suspended state (CH[x].SR.SUSPF = 1 and CH[x].SR.IDLEF = CH[x].CR.EN = 1). - channel in disabled state (CH[x].SR.IDLEF = 1 and CH[x].CR.EN = 0). After writing a RESET, to continue using this channel, the user must explicitly reconfigure the channel including the hardware-modified configuration registers (CH[x].BR1, CH[x].SAR and CH[x].DAR) before enabling again the channel (see the programming sequence in ).
        RESET: u1,
        /// suspend. Writing 1 into the field RESET (bit 1) causes the hardware to de-assert this bit, whatever is written into this bit 2. Else: Software must write 1 in order to suspend an active channel i.e. a channel with an on-going LPDMA transfer over its master ports. The software must write 0 in order to resume a suspended channel, following the programming sequence detailed in .
        SUSP: u1,
        reserved8: u5 = 0,
        /// transfer complete interrupt enable
        TCIE: u1,
        /// half transfer complete interrupt enable
        HTIE: u1,
        /// data transfer error interrupt enable
        DTEIE: u1,
        /// update link transfer error interrupt enable
        ULEIE: u1,
        /// user setting error interrupt enable
        USEIE: u1,
        /// completed suspension interrupt enable
        SUSPIE: u1,
        /// trigger overrun interrupt enable
        TOIE: u1,
        reserved16: u1 = 0,
        /// Link step mode. First the (possible 1D/repeated) block transfer is executed as defined by the current internal register file until CH[x].BR1.BNDT[15:0] = 0 and CH[x].BR1.BRC[10:0] = 0 if present. Secondly the next linked-list data structure is conditionally uploaded from memory as defined by CH[x].LLR. Then channel execution is completed. Note: This bit must be written when EN=0. This bit is read-only when EN=1.
        LSM: LSM,
        reserved22: u5 = 0,
        /// priority level of the channel x LPDMA transfer versus others. Note: This bit must be written when EN = 0. This bit is read-only when EN = 1.
        PRIO: PRIO,
        padding: u8 = 0,
    }),
    /// offset: 0x18
    reserved24: [40]u8,
    /// LPDMA channel 15 transfer register 1
    /// offset: 0x40
    TR1: mmio.Mmio(packed struct(u32) {
        /// binary logarithm of the source data width of a burst in bytes. Note: Setting a 8-byte data width causes a user setting error to be reported and no transfer is issued. A source block size must be a multiple of the source data width (CH[x].BR1.BNDT[2:0] versus SDW_LOG2[1:0]). Otherwise, a user setting error is reported and no transfer is issued. A source single transfer must have an aligned address with its data width (start address CH[x].SAR[2:0] versus SDW_LOG2[1:0]). Otherwise, a user setting error is reported and none transfer is issued.
        SDW: DW,
        reserved3: u1 = 0,
        /// source incrementing burst. The source address, pointed by CH[x].SAR, is kept constant after a burst beat/single transfer or is incremented by the offset value corresponding to a contiguous data after a burst beat/single transfer.
        SINC: u1,
        reserved11: u7 = 0,
        /// padding/alignment mode. If DDW[1:0] = SDW_LOG2[1:0]: if the data width of a burst destination transfer is equal to the data width of a burst source transfer, these bits are ignored. Else: - Case 1: If destination data width > source data width. 1x: successive source data are FIFO queued and packed at the destination data width, in a left (LSB) to right (MSB) order (named little endian), before a destination transfer. - Case 2: If destination data width < source data width. 1x: source data is FIFO queued and unpacked at the destination data width, to be transferred in a left (LSB) to right (MSB) order (named little endian) to the destination. Note:
        PAM: PAM,
        reserved15: u2 = 0,
        /// security attribute of the LPDMA transfer from the source. If SECCFGR.SECx = 1 and the access is secure: This is a secure register bit. This bit can only be read by a secure software. This bit must be written by a secure software when SECCFGR.SECx =1 . A secure write is ignored when SECCFGR.SECx = 0. When SECCFGR.SECx is de-asserted, this SSEC bit is also de-asserted by hardware (on a secure reconfiguration of the channel as non-secure), and the LPDMA transfer from the source is non-secure.
        SSEC: u1,
        /// binary logarithm of the destination data width of a burst, in bytes. Note: Setting a 8-byte data width causes a user setting error to be reported and none transfer is issued. A destination burst transfer must have an aligned address with its data width (start address CH[x].DAR[2:0] and address offset CH[x].TR3.DAO[2:0], versus DDW[1:0]). Otherwise a user setting error is reported and no transfer is issued.
        DDW: DW,
        reserved19: u1 = 0,
        /// destination incrementing burst. The destination address, pointed by CH[x].DAR, is kept constant after a burst beat/single transfer, or is incremented by the offset value corresponding to a contiguous data after a burst beat/single transfer.
        DINC: u1,
        reserved31: u11 = 0,
        /// security attribute of the LPDMA transfer to the destination. If SECCFGR.SECx = 1 and the access is secure: This is a secure register bit. This bit can only be read by a secure software. This bit must be written by a secure software when SECCFGR.SECx = 1. A secure write is ignored when SECCFGR.SECx = 0. When SECCFGR.SECx is de-asserted, this DSEC bit is also de-asserted by hardware (on a secure reconfiguration of the channel as non-secure), and the LPDMA transfer to the destination is non-secure.
        DSEC: u1,
    }),
    /// LPDMA channel 15 transfer register 2
    /// offset: 0x44
    TR2: mmio.Mmio(packed struct(u32) {
        /// LPDMA hardware request selection. These bits are ignored if channel x is activated (CH[x].CR.EN asserted) with SWREQ = 1 (software request for a memory-to-memory transfer). Else, the selected hardware request is internally taken into account as per . The user must not assign a same input hardware request (same REQSEL[6:0] value) to different active LPDMA channels (CH[x].CR.EN = 1 and CH[x].TR2.SWREQ = 0 for these channels). LPDMA is not intended to hardware support the case of simultaneous enabled channels incorrectly configured with a same hardware peripheral request signal, and there is no user setting error reporting.
        REQSEL: u7,
        reserved9: u2 = 0,
        /// software request. This bit is internally taken into account when CH[x].CR.EN is asserted.
        SWREQ: SWREQ,
        /// destination hardware request. This bit is ignored if channel x is activated (CH[x].CR.EN asserted) with SWREQ = 1 (software request for a memory-to-memory transfer). Else: Note:
        DREQ: DREQ,
        /// Block hardware request. If the channel x is activated (CH[x].CR.EN asserted) with SWREQ = 1 (software request for a memory-to-memory transfer), this bit is ignored. Else:
        BREQ: BREQ,
        reserved14: u2 = 0,
        /// trigger mode. These bits define the transfer granularity for its conditioning by the trigger. If the channel x is enabled (CH[x].CR.EN asserted) with TRIGPOL[1:0] = 00 or 11, these TRIGM[1:0] bits are ignored. Else, a LPDMA transfer is conditioned by at least one trigger hit: first burst read of a 2D/repeated block transfer is conditioned by one hit trigger. – If the peripheral is programmed as a source (DREQ = 0) of the LLI data transfer, each programmed burst read is conditioned. – If the peripheral is programmed as a destination (DREQ = 1) of the LLI data transfer, each programmed burst write is conditioned. The first memory burst read of a (possibly 2D/repeated) block, also named as the first ready FIFO-based source burst, is gated by the occurrence of both the hardware request and the first trigger hit. The LPDMA monitoring of a trigger for channel x is started when the channel is enabled/loaded with a new active trigger configuration: rising or falling edge on a selected trigger (TRIGPOL[1:0] = 01 or respectively TRIGPOL[1:0] = 10). The monitoring of this trigger is kept active during the triggered and uncompleted (data or link) transfer; and if a new trigger is detected then, this hit is internally memorized to grant the next transfer, as long as the defined rising or falling edge is not modified, and the TRIGSEL[5:0] is not modified, and the channel is enabled. Transferring a next LLIn+1 that updates the CH[x].TR2 with a new value for any of TRIGSEL[5:0] or TRIGPOL[1:0], resets the monitoring, trashing the memorized hit of the formerly defined LLIn trigger. After a first new trigger hitn+1 is memorized, if another second trigger hitn+2 is detected and if the hitn triggered transfer is still not completed, hitn+2 is lost and not memorized.memorized. A trigger overrun flag is reported (CH[x].SR.TOF =1 ), and an interrupt is generated if enabled (CH[x].CR.TOIE = 1). The channel is not automatically disabled by hardware due to a trigger overrun. Note: When the source block size is not a multiple of the source burst size and is a multiple of the source data width, then the last programmed source burst is not completed and is internally shorten to match the block size. In this case, if TRIGM[1:0] = 11 and (SWREQ =1 or (SWREQ = 0 and DREQ =0 )), the shortened burst transfer (by singles or/and by bursts of lower length) is conditioned once by the trigger. When the programmed destination burst is internally shortened by singles or/and by bursts of lower length (versus FIFO size, versus block size, 1-Kbyte boundary address crossing): if the trigger is conditioning the programmed destination burst (if TRIGM[1:0] = 11 and SWREQ = 0 and DREQ = 1), this shortened destination burst transfer is conditioned once by the trigger.
        TRIGM: TRIGM,
        /// trigger event input selection. These bits select the trigger event input of the LPDMA transfer (as per ), with an active trigger event if TRIGPOL[1:0] ≠ 00.
        TRIGSEL: u6,
        reserved24: u2 = 0,
        /// trigger event polarity. These bits define the polarity of the selected trigger event input defined by TRIGSEL[5:0].
        TRIGPOL: TRIGPOL,
        reserved30: u4 = 0,
        /// transfer complete event mode. These bits define the transfer granularity for the transfer complete and half transfer complete events generation. Note: If the initial LLI0 data transfer is null/void (directly programmed by the internal register file with CH[x].BR1.BNDT[15:0] = 0), then neither the complete transfer event nor the half transfer event is generated. Note: If the initial LLI0 data transfer is null/void (directly programmed by the internal register file with CH[x].BR1.BNDT[15:0] = 0), then neither the complete transfer event nor the half transfer event is generated. Note: If the initial LLI0 data transfer is null/void (i.e. directly programmed by the internal register file with CH[x].BR1.BNDT[15:0] =0 ), then the half transfer event is not generated, and the transfer complete event is generated when is completed the loading of the LLI1.
        TCEM: TCEM,
    }),
    /// LPDMA channel 15 alternate block register 1
    /// offset: 0x48
    BR1: mmio.Mmio(packed struct(u32) {
        /// block number of data bytes to transfer from the source. Block size transferred from the source. When the channel is enabled, this field becomes read-only and is decremented, indicating the remaining number of data items in the current source block to be transferred. BNDT[15:0] is programmed in number of bytes, maximum source block size is 64 Kbytes -1. Once the last data transfer is completed (BNDT[15:0] = 0): - if CH[x].LLR.UB1 = 1, this field is updated by the LLI in the memory. - if CH[x].LLR.UB1 = 0 and if there is at least one not null Uxx update bit, this field is internally restored to the programmed value. - if all CH[x].LLR.Uxx = 0 and if CH[x].LLR.LA[15:0] ≠ 0, this field is internally restored to the programmed value (infinite/continuous last LLI). - if CH[x].LLR = 0, this field is kept as zero following the last LLI data transfer. Note: A non-null source block size must be a multiple of the source data width (BNDT[2:0] versus CH[x].TR1.SDW_LOG2[1:0]). Else a user setting error is reported and no transfer is issued. When configured in packing mode (CH[x].TR1.PAM[1]=1 and destination data width different from source data width), a non-null source block size must be a multiple of the destination data width (BNDT[2:0] versus CH[x].TR1.DDW[1:0]). Else a user setting error is reported and no transfer is issued.
        BNDT: u16,
        /// Block repeat counter. This field contains the number of repetitions of the current block (0 to 2047). When the channel is enabled, this field becomes read-only. After decrements, this field indicates the remaining number of blocks, excluding the current one. This counter is hardware decremented for each completed block transfer. Once the last block transfer is completed (BRC[10:0] = BNDT[15:0] = 0): If CH[x].LLR.UB1 = 1, all CH[x].BR1 fields are updated by the next LLI in the memory. If CH[x].LLR.UB1 = 0 and if there is at least one not null Uxx update bit, this field is internally restored to the programmed value. if all CH[x].LLR.Uxx = 0 and if CH[x].LLR.LA[15:0] ≠ 0, this field is internally restored to the programmed value (infinite/continuous last LLI). if CH[x].LLR = 0, this field is kept as zero following the last LLI and data transfer.
        BRC: u11,
        reserved28: u1 = 0,
        /// source address decrement
        SDEC: DEC,
        /// destination address decrement
        DDEC: DEC,
        /// Block repeat source address decrement. Note: On top of this increment/decrement (depending on BRSDEC), CH[x].SAR is in the same time also updated by the increment/decrement (depending on SDEC) of the CH[x].TR3.SAO value, as it is done after any programmed burst transfer.
        BRSDEC: DEC,
        /// Block repeat destination address decrement. Note: On top of this increment/decrement (depending on BRDDEC), CH[x].DAR is in the same time also updated by the increment/decrement (depending on DDEC) of the CH[x].TR3.DAO value, as it is usually done at the end of each programmed burst transfer.
        BRDDEC: DEC,
    }),
    /// LPDMA channel 15 source address register
    /// offset: 0x4c
    SAR: u32,
    /// LPDMA channel 15 destination address register
    /// offset: 0x50
    DAR: u32,
    /// LPDMA channel 15 transfer register 3
    /// offset: 0x54
    TR3: mmio.Mmio(packed struct(u32) {
        /// source address offset increment. The source address, pointed by CH[x].SAR, is incremented or decremented (depending on CH[x].BR1.SDEC) by this offset SAO[12:0] for each programmed source burst. This offset is not including and is added to the programmed burst size when the completed burst is addressed in incremented mode (CH[x].TR1.SINC = 1). Note: A source address offset must be aligned with the programmed data width of a source burst (SAO[2:0] versus CH[x].TR1.SDW_LOG2[1:0]). Else a user setting error is reported and none transfer is issued. When the source block size is not a multiple of the destination burst size and is a multiple of the source data width, then the last programmed source burst is not completed and is internally shorten to match the block size. In this case, the additional CH[x].TR3.SAO[12:0] is not applied.
        SAO: u13,
        reserved16: u3 = 0,
        /// destination address offset increment. The destination address, pointed by CH[x].DAR, is incremented or decremented (depending on CH[x].BR1.DDEC) by this offset DAO[12:0] for each programmed destination burst. This offset is not including and is added to the programmed burst size when the completed burst is addressed in incremented mode (CH[x].TR1.DINC = 1). Note: A destination address offset must be aligned with the programmed data width of a destination burst (DAO[2:0] versus CH[x].TR1.DDW[1:0]). Else, a user setting error is reported and no transfer is issued.
        DAO: u13,
        padding: u3 = 0,
    }),
    /// LPDMA channel 15 block register 2
    /// offset: 0x58
    BR2: mmio.Mmio(packed struct(u32) {
        /// Block repeated source address offset. For a channel with 2D addressing capability, this field is used to update (by addition or subtraction depending on CH[x].BR1.BRSDEC) the current source address (CH[x].SAR) at the end of a block transfer. Note: A block repeated source address offset must be aligned with the programmed data width of a source burst (BRSAO[2:0] versus CH[x].TR1.SDW_LOG2[1:0]). Else a user setting error is reported and no transfer is issued.
        BRSAO: u16,
        /// Block repeated destination address offset. For a channel with 2D addressing capability, this field is used to update (by addition or subtraction depending on CH[x].BR1.BRDDEC) the current destination address (CH[x].DAR) at the end of a block transfer. Note: A block repeated destination address offset must be aligned with the programmed data width of a destination burst (BRDAO[2:0] versus CH[x].TR1.DDW[1:0]). Else a user setting error is reported and no transfer is issued.
        BRDAO: u16,
    }),
    /// offset: 0x5c
    reserved92: [32]u8,
    /// LPDMA channel 15 alternate linked-list address register
    /// offset: 0x7c
    LLR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// pointer (16-bit low-significant address) to the next linked-list data structure. If UT1 = UT2 = UB1 = USA = UDA = ULL = 0 and if LA[15:20] = 0, the current LLI is the last one. The channel transfer is completed without any update of the linked-list LPDMA register file. Else, this field is the pointer to the memory address offset from which the next linked-list data structure is automatically fetched from, once the data transfer is completed, in order to conditionally update the linked-list LPDMA internal register file (CH[x].CTR1, CH[x].TR2, CH[x].BR1, CH[x].SAR, CH[x].DAR and CH[x].LLR). Note: The user must program the pointer to be 32-bit aligned. The two low-significant bits are write ignored.
        LA: u14,
        /// Update CH[x].LLR register from memory. This bit is used to control the update of CH[x].LLR from the memory during the link transfer.
        ULL: u1,
        reserved25: u8 = 0,
        /// Update CH[x].BR2 from memory. This bit controls the update of CH[x].BR2 from the memory during the link transfer.
        UB2: u1,
        /// Update CH[x].TR3 from memory. This bit controls the update of CH[x].TR3 from the memory during the link transfer.
        UT3: u1,
        /// Update CH[x].DAR register from memory. This bit is used to control the update of CH[x].DAR from the memory during the link transfer.
        UDA: u1,
        /// update CH[x].SAR from memory. This bit controls the update of CH[x].SAR from the memory during the link transfer.
        USA: u1,
        /// Update CH[x].BR1 from memory. This bit controls the update of CH[x].BR1 from the memory during the link transfer. If UB1 = 0 and if CH[x].LLR ≠ 0, the linked-list is not completed. CH[x].BR1.BNDT[15:0] is then restored to the programmed value after data transfer is completed and before the link transfer.
        UB1: u1,
        /// Update CH[x].TR2 from memory. This bit controls the update of CH[x].TR2 from the memory during the link transfer.
        UT2: u1,
        /// Update CH[x].TR1 from memory. This bit controls the update of CH[x].TR1 from the memory during the link transfer.
        UT1: u1,
    }),
};

/// LPDMA
pub const LPDMA = extern struct {
    /// LPDMA secure configuration register
    /// offset: 0x00
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of SEC) SEC0
        @"SEC[0]": u1,
        /// (2/16 of SEC) SEC0
        @"SEC[1]": u1,
        /// (3/16 of SEC) SEC0
        @"SEC[2]": u1,
        /// (4/16 of SEC) SEC0
        @"SEC[3]": u1,
        /// (5/16 of SEC) SEC0
        @"SEC[4]": u1,
        /// (6/16 of SEC) SEC0
        @"SEC[5]": u1,
        /// (7/16 of SEC) SEC0
        @"SEC[6]": u1,
        /// (8/16 of SEC) SEC0
        @"SEC[7]": u1,
        /// (9/16 of SEC) SEC0
        @"SEC[8]": u1,
        /// (10/16 of SEC) SEC0
        @"SEC[9]": u1,
        /// (11/16 of SEC) SEC0
        @"SEC[10]": u1,
        /// (12/16 of SEC) SEC0
        @"SEC[11]": u1,
        /// (13/16 of SEC) SEC0
        @"SEC[12]": u1,
        /// (14/16 of SEC) SEC0
        @"SEC[13]": u1,
        /// (15/16 of SEC) SEC0
        @"SEC[14]": u1,
        /// (16/16 of SEC) SEC0
        @"SEC[15]": u1,
        padding: u16 = 0,
    }),
    /// LPDMA privileged configuration register
    /// offset: 0x04
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PRIV) PRIV0
        @"PRIV[0]": u1,
        /// (2/16 of PRIV) PRIV0
        @"PRIV[1]": u1,
        /// (3/16 of PRIV) PRIV0
        @"PRIV[2]": u1,
        /// (4/16 of PRIV) PRIV0
        @"PRIV[3]": u1,
        /// (5/16 of PRIV) PRIV0
        @"PRIV[4]": u1,
        /// (6/16 of PRIV) PRIV0
        @"PRIV[5]": u1,
        /// (7/16 of PRIV) PRIV0
        @"PRIV[6]": u1,
        /// (8/16 of PRIV) PRIV0
        @"PRIV[7]": u1,
        /// (9/16 of PRIV) PRIV0
        @"PRIV[8]": u1,
        /// (10/16 of PRIV) PRIV0
        @"PRIV[9]": u1,
        /// (11/16 of PRIV) PRIV0
        @"PRIV[10]": u1,
        /// (12/16 of PRIV) PRIV0
        @"PRIV[11]": u1,
        /// (13/16 of PRIV) PRIV0
        @"PRIV[12]": u1,
        /// (14/16 of PRIV) PRIV0
        @"PRIV[13]": u1,
        /// (15/16 of PRIV) PRIV0
        @"PRIV[14]": u1,
        /// (16/16 of PRIV) PRIV0
        @"PRIV[15]": u1,
        padding: u16 = 0,
    }),
    /// LPDMA configuration lock register
    /// offset: 0x08
    RCFGLOCKR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of LOCK) LOCK0
        @"LOCK[0]": u1,
        /// (2/16 of LOCK) LOCK0
        @"LOCK[1]": u1,
        /// (3/16 of LOCK) LOCK0
        @"LOCK[2]": u1,
        /// (4/16 of LOCK) LOCK0
        @"LOCK[3]": u1,
        /// (5/16 of LOCK) LOCK0
        @"LOCK[4]": u1,
        /// (6/16 of LOCK) LOCK0
        @"LOCK[5]": u1,
        /// (7/16 of LOCK) LOCK0
        @"LOCK[6]": u1,
        /// (8/16 of LOCK) LOCK0
        @"LOCK[7]": u1,
        /// (9/16 of LOCK) LOCK0
        @"LOCK[8]": u1,
        /// (10/16 of LOCK) LOCK0
        @"LOCK[9]": u1,
        /// (11/16 of LOCK) LOCK0
        @"LOCK[10]": u1,
        /// (12/16 of LOCK) LOCK0
        @"LOCK[11]": u1,
        /// (13/16 of LOCK) LOCK0
        @"LOCK[12]": u1,
        /// (14/16 of LOCK) LOCK0
        @"LOCK[13]": u1,
        /// (15/16 of LOCK) LOCK0
        @"LOCK[14]": u1,
        /// (16/16 of LOCK) LOCK0
        @"LOCK[15]": u1,
        padding: u16 = 0,
    }),
    /// LPDMA non-secure masked interrupt status register
    /// offset: 0x0c
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of MIS) MIS0
        @"MIS[0]": u1,
        /// (2/16 of MIS) MIS0
        @"MIS[1]": u1,
        /// (3/16 of MIS) MIS0
        @"MIS[2]": u1,
        /// (4/16 of MIS) MIS0
        @"MIS[3]": u1,
        /// (5/16 of MIS) MIS0
        @"MIS[4]": u1,
        /// (6/16 of MIS) MIS0
        @"MIS[5]": u1,
        /// (7/16 of MIS) MIS0
        @"MIS[6]": u1,
        /// (8/16 of MIS) MIS0
        @"MIS[7]": u1,
        /// (9/16 of MIS) MIS0
        @"MIS[8]": u1,
        /// (10/16 of MIS) MIS0
        @"MIS[9]": u1,
        /// (11/16 of MIS) MIS0
        @"MIS[10]": u1,
        /// (12/16 of MIS) MIS0
        @"MIS[11]": u1,
        /// (13/16 of MIS) MIS0
        @"MIS[12]": u1,
        /// (14/16 of MIS) MIS0
        @"MIS[13]": u1,
        /// (15/16 of MIS) MIS0
        @"MIS[14]": u1,
        /// (16/16 of MIS) MIS0
        @"MIS[15]": u1,
        padding: u16 = 0,
    }),
    /// LPDMA secure masked interrupt status register
    /// offset: 0x10
    SMISR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of MIS) MIS0
        @"MIS[0]": u1,
        /// (2/16 of MIS) MIS0
        @"MIS[1]": u1,
        /// (3/16 of MIS) MIS0
        @"MIS[2]": u1,
        /// (4/16 of MIS) MIS0
        @"MIS[3]": u1,
        /// (5/16 of MIS) MIS0
        @"MIS[4]": u1,
        /// (6/16 of MIS) MIS0
        @"MIS[5]": u1,
        /// (7/16 of MIS) MIS0
        @"MIS[6]": u1,
        /// (8/16 of MIS) MIS0
        @"MIS[7]": u1,
        /// (9/16 of MIS) MIS0
        @"MIS[8]": u1,
        /// (10/16 of MIS) MIS0
        @"MIS[9]": u1,
        /// (11/16 of MIS) MIS0
        @"MIS[10]": u1,
        /// (12/16 of MIS) MIS0
        @"MIS[11]": u1,
        /// (13/16 of MIS) MIS0
        @"MIS[12]": u1,
        /// (14/16 of MIS) MIS0
        @"MIS[13]": u1,
        /// (15/16 of MIS) MIS0
        @"MIS[14]": u1,
        /// (16/16 of MIS) MIS0
        @"MIS[15]": u1,
        padding: u16 = 0,
    }),
    /// offset: 0x14
    reserved20: [60]u8,
    /// offset: 0x50
    CH: u32,
};
