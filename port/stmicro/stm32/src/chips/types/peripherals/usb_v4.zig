const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const DIR = enum(u1) {
    /// data transmitted by the USB peripheral to the host PC
    To = 0x0,
    /// data received by the USB peripheral from the host PC
    From = 0x1,
};

pub const EP_TYPE = enum(u2) {
    /// Bulk endpoint
    Bulk = 0x0,
    /// Control endpoint
    Control = 0x1,
    /// Iso endpoint
    Iso = 0x2,
    /// Interrupt endpoint
    Interrupt = 0x3,
};

pub const LPMACK = enum(u1) {
    /// The valid LPM Token will be NYET / NYET answer
    Nyet = 0x0,
    /// The valid LPM Token will be ACK / ACK answer
    Ack = 0x1,
};

pub const SDET = enum(u1) {
    /// CDP detected
    CDP = 0x0,
    /// DCP detected
    DCP = 0x1,
};

pub const STAT = enum(u2) {
    /// all requests addressed to this endpoint are ignored
    Disabled = 0x0,
    /// the endpoint is stalled and all requests result in a STALL handshake
    Stall = 0x1,
    /// the endpoint is naked and all requests result in a NAK handshake
    Nak = 0x2,
    /// this endpoint is enabled, requests are ACKed
    Valid = 0x3,
};

/// Universal serial bus full-speed host/device interface
pub const USB = extern struct {
    /// endpoint/channel
    /// offset: 0x00
    EPR: [8]mmio.Mmio(packed struct(u32) {
        /// endpoint/channel address Device mode Software must write in this field the 4-bit address used to identify the transactions directed to this endpoint. A value must be written before enabling the corresponding endpoint. Host mode Software must write in this field the 4-bit address used to identify the channel addressed by the host transaction.
        EA: u4,
        /// Status bits, for transmission transfers Device mode These bits contain the information about the endpoint status, listed in . These bits can be toggled by the software to initialize their value. When the application software writes '0, the value remains unchanged, while writing '1 makes the bit value toggle. Hardware sets the STTX bits to NAK, when a correct transfer has occurred (VTTX=1) corresponding to a IN or SETUP (control only) transaction addressed to this channel/endpoint. It then waits for the software to prepare the next set of data to be transmitted. Double-buffered bulk endpoints implement a special transaction flow control, which controls the status based on buffer availability condition (Refer to endpoints). If the endpoint is defined as Isochronous, its status can only be VALID or DISABLED. Therefore, the hardware cannot change the status of the channel/endpoint/channel after a successful transaction. If the software sets the STTX bits to STALL or NAK for an Isochronous channel/endpoint, the USB peripheral behavior is not defined. These bits are read/write but they can be only toggled by writing '1. Host mode Same as STRX behaviour but for IN transactions (TBC)
        STAT_TX: STAT,
        /// Data Toggle, for transmission transfers If the endpoint/channel is non-isochronous, this bit contains the required value of the data toggle bit (0=DATA0, 1=DATA1) for the next data packet to be transmitted. Hardware toggles this bit when the ACK handshake is received from the USB host, following a data packet transmission. If the endpoint/channel is defined as a control one, hardware sets this bit to 1 at the reception of a SETUP PID addressed to this endpoint. If the endpoint/channel is using the double buffer feature, this bit is used to support packet buffer swapping too (Refer to ) If the endpoint/channel is Isochronous, this bit is used to support packet buffer swapping since no data toggling is used for this sort of endpoints and only DATA0 packet are transmitted (Refer to ). Hardware toggles this bit just after the end of data packet transmission, since no handshake is used for Isochronous transfers. This bit can also be toggled by the software to initialize its value (mandatory when the endpoint/channel is not a control one) or to force a specific data toggle/packet buffer usage. When the application software writes '0, the value of DTOGTX remains unchanged, while writing '1 makes the bit value toggle. This bit is read/write but it can only be toggled by writing 1.
        DTOG_TX: u1,
        /// Valid USB transaction transmitted Device mode This bit is set by the hardware when an IN transaction is successfully completed on this endpoint; the software can only clear this bit. If the CTRM bit in the USB_CNTR register is set accordingly, a generic interrupt condition is generated together with the endpoint related interrupt condition, which is always activated. A transaction ended with a NAK or STALL handshake does not set this bit, since no data is actually transferred, as in the case of protocol errors or data toggle mismatches. This bit is read/write but only '0 can be written. Host mode Same of VTRX behaviour but for USB OUT and SETUP transactions.
        CTR_TX: u1,
        /// endpoint/channel kind The meaning of this bit depends on the endpoint/channel type configured by the EP_TYPE bits. summarizes the different meanings. DBL_BUF: This bit is set by the software to enable the double-buffering feature for this bulk endpoint. The usage of double-buffered bulk endpoints is explained in Double-buffered endpoints. STATUS_OUT: This bit is set by the software to indicate that a status out transaction is expected: in this case all OUT transactions containing more than zero data bytes are answered STALL instead of ACK. This bit may be used to improve the robustness of the application to protocol errors during control transfers and its usage is intended for control endpoints only. When STATUS_OUT is reset, OUT transactions can have any number of bytes, as required.
        EP_KIND: u1,
        /// USB type of transaction These bits configure the behavior of this endpoint/channel as described in endpoint/channel type encoding on page 2001. Channel0/Endpoint0 must always be a control endpoint/channel and each USB function must have at least one control endpoint/channel which has address 0, but there may be other control channels/endpoints if required. Only control channels/endpoints handle SETUP transactions, which are ignored by endpoints of other kinds. SETUP transactions cannot be answered with NAK or STALL. If a control endpoint/channel is defined as NAK, the USB peripheral will not answer, simulating a receive error, in the receive direction when a SETUP transaction is received. If the control endpoint/channel is defined as STALL in the receive direction, then the SETUP packet will be accepted anyway, transferring data and issuing the CTR interrupt. The reception of OUT transactions is handled in the normal way, even if the endpoint/channel is a control one. Bulk and interrupt endpoints have very similar behavior and they differ only in the special feature available using the EPKIND configuration bit. The usage of Isochronous channels/endpoints is explained in transfers
        EP_TYPE: EP_TYPE,
        /// Setup transaction completed Device mode This bit is read-only and it is set by the hardware when the last completed transaction is a SETUP. This bit changes its value only for control endpoints. It must be examined, in the case of a successful receive transaction (VTRX event), to determine the type of transaction occurred. To protect the interrupt service routine from the changes in SETUP bits due to next incoming tokens, this bit is kept frozen while VTRX bit is at 1; its state changes when VTRX is at 0. This bit is read-only. Host mode This bit is set by the software to send a SETUP transaction on a control endpoint. This bit changes its value only for control endpoints. It is cleared by hardware when the SETUP transaction is acknowledged and VTTX interrupt generated.
        SETUP: u1,
        /// Status bits, for reception transfers Device mode These bits contain information about the endpoint status, which are listed in Reception status encoding on page 2000.These bits can be toggled by software to initialize their value. When the application software writes '0, the value remains unchanged, while writing '1 makes the bit value toggle. Hardware sets the STRX bits to NAK when a correct transfer has occurred (VTRX=1) corresponding to a OUT or SETUP (control only) transaction addressed to this endpoint, so the software has the time to elaborate the received data before it acknowledge a new transaction Double-buffered bulk endpoints implement a special transaction flow control, which control the status based upon buffer availability condition (Refer to endpoints). If the endpoint is defined as Isochronous, its status can be only VALID or DISABLED, so that the hardware cannot change the status of the endpoint after a successful transaction. If the software sets the STRX bits to 'STALL or 'NAK for an Isochronous endpoint, the USB peripheral behavior is not defined. These bits are read/write but they can be only toggled by writing '1. Host mode These bits are the host application controls to start, retry, or abort host transactions driven by the channel. These bits also contain information about the device answer to the last IN channel transaction and report the current status of the channel according to the following STRX table of states: - DISABLE DISABLE value is reported in case of ACK acknowledge is received on a single-buffer channel. When in DISABLE state the channel is unused or not active waiting for application to restart it by writing VALID. Application can reset a VALID channel to DISABLE to abort a transaction. In this case the transaction is immediately removed from the Host execution list. If the aborted transaction was already under execution it will be regularly terminated on the USB but the relative VTRX interrupt is not generated. - VALID An Host channel is actively trying to submit USB transaction to device only when in VALID state.VALID state can be set by software or automatically by hardware on a NAKED channel at the start of a new frame. When set to VALID, an host channel enters the host execution queue and waits permission from the Host Frame Schedure to submit its configured transaction. VALID value is also reported in case of ACK acknowledge is received on a double-buffered channel. In this case the channel remains active on the alternate buffer while application needs to read the current buffer and toggle DTOGTX. In case software is late in reading and the alternate buffer is not ready, the host channel is automatically suspended transparently to the application. The suspended double buffered channel will be re-activated as soon as delay is recovered and DTOGTX is toggled. - NAK NAK value is reported in case of NAK acknowledge received. When in NAK state the channel is suspended and does not try to transmit. NAK state is moved to VALID by hardware at the start of the next frame, or software can change it to immediately retry transmission by writing it to VALID, or can disable it and abort the transaction by writing DISABLE - STALL STALL value is reported in case of STALL acknowledge received. When in STALL state the channel behaves as disabled. Application should not retry transmission but reset the USB and re-enumerate.
        STAT_RX: STAT,
        /// Data Toggle, for reception transfers If the endpoint/channel is not Isochronous, this bit contains the expected value of the data toggle bit (0=DATA0, 1=DATA1) for the next data packet to be received. Hardware toggles this bit, when the ACK handshake is sent following a data packet reception having a matching data PID value; if the endpoint is defined as a control one, hardware clears this bit at the reception of a SETUP PID received from host (in device) or acknowledged by device (in host). If the endpoint/channel is using the double-buffering feature this bit is used to support packet buffer swapping too (Refer to ). If the endpoint/channel is Isochronous, this bit is used only to support packet buffer swapping for data transmission since no data toggling is used for this kind of channels/endpoints and only DATA0 packet are transmitted (Refer to Isochronous transfers). Hardware toggles this bit just after the end of data packet reception, since no handshake is used for isochronous transfers. This bit can also be toggled by the software to initialize its value (mandatory when the endpoint is not a control one) or to force specific data toggle/packet buffer usage. When the application software writes '0, the value of DTOGRX remains unchanged, while writing '1 makes the bit value toggle. This bit is read/write but it can be only toggled by writing 1.
        DTOG_RX: u1,
        /// USB valid transaction received Device mode This bit is set by the hardware when an OUT/SETUP transaction is successfully completed on this endpoint; the software can only clear this bit. If the CTRM bit in USB_CNTR register is set accordingly, a generic interrupt condition is generated together with the endpoint related interrupt condition, which is always activated. The type of occurred transaction, OUT or SETUP, can be determined from the SETUP bit described below. A transaction ended with a NAK or STALL handshake does not set this bit, since no data is actually transferred, as in the case of protocol errors or data toggle mismatches. This bit is read/write but only '0 can be written, writing 1 has no effect. Host mode This bit is set by the hardware when an IN transaction is successfully completed on this channel. The software can only clear this bit. If the VTRM bit in USB_CNTR register is set a generic interrupt condition is generated together with the channel related flag, which is always activated. - A transaction ended with a NAK sets this bit and NAK answer is reported to application reading the NAK state from the STRX field of this register. One naked transaction keeps pending and is automatically retried by the Host at the next frame, or the Host can immediately retry by resetting STRX state to VALID. - A transaction ended by STALL handshake sets this bit and the STALL answer is reported to application reading the STALL state from the STRX field of this register. Host application should consequently disable the channel and re-enumerate. - A transaction ended with ACK handshake sets this bit If double buffering is disabled, ACK answer is reported by application reading the DISABLE state from the STRX field of this register. Host application should read received data from USBRAM and re-arm the channel by writing VALID to the STRX field of this register. If double buffering is enabled, ACK answer is reported by application reading VALID state from the STRX field of this register. Host application should read received data from USBRAM and toggle the DTOGTX bit of this register. This bit is read/write but only '0 can be written, writing 1 has no effect.
        CTR_RX: u1,
        /// Host mode Device address assigned to the endpoint during the enumeration process.
        DEVADDR: u7,
        /// Host mode This bit is set by the hardware when a device responds with a NAK. Software can be use this bit to monitoring the number of NAKs received from a device.
        NAK: u1,
        /// Low speed endpoint Host with HUB only Host mode This bit is set by the software to send an LS transaction to the corresponding endpoint.
        LS_EP: u1,
        /// Transmit error Host mode This bit is set by the hardware when an error (e.g. no answer by the device, CRC error, bit stuffing error, framing format violation, etc.) has occurred during an OUT or SETUP transaction on this channel. The software can only clear this bit. If the ERRM bit in USB_CNTR register is set a generic interrupt condition is generated together with the channel related flag, which is always activated.
        ERR_TX: u1,
        /// Receive error Host mode This bit is set by the hardware when an error (e.g. no answer by the device, CRC error, bit stuffing error, framing format violation, etc.) has occurred during an IN transaction on this channel. The software can only clear this bit. If the ERRM bit in USB_CNTR register is set a generic interrupt condition is generated together with the channel related flag, which is always activated.
        ERR_RX: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x20
    reserved32: [32]u8,
    /// control register
    /// offset: 0x40
    CNTR: mmio.Mmio(packed struct(u32) {
        /// Force a reset of the USB peripheral, exactly like a RESET signaling on the USB
        FRES: u1,
        /// Power down This bit is used to completely switch off all USB-related analog parts if it is required to completely disable the USB peripheral for any reason. When this bit is set, the USB peripheral is disconnected from the transceivers and it cannot be used.
        PDWN: u1,
        /// Suspend state effective This bit is set by hardware as soon as the suspend state entered through the SUSPEN control gets internally effective. In this state USB activity is suspended, USB clock is gated, transceiver is set in low power mode by disabling the differential receiver. Only asynchronous wakeup logic and single ended receiver is kept alive to detect remote wakeup or resume events. Software must poll this bit to confirm it to be set before any STOP mode entry. This bit is cleared by hardware simultaneously to the WAKEUP flag being set.
        LPMODE: u1,
        /// Suspend state enable Device mode Software can set this bit when the SUSP interrupt is received, which is issued when no traffic is received by the USB peripheral for 3 ms. Software can also set this bit when the L1REQ interrupt is received with positive acknowledge sent. As soon as the suspend state is propagated internally all device activity is stopped, USB clock is gated, USB transceiver is set into low power mode and the SUSPRDY bit is set by hardware. In the case that device application wants to purse more aggressive power saving by stopping the USB clock source and by moving the microcontroller to stop mode, as in the case of bus powered device application, it must first wait few cycles to see the SUSPRDY=1 acknowledge the suspend request. This bit is cleared by hardware simultaneous with the WAKEUP flag set. Host mode Software can set this bit when Host application has nothing scheduled for the next frames and wants to enter long term power saving. When set, it stops immediately SOF generation and any other host activity, gates the USB clock and sets the transceiver in low power mode. If any USB transaction is on-going at the time SUSPEN is set, suspend is entered at the end of the current transaction. As soon as suspend state is propagated internally and gets effective the SUSPRDY bit is set. In the case that host application wants to purse more aggressive power saving by stopping the USB clock source and by moving the micro-controller to STOP mode, it must first wait few cycles to see SUSPRDY=1 acknowledge to the suspend request. This bit is cleared by hardware simultaneous with the WAKEUP flag set.
        FSUSP: u1,
        /// L2 Remote Wakeup / Resume driver Device mode The microcontroller can set this bit to send remote wake-up signaling to the Host. It must be activated, according to USB specifications, for no less than 1ms and no more than 15ms after which the Host PC is ready to drive the resume sequence up to its end. Host mode Software sets this bit to send resume signaling to the device. Software clears this bit to send end of resume to device and restart SOF generation. In the context of remote wake up, this bit is to be set following the WAKEUP interrupt.
        RESUME: u1,
        /// L1 Remote Wakeup / Resume driver Device mode Software sets this bit to send a LPM L1 50us remote wakeup signaling to the host. After the signaling ends, this bit is cleared by hardware. Host mode Software sets this bit to send L1 resume signaling to device. Resume duration and next SOF generation is automatically driven to set the restart of USB activity timely aligned with the programmed BESL value. In the context of remote wake up, this bit is to be set following the WAKEUP interrupt. This bit is cleared by hardware at the end of resume.
        L1RESUME: u1,
        reserved7: u1 = 0,
        /// LPM L1 state request interrupt mask
        L1REQM: u1,
        /// Expected start of frame interrupt mask
        ESOFM: u1,
        /// Start of frame interrupt mask
        SOFM: u1,
        /// reset interrupt mask
        RESETM: u1,
        /// Suspend mode interrupt mask
        SUSPM: u1,
        /// Wakeup interrupt mask
        WKUPM: u1,
        /// Error interrupt mask
        ERRM: u1,
        /// Packet memory area over / underrun interrupt mask
        PMAOVRM: u1,
        /// CTR Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        CTRM: u1,
        /// 512 byte threshold interrupt mask
        THR512M: u1,
        reserved31: u14 = 0,
        /// HOST mode HOST bit selects betweens Host or Device USB mode of operation. It must be set before enabling the USB peripheral by the function enable bit.
        HOST: u1,
    }),
    /// interrupt status register
    /// offset: 0x44
    ISTR: mmio.Mmio(packed struct(u32) {
        /// Device Endpoint / Host channel identification number These bits are written by the hardware according to the host channel or device endpoint number, which generated the interrupt request. If several endpoint/channel transactions are pending, the hardware writes the identification number related to the endpoint/channel having the highest priority defined in the following way: Two levels are defined, in order of priority: Isochronous and double-buffered bulk channels/endpoints are considered first and then the others are examined. If more than one endpoint/channel from the same set is requesting an interrupt, the IDN bits in USB_ISTR register are assigned according to the lowest requesting register, CHEP0R having the highest priority followed by CHEP1R and so on. The application software can assign a register to each endpoint/channel according to this priority scheme, so as to order the concurring endpoint/channel requests in a suitable way. These bits are read only.
        EP_ID: u4,
        /// Direction of transaction This bit is written by the hardware according to the direction of the successful transaction, which generated the interrupt request. If DIR bit=0, VTTX bit is set in the USB_EPnR register related to the interrupting endpoint. The interrupting transaction is of IN type (data transmitted by the USB peripheral to the host PC). If DIR bit=1, VTRX bit or both VTTX/VTRX are set in the USB_EPnR register related to the interrupting endpoint. The interrupting transaction is of OUT type (data received by the USB peripheral from the host PC) or two pending transactions are waiting to be processed. This information can be used by the application software to access the USB_EPnR bits related to the triggering transaction since it represents the direction having the interrupt pending. This bit is read-only.
        DIR: DIR,
        reserved7: u2 = 0,
        /// LPM L1 state request This bit is set by the hardware when LPM command to enter the L1 state is successfully received and acknowledged. This bit is read/write but only '0 can be written and writing '1 has no effect.
        L1REQ: u1,
        /// Expected start of frame This bit is set by the hardware when an SOF packet is expected but not received. The host sends an SOF packet each 1 ms, but if the device does not receive it properly, the Suspend Timer issues this interrupt. If three consecutive ESOF interrupts are generated (i.e. three SOF packets are lost) without any traffic occurring in between, a SUSP interrupt is generated. This bit is set even when the missing SOF packets occur while the Suspend Timer is not yet locked. This bit is read/write but only '0 can be written and writing '1 has no effect.
        ESOF: u1,
        /// Start of frame This bit signals the beginning of a new USB frame and it is set when a SOF packet arrives through the USB bus. The interrupt service routine may monitor the SOF events to have a 1 ms synchronization event to the USB host and to safely read the USB_FNR register which is updated at the SOF packet reception (this could be useful for isochronous applications). This bit is read/write but only '0 can be written and writing '1 has no effect.
        SOF: u1,
        /// reset request Device mode This bit is set by hardware when an USB reset is released by the host and the bus returns to idle. USB reset state is internally detected after the sampling of 60 consecutive SE0 cycles. Host mode This bit is set by hardware when device connection or device disconnection is detected. Device connection is signaled after J state is sampled for 22cycles consecutively from unconnected state. Device disconnection is signaled after SE0 state is sampled for 22cycles consecutively from connected state.
        RESET: u1,
        /// Suspend mode request This bit is set by the hardware when no traffic has been received for 3 ms, indicating a suspend mode request from the USB bus. The suspend condition check is enabled immediately after any USB reset and it is disabled by the hardware when the suspend mode is active (SUSPEN=1) until the end of resume sequence. This bit is read/write but only '0 can be written and writing '1 has no effect.
        SUSP: u1,
        /// Wakeup This bit is set to 1 by the hardware when, during suspend mode, activity is detected that wakes up the USB peripheral. This event asynchronously clears the LP_MODE bit in the CTLR register and activates the USB_WAKEUP line, which can be used to notify the rest of the device (e.g. wakeup unit) about the start of the resume process. This bit is read/write but only '0 can be written and writing '1 has no effect.
        WKUP: u1,
        /// Error This flag is set whenever one of the errors listed below has occurred: NANS: No ANSwer. The timeout for a host response has expired. CRC: Cyclic Redundancy Check error. One of the received CRCs, either in the token or in the data, was wrong. BST: Bit Stuffing error. A bit stuffing error was detected anywhere in the PID, data, and/or CRC. FVIO: Framing format Violation. A non-standard frame was received (EOP not in the right place, wrong token sequence, etc.). The USB software can usually ignore errors, since the USB peripheral and the PC host manage retransmission in case of errors in a fully transparent way. This interrupt can be useful during the software development phase, or to monitor the quality of transmission over the USB bus, to flag possible problems to the user (e.g. loose connector, too noisy environment, broken conductor in the USB cable and so on). This bit is read/write but only '0 can be written and writing '1 has no effect.
        ERR: u1,
        /// Packet memory area over / underrun This bit is set if the microcontroller has not been able to respond in time to an USB memory request. The USB peripheral handles this event in the following way: During reception an ACK handshake packet is not sent, during transmission a bit-stuff error is forced on the transmitted stream; in both cases the host will retry the transaction. The PMAOVR interrupt should never occur during normal operations. Since the failed transaction is retried by the host, the application software has the chance to speed-up device operations during this interrupt handling, to be ready for the next transaction retry; however this does not happen during Isochronous transfers (no isochronous transaction is anyway retried) leading to a loss of data in this case. This bit is read/write but only '0 can be written and writing '1 has no effect.
        PMAOVR: u1,
        /// Correct transfer This bit is set by the hardware to indicate that an endpoint/channel has successfully completed a transaction; using DIR and EP_ID bits software can determine which endpoint/channel requested the interrupt. This bit is read-only.
        CTR: u1,
        /// 512 byte threshold interrupt This bit is set to 1 by the hardware when 512 bytes have been transmitted or received during isochronous transfers. This bit is read/write but only 0 can be written and writing 1 has no effect. Note that no information is available to indicate the associated channel/endpoint, however in practice only one ISO endpoint/channel with such large packets can be supported, so that channel.
        THR512: u1,
        reserved29: u12 = 0,
        /// Device connection status Host mode: This bit contains information about device connection status. It is set by hardware when a LS/FS device is attached to the host while it is reset when the device is disconnected.
        DCON_STAT: u1,
        /// Low Speed device connected Host mode: This bit is set by hardware when an LS device connection is detected. Device connection is signaled after LS J-state is sampled for 22 consecutive cycles of the USB clock (48 MHz) from the unconnected state.
        LS_DCON: u1,
        padding: u1 = 0,
    }),
    /// frame number register
    /// offset: 0x48
    FNR: mmio.Mmio(packed struct(u32) {
        /// Frame number This bit field contains the 11-bits frame number contained in the last received SOF packet. The frame number is incremented for every frame sent by the host and it is useful for Isochronous transfers. This bit field is updated on the generation of an SOF interrupt.
        FN: u11,
        /// Lost SOF Device mode These bits are written by the hardware when an ESOF interrupt is generated, counting the number of consecutive SOF packets lost. At the reception of an SOF packet, these bits are cleared.
        LSOF: u2,
        /// Locked Device mode This bit is set by the hardware when at least two consecutive SOF packets have been received after the end of an USB reset condition or after the end of an USB resume sequence. Once locked, the frame timer remains in this state until an USB reset or USB suspend event occurs.
        LCK: u1,
        /// Receive data - line status This bit can be used to observe the status of received data minus upstream port data line. It can be used during end-of-suspend routines to help determining the wakeup event.
        RXDM: u1,
        /// Receive data + line status This bit can be used to observe the status of received data plus upstream port data line. It can be used during end-of-suspend routines to help determining the wakeup event.
        RXDP: u1,
        padding: u16 = 0,
    }),
    /// device address
    /// offset: 0x4c
    DADDR: mmio.Mmio(packed struct(u32) {
        /// Device address Device mode These bits contain the USB function address assigned by the host PC during the enumeration process. Both this field and the endpoint/channel Address (EA) field in the associated USB_EPnR register must match with the information contained in a USB token in order to handle a transaction to the required endpoint. Host mode These bits contain the address transmitted with the LPM transaction
        ADD: u7,
        /// Enable function This bit is set by the software to enable the USB device. The address of this device is contained in the following ADD[6:0] bits. If this bit is at '0 no transactions are handled, irrespective of the settings of USB_EPnR registers.
        EF: u1,
        padding: u24 = 0,
    }),
    /// offset: 0x50
    reserved80: [4]u8,
    /// LPM control and status register
    /// offset: 0x54
    LPMCSR: mmio.Mmio(packed struct(u32) {
        /// LPM support enable Device mode This bit is set by the software to enable the LPM support within the USB device. If this bit is at '0 no LPM transactions are handled. Host mode Software sets this bit to transmit an LPM transaction to device. This bit is cleared by hardware, simultaneous with L1REQ flag set, when device answer is received
        LPMEN: u1,
        /// LPM Token acknowledge enable The NYET/ACK will be returned only on a successful LPM transaction: No errors in both the EXT token and the LPM token (else ERROR) A valid bLinkState = 0001B (L1) is received (else STALL) This bit contains the device answer to the LPM transaction. It mast be evaluated following the L1REQ interrupt.
        LPMACK: LPMACK,
        reserved3: u1 = 0,
        /// bRemoteWake value Device mode This bit contains the bRemoteWake value received with last ACKed LPM Token Host mode This bit contains the bRemoteWake value transmitted with the LPM transaction
        REMWAKE: u1,
        /// BESL value Device mode These bits contain the BESL value received with last ACKed LPM Token Host mode These bits contain the BESL value transmitted with the LPM transaction
        BESL: u4,
        padding: u24 = 0,
    }),
    /// Battery charging detector
    /// offset: 0x58
    BCDR: mmio.Mmio(packed struct(u32) {
        /// Battery charging detector (BCD) enable Device mode This bit is set by the software to enable the BCD support within the USB device. When enabled, the USB PHY is fully controlled by BCD and cannot be used for normal communication. Once the BCD discovery is finished, the BCD should be placed in OFF mode by clearing this bit to '0 in order to allow the normal USB operation.
        BCDEN: u1,
        /// Data contact detection (DCD) mode enable Device mode This bit is set by the software to put the BCD into DCD mode. Only one detection mode (DCD, PD, SD or OFF) should be selected to work correctly.
        DCDEN: u1,
        /// Primary detection (PD) mode enable Device mode This bit is set by the software to put the BCD into PD mode. Only one detection mode (DCD, PD, SD or OFF) should be selected to work correctly.
        PDEN: u1,
        /// Secondary detection (SD) mode enable Device mode This bit is set by the software to put the BCD into SD mode. Only one detection mode (DCD, PD, SD or OFF) should be selected to work correctly.
        SDEN: u1,
        /// Data contact detection (DCD) status Device mode This bit gives the result of DCD.
        DCDET: u1,
        /// Primary detection (PD) status Device mode This bit gives the result of PD.
        PDET: u1,
        /// Secondary detection (SD) status Device mode This bit gives the result of SD.
        SDET: SDET,
        /// DM pull-up detection status Device mode This bit is active only during PD and gives the result of comparison between DM voltage level and VLGC threshold. In normal situation, the DM level should be below this threshold. If it is above, it means that the DM is externally pulled high. This can be caused by connection to a PS2 port (which pulls-up both DP and DM lines) or to some proprietary charger not following the BCD specification.
        PS2DET: u1,
        reserved15: u7 = 0,
        /// DP pull-up / DPDM pull-down Device mode This bit is set by software to enable the embedded pull-up on DP line. Clearing it to '0 can be used to signal disconnect to the host when needed by the user software. Host mode This bit is set by software to enable the embedded pull-down on DP and DM lines.
        DPPU: u1,
        padding: u16 = 0,
    }),
};
