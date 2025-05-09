const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ACCMOD = enum(u2) {
    /// Access mode A
    A = 0x0,
    /// Access mode B
    B = 0x1,
    /// Access mode C
    C = 0x2,
    /// Access mode D
    D = 0x3,
};

pub const CAS = enum(u2) {
    /// 1 cycle
    Clocks1 = 0x1,
    /// 2 cycles
    Clocks2 = 0x2,
    /// 3 cycles
    Clocks3 = 0x3,
    _,
};

pub const CBURSTRW = enum(u1) {
    /// Write operations are always performed in Asynchronous mode.
    Asynchronous = 0x0,
    /// Write operations are performed in Synchronous mode.
    Synchronous = 0x1,
};

pub const CPSIZE = enum(u3) {
    /// No burst split when crossing page boundary
    NoBurstSplit = 0x0,
    /// 128 bytes CRAM page size
    Bytes128 = 0x1,
    /// 256 bytes CRAM page size
    Bytes256 = 0x2,
    /// 512 bytes CRAM page size
    Bytes512 = 0x3,
    /// 1024 bytes CRAM page size
    Bytes1024 = 0x4,
    _,
};

pub const ECCPS = enum(u3) {
    /// ECC page size 256 bytes
    Bytes256 = 0x0,
    /// ECC page size 512 bytes
    Bytes512 = 0x1,
    /// ECC page size 1024 bytes
    Bytes1024 = 0x2,
    /// ECC page size 2048 bytes
    Bytes2048 = 0x3,
    /// ECC page size 4096 bytes
    Bytes4096 = 0x4,
    /// ECC page size 8192 bytes
    Bytes8192 = 0x5,
    _,
};

pub const MODE = enum(u3) {
    /// Normal Mode
    Normal = 0x0,
    /// Clock Configuration Enable
    ClockConfigurationEnable = 0x1,
    /// PALL (All Bank Precharge) command
    PALL = 0x2,
    /// Auto-refresh command
    AutoRefreshCommand = 0x3,
    /// Load Mode Resgier
    LoadModeRegister = 0x4,
    /// Self-refresh command
    SelfRefreshCommand = 0x5,
    /// Power-down command
    PowerDownCommand = 0x6,
    _,
};

pub const MODES = enum(u2) {
    /// Normal Mode
    Normal = 0x0,
    /// Self-refresh mode
    SelfRefresh = 0x1,
    /// Power-down mode
    PowerDown = 0x2,
    _,
};

pub const MTYP = enum(u2) {
    /// SRAM memory type
    SRAM = 0x0,
    /// PSRAM (CRAM) memory type
    PSRAM = 0x1,
    /// NOR Flash/OneNAND Flash
    Flash = 0x2,
    _,
};

pub const MWID = enum(u2) {
    /// Memory data bus width 8 bits
    Bits8 = 0x0,
    /// Memory data bus width 16 bits
    Bits16 = 0x1,
    /// Memory data bus width 32 bits
    Bits32 = 0x2,
    _,
};

pub const NB = enum(u1) {
    /// Two internal Banks
    NB2 = 0x0,
    /// Four internal Banks
    NB4 = 0x1,
};

pub const NC = enum(u2) {
    /// 8 bits
    Bits8 = 0x0,
    /// 9 bits
    Bits9 = 0x1,
    /// 10 bits
    Bits10 = 0x2,
    /// 11 bits
    Bits11 = 0x3,
};

pub const NR = enum(u2) {
    /// 11 bits
    Bits11 = 0x0,
    /// 12 bits
    Bits12 = 0x1,
    /// 13 bits
    Bits13 = 0x2,
    _,
};

pub const PTYP = enum(u1) {
    /// NAND flash
    NAND = 0x1,
    _,
};

pub const PWID = enum(u2) {
    /// External memory device width 8 bits
    Bits8 = 0x0,
    /// External memory device width 16 bits
    Bits16 = 0x1,
    _,
};

pub const RPIPE = enum(u2) {
    /// No clock cycle delay
    NoDelay = 0x0,
    /// One clock cycle delay
    Clocks1 = 0x1,
    /// Two clock cycles delay
    Clocks2 = 0x2,
    _,
};

pub const SDCLK = enum(u2) {
    /// SDCLK clock disabled
    Disabled = 0x0,
    /// SDCLK period = 2 x HCLK period
    Div2 = 0x2,
    /// SDCLK period = 3 x HCLK period
    Div3 = 0x3,
    _,
};

pub const WAITCFG = enum(u1) {
    /// NWAIT signal is active one data cycle before wait state
    BeforeWaitState = 0x0,
    /// NWAIT signal is active during wait state
    DuringWaitState = 0x1,
};

pub const WAITPOL = enum(u1) {
    /// NWAIT active low
    ActiveLow = 0x0,
    /// NWAIT active high
    ActiveHigh = 0x1,
};

/// Flexible memory controller.
pub const FMC = extern struct {
    /// offset: 0x00
    NOR_PSRAM: u32,
    /// offset: 0x04
    reserved4: [124]u8,
    /// offset: 0x80
    NAND: u32,
    /// offset: 0x84
    reserved132: [188]u8,
    /// offset: 0x140
    SDRAM: u32,
};

pub const NAND = extern struct {
    /// NAND Flash control registers.
    /// offset: 0x00
    PCR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Wait feature enable bit Enables the Wait feature for the NAND Flash memory bank:.
        PWAITEN: u1,
        /// NAND Flash memory bank enable bit Enables the memory bank. Accessing a disabled memory bank causes an ERROR on AHB bus.
        PBKEN: u1,
        /// Memory type Defines the type of device attached to the corresponding memory bank:.
        PTYP: PTYP,
        /// Data bus width Defines the external memory device width.
        PWID: PWID,
        /// ECC computation logic enable bit.
        ECCEN: u1,
        reserved9: u2 = 0,
        /// CLE to RE delay Sets time from CLE low to RE low in number of AHB clock cycles (HCLK). Time is t_clr = (TCLR + SET + 2) � THCLK where THCLK is the HCLK clock period Note: SET is MEMSET or ATTSET according to the addressed space.
        TCLR: u4,
        /// ALE to RE delay Sets time from ALE low to RE low in number of AHB clock cycles (HCLK). Time is: t_ar = (TAR + SET + 2) � THCLK where THCLK is the HCLK clock period Note: SET is MEMSET or ATTSET according to the addressed space.
        TAR: u4,
        /// ECC page size Defines the page size for the extended ECC:.
        ECCPS: ECCPS,
        padding: u12 = 0,
    }),
    /// FIFO status and interrupt register.
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// Interrupt rising edge status The flag is set by hardware and reset by software. Note: If this bit is written by software to 1 it is set.
        IRS: u1,
        /// Interrupt high-level status The flag is set by hardware and reset by software.
        ILS: u1,
        /// Interrupt falling edge status The flag is set by hardware and reset by software. Note: If this bit is written by software to 1 it is set.
        IFS: u1,
        /// Interrupt rising edge detection enable bit.
        IREN: u1,
        /// Interrupt high-level detection enable bit.
        ILEN: u1,
        /// Interrupt falling edge detection enable bit.
        IFEN: u1,
        /// FIFO empty Read-only bit that provides the status of the FIFO.
        FEMPT: u1,
        padding: u25 = 0,
    }),
    /// Common memory space timing register.
    /// offset: 0x08
    PMEM: mmio.Mmio(packed struct(u32) {
        /// Common memory x setup time Defines the number of HCLK (+1) clock cycles to set up the address before the command assertion (NWE, NOE), for NAND Flash read or write access to common memory space on socket x:.
        MEMSET: u8,
        /// Common memory wait time Defines the minimum number of HCLK (+1) clock cycles to assert the command (NWE, NOE), for NAND Flash read or write access to common memory space on socket. The duration of command assertion is extended if the wait signal (NWAIT) is active (low) at the end of the programmed value of HCLK:.
        MEMWAIT: u8,
        /// Common memory hold time Defines the number of HCLK clock cycles for write access and HCLK (+2) clock cycles for read access during which the address is held (and data for write accesses) after the command is deasserted (NWE, NOE), for NAND Flash read or write access to common memory space on socket x:.
        MEMHOLD: u8,
        /// Common memory x data bus Hi-Z time Defines the number of HCLK clock cycles during which the data bus is kept Hi-Z after the start of a NAND Flash write access to common memory space on socket. This is only valid for write transactions:.
        MEMHIZ: u8,
    }),
    /// Attribute memory space timing register.
    /// offset: 0x0c
    PATT: mmio.Mmio(packed struct(u32) {
        /// Attribute memory setup time Defines the number of HCLK (+1) clock cycles to set up address before the command assertion (NWE, NOE), for NAND Flash read or write access to attribute memory space on socket:.
        ATTSET: u8,
        /// Attribute memory wait time Defines the minimum number of HCLK (+1) clock cycles to assert the command (NWE, NOE), for NAND Flash read or write access to attribute memory space on socket x. The duration for command assertion is extended if the wait signal (NWAIT) is active (low) at the end of the programmed value of HCLK:.
        ATTWAIT: u8,
        /// Attribute memory hold time Defines the number of HCLK clock cycles for write access and HCLK (+2) clock cycles for read access during which the address is held (and data for write access) after the command deassertion (NWE, NOE), for NAND Flash read or write access to attribute memory space on socket:.
        ATTHOLD: u8,
        /// Attribute memory data bus Hi-Z time Defines the number of HCLK clock cycles during which the data bus is kept in Hi-Z after the start of a NAND Flash write access to attribute memory space on socket. Only valid for writ transaction:.
        ATTHIZ: u8,
    }),
    /// offset: 0x10
    reserved16: [4]u8,
    /// ECC result registers.
    /// offset: 0x14
    ECCR: u32,
};

pub const NOR_PSRAM = extern struct {
    /// SRAM/NOR-Flash chip-select control register for bank 1.
    /// offset: 0x00
    BCR1: mmio.Mmio(packed struct(u32) {
        /// Memory bank enable bit Enables the memory bank. After reset Bank1 is enabled, all others are disabled. Accessing a disabled bank causes an ERROR on AHB bus.
        MBKEN: u1,
        /// Address/data multiplexing enable bit When this bit is set, the address and data values are multiplexed on the data bus, valid only with NOR and PSRAM memories:.
        MUXEN: u1,
        /// Memory type Defines the type of external memory attached to the corresponding memory bank.
        MTYP: MTYP,
        /// Memory data bus width Defines the external memory device width, valid for all type of memories.
        MWID: MWID,
        /// Flash access enable Enables NOR Flash memory access operations.
        FACCEN: u1,
        reserved8: u1 = 0,
        /// Burst enable bit This bit enables/disables synchronous accesses during read operations. It is valid only for synchronous memories operating in Burst mode.
        BURSTEN: u1,
        /// Wait signal polarity bit Defines the polarity of the wait signal from memory used for either in Synchronous or Asynchronous mode.
        WAITPOL: WAITPOL,
        reserved11: u1 = 0,
        /// Wait timing configuration The NWAIT signal indicates whether the data from the memory are valid or if a wait state must be inserted when accessing the memory in Synchronous mode. This configuration bit determines if NWAIT is asserted by the memory one clock cycle before the wait state or during the wait state:.
        WAITCFG: WAITCFG,
        /// Write enable bit This bit indicates whether write operations are enabled/disabled in the bank by the FMC.
        WREN: u1,
        /// Wait enable bit This bit enables/disables wait-state insertion via the NWAIT signal when accessing the memory in Synchronous mode.
        WAITEN: u1,
        /// Extended mode enable This bit enables the FMC to program the write timings for non multiplexed asynchronous accesses inside the FMC_BWTR register, thus resulting in different timings for read and write operations. Note: When the Extended mode is disabled, the FMC can operate in mode 1 or mode 2 as follows: Mode 1 is the default mode when the SRAM/PSRAM memory type is selected (MTYP = 0x0 or 0x01) Mode 2 is the default mode when the NOR memory type is selected (MTYP = 0x10).
        EXTMOD: u1,
        /// Wait signal during asynchronous transfers This bit enables/disables the FMC to use the wait signal even during an asynchronous protocol.
        ASYNCWAIT: u1,
        /// CRAM page size These are used for CellularRAM™ 1.5 which does not allow burst access to cross the address boundaries between pages. When these bits are configured, the FMC controller splits automatically the burst access when the memory page size is reached (refer to memory datasheet for page size). Others: reserved.
        CPSIZE: CPSIZE,
        /// Write burst enable For PSRAM (CRAM) operating in Burst mode, the bit enables synchronous accesses during write operations. The enable bit for synchronous read accesses is the BURSTEN bit in the FMC_BCRx register.
        CBURSTRW: CBURSTRW,
        /// Continuous clock enable This bit enables the FMC_CLK clock output to external memory devices. Note: The CCLKEN bit of the FMC_BCR2..4 registers is don’t care. It is only enabled through the FMC_BCR1 register. Bank 1 must be configured in Synchronous mode to generate the FMC_CLK continuous clock. Note: If CCLKEN bit is set, the FMC_CLK clock ratio is specified by CLKDIV value in the FMC_BTR1 register. CLKDIV in FMC_BWTR1 is don’t care. Note: If the Synchronous mode is used and CCLKEN bit is set, the synchronous memories connected to other banks than Bank 1 are clocked by the same clock (the CLKDIV value in the FMC_BTR2..4 and FMC_BWTR2..4 registers for other banks has no effect.).
        CCLKEN: u1,
        /// Write FIFO disable This bit disables the Write FIFO used by the FMC controller. Note: The WFDIS bit of the FMC_BCR2..4 registers is don’t care. It is only enabled through the FMC_BCR1 register.
        WFDIS: u1,
        /// Byte lane (NBL) setup These bits configure the NBL setup timing from NBLx low to chip select NEx low.
        NBLSET: u2,
        reserved31: u7 = 0,
        /// FMC controller enable This bit enables or disables the FMC controller. Note: The FMCEN bit of the FMC_BCR2..4 registers is don’t care. It is only enabled through the FMC_BCR1 register.
        FMCEN: u1,
    }),
    /// SRAM/NOR-Flash chip-select timing register for bank 1.
    /// offset: 0x04
    BTR: mmio.Mmio(packed struct(u32) {
        /// Address setup phase duration. These bits are written by software to define the duration of the address setup phase in HCLK cycles (refer to Figure 21 to Figure 33), used in asynchronous accesses: ... Note: In synchronous accesses, this value is not used, the address setup phase is always 1 Flash clock period duration. In muxed mode, the minimum ADDSET value is 1.
        ADDSET: u4,
        /// Address-hold phase duration. These bits are written by software to define the duration of the address hold phase (refer to Figure 30 to Figure 33), used in asynchronous multiplexed accesses: ... Note: In synchronous NOR Flash accesses, this value is not used, the address hold phase is always 1 Flash clock period duration.
        ADDHLD: u4,
        /// Data-phase duration. These bits are written by software to define the duration of the data phase (refer to Figure 21 to Figure 33), used in asynchronous SRAM, PSRAM and NOR Flash memory accesses: ...
        DATAST: u8,
        /// Bus turnaround phase duration These bits are written by software to add a delay at the end of current write transaction to next transaction on the same bank. For FRAM memories, the bus turnaround delay should be configured to match the minimum t<sub>PC</sub> (precharge time) timings. The bus turnaround delay is inserted between any consecutive transactions on the same bank (read/read, write/write, read/write and write/read). The chip select is toggling between any consecutive accesses. (BUSTURN + 1)HCLK period ≥ tPC min ...
        BUSTURN: u4,
        /// Clock divide ratio (for FMC_CLK signal) Defines the period of FMC_CLK clock output signal, expressed in number of HCLK cycles: In asynchronous NOR Flash, SRAM or PSRAM accesses, this value is don’t care. Note: Refer to Section 5.6.5: Synchronous transactions for FMC_CLK divider ratio formula).
        CLKDIV: u4,
        /// (see note below bit descriptions): Data latency for synchronous memory For synchronous access with read/write Burst mode enabled (BURSTEN / CBURSTRW bits set), defines the number of memory clock cycles (+2) to issue to the memory before reading/writing the first data: This timing parameter is not expressed in HCLK periods, but in FMC_CLK periods. For asynchronous access, this value is don't care.
        DATLAT: u4,
        /// Access mode. Specifies the asynchronous access modes as shown in the next timing diagrams.These bits are taken into account only when the EXTMOD bit in the FMC_BCRx register is 1.
        ACCMOD: ACCMOD,
        /// Data hold phase duration These bits are written by software to define the duration of the data hold phase in HCLK cycles (refer to Figure 21 to Figure 33), used in asynchronous write accesses:.
        DATAHLD: u2,
    }),
    /// SRAM/NOR-Flash chip-select control register for bank 2.
    /// offset: 0x08
    BCR: mmio.Mmio(packed struct(u32) {
        /// Memory bank enable bit Enables the memory bank. After reset Bank1 is enabled, all others are disabled. Accessing a disabled bank causes an ERROR on AHB bus.
        MBKEN: u1,
        /// Address/data multiplexing enable bit When this bit is set, the address and data values are multiplexed on the data bus, valid only with NOR and PSRAM memories:.
        MUXEN: u1,
        /// Memory type Defines the type of external memory attached to the corresponding memory bank.
        MTYP: MTYP,
        /// Memory data bus width Defines the external memory device width, valid for all type of memories.
        MWID: MWID,
        /// Flash access enable Enables NOR Flash memory access operations.
        FACCEN: u1,
        reserved8: u1 = 0,
        /// Burst enable bit This bit enables/disables synchronous accesses during read operations. It is valid only for synchronous memories operating in Burst mode.
        BURSTEN: u1,
        /// Wait signal polarity bit Defines the polarity of the wait signal from memory used for either in Synchronous or Asynchronous mode.
        WAITPOL: WAITPOL,
        reserved11: u1 = 0,
        /// Wait timing configuration The NWAIT signal indicates whether the data from the memory are valid or if a wait state must be inserted when accessing the memory in Synchronous mode. This configuration bit determines if NWAIT is asserted by the memory one clock cycle before the wait state or during the wait state:.
        WAITCFG: WAITCFG,
        /// Write enable bit This bit indicates whether write operations are enabled/disabled in the bank by the FMC.
        WREN: u1,
        /// Wait enable bit This bit enables/disables wait-state insertion via the NWAIT signal when accessing the memory in Synchronous mode.
        WAITEN: u1,
        /// Extended mode enable This bit enables the FMC to program the write timings for non multiplexed asynchronous accesses inside the FMC_BWTR register, thus resulting in different timings for read and write operations. Note: When the Extended mode is disabled, the FMC can operate in mode 1 or mode 2 as follows: Mode 1 is the default mode when the SRAM/PSRAM memory type is selected (MTYP = 0x0 or 0x01) Mode 2 is the default mode when the NOR memory type is selected (MTYP = 0x10).
        EXTMOD: u1,
        /// Wait signal during asynchronous transfers This bit enables/disables the FMC to use the wait signal even during an asynchronous protocol.
        ASYNCWAIT: u1,
        /// CRAM page size These are used for CellularRAM™ 1.5 which does not allow burst access to cross the address boundaries between pages. When these bits are configured, the FMC controller splits automatically the burst access when the memory page size is reached (refer to memory datasheet for page size). Others: reserved.
        CPSIZE: CPSIZE,
        /// Write burst enable For PSRAM (CRAM) operating in Burst mode, the bit enables synchronous accesses during write operations. The enable bit for synchronous read accesses is the BURSTEN bit in the FMC_BCRx register.
        CBURSTRW: CBURSTRW,
        /// Continuous clock enable This bit enables the FMC_CLK clock output to external memory devices. Note: The CCLKEN bit of the FMC_BCR2..4 registers is don’t care. It is only enabled through the FMC_BCR1 register. Bank 1 must be configured in Synchronous mode to generate the FMC_CLK continuous clock. Note: If CCLKEN bit is set, the FMC_CLK clock ratio is specified by CLKDIV value in the FMC_BTR1 register. CLKDIV in FMC_BWTR1 is don’t care. Note: If the Synchronous mode is used and CCLKEN bit is set, the synchronous memories connected to other banks than Bank 1 are clocked by the same clock (the CLKDIV value in the FMC_BTR2..4 and FMC_BWTR2..4 registers for other banks has no effect.).
        CCLKEN: u1,
        /// Write FIFO disable This bit disables the Write FIFO used by the FMC controller. Note: The WFDIS bit of the FMC_BCR2..4 registers is don’t care. It is only enabled through the FMC_BCR1 register.
        WFDIS: u1,
        /// Byte lane (NBL) setup These bits configure the NBL setup timing from NBLx low to chip select NEx low.
        NBLSET: u2,
        reserved31: u7 = 0,
        /// FMC controller enable This bit enables or disables the FMC controller. Note: The FMCEN bit of the FMC_BCR2..4 registers is don’t care. It is only enabled through the FMC_BCR1 register.
        FMCEN: u1,
    }),
    /// offset: 0x0c
    reserved12: [20]u8,
    /// PSRAM chip select counter register.
    /// offset: 0x20
    PCSCNTR: mmio.Mmio(packed struct(u32) {
        /// Chip select counter. These bits are written by software to define the maximum chip select low pulse duration. It is expressed in FMC_CLK cycles for synchronous accesses and in HCLK cycles for asynchronous accesses. The counter is disabled if the programmed value is 0.
        CSCOUNT: u16,
        /// (1/4 of CNTBEN) Counter Bank 1 enable This bit enables the chip select counter for PSRAM/NOR Bank 1.
        @"CNTBEN[0]": u1,
        /// (2/4 of CNTBEN) Counter Bank 1 enable This bit enables the chip select counter for PSRAM/NOR Bank 1.
        @"CNTBEN[1]": u1,
        /// (3/4 of CNTBEN) Counter Bank 1 enable This bit enables the chip select counter for PSRAM/NOR Bank 1.
        @"CNTBEN[2]": u1,
        /// (4/4 of CNTBEN) Counter Bank 1 enable This bit enables the chip select counter for PSRAM/NOR Bank 1.
        @"CNTBEN[3]": u1,
        padding: u12 = 0,
    }),
    /// offset: 0x24
    reserved36: [224]u8,
    /// SRAM/NOR-Flash write timing registers 1.
    /// offset: 0x104
    BWTR: mmio.Mmio(packed struct(u32) {
        /// Address setup phase duration. These bits are written by software to define the duration of the address setup phase in HCLK cycles (refer to Figure 21 to Figure 33), used in asynchronous accesses: ... Note: In synchronous accesses, this value is not used, the address setup phase is always 1 Flash clock period duration. In muxed mode, the minimum ADDSET value is 1.
        ADDSET: u4,
        /// Address-hold phase duration. These bits are written by software to define the duration of the address hold phase (refer to Figure 30 to Figure 33), used in asynchronous multiplexed accesses: ... Note: In synchronous NOR Flash accesses, this value is not used, the address hold phase is always 1 Flash clock period duration.
        ADDHLD: u4,
        /// Data-phase duration. These bits are written by software to define the duration of the data phase (refer to Figure 21 to Figure 33), used in asynchronous SRAM, PSRAM and NOR Flash memory accesses: ...
        DATAST: u8,
        /// Bus turnaround phase duration These bits are written by software to add a delay at the end of current write transaction to next transaction on the same bank. For FRAM memories, the bus turnaround delay should be configured to match the minimum t<sub>PC</sub> (precharge time) timings. The bus turnaround delay is inserted between any consecutive transactions on the same bank (read/read, write/write, read/write and write/read). The chip select is toggling between any consecutive accesses. (BUSTURN + 1)HCLK period ≥ tPC min ...
        BUSTURN: u4,
        reserved28: u8 = 0,
        /// Access mode. Specifies the asynchronous access modes as shown in the next timing diagrams.These bits are taken into account only when the EXTMOD bit in the FMC_BCRx register is 1.
        ACCMOD: ACCMOD,
        /// Data hold phase duration These bits are written by software to define the duration of the data hold phase in HCLK cycles (refer to Figure 21 to Figure 33), used in asynchronous write accesses:.
        DATAHLD: u2,
    }),
};

pub const SDRAM = extern struct {
    /// SDRAM control registers 1.
    /// offset: 0x00
    SDCR: [2]mmio.Mmio(packed struct(u32) {
        /// Number of column address bits These bits define the number of bits of a column address.
        NC: NC,
        /// Number of row address bits These bits define the number of bits of a row address.
        NR: NR,
        /// Memory data bus width. These bits define the memory device width.
        MWID: MWID,
        /// Number of internal banks This bit sets the number of internal banks.
        NB: NB,
        /// CAS Latency This bits sets the SDRAM CAS latency in number of memory clock cycles.
        CAS: CAS,
        /// Write protection This bit enables write mode access to the SDRAM bank.
        WP: u1,
        /// SDRAM clock configuration These bits define the SDRAM clock period for both SDRAM banks and allow disabling the clock before changing the frequency. In this case the SDRAM must be re-initialized. Note: The corresponding bits in the FMC_SDCR2 register are don’t care.
        SDCLK: SDCLK,
        /// Burst read This bit enables Burst read mode. The SDRAM controller anticipates the next read commands during the CAS latency and stores data in the Read FIFO. Note: The corresponding bit in the FMC_SDCR2 register is don’t care.
        RBURST: u1,
        /// Read pipe These bits define the delay, in clock cycles, for reading data after CAS latency. Note: The corresponding bits in the FMC_SDCR2 register is read only.
        RPIPE: RPIPE,
        padding: u17 = 0,
    }),
    /// SDRAM timing registers 1.
    /// offset: 0x08
    SDTR: [2]mmio.Mmio(packed struct(u32) {
        /// Load Mode Register to Active These bits define the delay between a Load Mode Register command and an Active or Refresh command in number of memory clock cycles. ....
        TMRD: u4,
        /// Exit Self-refresh delay These bits define the delay from releasing the Self-refresh command to issuing the Activate command in number of memory clock cycles. .... Note: If two SDRAM devices are used, the FMC_SDTR1 and FMC_SDTR2 must be programmed with the same TXSR timing corresponding to the slowest SDRAM device.
        TXSR: u4,
        /// Self refresh time These bits define the minimum Self-refresh period in number of memory clock cycles. ....
        TRAS: u4,
        /// Row cycle delay These bits define the delay between the Refresh command and the Activate command, as well as the delay between two consecutive Refresh commands. It is expressed in number of memory clock cycles. The TRC timing is only configured in the FMC_SDTR1 register. If two SDRAM devices are used, the TRC must be programmed with the timings of the slowest device. .... Note: TRC must match the TRC and TRFC (Auto Refresh period) timings defined in the SDRAM device datasheet. Note: The corresponding bits in the FMC_SDTR2 register are don’t care.
        TRC: u4,
        /// Recovery delay These bits define the delay between a Write and a Precharge command in number of memory clock cycles. .... Note: TWR must be programmed to match the write recovery time (t<sub>WR</sub>) defined in the SDRAM datasheet, and to guarantee that: Note: TWR ≥ TRAS - TRCD and TWR ≥TRC - TRCD - TRP Note: Example: TRAS= 4 cycles, TRCD= 2 cycles. So, TWR >= 2 cycles. TWR must be programmed to 0x1. Note: If two SDRAM devices are used, the FMC_SDTR1 and FMC_SDTR2 must be programmed with the same TWR timing corresponding to the slowest SDRAM device. Note: If only one SDRAM device is used, the TWR timing must be kept at reset value (0xF) for the not used bank.
        TWR: u4,
        /// Row precharge delay These bits define the delay between a Precharge command and another command in number of memory clock cycles. The TRP timing is only configured in the FMC_SDTR1 register. If two SDRAM devices are used, the TRP must be programmed with the timing of the slowest device. .... Note: The corresponding bits in the FMC_SDTR2 register are don’t care.
        TRP: u4,
        /// Row to column delay These bits define the delay between the Activate command and a Read/Write command in number of memory clock cycles. ....
        TRCD: u4,
        padding: u4 = 0,
    }),
    /// SDRAM Command Mode register.
    /// offset: 0x10
    SDCMR: mmio.Mmio(packed struct(u32) {
        /// Command mode These bits define the command issued to the SDRAM device. Note: When a command is issued, at least one Command Target Bank bit ( CTB1 or CTB2) must be set otherwise the command will be ignored. Note: If two SDRAM banks are used, the Auto-refresh and PALL command must be issued simultaneously to the two devices with CTB1 and CTB2 bits set otherwise the command will be ignored. Note: If only one SDRAM bank is used and a command is issued with it’s associated CTB bit set, the other CTB bit of the the unused bank must be kept to 0.
        MODE: MODE,
        /// (1/2 of CTB) Command Target Bank 2 This bit indicates whether the command will be issued to SDRAM Bank 2 or not.
        @"CTB[0]": u1,
        /// (2/2 of CTB) Command Target Bank 2 This bit indicates whether the command will be issued to SDRAM Bank 2 or not.
        @"CTB[1]": u1,
        /// Number of Auto-refresh These bits define the number of consecutive Auto-refresh commands issued when MODE = ‘011’. ....
        NRFS: u4,
        /// Mode Register definition This 13-bit field defines the SDRAM Mode Register content. The Mode Register is programmed using the Load Mode Register command.
        MRD: u13,
        padding: u10 = 0,
    }),
    /// SDRAM refresh timer register.
    /// offset: 0x14
    SDRTR: mmio.Mmio(packed struct(u32) {
        /// Clear Refresh error flag This bit is used to clear the Refresh Error Flag (RE) in the Status Register.
        CRE: u1,
        /// Refresh Timer Count This 13-bit field defines the refresh rate of the SDRAM device. It is expressed in number of memory clock cycles. It must be set at least to 41 SDRAM clock cycles (0x29). Refresh rate = (COUNT + 1) x SDRAM frequency clock COUNT = (SDRAM refresh period / Number of rows) - 20.
        COUNT: u13,
        /// RES Interrupt Enable.
        REIE: u1,
        padding: u17 = 0,
    }),
    /// SDRAM status register.
    /// offset: 0x18
    SDSR: mmio.Mmio(packed struct(u32) {
        /// Refresh error flag An interrupt is generated if REIE = 1 and RE = 1.
        RE: u1,
        /// (1/2 of MODES) Status Mode for Bank 1 This bit defines the Status Mode of SDRAM Bank 1.
        @"MODES[0]": MODES,
        /// (2/2 of MODES) Status Mode for Bank 1 This bit defines the Status Mode of SDRAM Bank 1.
        @"MODES[1]": MODES,
        /// Busy status This bit defines the status of the SDRAM controller after a Command Mode request 1; SDRAM Controller is not ready to accept a new request.
        BUSY: u1,
        padding: u26 = 0,
    }),
};
