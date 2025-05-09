const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ACK = enum(u1) {
    Must_NACKed = 0x0,
    Must_ACKed = 0x1,
};

pub const CODERR = enum(u4) {
    /// Transaction after sending CCC. Controller detected an illegally formatted CCC
    CE0 = 0x0,
    /// Monitoring error. Controller detected that transmitted data on the bus is different from expected
    CE1 = 0x1,
    /// No response to broadcast address. Controller detected a not acknowledged broadcast address (0b111_1110)
    CE2 = 0x2,
    /// Failed controller-role hand-off. Controller detected the new controller did not drive bus after controller-role hand-off
    CE3 = 0x3,
    /// Invalid broadcast address 0b111_1110 + W. Target detected an invalid broadcast address 0b111_1110 + W
    TE0 = 0x8,
    /// CCC code. Target detected a parity error on a CCC code via a parity check (vs. T bit)
    TE1 = 0x9,
    /// Write data. Target detected a parity error on a write data via a parity check (vs. T bit)
    TE2 = 0xa,
    /// Assigned address during dynamic address arbitration. Target detected a parity error on the assigned address during dynamic address arbitration via a parity check (vs. PAR bit)
    TE3 = 0xb,
    /// 0b111_1110 + R missing after Sr during dynamic address arbitration. Target detected a 0b111_1110 + R missing after Sr during dynamic address arbitration
    TE4 = 0xc,
    /// Transaction after detecting CCC. Target detected an illegally formatted CCC
    TE5 = 0xd,
    /// Monitoring error. Target detected that transmitted data on the bus is different from expected
    TE6 = 0xe,
    _,
};

pub const CRINIT = enum(u1) {
    /// Once enabled by setting EN = 1, the peripheral initially acts as a target. I3C does not drive SCL line and does not enable SDA pull-up, until it eventually acquires the controller role.
    Target = 0x0,
    /// Once enabled by setting EN = 1, the peripheral initially acts as a controller. It has the I3C controller role, so drives SCL line and enables SDA pull-up, until it eventually offers the controller role to an I3C secondary controller.
    Controller = 0x1,
};

pub const DIR = enum(u1) {
    Write = 0x0,
    Read = 0x1,
};

pub const DIS = enum(u1) {
    /// write to DA[7:0] and to IBIDEN in the I3C_DEVRx register is allowed
    Allowed = 0x0,
    /// write to DA[7:0] and to IBIDEN is disabled/locked
    Locked = 0x1,
};

pub const MEND = enum(u1) {
    /// this message from controller is followed by a repeated start (Sr), before another message must be emitted
    RepeatedStart = 0x0,
    /// this message from controller ends with a stop (P), being the last message of a frame
    Stop = 0x1,
};

pub const RNW = enum(u1) {
    /// write message
    Write = 0x0,
    /// read message
    Read = 0x1,
};

pub const RSTACT = enum(u2) {
    NoReset = 0x0,
    /// first level of reset: the application software must either: a) partially reset the peripheral, by a write and clear of the enable bit of the I3C configuration register (write EN = 0). This resets the I3C bus interface and the I3C kernel sub-parts, without modifying the content of the I3C APB registers (except the EN bit). b) fully reset the peripheral, including all its registers, via a write and set of the I3C reset control bit of the RCC (reset and clock controller) register.
    FirstLevel = 0x1,
    /// second level of reset: the application software must issue a warm reset, also known as a system reset. This (see Section 11: Reset and clock control (RCC)) has the same impact as a pin reset (NRST = 0): – the software writes and sets the SYSRESETREQ control bit of the AITR register, when the device is controlled by a Cortex®-M. – the software writes and sets SYSRST = 1 in the RCC_GRSTCSETR register, when the device is controlled by a Cortex®-A.
    SecondLevel = 0x2,
    NoResetEither = 0x3,
};

pub const THRES = enum(u1) {
    /// TXFNFF is set when 1 byte must be written in TX-FIFO (in I3C_TDR).
    Byte = 0x0,
    /// TXFNFF is set when 1 word / 4 bytes must be written in TX-FIFO (in the I3C_TDWR register). If the a number of the last transmitted data is not a multiple of 4 bytes (XDCNT[1:0] = 00 in the I3C_SR register), only the relevant 1, 2, or 3 valid LSB bytes of the last word are taken into account by the hardware, and sent on the I3C bus.
    Word = 0x1,
};

pub const DataRegs = extern struct {
    /// I3C receive data byte register.
    /// offset: 0x00
    DR: mmio.Mmio(packed struct(u32) {
        /// 8-bit received data on I3C bus.
        DB: u8,
        padding: u24 = 0,
    }),
    /// I3C receive data word register.
    /// offset: 0x04
    DWR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of DB) 8-bit received data (earliest byte on I3C bus).
        @"DB[0]": u8,
        /// (2/4 of DB) 8-bit received data (earliest byte on I3C bus).
        @"DB[1]": u8,
        /// (3/4 of DB) 8-bit received data (earliest byte on I3C bus).
        @"DB[2]": u8,
        /// (4/4 of DB) 8-bit received data (earliest byte on I3C bus).
        @"DB[3]": u8,
    }),
};

/// Improved inter-integrated circuit.
pub const I3C = extern struct {
    /// I3C message control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// count of data to transfer during a read or write message, in bytes (whatever I3C is acting as controller/target) Linear encoding up to 64 Kbytes -1 ...
        DCNT: u16,
        /// read / non-write message (when I3C is acting as controller) When I3C is acting as controller, this field is used if MTYPE[3:0]=0010 (private message) or MTYPE[3:0]=0011 (direct message) or MTYPE[3:0]=0100 (legacy I2C message), in order to emit the RnW bit on the I3C bus.
        RNW: RNW,
        /// 7-bit I3C dynamic / I2C static target address (when I3C is acting as controller) When I3C is acting as controller, this field is used if MTYPE[3:0]=0010 (private message) or MTYPE[3:0]=0011 (direct message) or MTYPE[3:0]=0100 (legacy I2C message).
        ADD: u7,
        reserved27: u3 = 0,
        /// message type (whatever I3C is acting as controller/target) Bits[26:0] are ignored. After M2 error detection on an I3C SDR message, this is needed for SCL “stuck at” recovery. Bits[26:0] are ignored. If I3C_CFGR.EXITPTRN=1, an HDR exit pattern is emitted on the bus to generate an escalation fault. Bits[23:17] (ADD[6:0]) is the emitted 7-bit dynamic address. Bit[16] (RNW) is the emitted RnW bit. The transferred private message is: {S / S+7’h7E+RnW=0+Sr / Sr+*} + 7-bit DynAddr + RnW + (8-bit Data + T)* + Sr/P. After a S (START), depending on I3C_CFGR.NOARBH, the arbitrable header (7’h7E+RnW=0) is inserted or not. Sr+*: after a Sr (Repeated Start), the hardware automatically inserts (7’h7E+RnW=0) if needed, i.e. if it follows an I3C direct message without ending by a P (Stop). Bits[23:17] (ADD[6:0]) is the emitted 7-bit dynamic address. Bit[16] (RNW) is the emitted RnW bit. The transferred direct message is: Sr + 7-bit DynAddr + RnW + (8-bit Data + T)* + Sr/P Bits[23:17] (ADD[6:0]) is the emitted 7-bit static address. Bit[16] (RNW) is the emitted RnW bit. The transferred legacy I2C message is: {S / S+ 7’h7E+RnW=0 + Sr / Sr+*} + 7-bit StaAddr + RnW + (8-bit Data + T)* + Sr/P. After a S (START), depending on I3C_CFGR.NOARBH, the arbitrable header (7’h7E+RnW=0) is inserted or not. Sr+*: after a Sr (Repeated Start), the hardware automatically inserts (7’h7E+RnW=0) if needed, i.e. if it follows an I3C direct message without ending by a P (Stop). 1xxx: reserved (when I3C is acting as I3C controller, used when target) 0xxx: reserved {S +} 7’h02 addr + RnW=0 {S +} 7-bit I3C_DEVR0.DA[6:0] + RnW=0 after a bus available condition (the target first emits a START request), or once the controller drives a START. {S +} 7-bit I3C_DEVR0.DA[6:0] + RnW=1 (+Ack/Nack from controller) When acknowledged from controller, the next (optional, depending on I3C_BCR.BCR2) transmitted IBI payload data is defined by I3C_CR.DCNT[15:0] and must be consistently programmed vs the maximum IBI payload data size which is defined by I3C_IBIDR.IBIP[2:0]. Others: reserved.
        MTYPE: u4,
        /// message end type (when the I3C is acting as controller).
        MEND: MEND,
    }),
    /// I3C configuration register.
    /// offset: 0x04
    CFGR: mmio.Mmio(packed struct(u32) {
        /// I3C enable (whatever I3C is acting as controller/target) - Except registers, the peripheral is under reset (a.k.a. partial reset). - Before clearing EN, when I3C is acting as a controller, all the possible target requests must be disabled using DISEC CCC. - When I3C is acting as a target, software should not disable the I3C, unless a partial reset is needed. In this state, some register fields can not be modified (like CRINIT, HKSDAEN for the I3C_CFGR).
        EN: u1,
        /// initial controller/target role This bit can be modified only when I3C_CFGR.EN = 0. Once enabled by setting I3C_CFGR.EN = 1, I3C peripheral initially acts as an I3C target. I3C does not drive SCL line and does not enable SDA pull-up, until it eventually acquires the controller role. Once enabled by setting I3C_CFGR.EN = 1, I3C peripheral initially acts as a controller. It has the I3C controller role, so drives SCL line and enables SDA pull-up, until it eventually offers the controller role to an I3C secondary controller.
        CRINIT: CRINIT,
        /// no arbitrable header after a START (when I3C is acting as a controller) This bit can be modified only when there is no on-going frame. - The target address is emitted directly after a START in case of a legacy I2C message or an I3C SDR private read/write message. - This is a more performing option (when is useless the emission of the 0x7E arbitrable header), but this is to be used only when the controller is sure that the addressed target device can not emit concurrently an IBI or a controller-role request (to insure no misinterpretation and no potential conflict between the address emitted by the controller in open-drain mode and the same address a target device can emit after a START, for IBI or MR).
        NOARBH: u1,
        /// HDR reset pattern enable (when I3C is acting as a controller) This bit can be modified only when there is no on-going frame.
        RSTPTRN: u1,
        /// HDR Exit Pattern enable (when I3C is acting as a controller) This bit can be modified only when there is no on-going frame. This is used to send only the header to test ownership of the bus when there is a suspicion of problem after controller-role hand-off (new controller didn’t assert its controller-role by accessing the previous one in less than Activity State time). The HDR Exit Pattern is sent even if the message header {S/Sr + 0x7E addr + W } is ACKed.
        EXITPTRN: u1,
        /// High-keeper enable on SDA line (when I3C is acting as a controller) This bit can be modified only when I3C_CFGR.EN=0.
        HKSDAEN: u1,
        reserved7: u1 = 0,
        /// Hot Join request acknowledge (when I3C is acting as a controller) After the NACK, the message continues as initially programmed (the hot-joining target is aware of the NACK and surely emits another hot-join request later on). After the ACK, the message continues as initially programmed. The software is aware by the HJ interrupt (flag I3C_EVR.HJF is set) and initiates the ENTDAA sequence later on, potentially preventing others Hot Join requests with a Disable target events command (DISEC, with DISHJ=1). Independently of the HJACK configuration, further Hot Join request(s) are NACKed until the Hot Join flag, HJF, is cleared. However, a NACKed target can be assigned a dynamic address by the ENTDAA sequence initiated later on by the first HJ request, preventing this target to emit an HJ request again.
        HJACK: u1,
        /// RX-FIFO DMA request enable (whatever I3C is acting as controller/target) - Software reads and pops a data byte/word from RX-FIFO i.e. reads I3C_RDR or I3C_RDWR register. - A next data byte/word is to be read by the software either via polling on the flag I3C_EVR.RXFNEF=1 or via interrupt notification (enabled by I3C_IER.RXFNEIE=1). - DMA reads and pops data byte(s)/word(s) from RX-FIFO i.e. reads I3C_RDR or I3C_RDWR register. - A next data byte/word is automatically read by the programmed hardware (i.e. via the asserted RX-FIFO DMA request from the I3C and the programmed DMA channel).
        RXDMAEN: u1,
        /// RX-FIFO flush (whatever I3C is acting as controller/target) This bit can only be written.
        RXFLUSH: u1,
        /// RX-FIFO threshold (whatever I3C is acting as controller/target) This threshold defines, compared to the RX-FIFO level, when the I3C_EVR.RXFNEF flag is set (and consequently if RXDMAEN=1 when is asserted a DMA RX request). RXFNEF is set when 1 byte is to be read in RX-FIFO (i.e. in I3C_RDR). RXFNEF is set when 4 bytes are to be read in RX-FIFO (i.e. in I3C_RDWR).
        RXTHRES: THRES,
        reserved12: u1 = 0,
        /// TX-FIFO DMA request enable (whatever I3C is acting as controller/target) - Software writes and pushes a data byte/word into TX-FIFO i.e. writes I3C_TDR or I3C_TDWR register, to be transmitted over the I3C bus. - A next data byte/word is to be written by the software either via polling on the flag I3C_EVR.TXFNFF=1 or via interrupt notification (enabled by I3C_IER.TXFNFIE=1). - DMA writes and pushes data byte(s)/word(s) into TX-FIFO i.e. writes I3C_TDR or I3C_TDWR register. - A next data byte/word transfer is automatically pushed by the programmed hardware (i.e. via the asserted TX-FIFO DMA request from the I3C and the programmed DMA channel).
        TXDMAEN: u1,
        /// TX-FIFO flush (whatever I3C is acting as controller/target) This bit can only be written. When the I3C is acting as target, this bit can be used to flush the TX-FIFO on a private read if the controller has early ended the read data (i.e. driven low the T bit) and there is/are remaining data in the TX-FIFO (i.e. I3C_SR.ABT=1 and I3C_SR.XDCNT[15:0] < I3C_TGTTDR.TGTTDCNT[15:0]).
        TXFLUSH: u1,
        /// TX-FIFO threshold (whatever I3C is acting as controller/target) This threshold defines, compared to the TX-FIFO level, when the I3C_EVR.TXFNFF flag is set (and consequently if TXDMAEN=1 when is asserted a DMA TX request). TXFNFF is set when 1 byte is to be written in TX-FIFO (i.e. in I3C_TDR). TXFNFF is set when 4 bytes are to be written in TX-FIFO (i.e. in I3C_TDWR).
        TXTHRES: THRES,
        reserved16: u1 = 0,
        /// S-FIFO DMA request enable (when I3C is acting as controller) Condition: When RMODE=1 (FIFO is enabled for the status): - Software reads and pops a status word from S-FIFO i.e. reads I3C_SR register after a completed frame (I3C_EVR.FCF=1) or an error (I3C_EVR.ERRF=1). - A status word can be read by the software either via polling on these register flags or via interrupt notification (enabled by I3C_IER.FCIE=1 and I3C_IER.ERRIE=1). - DMA reads and pops status word(s) from S-FIFO i.e. reads I3C_SR register. - Status word(s) are automatically read by the programmed hardware (i.e. via the asserted S-FIFO DMA request from the I3C and the programmed DMA channel).
        SDMAEN: u1,
        /// S-FIFO flush (when I3C is acting as controller) When I3C is acting as I3C controller, this bit can only be written (and is only used when I3C is acting as controller).
        SFLUSH: u1,
        /// S-FIFO enable / status receive mode (when I3C is acting as controller) When I3C is acting as I3C controller, this bit is used for the enabling the FIFO for the status (S-FIFO) vs the received status from the target on the I3C bus. When I3C is acting as target, this bit must be cleared. - Status register (i.e. I3C_SR) is used without FIFO mechanism. - There is no SCL stretch if a new status register content is not read. - Status register must be read before being lost/overwritten. All message status must be read. There is SCL stretch when there is no more space in the S-FIFO.
        RMODE: u1,
        /// transmit mode (when I3C is acting as controller) When I3C is acting as I3C controller, this bit is used for the C-FIFO and TX-FIFO management vs the emitted frame on the I3C bus. A frame transfer starts as soon as first control word is present in C-FIFO.
        TMODE: u1,
        /// C-FIFO DMA request enable (when I3C is acting as controller) When I3C is acting as controller: - Software writes and pushes control word(s) into C-FIFO i.e. writes I3C_CR register, as needed for a given frame. - A next control word transfer can be written by software either via polling on the flag I3C_EVR.CFNFF=1 or via interrupt notification (enabled by I3C_IER.CFNFIE=1). - DMA writes and pushes control word(s) into C-FIFO i.e. writes I3C_CR register, as needed for a given frame. - A next control word transfer is automatically written by the programmed hardware (i.e. via the asserted C-FIFO DMA request from the I3C and the programmed DMA channel).
        CDMAEN: u1,
        /// C-FIFO flush (when I3C is acting as controller) This bit can only be written.
        CFLUSH: u1,
        reserved30: u8 = 0,
        /// frame transfer set (a.k.a. software trigger) (when I3C is acting as controller) This bit can only be written. When I3C is acting as I3C controller: Note: If this bit is not set, the other alternative for the software to initiate a frame transfer is to directly write the first control word register (i.e. I3C_CR) while C-FIFO is empty (i.e. I3C_EVR.CFEF=1). Then, if the first written control word is not tagged as a message end (i.e I3C_CR.MEND=0), it causes the hardware to assert the flag I3C_EVR.CFNFF (C-FIFO not full and a next control word is needed).
        TSFSET: u1,
        padding: u1 = 0,
    }),
    /// offset: 0x08
    reserved8: [8]u8,
    /// offset: 0x10
    RxDataRegs: u32,
    /// offset: 0x14
    reserved20: [4]u8,
    /// offset: 0x18
    TxDataRegs: u32,
    /// offset: 0x1c
    reserved28: [4]u8,
    /// I3C IBI payload data register.
    /// offset: 0x20
    IBIDR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of IBIDB) 8-bit IBI payload data (earliest byte on I3C bus, i.e. MDB[7:0] mandatory data byte).
        @"IBIDB[0]": u8,
        /// (2/4 of IBIDB) 8-bit IBI payload data (earliest byte on I3C bus, i.e. MDB[7:0] mandatory data byte).
        @"IBIDB[1]": u8,
        /// (3/4 of IBIDB) 8-bit IBI payload data (earliest byte on I3C bus, i.e. MDB[7:0] mandatory data byte).
        @"IBIDB[2]": u8,
        /// (4/4 of IBIDB) 8-bit IBI payload data (earliest byte on I3C bus, i.e. MDB[7:0] mandatory data byte).
        @"IBIDB[3]": u8,
    }),
    /// I3C target transmit configuration register.
    /// offset: 0x24
    TGTTDR: mmio.Mmio(packed struct(u32) {
        /// transmit data counter, in bytes (when I3C is configured as target) This field must be written by software in the same access when is asserted PRELOAD, in order to define the number of bytes to preload and to transmit. This field is updated by hardware and reports, when read, the remaining number of bytes to be loaded into the TX-FIFO.
        TGTTDCNT: u16,
        /// preload of the TX-FIFO (when I3C is configured as target) This bit must be written and asserted by software in the same access when is written and defined the number of bytes to preload into the TX-FIFO and to transmit. This bit is cleared by hardware when all the data bytes to transmit are loaded into the TX-FIFO.
        PRELOAD: u1,
        padding: u15 = 0,
    }),
    /// offset: 0x28
    reserved40: [8]u8,
    /// I3C status register.
    /// offset: 0x30
    SR: mmio.Mmio(packed struct(u32) {
        /// data counter - When the I3C is acting as controller: number of targets detected on the bus - When the I3C is acting as target: number of transmitted bytes - Whatever the I3C is acting as controller or target: number of data bytes read from or transmitted on the I3C bus during the MID[7:0] message.
        XDCNT: u16,
        reserved17: u1 = 0,
        /// a private read message is completed/aborted prematurely by the target (when the I3C is acting as controller) When the I3C is acting as controller, this bit indicates if the private read data which is transmitted by the target early terminates (i.e. the target drives T bit low earlier vs what does expect the controller in terms of programmed number of read data bytes i.e. I3C_CR.DCNT[15:0]).
        ABT: u1,
        /// message direction Whatever the I3C is acting as controller or target, this bit indicates the direction of the related message on the I3C bus Note: ENTDAA CCC is considered as a write command.
        DIR: DIR,
        reserved24: u5 = 0,
        /// message identifier/counter of a given frame (when the I3C is acting as controller) When the I3C is acting as controller, this field identifies the control word message (i.e. I3C_CR) to which the I3C_SR status register refers. First message of a frame is identified with MID[7:0]=0. This field is incremented (by hardware) on the completion of a new message control word (i.e. I3C_CR) over I3C bus. This field is reset for every new frame start.
        MID: u8,
    }),
    /// I3C status error register.
    /// offset: 0x34
    SER: mmio.Mmio(packed struct(u32) {
        /// protocol error code/type controller detected an illegally formatted CCC controller detected that transmitted data on the bus is different from expected controller detected a not acknowledged broadcast address (7’hE) controller detected the new controller did not drive bus after controller-role hand-off target detected an invalid broadcast address 7’hE+W target detected a parity error on a CCC code via a parity check (vs T bit) target detected a parity error on a write data via a parity check (vs T bit) target detected a parity error on the assigned address during dynamic address arbitration via a parity check (vs PAR bit) target detected a 7’hE+R missing after Sr during dynamic address arbitration target detected an illegally formatted CCC target detected that transmitted data on the bus is different from expected others: reserved.
        CODERR: CODERR,
        /// protocol error.
        PERR: u1,
        /// SCL stall error (when the I3C is acting as target).
        STALL: u1,
        /// RX-FIFO overrun or TX-FIFO underrun i) a TX-FIFO underrun: TX-FIFO is empty and a write data byte has to be transmitted ii) a RX-FIFO overrun: RX-FIFO is full and a new data byte is received.
        DOVR: u1,
        /// C-FIFO underrun or S-FIFO overrun (when the I3C is acting as controller) i) a C-FIFO underrun: control FIFO is empty and a restart has to be emitted ii) a S-FIFO overrun: S-FIFO is full and a new message ends.
        COVR: u1,
        /// address not acknowledged (when the I3C is configured as controller) i) a legacy I2C read/write transfer ii) a direct CCC write transfer iii) the second trial of a direct CCC read transfer iv) a private read/write transfer.
        ANACK: u1,
        /// data not acknowledged (when the I3C is acting as controller) i) a legacy I2C write transfer ii) the second trial when sending dynamic address during ENTDAA procedure.
        DNACK: u1,
        /// data error (when the I3C is acting as controller).
        DERR: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x38
    reserved56: [8]u8,
    /// I3C received message register.
    /// offset: 0x40
    RMR: mmio.Mmio(packed struct(u32) {
        /// IBI received payload data count (when the I3C is configured as controller) When the I3C is configured as controller, this field logs the number of data bytes effectively received in the I3C_IBIDR register.
        IBIRDCNT: u3,
        reserved8: u5 = 0,
        /// received CCC code (when the I3C is configured as target) When the I3C is configured as target, this field logs the received CCC code.
        RCODE: u8,
        reserved17: u1 = 0,
        /// received target address (when the I3C is configured as controller) When the I3C is configured as controller, this field logs the received dynamic address from the target during acknowledged IBI or controller-role request.
        RADD: u7,
        padding: u8 = 0,
    }),
    /// offset: 0x44
    reserved68: [12]u8,
    /// I3C event register.
    /// offset: 0x50
    EVR: mmio.Mmio(packed struct(u32) {
        /// C-FIFO empty flag (whatever the I3C is acting as controller/target) This flag is asserted by hardware to indicate that the C-FIFO is empty when controller, and that the I3C_CR register contains no control word (i.e. none IBI/CR/HJ request) when target. This flag is de-asserted by hardware to indicate that the C-FIFO is not empty when controller, and that the I3C_CR register contains one control word (i.e. a pending IBI/CR/HJ request) when target. Note: When the I3C is acting as controller, if the C-FIFO and TX-FIFO preload is configured (i.e. I3C_CFGR.TMODE=1), the software must wait for TXFEF=1 and CFEF=1 before starting a new frame transfer.
        CFEF: u1,
        /// TX-FIFO empty flag (whatever the I3C is acting as controller/target) This flag is asserted by hardware to indicate that the TX-FIFO is empty. This flag is de-asserted by hardware to indicate that the TX-FIFO is not empty. Note: When the I3C is acting as controller, if the C-FIFO and TX-FIFO preload is configured (i.e. I3C_CFGR.TMODE=1), the software must wait for TXFEF=1 and CFEF=1 before starting a new frame transfer.
        TXFEF: u1,
        /// C-FIFO not full flag (when the I3C is acting as controller) When the I3C is acting as controller, this flag is asserted by hardware to indicate that a control word is to be written to the C-FIFO. This flag is de-asserted by hardware to indicate that a control word is not to be written to the C-FIFO. Note: The software must wait for CFNFF=1 (by polling or via the enabled interrupt) before writing to C-FIFO (i.e. writing to I3C_CR).
        CFNFF: u1,
        /// S-FIFO not empty flag (when the I3C is acting as controller) When the I3C is acting as controller, if the S-FIFO is enabled (i.e. I3C_CFGR.RMODE=1), this flag is asserted by hardware to indicate that a status word is to be read from the S-FIFO. This flag is de-asserted by hardware to indicate that a status word is not to be read from the S-FIFO.
        SFNEF: u1,
        /// TX-FIFO not full flag (whatever the I3C is acting as controller/target) This flag is asserted by hardware to indicate that a data byte/word is to be written to the TX-FIFO. This flag is de-asserted by hardware to indicate that a data byte/word is not to be written to the TX-FIFO. Note: The software must wait for TXFNFF=1 (by polling or via the enabled interrupt) before writing to TX-FIFO (i.e. writing to I3C_TDR or I3C_TDWR depending on I3C_CFGR.TXTHRES). Note: When the I3C is acting as target, if the software intends to use the TXFNFF flag for writing into I3C_TDR/I3C_TDWR, it must have configured and set the TX-FIFO preload (i.e. write I3C_TGTTDR.PRELOAD).
        TXFNFF: u1,
        /// RX-FIFO not empty flag (whatever the I3C is acting as controller/target) This flag is asserted by hardware to indicate that a data byte is to be read from the RX-FIFO. This flag is de-asserted by hardware to indicate that a data byte is not to be read from the RX-FIFO. Note: The software must wait for RXFNEF=1 (by polling or via the enabled interrupt) before reading from RX-FIFO (i.e. writing to I3C_RDR or I3C_RDWR depending on I3C_CFGR.RXTHRES).
        RXFNEF: u1,
        /// last written data byte/word flag (whatever the I3C is acting as controller/target) This flag is asserted by hardware to indicate that the last data byte/word (depending on I3C_CFGR.TXTHRES) of a message is to be written to the TX-FIFO. This flag is de-asserted by hardware when the last data byte/word of a message is written.
        TXLASTF: u1,
        /// last read data byte/word flag (whatever the I3C is acting as controller/target) This flag is asserted by hardware to indicate that the last data byte/word (depending on I3C_CFGR.RXTHRES) of a message is to be read from the RX-FIFO. This flag is de-asserted by hardware when the last data byte/word of a message is read.
        RXLASTF: u1,
        reserved9: u1 = 0,
        /// frame complete flag (whatever the I3C is acting as controller/target) When the I3C is acting as controller, this flag is asserted by hardware to indicate that a frame has been (normally) completed on the I3C bus, i.e when a stop is issued. When the I3C is acting as target, this flag is asserted by hardware to indicate that a message addressed to/by this target has been (normally) completed on the I3C bus, i.e when a next stop or repeated start is then issued by the controller. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CFCF bit.
        FCF: u1,
        /// target-initiated read end flag (when the I3C is acting as controller) When the I3C is acting as controller, this flag is asserted by hardware to indicate that the target has prematurely ended a read transfer. Then, software should read I3C_SR to get more information on the prematurely read transfer. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CRXTGTENDF bit.
        RXTGTENDF: u1,
        /// flag (whatever the I3C is acting as controller/target) This flag is asserted by hardware to indicate that an error occurred.Then, software should read I3C_SER to get the error type. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CERRF bit.
        ERRF: u1,
        reserved15: u3 = 0,
        /// IBI flag (when the I3C is acting as controller) When the I3C is acting as controller, this flag is asserted by hardware to indicate that an IBI request has been received. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CIBIF bit.
        IBIF: u1,
        /// IBI end flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that a IBI transfer has been received and completed (IBI acknowledged and IBI data bytes read by controller if any). This flag is cleared when software writes 1 into corresponding I3C_CEVR.CIBIENDF bit.
        IBIENDF: u1,
        /// controller-role request flag (when the I3C is acting as controller) When the I3C is acting as controller, this flag is asserted by hardware to indicate that a controller-role request has been acknowledged and completed (by hardware). The software should then issue a GETACCCR CCC (get accept controller role) for the controller-role hand-off procedure. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CCRF bit.
        CRF: u1,
        /// controller-role update flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that it has now gained the controller role after the completed controller-role hand-off procedure. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CCRUPDF bit.
        CRUPDF: u1,
        /// hot-join flag (when the I3C is acting as controller) When the I3C is acting as controller, this flag is asserted by hardware to indicate that an hot join request has been received. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CHJF bit.
        HJF: u1,
        reserved21: u1 = 0,
        /// wakeup/missed start flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that a start has been detected (i.e. a SDA falling edge followed by a SCL falling edge) but on the next SCL falling edge, the I3C kernel clock is (still) gated. Thus an I3C bus transaction may have been lost by the target. The corresponding interrupt may be used to wakeup the device from a low power mode (Sleep or Stop mode). This flag is cleared when software writes 1 into corresponding I3C_CEVR.CWKPF bit.
        WKPF: u1,
        /// get flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that any direct CCC of get type (GET*** CCC) has been received. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CGETF bit.
        GETF: u1,
        /// get status flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that a direct GETSTATUS CCC (get status) has been received. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CSTAF bit.
        STAF: u1,
        /// dynamic address update flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that a dynamic address update has been received via any of the broadcast ENTDAA, RSTDAA and direct SETNEWDA CCC. Then, software should read I3C_DEVR0.DA[6:0] to get the maximum write length value. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CDAUPDF bit.
        DAUPDF: u1,
        /// maximum write length update flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that a direct SETMWL CCC (set max write length) has been received. Then, software should read I3C_MAXWLR.MWL[15:0] to get the maximum write length value. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CMWLUPDF bit.
        MWLUPDF: u1,
        /// maximum read length update flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that a direct SETMRL CCC (set max read length) has been received. Then, software should read I3C_MAXRLR.MRL[15:0] to get the maximum read length value. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CMRLUPDF bit.
        MRLUPDF: u1,
        /// reset pattern flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that a reset pattern has been detected (i.e. 14 SDA transitions while SCL is low, followed by repeated start, then stop). Then, software should read I3C_DEVR0.RSTACT[1:0] and I3C_DEVR0.RSTVAL, to know what reset level is required. If RSTVAL=1: when the RSTF is asserted (and/or the corresponding interrupt if enabled), I3C_DEVR0.RSTACT[1:0] dictates the reset action to be performed by the software if any. If RSTVAL=0: when the RSTF is asserted (and/or the corresponding interrupt if enabled), the software should issue an I3C reset after a first detected reset pattern, and a system reset on the second one. The corresponding interrupt may be used to wakeup the device from a low power mode (Sleep or Stop mode). This flag is cleared when software writes 1 into corresponding I3C_CEVR.CRSTF bit.
        RSTF: u1,
        /// activity state update flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that the direct or broadcast ENTASx CCC (with x=0...3) has been received. Then, software should read I3C_DEVR0.AS[1:0]. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CASUPDF bit.
        ASUPDF: u1,
        /// interrupt/controller-role/hot-join update flag (when the I3C is acting as target) When the I3C is acting as target, this flag is asserted by hardware to indicate that the direct or broadcast ENEC/DISEC CCC (enable/disable target events) has been received, where a target event is either an interrupt/IBI request, a controller-role request, or an hot-join request. Then, software should read respectively I3C_DEVR0.IBIEN, I3C_DEVR0.CREN or I3C_DEVR0.HJEN. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CINTUPDF bit.
        INTUPDF: u1,
        /// DEFTGTS flag (when the I3C is acting as target) When the I3C is acting as target (and is typically controller capable), this flag is asserted by hardware to indicate that the broadcast DEFTGTS CCC (define list of targets) has been received. Then, software may store the received data for when getting the controller role. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CDEFF bit.
        DEFF: u1,
        /// group addressing flag (when the I3C is acting as target) When the I3C is acting as target (and is typically controller capable), this flag is asserted by hardware to indicate that the broadcast DEFGRPA CCC (define list of group addresses) has been received. Then, software may store the received data for when getting the controller role. This flag is cleared when software writes 1 into corresponding I3C_CEVR.CGRPF bit.
        GRPF: u1,
    }),
    /// I3C interrupt enable register.
    /// offset: 0x54
    IER: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// C-FIFO not full interrupt enable (whatever the I3C is acting as controller/target).
        CFNFIE: u1,
        /// S-FIFO not empty interrupt enable (whatever the I3C is acting as controller/target).
        SFNEIE: u1,
        /// TX-FIFO not full interrupt enable (whatever the I3C is acting as controller/target).
        TXFNFIE: u1,
        /// RX-FIFO not empty interrupt enable (whatever the I3C is acting as controller/target).
        RXFNEIE: u1,
        reserved9: u3 = 0,
        /// frame complete interrupt enable (whatever the I3C is acting as controller/target).
        FCIE: u1,
        /// target-initiated read end interrupt enable (when the I3C is acting as controller).
        RXTGTENDIE: u1,
        /// error interrupt enable (whatever the I3C is acting as controller/target).
        ERRIE: u1,
        reserved15: u3 = 0,
        /// IBI request interrupt enable (when the I3C is acting as controller).
        IBIIE: u1,
        /// IBI end interrupt enable (when the I3C is acting as target).
        IBIENDIE: u1,
        /// controller-role request interrupt enable (when the I3C is acting as controller).
        CRIE: u1,
        /// controller-role update interrupt enable (when the I3C is acting as target).
        CRUPDIE: u1,
        /// hot-join interrupt enable (when the I3C is acting as controller).
        HJIE: u1,
        reserved21: u1 = 0,
        /// wakeup interrupt enable (when the I3C is acting as target).
        WKPIE: u1,
        /// GETxxx CCC interrupt enable (when the I3C is acting as target).
        GETIE: u1,
        /// GETSTATUS CCC interrupt enable (when the I3C is acting as target).
        STAIE: u1,
        /// ENTDAA/RSTDAA/SETNEWDA CCC interrupt enable (when the I3C is acting as target).
        DAUPDIE: u1,
        /// SETMWL CCC interrupt enable (when the I3C is acting as target).
        MWLUPDIE: u1,
        /// SETMRL CCC interrupt enable (when the I3C is acting as target).
        MRLUPDIE: u1,
        /// reset pattern interrupt enable (when the I3C is acting as target).
        RSTIE: u1,
        /// ENTASx CCC interrupt enable (when the I3C is acting as target).
        ASUPDIE: u1,
        /// ENEC/DISEC CCC interrupt enable (when the I3C is acting as target).
        INTUPDIE: u1,
        /// DEFTGTS CCC interrupt enable (when the I3C is acting as target).
        DEFIE: u1,
        /// DEFGRPA CCC interrupt enable (when the I3C is acting as target).
        GRPIE: u1,
    }),
    /// I3C clear event register.
    /// offset: 0x58
    CEVR: mmio.Mmio(packed struct(u32) {
        reserved9: u9 = 0,
        /// clear frame complete flag (whatever the I3C is acting as controller/target).
        CFCF: u1,
        /// clear target-initiated read end flag (when the I3C is acting as controller).
        CRXTGTENDF: u1,
        /// clear error flag (whatever the I3C is acting as controller/target).
        CERRF: u1,
        reserved15: u3 = 0,
        /// clear IBI request flag (when the I3C is acting as controller).
        CIBIF: u1,
        /// clear IBI end flag (when the I3C is acting as target).
        CIBIENDF: u1,
        /// clear controller-role request flag (when the I3C is acting as controller).
        CCRF: u1,
        /// clear controller-role update flag (when the I3C is acting as target).
        CCRUPDF: u1,
        /// clear hot-join flag (when the I3C is acting as controller).
        CHJF: u1,
        reserved21: u1 = 0,
        /// clear wakeup flag (when the I3C is acting as target).
        CWKPF: u1,
        /// clear GETxxx CCC flag (when the I3C is acting as target).
        CGETF: u1,
        /// clear GETSTATUS CCC flag (when the I3C is acting as target).
        CSTAF: u1,
        /// clear ENTDAA/RSTDAA/SETNEWDA CCC flag (when the I3C is acting as target).
        CDAUPDF: u1,
        /// clear SETMWL CCC flag (when the I3C is acting as target).
        CMWLUPDF: u1,
        /// clear SETMRL CCC flag (when the I3C is acting as target).
        CMRLUPDF: u1,
        /// clear reset pattern flag (when the I3C is acting as target).
        CRSTF: u1,
        /// clear ENTASx CCC flag (when the I3C is acting as target).
        CASUPDF: u1,
        /// clear ENEC/DISEC CCC flag (when the I3C is acting as target).
        CINTUPDF: u1,
        /// clear DEFTGTS CCC flag (when the I3C is acting as target).
        CDEFF: u1,
        /// clear DEFGRPA CCC flag (when the I3C is acting as target).
        CGRPF: u1,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// I3C own device characteristics register.
    /// offset: 0x60
    DEVR0: mmio.Mmio(packed struct(u32) {
        /// dynamic address is valid (when the I3C is acting as target) When the I3C is acting as controller, this field can be written by software, for validating its own dynamic address, for example before a controller-role hand-off. When the I3C is acting as target, this field is asserted by hardware on the acknowledge of the broadcast ENTDAA CCC or the direct SETNEWDA CCC, and this field is cleared by hardware on the acknowledge of the broadcast RSTDAA CCC.
        DAVAL: u1,
        /// 7-bit dynamic address When the I3C is acting as controller, this field can be written by software, for defining its own dynamic address. When the I3C is acting as target, this field is updated by hardware on the reception of either the broadcast ENTDAA CCC or the direct SETNEWDA CCC.
        DA: u7,
        reserved16: u8 = 0,
        /// IBI request enable (when the I3C is acting as target) This field is initially written by software when I3C_CFGR.EN=0, and is updated by hardware on the reception of DISEC CCC with DISINT=1 (i.e. cleared) and the reception of ENEC CCC with ENINT=1 (i.e. set).
        IBIEN: u1,
        /// controller-role request enable (when the I3C is acting as target) This field is initially written by software when I3C_CFGR.EN=0, and is updated by hardware on the reception of DISEC CCC with DISCR=1 (i.e. cleared) and the reception of ENEC CCC with ENCR=1 (i.e. set).
        CREN: u1,
        reserved19: u1 = 0,
        /// hot-join request enable (when the I3C is acting as target) This field is initially written by software when I3C_CFGR.EN=0, and is updated by hardware on the reception of DISEC CCC with DISHJ=1 (i.e. cleared) and the reception of ENEC CCC with ENHJ=1 (i.e. set).
        HJEN: u1,
        /// activity state (when the I3C is acting as target) This read field is updated by hardware on the reception of a ENTASx CCC (enter activity state, with x=0-3):.
        AS: u2,
        /// reset action/level on received reset pattern (when the I3C is acting as target) This read field is used by hardware on the reception of a direct read RSTACT CCC in order to return the corresponding data byte on the I3C bus. This read field is updated by hardware on the reception of a broadcast or direct write RSTACT CCC (target reset action). Only the defining bytes 0x00, 0x01 and 0x02 are mapped, and RSTACT[1:0] = Defining Byte[1:0]. a) partially reset the I3C peripheral, by a write and clear of the enable bit of the i3C configuration register (i.e. write I3C_CFGR.EN=0). This reset the I3C bus interface and the I3C kernel sub-parts, without modifying the content of the I3C APB registers (excepted the I3C_CFGR.EN bit). b) reset fully the I3C peripheral including all its registers via a write and set to the I3C reset control bit of the RCC (Reset and Clock Controller) register. a system reset. This has the same impact as a pin reset (i.e. NRST=0) (refer to RCC functional description - Reset part): – the software writes and set the AICR.SYSRESETREQ register control bit, when the device is controlled by a CortexTM-M. – the software writes and set the RCC_GRSTCSETR.SYSRST=1, when the device is controlled by a CortexTM-A.
        RSTACT: RSTACT,
        /// reset action is valid (when the I3C is acting as target) This read bit is asserted by hardware to indicate that the RTSACT[1:0] field has been updated on the reception of a broadcast or direct write RSTACT CCC (target reset action) and is valid. This field is cleared by hardware when the target receives a frame start. If RSTVAL=1: when the RSTF is asserted (and/or the corresponding interrupt if enabled), I3C_DEVR0.RSTACT[1:0] dictates the reset action to be performed by the software if any. If RSTVAL=0: when the RSTF is asserted (and/or the corresponding interrupt if enabled), the software should issue an I3C reset after a first detected reset pattern, and a system reset on the second one.
        RSTVAL: u1,
        padding: u7 = 0,
    }),
    /// I3C device 1 characteristics register.
    /// offset: 0x64
    DEVR: [4]mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// assigned I3C dynamic address to target x (when the I3C is acting as controller) When the I3C is acting as controller, this field should be written by software to store the 7-bit dynamic address that the controller sends via a broadcast ENTDAA or a direct SETNEWDA CCC which has been acknowledged by the target x. Writing to this field has no impact when the read field I3C_DEVRx.DIS=1.
        DA: u7,
        reserved16: u8 = 0,
        /// IBI request acknowledge (when the I3C is acting as controller) When the I3C is acting as controller, this bit is written by software to define the acknowledge policy to be applied on the I3C bus on the reception of a IBI request from target x: - After the NACK, the message continues as initially programmed (the target is aware of the NACK and can emit another IBI request later on) - The field DIS is asserted by hardware to protect DA[6:0] from being modified by software meanwhile the hardware can store internally the current DA[6:0] into the kernel clock domain. - After the ACK, the controller logs the IBI payload data, if any, depending on I3C_DEVRx.IBIDEN. - The software is notified by the IBI flag (i.e. I3C_EVR.IBIF=1) and/or the corresponding interrupt if enabled; - Independently from IBIACK configuration for this or other devices, further IBI request(s) are NACKed until IBI request flag (i.e. I3C_EVR.IBIF) and controller-role request flag (i.e. I3C_EVR.CRF) are both cleared.
        IBIACK: ACK,
        /// controller-role request acknowledge (when the I3C is acting as controller) When the I3C is acting as controller, this bit is written by software to define the acknowledge policy to be applied on the I3C bus on the reception of a controller-role request from target x: After the NACK, the message continues as initially programmed (the target is aware of the NACK and can emit another controller-role request later on) - The field DIS is asserted by hardware to protect DA[6:0] from being modified by software meanwhile the hardware can store internally the current DA[6:0] into the kernel clock domain. - After the ACK, the message continues as initially programmed. The software is notified by the controller-role request flag (i.e. I3C_EVR.CRF=1) and/or the corresponding interrupt if enabled; For effectively granting the controller-role to the requesting secondary controller, software should issue a GETACCCR (formerly known as GETACCMST), followed by a STOP. - Independently of CRACK configuration for this or other devices, further controller-role request(s) are NACKed until controller-role request flag (i.e. I3C_EVR.CRF) and IBI flag (i.e. I3C_EVR.IBIF) are both cleared.
        CRACK: ACK,
        /// IBI data enable (when the I3C is acting as controller) When the I3C is acting as controller, this bit should be written by software to store the BCR[2] bit as received from the target x during broadcast ENTDAA or direct GETBCR CCC via the received I3C_RDR. Writing to this field has no impact when the read field I3C_DEVRx.DIS=1.
        IBIDEN: u1,
        /// suspend/stop I3C transfer on received IBI (when the I3C is acting as controller) When the I3C is acting as controller, this bit is used to receive an IBI from target x with pending read notification feature (i.e. with received MDB[7:5]=3’b101). If this bit is set, when an IBI is received (i.e. I3C_EVR.IBIF=1), a Stop is emitted on the I3C bus and the C-FIFO is automatically flushed by hardware; to avoid a next private read communication issue if a previous private read message to the target x was stored in the C-FIFO.
        SUSP: u1,
        reserved31: u11 = 0,
        /// DA[6:0] write disabled (when the I3C is acting as controller) When the I3C is acting as controller, once that software set IBIACK=1 or CRACK=1, this read bit is set by hardware (i.e. DIS=1) to lock the configured DA[6:0] and IBIDEN values. Then, to be able to next modify DA[6:0] or IBIDEN, the software must wait for this field DIS to be de-asserted by hardware (i.e. polling on DIS=0) before modifying these two assigned values to the target x. Indeed, the target may be requesting an IBI or a controller-role meanwhile the controller intends to modify DA[6:0] or IBIDEN.
        DIS: DIS,
    }),
    /// offset: 0x74
    reserved116: [28]u8,
    /// I3C maximum read length register.
    /// offset: 0x90
    MAXRLR: mmio.Mmio(packed struct(u32) {
        /// maximum data write length (when I3C is acting as target) This field is initially written by software when I3C_CFGR.EN=0 and updated by hardware on the reception of SETMWL command. Software is notified of a MWL update by the I3C_EVR.MWLUPF and the corresponding interrupt if enabled. This field is used by hardware to return the value on the I3C bus when the target receives a GETMWL CCC.
        ML: u16,
        /// IBI payload data size, in bytes (when I3C is acting as target) This field is initially written by software when I3C_CFGR.EN=0 to set the number of data bytes to be sent to the controller after an IBI request has been acknowledged.This field may be updated by hardware on the reception of SETMRL command (which potentially also updated IBIP[2:0]). Software is notified of a MRL update by the I3C_EVR.MRLUPF and the corresponding interrupt if enabled. others: same as 100.
        IBIP: u3,
        padding: u13 = 0,
    }),
    /// I3C maximum write length register.
    /// offset: 0x94
    MAXWLR: mmio.Mmio(packed struct(u32) {
        /// maximum data write length (when I3C is acting as target) This field is initially written by software when I3C_CFGR.EN=0 and updated by hardware on the reception of SETMWL command. Software is notified of a MWL update by the I3C_EVR.MWLUPF and the corresponding interrupt if enabled. This field is used by hardware to return the value on the I3C bus when the target receives a GETMWL CCC.
        ML: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x98
    reserved152: [8]u8,
    /// I3C timing register 0.
    /// offset: 0xa0
    TIMINGR0: mmio.Mmio(packed struct(u32) {
        /// SCL low duration in I3C push-pull phases, in number of kernel clocks cycles: tSCLL_PP = (SCLL_PP + 1) x tI3CCLK SCLL_PP is used to generate tLOW (I3C) timing.
        SCLL_PP: u8,
        /// SCL high duration, used for I3C messages (both in push-pull and open-drain phases), in number of kernel clocks cycles: tSCLH_I3C = (SCLH_I3C + 1) x tI3CCLK SCLH_I3C is used to generate both tHIGH (I3C) and tHIGH_MIXED timings.
        SCLH_I3C: u8,
        /// SCL low duration in open-drain phases, used for legacy I2C commands and for I3C open-drain phases (address header phase following a START, not a Repeated START), in number of kernel clocks cycles: tSCLL_OD = (SCLL_OD + 1) x tI3CCLK SCLL_OD is used to generate both tLOW (I2C) and tLOW_OD timings (max. of the two).
        SCLL_OD: u8,
        /// SCL high duration, used for legacy I2C commands, in number of kernel clocks cycles: tSCLH_I2C = (SCLH_I2C + 1) x tI3CCLK SCLH_I2C is used to generate tHIGH (I2C) timing.
        SCLH_I2C: u8,
    }),
    /// I3C timing register 1.
    /// offset: 0xa4
    TIMINGR1: mmio.Mmio(packed struct(u32) {
        /// number of kernel clock cycles, that is used whatever I3C is acting as controller or target, to set the following MIPI I3C timings, like bus available condition time: When the I3C is acting as target: for bus available condition time: it must wait for (bus available condition) time to be elapsed after a stop and before issuing a start request for an IBI or a controller-role request (i.e. bus free condition is sustained for at least tAVAL). refer to MIPI timing tAVAL = 1 �s. This timing is defined by: tAVAL = (AVAL[7:0] + 2) x tI3CCLK for bus idle condition time: it must wait for (bus idle condition) time to be elapsed after that both SDA and SCL are continuously high and stable before issuing a hot-join event. Refer to MIPI v1.1 timing tIDLE = 200 �s . This timing is defined by: tIDLE = (AVAL[7:0] + 2) x 200 x tI3CCLK When the I3C is acting as controller, it can not stall the clock beyond a maximum stall time (i.e. stall the SCL clock low), as follows: on first bit of assigned address during dynamic address assignment: it can not stall the clock beyond the MIPI timing tSTALLDAA = 15 ms. This timing is defined by: tSTALLDAA = (AVAL[7:0] + 1) x 15000 x tI3CCLK on ACK/NACK phase of I3C/I2C transfer, on parity bit of write data transfer, on transition bit of I3C read transfer: it can not stall the clock beyond the MIPI timing tSTALL = 100 �s. This timing is defined by: tSTALL = (AVAL[7:0] + 1) x 100 x tI3CCLK Whatever the I3C is acting as controller or as (controller-capable) target, during a controller-role hand-off procedure: The new controller must wait for a time (refer to MIPI timing tNEWCRLock) before pulling SDA low (i.e. issuing a start). And the active controller must wait for the same time while monitoring new controller and before testing the new controller by pulling SDA low. This time to wait is dependent on the defined I3C_TIMINGR1.ANSCR[1:0], as follows: If ASNCR[1:0]=00: tNEWCRLock = (AVAL[7:0] + 1) x tI3CCLK If ASNCR[1:0]=01: tNEWCRLock = (AVAL[7:0] + 1) x 100 x tI3CCLK If ASNCR[1:0]=10: tNEWCRLock = (AVAL[7:0] + 1) x 2000 x tI3CCLK If ASNCR[1:0]=11: tNEWCRLock = (AVAL[7:0] + 1) x 50000 x tI3CCLK.
        AVAL: u8,
        /// activity state of the new controller (when I3C is acting as - active- controller) This field indicates the time to wait before being accessed as new target, refer to the other field AVAL[7:0]. This field can be modified only when the I3C is acting as controller.
        ASNCR: u2,
        reserved16: u6 = 0,
        /// number of kernel clocks cycles that is used to set some MIPI timings like bus free condition time (when the I3C is acting as controller) When the I3C is acting as controller: for I3C start timing: it must wait for (bus free condition) time to be elapsed after a stop and before a start, refer to MIPI timings (I3C) tCAS and (I2C) tBUF. These timings are defined by: tBUF= tCAS = [ (FREE[6:0] + 1) x 2 - (0,5 + SDA_HD)] x tI3CCLK Note: for pure I3C bus: tCASmin= 38,4 ns. Note: for pure I3C bus: tCASmax=1�s, 100�s, 2ms, 50ms for respectively ENTAS0,1,2, and 3. Note: for mixed bus with I2C fm+ device: tBUFmin = 0,5 �s. Note: for mixed bus with I2C fm device: tBUFmin = 1,3 �s. for I3C repeated start timing: it must wait for time to be elapsed after a repeated start (i.e. SDA is de-asserted) and before driving SCL low, refer to. MIPI timing tCASr. This timing is defined by: tCASr = [ (FREE[6:0] + 1) x 2 - (0,5 + SDA_HD)] x tI3CCLK for I3C stop timing: it must wait for time to be elapsed after that the SCL clock is driven high and before the stop condition (i.e. SDA is asserted). This timing is defined by: tCBP = (FREE[6:0] + 1) x tI3CCLK for I3C repeated start timing (T-bit when controller ends read with repeated start followed by stop): it must wait for time to be elapsed after that the SCL clock is driven high and before the repeated start condition (i.e. SDA is de-asserted). This timing is defined by: tCBSr = (FREE[6:0] + 1) x tI3CCLK.
        FREE: u7,
        reserved28: u5 = 0,
        /// SDA hold time (when the I3C is acting as controller), in number of kernel clocks cycles (refer to MIPI timing SDA hold time in push-pull tHD_PP):.
        SDA_HD: u1,
        padding: u3 = 0,
    }),
    /// I3C timing register 2.
    /// offset: 0xa8
    TIMINGR2: mmio.Mmio(packed struct(u32) {
        /// Controller clock stall on T-bit phase of Data enable The SCL is stalled during STALL x tSCLL_PP in the T-bit phase (before 9th bit). This allows the target to prepare data to be sent.
        STALLT: u1,
        /// controller clock stall on PAR phase of Data enable The SCL is stalled during STALL x tSCLL_PP in the T-bit phase (before 9th bit). This allows the target to read received data.
        STALLD: u1,
        /// controller clock stall on PAR phase of CCC enable The SCL is stalled during STALL x tSCLL_PP in the T-bit phase of common command code (before 9th bit). This allows the target to decode the command.
        STALLC: u1,
        /// controller clock stall enable on ACK phase The SCL is stalled (during tSCLL_STALLas defined by STALL) in the address ACK/NACK phase (before 9th bit). This allows the target to prepare data or the controller to respond to target interrupt.
        STALLA: u1,
        reserved8: u4 = 0,
        /// controller clock stall time, in number of kernel clock cycles tSCLL_STALL = STALL x tI3CCLK.
        STALL: u8,
        padding: u16 = 0,
    }),
    /// offset: 0xac
    reserved172: [20]u8,
    /// I3C bus characteristics register.
    /// offset: 0xc0
    BCR: mmio.Mmio(packed struct(u32) {
        /// max data speed limitation.
        BCR0: u1,
        reserved2: u1 = 0,
        /// in-band interrupt (IBI) payload.
        BCR2: u1,
        reserved6: u3 = 0,
        /// controller capable.
        BCR6: u1,
        padding: u25 = 0,
    }),
    /// I3C device characteristics register.
    /// offset: 0xc4
    DCR: mmio.Mmio(packed struct(u32) {
        /// device characteristics ID others: ID to describe the type of the I3C sensor/device Note: The latest MIPI DCR ID assignments are available at: https://www.mipi.org/MIPI_I3C_device_characteristics_register.
        DCR: u8,
        padding: u24 = 0,
    }),
    /// I3C get capability register.
    /// offset: 0xc8
    GETCAPR: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// IBI MDB support for pending read notification This bit is written by software during bus initialization (i.e. I3C_CFGR.EN=0) and indicates the support (or not) of the pending read notification via the IBI MDB[7:0] value. This bit is used to return the GETCAP3 byte in response to the GETCAPS CCC format 1.
        CAPPEND: u1,
        padding: u17 = 0,
    }),
    /// I3C controller-role capability register.
    /// offset: 0xcc
    CRCAPR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// delayed controller-role hand-off This bit is written by software during bus initialization (i.e. I3C_CFGR.EN=0) and indicates if this target I3C may need additional time to process a controller-role hand-off requested by the current controller. This bit is used to return the CRCAP2 byte in response to the GETCAPS CCC format 2.
        CAPDHOFF: u1,
        reserved9: u5 = 0,
        /// group management support (when acting as controller) This bit is written by software during bus initialization (i.e. I3C_CFGR.EN=0) and indicates if the I3C is able to support group management when it acts as a controller (after controller-role hand-off) via emitted DEFGRPA, RSTGRPA, and SETGRPA CCC. This bit is used to return the CRCAP1 byte in response to the GETCAPS CCC format 2.
        CAPGRP: u1,
        padding: u22 = 0,
    }),
    /// I3C get capability register.
    /// offset: 0xd0
    GETMXDSR: mmio.Mmio(packed struct(u32) {
        /// controller hand-off activity state This bit is written by software during bus initialization (i.e. I3C_CFGR.EN=0) and indicates in which initial activity state the (other) current controller should expect the I3C bus after a controller-role hand-off to this controller-capable I3C, when returning the defining byte CRHDLY (0x91) to a GETMXDS CCC. This 2-bit field is used to return the CRHDLY1 byte in response to the GETCAPS CCC format 3, in order to state which is the activity state of this I3C when becoming controller after a controller-role hand-off, and consequently the time the former controller should wait before testing this I3C to be confirmed its ownership.
        HOFFAS: u2,
        reserved8: u6 = 0,
        /// GETMXDS CCC format.
        FMT: u2,
        reserved16: u6 = 0,
        /// programmed byte of the 3-byte MaxRdTurn (maximum read turnaround byte) This bit is written by software during bus initialization (i.e. I3C_CFGR.EN=0) and writes the value of the selected byte (via the FMT[1:0] field) of the 3-byte MaxRdTurn which is returned in response to the GETMXDS CCC format 2 to encode the maximum read turnaround time.
        RDTURN: u8,
        /// clock-to-data turnaround time (tSCO) This bit is written by software during bus initialization (i.e. I3C_CFGR.EN=0) and is used to specify the clock-to-data turnaround time tSCO (vs the value of 12 ns). This bit is used by the hardware in response to the GETMXDS CCC to return the encoded clock-to-data turnaround time via the returned MaxRd[5:3] bits.
        TSCO: u1,
        padding: u7 = 0,
    }),
    /// I3C extended provisioned ID register.
    /// offset: 0xd4
    EPIDR: mmio.Mmio(packed struct(u32) {
        reserved12: u12 = 0,
        /// 4-bit MIPI Instance ID This field is written by software to set and identify individually each instance of this I3C IP with a specific number on a single I3C bus. This field represents the bits[15:12] of the 48-bit provisioned ID. Note: The bits[11:0] of the provisioned ID may be 0.
        MIPIID: u4,
        /// provisioned ID type selector This field is set as 0 i.e. vendor fixed value. This field represents the bit[32] of the 48-bit provisioned ID. Note: The bits[31:16] of the provisioned ID may be 0.
        IDTSEL: u1,
        /// 15-bit MIPI manufacturer ID This read field is the 15-bit STMicroelectronics MIPI ID i.e. 0x0104. This field represents the bits[47:33] of the 48-bit provisioned ID.
        MIPIMID: u15,
    }),
};
