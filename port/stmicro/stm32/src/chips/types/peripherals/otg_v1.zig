const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const DPID = enum(u2) {
    DATA0 = 0x0,
    DATA2 = 0x1,
    DATA1 = 0x2,
    MDATA = 0x3,
};

pub const DSPD = enum(u2) {
    /// High speed
    HIGH_SPEED = 0x0,
    /// Full speed using external ULPI PHY
    FULL_SPEED_EXTERNAL = 0x1,
    /// Full speed using internal embedded PHY
    FULL_SPEED_INTERNAL = 0x3,
    _,
};

pub const EPTYP = enum(u2) {
    CONTROL = 0x0,
    ISOCHRONOUS = 0x1,
    BULK = 0x2,
    INTERRUPT = 0x3,
};

pub const PFIVL = enum(u2) {
    /// 80% of the frame interval
    FRAME_INTERVAL_80 = 0x0,
    /// 85% of the frame interval
    FRAME_INTERVAL_85 = 0x1,
    /// 90% of the frame interval
    FRAME_INTERVAL_90 = 0x2,
    /// 95% of the frame interval
    FRAME_INTERVAL_95 = 0x3,
};

pub const PKTSTSD = enum(u4) {
    /// Global OUT NAK (triggers an interrupt)
    OUT_NAK = 0x1,
    /// OUT data packet received
    OUT_DATA_RX = 0x2,
    /// OUT transfer completed (triggers an interrupt)
    OUT_DATA_DONE = 0x3,
    /// SETUP transaction completed (triggers an interrupt)
    SETUP_DATA_DONE = 0x4,
    /// SETUP data packet received
    SETUP_DATA_RX = 0x6,
    _,
};

pub const PKTSTSH = enum(u4) {
    /// IN data packet received
    IN_DATA_RX = 0x2,
    /// IN transfer completed (triggers an interrupt)
    IN_DATA_DONE = 0x3,
    /// Data toggle error (triggers an interrupt)
    DATA_TOGGLE_ERR = 0x5,
    /// Channel halted (triggers an interrupt)
    CHANNEL_HALTED = 0x7,
    _,
};

/// USB on the go
pub const OTG = extern struct {
    /// Control and status register
    /// offset: 0x00
    GOTGCTL: mmio.Mmio(packed struct(u32) {
        /// Session request success
        SRQSCS: u1,
        /// Session request
        SRQ: u1,
        /// VBUS valid override enable
        VBVALOEN: u1,
        /// VBUS valid override value
        VBVALOVAL: u1,
        /// A-peripheral session valid override enable
        AVALOEN: u1,
        /// A-peripheral session valid override value
        AVALOVAL: u1,
        /// B-peripheral session valid override enable
        BVALOEN: u1,
        /// B-peripheral session valid override value
        BVALOVAL: u1,
        /// Host negotiation success
        HNGSCS: u1,
        /// HNP request
        HNPRQ: u1,
        /// Host set HNP enable
        HSHNPEN: u1,
        /// Device HNP enabled
        DHNPEN: u1,
        /// Embedded host enable
        EHEN: u1,
        reserved16: u3 = 0,
        /// Connector ID status
        CIDSTS: u1,
        /// Long/short debounce time
        DBCT: u1,
        /// A-session valid
        ASVLD: u1,
        /// B-session valid
        BSVLD: u1,
        padding: u12 = 0,
    }),
    /// Interrupt register
    /// offset: 0x04
    GOTGINT: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Session end detected
        SEDET: u1,
        reserved8: u5 = 0,
        /// Session request success status change
        SRSSCHG: u1,
        /// Host negotiation success status change
        HNSSCHG: u1,
        reserved17: u7 = 0,
        /// Host negotiation detected
        HNGDET: u1,
        /// A-device timeout change
        ADTOCHG: u1,
        /// Debounce done
        DBCDNE: u1,
        /// ID input pin changed
        IDCHNG: u1,
        padding: u11 = 0,
    }),
    /// AHB configuration register
    /// offset: 0x08
    GAHBCFG: mmio.Mmio(packed struct(u32) {
        /// Global interrupt mask
        GINT: u1,
        /// Burst length/type
        HBSTLEN: u4,
        /// DMA enable
        DMAEN: u1,
        reserved7: u1 = 0,
        /// TxFIFO empty level
        TXFELVL: u1,
        /// Periodic TxFIFO empty level
        PTXFELVL: u1,
        padding: u23 = 0,
    }),
    /// USB configuration register
    /// offset: 0x0c
    GUSBCFG: mmio.Mmio(packed struct(u32) {
        /// FS timeout calibration
        TOCAL: u3,
        reserved6: u3 = 0,
        /// Full-speed internal serial transceiver enable
        PHYSEL: u1,
        reserved8: u1 = 0,
        /// SRP-capable
        SRPCAP: u1,
        /// HNP-capable
        HNPCAP: u1,
        /// USB turnaround time
        TRDT: u4,
        reserved15: u1 = 0,
        /// PHY Low-power clock select
        PHYLPCS: u1,
        reserved17: u1 = 0,
        /// ULPI FS/LS select
        ULPIFSLS: u1,
        /// ULPI Auto-resume
        ULPIAR: u1,
        /// ULPI Clock SuspendM
        ULPICSM: u1,
        /// ULPI External VBUS Drive
        ULPIEVBUSD: u1,
        /// ULPI external VBUS indicator
        ULPIEVBUSI: u1,
        /// TermSel DLine pulsing selection
        TSDPS: u1,
        /// Indicator complement
        PCCI: u1,
        /// Indicator pass through
        PTCI: u1,
        /// ULPI interface protect disable
        ULPIIPD: u1,
        reserved29: u3 = 0,
        /// Force host mode
        FHMOD: u1,
        /// Force device mode
        FDMOD: u1,
        /// Corrupt Tx packet
        CTXPKT: u1,
    }),
    /// Reset register
    /// offset: 0x10
    GRSTCTL: mmio.Mmio(packed struct(u32) {
        /// Core soft reset
        CSRST: u1,
        /// HCLK soft reset
        HSRST: u1,
        /// Host frame counter reset
        FCRST: u1,
        reserved4: u1 = 0,
        /// RxFIFO flush
        RXFFLSH: u1,
        /// TxFIFO flush
        TXFFLSH: u1,
        /// TxFIFO number
        TXFNUM: u5,
        reserved30: u19 = 0,
        /// DMA request signal enabled for USB OTG HS
        DMAREQ: u1,
        /// AHB master idle
        AHBIDL: u1,
    }),
    /// Core interrupt register
    /// offset: 0x14
    GINTSTS: mmio.Mmio(packed struct(u32) {
        /// Current mode of operation
        CMOD: u1,
        /// Mode mismatch interrupt
        MMIS: u1,
        /// OTG interrupt
        OTGINT: u1,
        /// Start of frame
        SOF: u1,
        /// RxFIFO non-empty
        RXFLVL: u1,
        /// Non-periodic TxFIFO empty
        NPTXFE: u1,
        /// Global IN non-periodic NAK effective
        GINAKEFF: u1,
        /// Global OUT NAK effective
        GOUTNAKEFF: u1,
        reserved10: u2 = 0,
        /// Early suspend
        ESUSP: u1,
        /// USB suspend
        USBSUSP: u1,
        /// USB reset
        USBRST: u1,
        /// Enumeration done
        ENUMDNE: u1,
        /// Isochronous OUT packet dropped interrupt
        ISOODRP: u1,
        /// End of periodic frame interrupt
        EOPF: u1,
        reserved18: u2 = 0,
        /// IN endpoint interrupt
        IEPINT: u1,
        /// OUT endpoint interrupt
        OEPINT: u1,
        /// Incomplete isochronous IN transfer
        IISOIXFR: u1,
        /// Incomplete periodic transfer (host mode) / Incomplete isochronous OUT transfer (device mode)
        IPXFR_INCOMPISOOUT: u1,
        /// Data fetch suspended
        DATAFSUSP: u1,
        reserved24: u1 = 0,
        /// Host port interrupt
        HPRTINT: u1,
        /// Host channels interrupt
        HCINT: u1,
        /// Periodic TxFIFO empty
        PTXFE: u1,
        reserved28: u1 = 0,
        /// Connector ID status change
        CIDSCHG: u1,
        /// Disconnect detected interrupt
        DISCINT: u1,
        /// Session request/new session detected interrupt
        SRQINT: u1,
        /// Resume/remote wakeup detected interrupt
        WKUPINT: u1,
    }),
    /// Interrupt mask register
    /// offset: 0x18
    GINTMSK: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Mode mismatch interrupt mask
        MMISM: u1,
        /// OTG interrupt mask
        OTGINT: u1,
        /// Start of frame mask
        SOFM: u1,
        /// Receive FIFO non-empty mask
        RXFLVLM: u1,
        /// Non-periodic TxFIFO empty mask
        NPTXFEM: u1,
        /// Global non-periodic IN NAK effective mask
        GINAKEFFM: u1,
        /// Global OUT NAK effective mask
        GONAKEFFM: u1,
        reserved10: u2 = 0,
        /// Early suspend mask
        ESUSPM: u1,
        /// USB suspend mask
        USBSUSPM: u1,
        /// USB reset mask
        USBRST: u1,
        /// Enumeration done mask
        ENUMDNEM: u1,
        /// Isochronous OUT packet dropped interrupt mask
        ISOODRPM: u1,
        /// End of periodic frame interrupt mask
        EOPFM: u1,
        reserved17: u1 = 0,
        /// Endpoint mismatch interrupt mask
        EPMISM: u1,
        /// IN endpoints interrupt mask
        IEPINT: u1,
        /// OUT endpoints interrupt mask
        OEPINT: u1,
        /// Incomplete isochronous IN transfer mask
        IISOIXFRM: u1,
        /// Incomplete periodic transfer mask (host mode) / Incomplete isochronous OUT transfer mask (device mode)
        IPXFRM_IISOOXFRM: u1,
        /// Data fetch suspended mask
        FSUSPM: u1,
        /// Reset detected interrupt mask
        RSTDE: u1,
        /// Host port interrupt mask
        PRTIM: u1,
        /// Host channels interrupt mask
        HCIM: u1,
        /// Periodic TxFIFO empty mask
        PTXFEM: u1,
        /// LPM interrupt mask
        LPMINTM: u1,
        /// Connector ID status change mask
        CIDSCHGM: u1,
        /// Disconnect detected interrupt mask
        DISCINT: u1,
        /// Session request/new session detected interrupt mask
        SRQIM: u1,
        /// Resume/remote wakeup detected interrupt mask
        WUIM: u1,
    }),
    /// Receive status debug read register
    /// offset: 0x1c
    GRXSTSR: mmio.Mmio(packed struct(u32) {
        /// Endpoint number (device mode) / Channel number (host mode)
        EPNUM: u4,
        /// Byte count
        BCNT: u11,
        /// Data PID
        DPID: DPID,
        /// Packet status (device mode)
        PKTSTSD: PKTSTSD,
        /// Frame number (device mode)
        FRMNUM: u4,
        padding: u7 = 0,
    }),
    /// Status read and pop register
    /// offset: 0x20
    GRXSTSP: mmio.Mmio(packed struct(u32) {
        /// Endpoint number (device mode) / Channel number (host mode)
        EPNUM: u4,
        /// Byte count
        BCNT: u11,
        /// Data PID
        DPID: DPID,
        /// Packet status (device mode)
        PKTSTSD: PKTSTSD,
        /// Frame number (device mode)
        FRMNUM: u4,
        padding: u7 = 0,
    }),
    /// Receive FIFO size register
    /// offset: 0x24
    GRXFSIZ: mmio.Mmio(packed struct(u32) {
        /// RxFIFO depth
        RXFD: u16,
        padding: u16 = 0,
    }),
    /// Endpoint 0 transmit FIFO size register (device mode)
    /// offset: 0x28
    DIEPTXF0: mmio.Mmio(packed struct(u32) {
        /// RAM start address
        SA: u16,
        /// FIFO depth
        FD: u16,
    }),
    /// Non-periodic transmit FIFO/queue status register (host mode)
    /// offset: 0x2c
    HNPTXSTS: mmio.Mmio(packed struct(u32) {
        /// Non-periodic TxFIFO space available
        NPTXFSAV: u16,
        /// Non-periodic transmit request queue space available
        NPTQXSAV: u8,
        /// Top of the non-periodic transmit request queue
        NPTXQTOP: u7,
        padding: u1 = 0,
    }),
    /// OTG I2C access register
    /// offset: 0x30
    GI2CCTL: mmio.Mmio(packed struct(u32) {
        /// I2C Read/Write Data
        RWDATA: u8,
        /// I2C Register Address
        REGADDR: u8,
        /// I2C Address
        ADDR: u7,
        /// I2C Enable
        I2CEN: u1,
        /// I2C ACK
        ACK: u1,
        reserved26: u1 = 0,
        /// I2C Device Address
        I2CDEVADR: u2,
        /// I2C DatSe0 USB mode
        I2CDATSE0: u1,
        reserved30: u1 = 0,
        /// Read/Write Indicator
        RW: u1,
        /// I2C Busy/Done
        BSYDNE: u1,
    }),
    /// offset: 0x34
    reserved52: [4]u8,
    /// General core configuration register, for core_id 0x0000_1xxx
    /// offset: 0x38
    GCCFG_V1: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Power down
        PWRDWN: u1,
        reserved18: u1 = 0,
        /// Enable the VBUS "A" sensing device
        VBUSASEN: u1,
        /// Enable the VBUS "B" sensing device
        VBUSBSEN: u1,
        /// SOF output enable
        SOFOUTEN: u1,
        /// VBUS sensing disable
        NOVBUSSENS: u1,
        padding: u10 = 0,
    }),
    /// Core ID register
    /// offset: 0x3c
    CID: mmio.Mmio(packed struct(u32) {
        /// Product ID field
        PRODUCT_ID: u32,
    }),
    /// offset: 0x40
    reserved64: [20]u8,
    /// OTG core LPM configuration register
    /// offset: 0x54
    GLPMCFG: mmio.Mmio(packed struct(u32) {
        /// LPM support enable
        LPMEN: u1,
        /// LPM token acknowledge enable
        LPMACK: u1,
        /// Best effort service latency
        BESL: u4,
        /// bRemoteWake value
        REMWAKE: u1,
        /// L1 Shallow Sleep enable
        L1SSEN: u1,
        /// BESL threshold
        BESLTHRS: u4,
        /// L1 deep sleep enable
        L1DSEN: u1,
        /// LPM response
        LPMRST: u2,
        /// Port sleep status
        SLPSTS: u1,
        /// Sleep State Resume OK
        L1RSMOK: u1,
        /// LPM Channel Index
        LPMCHIDX: u4,
        /// LPM retry count
        LPMRCNT: u3,
        /// Send LPM transaction
        SNDLPM: u1,
        /// LPM retry count status
        LPMRCNTSTS: u3,
        /// Enable best effort service latency
        ENBESL: u1,
        padding: u3 = 0,
    }),
    /// offset: 0x58
    reserved88: [168]u8,
    /// Host periodic transmit FIFO size register
    /// offset: 0x100
    HPTXFSIZ: mmio.Mmio(packed struct(u32) {
        /// RAM start address
        SA: u16,
        /// FIFO depth
        FD: u16,
    }),
    /// Device IN endpoint transmit FIFO size register
    /// offset: 0x104
    DIEPTXF: [7]mmio.Mmio(packed struct(u32) {
        /// RAM start address
        SA: u16,
        /// FIFO depth
        FD: u16,
    }),
    /// offset: 0x120
    reserved288: [736]u8,
    /// Host configuration register
    /// offset: 0x400
    HCFG: mmio.Mmio(packed struct(u32) {
        /// FS/LS PHY clock select
        FSLSPCS: u2,
        /// FS- and LS-only support
        FSLSS: u1,
        padding: u29 = 0,
    }),
    /// Host frame interval register
    /// offset: 0x404
    HFIR: mmio.Mmio(packed struct(u32) {
        /// Frame interval
        FRIVL: u16,
        padding: u16 = 0,
    }),
    /// Host frame number/frame time remaining register
    /// offset: 0x408
    HFNUM: mmio.Mmio(packed struct(u32) {
        /// Frame number
        FRNUM: u16,
        /// Frame time remaining
        FTREM: u16,
    }),
    /// offset: 0x40c
    reserved1036: [4]u8,
    /// Periodic transmit FIFO/queue status register
    /// offset: 0x410
    HPTXSTS: mmio.Mmio(packed struct(u32) {
        /// Periodic transmit data FIFO space available
        PTXFSAVL: u16,
        /// Periodic transmit request queue space available
        PTXQSAV: u8,
        /// Top of the periodic transmit request queue
        PTXQTOP: u8,
    }),
    /// Host all channels interrupt register
    /// offset: 0x414
    HAINT: mmio.Mmio(packed struct(u32) {
        /// Channel interrupts
        HAINT: u16,
        padding: u16 = 0,
    }),
    /// Host all channels interrupt mask register
    /// offset: 0x418
    HAINTMSK: mmio.Mmio(packed struct(u32) {
        /// Channel interrupt mask
        HAINTM: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x41c
    reserved1052: [36]u8,
    /// Host port control and status register
    /// offset: 0x440
    HPRT: mmio.Mmio(packed struct(u32) {
        /// Port connect status
        PCSTS: u1,
        /// Port connect detected
        PCDET: u1,
        /// Port enable
        PENA: u1,
        /// Port enable/disable change
        PENCHNG: u1,
        /// Port overcurrent active
        POCA: u1,
        /// Port overcurrent change
        POCCHNG: u1,
        /// Port resume
        PRES: u1,
        /// Port suspend
        PSUSP: u1,
        /// Port reset
        PRST: u1,
        reserved10: u1 = 0,
        /// Port line status
        PLSTS: u2,
        /// Port power
        PPWR: u1,
        /// Port test control
        PTCTL: u4,
        /// Port speed
        PSPD: u2,
        padding: u13 = 0,
    }),
    /// offset: 0x444
    reserved1092: [188]u8,
    /// Host channel characteristics register
    /// offset: 0x500
    HCCHAR: mmio.Mmio(packed struct(u32) {
        /// Maximum packet size
        MPSIZ: u11,
        /// Endpoint number
        EPNUM: u4,
        /// Endpoint direction
        EPDIR: u1,
        reserved17: u1 = 0,
        /// Low-speed device
        LSDEV: u1,
        /// Endpoint type
        EPTYP: EPTYP,
        /// Multicount
        MCNT: u2,
        /// Device address
        DAD: u7,
        /// Odd frame
        ODDFRM: u1,
        /// Channel disable
        CHDIS: u1,
        /// Channel enable
        CHENA: u1,
    }),
    /// Host channel split control register
    /// offset: 0x504
    HCSPLT: u32,
    /// Host channel interrupt register
    /// offset: 0x508
    HCINT: mmio.Mmio(packed struct(u32) {
        /// Transfer completed
        XFRC: u1,
        /// Channel halted
        CHH: u1,
        reserved3: u1 = 0,
        /// STALL response received interrupt
        STALL: u1,
        /// NAK response received interrupt
        NAK: u1,
        /// ACK response received/transmitted interrupt
        ACK: u1,
        reserved7: u1 = 0,
        /// Transaction error
        TXERR: u1,
        /// Babble error
        BBERR: u1,
        /// Frame overrun
        FRMOR: u1,
        /// Data toggle error
        DTERR: u1,
        padding: u21 = 0,
    }),
    /// Host channel mask register
    /// offset: 0x50c
    HCINTMSK: mmio.Mmio(packed struct(u32) {
        /// Transfer completed mask
        XFRCM: u1,
        /// Channel halted mask
        CHHM: u1,
        reserved3: u1 = 0,
        /// STALL response received interrupt mask
        STALLM: u1,
        /// NAK response received interrupt mask
        NAKM: u1,
        /// ACK response received/transmitted interrupt mask
        ACKM: u1,
        /// Response received interrupt mask
        NYET: u1,
        /// Transaction error mask
        TXERRM: u1,
        /// Babble error mask
        BBERRM: u1,
        /// Frame overrun mask
        FRMORM: u1,
        /// Data toggle error mask
        DTERRM: u1,
        padding: u21 = 0,
    }),
    /// Host channel transfer size register
    /// offset: 0x510
    HCTSIZ: mmio.Mmio(packed struct(u32) {
        /// Transfer size
        XFRSIZ: u19,
        /// Packet count
        PKTCNT: u10,
        /// Data PID
        DPID: u2,
        padding: u1 = 0,
    }),
    /// offset: 0x514
    reserved1300: [748]u8,
    /// Device configuration register
    /// offset: 0x800
    DCFG: mmio.Mmio(packed struct(u32) {
        /// Device speed
        DSPD: DSPD,
        /// Non-zero-length status OUT handshake
        NZLSOHSK: u1,
        reserved4: u1 = 0,
        /// Device address
        DAD: u7,
        /// Periodic frame interval
        PFIVL: PFIVL,
        reserved14: u1 = 0,
        /// Transceiver delay
        XCVRDLY: u1,
        padding: u17 = 0,
    }),
    /// Device control register
    /// offset: 0x804
    DCTL: mmio.Mmio(packed struct(u32) {
        /// Remote wakeup signaling
        RWUSIG: u1,
        /// Soft disconnect
        SDIS: u1,
        /// Global IN NAK status
        GINSTS: u1,
        /// Global OUT NAK status
        GONSTS: u1,
        /// Test control
        TCTL: u3,
        /// Set global IN NAK
        SGINAK: u1,
        /// Clear global IN NAK
        CGINAK: u1,
        /// Set global OUT NAK
        SGONAK: u1,
        /// Clear global OUT NAK
        CGONAK: u1,
        /// Power-on programming done
        POPRGDNE: u1,
        padding: u20 = 0,
    }),
    /// Device status register
    /// offset: 0x808
    DSTS: mmio.Mmio(packed struct(u32) {
        /// Suspend status
        SUSPSTS: u1,
        /// Enumerated speed
        ENUMSPD: DSPD,
        /// Erratic error
        EERR: u1,
        reserved8: u4 = 0,
        /// Frame number of the received SOF
        FNSOF: u14,
        padding: u10 = 0,
    }),
    /// offset: 0x80c
    reserved2060: [4]u8,
    /// Device IN endpoint common interrupt mask register
    /// offset: 0x810
    DIEPMSK: mmio.Mmio(packed struct(u32) {
        /// Transfer completed interrupt mask
        XFRCM: u1,
        /// Endpoint disabled interrupt mask
        EPDM: u1,
        reserved3: u1 = 0,
        /// Timeout condition mask (Non-isochronous endpoints)
        TOM: u1,
        /// IN token received when TxFIFO empty mask
        ITTXFEMSK: u1,
        /// IN token received with EP mismatch mask
        INEPNMM: u1,
        /// IN endpoint NAK effective mask
        INEPNEM: u1,
        padding: u25 = 0,
    }),
    /// Device OUT endpoint common interrupt mask register
    /// offset: 0x814
    DOEPMSK: mmio.Mmio(packed struct(u32) {
        /// Transfer completed interrupt mask
        XFRCM: u1,
        /// Endpoint disabled interrupt mask
        EPDM: u1,
        reserved3: u1 = 0,
        /// SETUP phase done mask
        STUPM: u1,
        /// OUT token received when endpoint disabled mask
        OTEPDM: u1,
        padding: u27 = 0,
    }),
    /// Device all endpoints interrupt register
    /// offset: 0x818
    DAINT: mmio.Mmio(packed struct(u32) {
        /// IN endpoint interrupt bits
        IEPINT: u16,
        /// OUT endpoint interrupt bits
        OEPINT: u16,
    }),
    /// All endpoints interrupt mask register
    /// offset: 0x81c
    DAINTMSK: mmio.Mmio(packed struct(u32) {
        /// IN EP interrupt mask bits
        IEPM: u16,
        /// OUT EP interrupt mask bits
        OEPM: u16,
    }),
    /// offset: 0x820
    reserved2080: [8]u8,
    /// Device VBUS discharge time register
    /// offset: 0x828
    DVBUSDIS: mmio.Mmio(packed struct(u32) {
        /// Device VBUS discharge time
        VBUSDT: u16,
        padding: u16 = 0,
    }),
    /// Device VBUS pulsing time register
    /// offset: 0x82c
    DVBUSPULSE: mmio.Mmio(packed struct(u32) {
        /// Device VBUS pulsing time
        DVBUSP: u12,
        padding: u20 = 0,
    }),
    /// offset: 0x830
    reserved2096: [4]u8,
    /// Device IN endpoint FIFO empty interrupt mask register
    /// offset: 0x834
    DIEPEMPMSK: mmio.Mmio(packed struct(u32) {
        /// IN EP Tx FIFO empty interrupt mask bits
        INEPTXFEM: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x838
    reserved2104: [200]u8,
    /// Device IN endpoint control register
    /// offset: 0x900
    DIEPCTL: mmio.Mmio(packed struct(u32) {
        /// MPSIZ
        MPSIZ: u11,
        reserved15: u4 = 0,
        /// USBAEP
        USBAEP: u1,
        /// EONUM/DPID
        EONUM_DPID: u1,
        /// NAKSTS
        NAKSTS: u1,
        /// EPTYP
        EPTYP: EPTYP,
        /// SNPM
        SNPM: u1,
        /// STALL
        STALL: u1,
        /// TXFNUM
        TXFNUM: u4,
        /// CNAK
        CNAK: u1,
        /// SNAK
        SNAK: u1,
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1,
        /// SODDFRM/SD1PID
        SODDFRM_SD1PID: u1,
        /// EPDIS
        EPDIS: u1,
        /// EPENA
        EPENA: u1,
    }),
    /// offset: 0x904
    reserved2308: [4]u8,
    /// Device IN endpoint interrupt register
    /// offset: 0x908
    DIEPINT: mmio.Mmio(packed struct(u32) {
        /// XFRC
        XFRC: u1,
        /// EPDISD
        EPDISD: u1,
        reserved3: u1 = 0,
        /// TOC
        TOC: u1,
        /// ITTXFE
        ITTXFE: u1,
        reserved6: u1 = 0,
        /// INEPNE
        INEPNE: u1,
        /// TXFE
        TXFE: u1,
        padding: u24 = 0,
    }),
    /// offset: 0x90c
    reserved2316: [4]u8,
    /// Device IN endpoint transfer size register
    /// offset: 0x910
    DIEPTSIZ: mmio.Mmio(packed struct(u32) {
        /// Transfer size
        XFRSIZ: u19,
        /// Packet count
        PKTCNT: u10,
        /// Multi count
        MCNT: u2,
        padding: u1 = 0,
    }),
    /// offset: 0x914
    reserved2324: [4]u8,
    /// Device IN endpoint transmit FIFO status register
    /// offset: 0x918
    DTXFSTS: mmio.Mmio(packed struct(u32) {
        /// IN endpoint TxFIFO space available
        INEPTFSAV: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x91c
    reserved2332: [484]u8,
    /// Device OUT endpoint control register
    /// offset: 0xb00
    DOEPCTL: mmio.Mmio(packed struct(u32) {
        /// MPSIZ
        MPSIZ: u11,
        reserved15: u4 = 0,
        /// USBAEP
        USBAEP: u1,
        /// EONUM/DPID
        EONUM_DPID: u1,
        /// NAKSTS
        NAKSTS: u1,
        /// EPTYP
        EPTYP: EPTYP,
        /// SNPM
        SNPM: u1,
        /// STALL
        STALL: u1,
        reserved26: u4 = 0,
        /// CNAK
        CNAK: u1,
        /// SNAK
        SNAK: u1,
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1,
        /// SODDFRM
        SODDFRM: u1,
        /// EPDIS
        EPDIS: u1,
        /// EPENA
        EPENA: u1,
    }),
    /// offset: 0xb04
    reserved2820: [4]u8,
    /// Device OUT endpoint interrupt register
    /// offset: 0xb08
    DOEPINT: mmio.Mmio(packed struct(u32) {
        /// XFRC
        XFRC: u1,
        /// EPDISD
        EPDISD: u1,
        reserved3: u1 = 0,
        /// STUP
        STUP: u1,
        /// OTEPDIS
        OTEPDIS: u1,
        reserved6: u1 = 0,
        /// B2BSTUP
        B2BSTUP: u1,
        padding: u25 = 0,
    }),
    /// offset: 0xb0c
    reserved2828: [4]u8,
    /// Device OUT endpoint transfer size register
    /// offset: 0xb10
    DOEPTSIZ: mmio.Mmio(packed struct(u32) {
        /// Transfer size
        XFRSIZ: u19,
        /// Packet count
        PKTCNT: u10,
        /// Received data PID/SETUP packet count
        RXDPID_STUPCNT: u2,
        padding: u1 = 0,
    }),
    /// offset: 0xb14
    reserved2836: [748]u8,
    /// Power and clock gating control register
    /// offset: 0xe00
    PCGCCTL: mmio.Mmio(packed struct(u32) {
        /// Stop PHY clock
        STPPCLK: u1,
        /// Gate HCLK
        GATEHCLK: u1,
        reserved4: u2 = 0,
        /// PHY Suspended
        PHYSUSP: u1,
        padding: u27 = 0,
    }),
    /// offset: 0xe04
    reserved3588: [508]u8,
    /// Device endpoint / host channel FIFO register
    /// offset: 0x1000
    FIFO: mmio.Mmio(packed struct(u32) {
        /// Data
        DATA: u32,
    }),
};
