// generated using svd2zig.py
// DO NOT EDIT
// based on STM32F103xx version 1.3
const mmio = @import("microzig-mmio").mmio;
const Name = "STM32F103xx";
pub const FSMC = extern struct {
    pub const Address: u32 = 0xa0000000;
    // byte offset: 0 SRAM/NOR-Flash chip-select control register 1
    pub const BCR1 = mmio(Address + 0x00000000, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        reserved2: u1 = 0,
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 SRAM/NOR-Flash chip-select timing register 1
    pub const BTR1 = mmio(Address + 0x00000004, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 SRAM/NOR-Flash chip-select control register 2
    pub const BCR2 = mmio(Address + 0x00000008, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        WRAPMOD: u1, // bit offset: 10 desc: WRAPMOD
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 SRAM/NOR-Flash chip-select timing register 2
    pub const BTR2 = mmio(Address + 0x0000000c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 SRAM/NOR-Flash chip-select control register 3
    pub const BCR3 = mmio(Address + 0x00000010, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        WRAPMOD: u1, // bit offset: 10 desc: WRAPMOD
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 SRAM/NOR-Flash chip-select timing register 3
    pub const BTR3 = mmio(Address + 0x00000014, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 SRAM/NOR-Flash chip-select control register 4
    pub const BCR4 = mmio(Address + 0x00000018, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        WRAPMOD: u1, // bit offset: 10 desc: WRAPMOD
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 SRAM/NOR-Flash chip-select timing register 4
    pub const BTR4 = mmio(Address + 0x0000001c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 PC Card/NAND Flash control register 2
    pub const PCR2 = mmio(Address + 0x00000060, 32, packed struct {
        reserved1: u1 = 0,
        PWAITEN: u1, // bit offset: 1 desc: PWAITEN
        PBKEN: u1, // bit offset: 2 desc: PBKEN
        PTYP: u1, // bit offset: 3 desc: PTYP
        PWID: u2, // bit offset: 4 desc: PWID
        ECCEN: u1, // bit offset: 6 desc: ECCEN
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TCLR: u4, // bit offset: 9 desc: TCLR
        TAR: u4, // bit offset: 13 desc: TAR
        ECCPS: u3, // bit offset: 17 desc: ECCPS
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 100 FIFO status and interrupt register 2
    pub const SR2 = mmio(Address + 0x00000064, 32, packed struct {
        IRS: u1, // bit offset: 0 desc: IRS
        ILS: u1, // bit offset: 1 desc: ILS
        IFS: u1, // bit offset: 2 desc: IFS
        IREN: u1, // bit offset: 3 desc: IREN
        ILEN: u1, // bit offset: 4 desc: ILEN
        IFEN: u1, // bit offset: 5 desc: IFEN
        FEMPT: u1, // bit offset: 6 desc: FEMPT
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 104 Common memory space timing register 2
    pub const PMEM2 = mmio(Address + 0x00000068, 32, packed struct {
        MEMSETx: u8, // bit offset: 0 desc: MEMSETx
        MEMWAITx: u8, // bit offset: 8 desc: MEMWAITx
        MEMHOLDx: u8, // bit offset: 16 desc: MEMHOLDx
        MEMHIZx: u8, // bit offset: 24 desc: MEMHIZx
    });
    // byte offset: 108 Attribute memory space timing register 2
    pub const PATT2 = mmio(Address + 0x0000006c, 32, packed struct {
        ATTSETx: u8, // bit offset: 0 desc: Attribute memory x setup time
        ATTWAITx: u8, // bit offset: 8 desc: Attribute memory x wait time
        ATTHOLDx: u8, // bit offset: 16 desc: Attribute memory x hold time
        ATTHIZx: u8, // bit offset: 24 desc: Attribute memory x databus HiZ time
    });
    // byte offset: 116 ECC result register 2
    pub const ECCR2 = mmio(Address + 0x00000074, 32, packed struct {
        ECCx: u32, // bit offset: 0 desc: ECC result
    });
    // byte offset: 128 PC Card/NAND Flash control register 3
    pub const PCR3 = mmio(Address + 0x00000080, 32, packed struct {
        reserved1: u1 = 0,
        PWAITEN: u1, // bit offset: 1 desc: PWAITEN
        PBKEN: u1, // bit offset: 2 desc: PBKEN
        PTYP: u1, // bit offset: 3 desc: PTYP
        PWID: u2, // bit offset: 4 desc: PWID
        ECCEN: u1, // bit offset: 6 desc: ECCEN
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TCLR: u4, // bit offset: 9 desc: TCLR
        TAR: u4, // bit offset: 13 desc: TAR
        ECCPS: u3, // bit offset: 17 desc: ECCPS
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 FIFO status and interrupt register 3
    pub const SR3 = mmio(Address + 0x00000084, 32, packed struct {
        IRS: u1, // bit offset: 0 desc: IRS
        ILS: u1, // bit offset: 1 desc: ILS
        IFS: u1, // bit offset: 2 desc: IFS
        IREN: u1, // bit offset: 3 desc: IREN
        ILEN: u1, // bit offset: 4 desc: ILEN
        IFEN: u1, // bit offset: 5 desc: IFEN
        FEMPT: u1, // bit offset: 6 desc: FEMPT
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 Common memory space timing register 3
    pub const PMEM3 = mmio(Address + 0x00000088, 32, packed struct {
        MEMSETx: u8, // bit offset: 0 desc: MEMSETx
        MEMWAITx: u8, // bit offset: 8 desc: MEMWAITx
        MEMHOLDx: u8, // bit offset: 16 desc: MEMHOLDx
        MEMHIZx: u8, // bit offset: 24 desc: MEMHIZx
    });
    // byte offset: 140 Attribute memory space timing register 3
    pub const PATT3 = mmio(Address + 0x0000008c, 32, packed struct {
        ATTSETx: u8, // bit offset: 0 desc: ATTSETx
        ATTWAITx: u8, // bit offset: 8 desc: ATTWAITx
        ATTHOLDx: u8, // bit offset: 16 desc: ATTHOLDx
        ATTHIZx: u8, // bit offset: 24 desc: ATTHIZx
    });
    // byte offset: 148 ECC result register 3
    pub const ECCR3 = mmio(Address + 0x00000094, 32, packed struct {
        ECCx: u32, // bit offset: 0 desc: ECCx
    });
    // byte offset: 160 PC Card/NAND Flash control register 4
    pub const PCR4 = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        PWAITEN: u1, // bit offset: 1 desc: PWAITEN
        PBKEN: u1, // bit offset: 2 desc: PBKEN
        PTYP: u1, // bit offset: 3 desc: PTYP
        PWID: u2, // bit offset: 4 desc: PWID
        ECCEN: u1, // bit offset: 6 desc: ECCEN
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TCLR: u4, // bit offset: 9 desc: TCLR
        TAR: u4, // bit offset: 13 desc: TAR
        ECCPS: u3, // bit offset: 17 desc: ECCPS
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 164 FIFO status and interrupt register 4
    pub const SR4 = mmio(Address + 0x000000a4, 32, packed struct {
        IRS: u1, // bit offset: 0 desc: IRS
        ILS: u1, // bit offset: 1 desc: ILS
        IFS: u1, // bit offset: 2 desc: IFS
        IREN: u1, // bit offset: 3 desc: IREN
        ILEN: u1, // bit offset: 4 desc: ILEN
        IFEN: u1, // bit offset: 5 desc: IFEN
        FEMPT: u1, // bit offset: 6 desc: FEMPT
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 168 Common memory space timing register 4
    pub const PMEM4 = mmio(Address + 0x000000a8, 32, packed struct {
        MEMSETx: u8, // bit offset: 0 desc: MEMSETx
        MEMWAITx: u8, // bit offset: 8 desc: MEMWAITx
        MEMHOLDx: u8, // bit offset: 16 desc: MEMHOLDx
        MEMHIZx: u8, // bit offset: 24 desc: MEMHIZx
    });
    // byte offset: 172 Attribute memory space timing register 4
    pub const PATT4 = mmio(Address + 0x000000ac, 32, packed struct {
        ATTSETx: u8, // bit offset: 0 desc: ATTSETx
        ATTWAITx: u8, // bit offset: 8 desc: ATTWAITx
        ATTHOLDx: u8, // bit offset: 16 desc: ATTHOLDx
        ATTHIZx: u8, // bit offset: 24 desc: ATTHIZx
    });
    // byte offset: 176 I/O space timing register 4
    pub const PIO4 = mmio(Address + 0x000000b0, 32, packed struct {
        IOSETx: u8, // bit offset: 0 desc: IOSETx
        IOWAITx: u8, // bit offset: 8 desc: IOWAITx
        IOHOLDx: u8, // bit offset: 16 desc: IOHOLDx
        IOHIZx: u8, // bit offset: 24 desc: IOHIZx
    });
    // byte offset: 260 SRAM/NOR-Flash write timing registers 1
    pub const BWTR1 = mmio(Address + 0x00000104, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 268 SRAM/NOR-Flash write timing registers 2
    pub const BWTR2 = mmio(Address + 0x0000010c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 276 SRAM/NOR-Flash write timing registers 3
    pub const BWTR3 = mmio(Address + 0x00000114, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 284 SRAM/NOR-Flash write timing registers 4
    pub const BWTR4 = mmio(Address + 0x0000011c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const PWR = extern struct {
    pub const Address: u32 = 0x40007000;
    // byte offset: 0 Power control register (PWR_CR)
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        LPDS: u1, // bit offset: 0 desc: Low Power Deep Sleep
        PDDS: u1, // bit offset: 1 desc: Power Down Deep Sleep
        CWUF: u1, // bit offset: 2 desc: Clear Wake-up Flag
        CSBF: u1, // bit offset: 3 desc: Clear STANDBY Flag
        PVDE: u1, // bit offset: 4 desc: Power Voltage Detector Enable
        PLS: u3, // bit offset: 5 desc: PVD Level Selection
        DBP: u1, // bit offset: 8 desc: Disable Backup Domain write protection
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Power control register (PWR_CR)
    pub const CSR = mmio(Address + 0x00000004, 32, packed struct {
        WUF: u1, // bit offset: 0 desc: Wake-Up Flag
        SBF: u1, // bit offset: 1 desc: STANDBY Flag
        PVDO: u1, // bit offset: 2 desc: PVD Output
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        EWUP: u1, // bit offset: 8 desc: Enable WKUP pin
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const RCC = extern struct {
    pub const Address: u32 = 0x40021000;
    // byte offset: 0 Clock control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        HSION: u1, // bit offset: 0 desc: Internal High Speed clock enable
        HSIRDY: u1, // bit offset: 1 desc: Internal High Speed clock ready flag
        reserved1: u1 = 0,
        HSITRIM: u5, // bit offset: 3 desc: Internal High Speed clock trimming
        HSICAL: u8, // bit offset: 8 desc: Internal High Speed clock Calibration
        HSEON: u1, // bit offset: 16 desc: External High Speed clock enable
        HSERDY: u1, // bit offset: 17 desc: External High Speed clock ready flag
        HSEBYP: u1, // bit offset: 18 desc: External High Speed clock Bypass
        CSSON: u1, // bit offset: 19 desc: Clock Security System enable
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        PLLON: u1, // bit offset: 24 desc: PLL enable
        PLLRDY: u1, // bit offset: 25 desc: PLL clock ready flag
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Clock configuration register (RCC_CFGR)
    pub const CFGR = mmio(Address + 0x00000004, 32, packed struct {
        SW: u2, // bit offset: 0 desc: System clock Switch
        SWS: u2, // bit offset: 2 desc: System Clock Switch Status
        HPRE: u4, // bit offset: 4 desc: AHB prescaler
        PPRE1: u3, // bit offset: 8 desc: APB Low speed prescaler (APB1)
        PPRE2: u3, // bit offset: 11 desc: APB High speed prescaler (APB2)
        ADCPRE: u2, // bit offset: 14 desc: ADC prescaler
        PLLSRC: u1, // bit offset: 16 desc: PLL entry clock source
        PLLXTPRE: u1, // bit offset: 17 desc: HSE divider for PLL entry
        PLLMUL: u4, // bit offset: 18 desc: PLL Multiplication Factor
        OTGFSPRE: u1, // bit offset: 22 desc: USB OTG FS prescaler
        reserved1: u1 = 0,
        MCO: u3, // bit offset: 24 desc: Microcontroller clock output
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Clock interrupt register (RCC_CIR)
    pub const CIR = mmio(Address + 0x00000008, 32, packed struct {
        LSIRDYF: u1, // bit offset: 0 desc: LSI Ready Interrupt flag
        LSERDYF: u1, // bit offset: 1 desc: LSE Ready Interrupt flag
        HSIRDYF: u1, // bit offset: 2 desc: HSI Ready Interrupt flag
        HSERDYF: u1, // bit offset: 3 desc: HSE Ready Interrupt flag
        PLLRDYF: u1, // bit offset: 4 desc: PLL Ready Interrupt flag
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CSSF: u1, // bit offset: 7 desc: Clock Security System Interrupt flag
        LSIRDYIE: u1, // bit offset: 8 desc: LSI Ready Interrupt Enable
        LSERDYIE: u1, // bit offset: 9 desc: LSE Ready Interrupt Enable
        HSIRDYIE: u1, // bit offset: 10 desc: HSI Ready Interrupt Enable
        HSERDYIE: u1, // bit offset: 11 desc: HSE Ready Interrupt Enable
        PLLRDYIE: u1, // bit offset: 12 desc: PLL Ready Interrupt Enable
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        LSIRDYC: u1, // bit offset: 16 desc: LSI Ready Interrupt Clear
        LSERDYC: u1, // bit offset: 17 desc: LSE Ready Interrupt Clear
        HSIRDYC: u1, // bit offset: 18 desc: HSI Ready Interrupt Clear
        HSERDYC: u1, // bit offset: 19 desc: HSE Ready Interrupt Clear
        PLLRDYC: u1, // bit offset: 20 desc: PLL Ready Interrupt Clear
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        CSSC: u1, // bit offset: 23 desc: Clock security system interrupt clear
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 APB2 peripheral reset register (RCC_APB2RSTR)
    pub const APB2RSTR = mmio(Address + 0x0000000c, 32, packed struct {
        AFIORST: u1, // bit offset: 0 desc: Alternate function I/O reset
        reserved1: u1 = 0,
        IOPARST: u1, // bit offset: 2 desc: IO port A reset
        IOPBRST: u1, // bit offset: 3 desc: IO port B reset
        IOPCRST: u1, // bit offset: 4 desc: IO port C reset
        IOPDRST: u1, // bit offset: 5 desc: IO port D reset
        IOPERST: u1, // bit offset: 6 desc: IO port E reset
        IOPFRST: u1, // bit offset: 7 desc: IO port F reset
        IOPGRST: u1, // bit offset: 8 desc: IO port G reset
        ADC1RST: u1, // bit offset: 9 desc: ADC 1 interface reset
        ADC2RST: u1, // bit offset: 10 desc: ADC 2 interface reset
        TIM1RST: u1, // bit offset: 11 desc: TIM1 timer reset
        SPI1RST: u1, // bit offset: 12 desc: SPI 1 reset
        TIM8RST: u1, // bit offset: 13 desc: TIM8 timer reset
        USART1RST: u1, // bit offset: 14 desc: USART1 reset
        ADC3RST: u1, // bit offset: 15 desc: ADC 3 interface reset
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TIM9RST: u1, // bit offset: 19 desc: TIM9 timer reset
        TIM10RST: u1, // bit offset: 20 desc: TIM10 timer reset
        TIM11RST: u1, // bit offset: 21 desc: TIM11 timer reset
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 APB1 peripheral reset register (RCC_APB1RSTR)
    pub const APB1RSTR = mmio(Address + 0x00000010, 32, packed struct {
        TIM2RST: u1, // bit offset: 0 desc: Timer 2 reset
        TIM3RST: u1, // bit offset: 1 desc: Timer 3 reset
        TIM4RST: u1, // bit offset: 2 desc: Timer 4 reset
        TIM5RST: u1, // bit offset: 3 desc: Timer 5 reset
        TIM6RST: u1, // bit offset: 4 desc: Timer 6 reset
        TIM7RST: u1, // bit offset: 5 desc: Timer 7 reset
        TIM12RST: u1, // bit offset: 6 desc: Timer 12 reset
        TIM13RST: u1, // bit offset: 7 desc: Timer 13 reset
        TIM14RST: u1, // bit offset: 8 desc: Timer 14 reset
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        WWDGRST: u1, // bit offset: 11 desc: Window watchdog reset
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        SPI2RST: u1, // bit offset: 14 desc: SPI2 reset
        SPI3RST: u1, // bit offset: 15 desc: SPI3 reset
        reserved5: u1 = 0,
        USART2RST: u1, // bit offset: 17 desc: USART 2 reset
        USART3RST: u1, // bit offset: 18 desc: USART 3 reset
        UART4RST: u1, // bit offset: 19 desc: UART 4 reset
        UART5RST: u1, // bit offset: 20 desc: UART 5 reset
        I2C1RST: u1, // bit offset: 21 desc: I2C1 reset
        I2C2RST: u1, // bit offset: 22 desc: I2C2 reset
        USBRST: u1, // bit offset: 23 desc: USB reset
        reserved6: u1 = 0,
        CANRST: u1, // bit offset: 25 desc: CAN reset
        reserved7: u1 = 0,
        BKPRST: u1, // bit offset: 27 desc: Backup interface reset
        PWRRST: u1, // bit offset: 28 desc: Power interface reset
        DACRST: u1, // bit offset: 29 desc: DAC interface reset
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 AHB Peripheral Clock enable register (RCC_AHBENR)
    pub const AHBENR = mmio(Address + 0x00000014, 32, packed struct {
        DMA1EN: u1, // bit offset: 0 desc: DMA1 clock enable
        DMA2EN: u1, // bit offset: 1 desc: DMA2 clock enable
        SRAMEN: u1, // bit offset: 2 desc: SRAM interface clock enable
        reserved1: u1 = 0,
        FLITFEN: u1, // bit offset: 4 desc: FLITF clock enable
        reserved2: u1 = 0,
        CRCEN: u1, // bit offset: 6 desc: CRC clock enable
        reserved3: u1 = 0,
        FSMCEN: u1, // bit offset: 8 desc: FSMC clock enable
        reserved4: u1 = 0,
        SDIOEN: u1, // bit offset: 10 desc: SDIO clock enable
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 APB2 peripheral clock enable register (RCC_APB2ENR)
    pub const APB2ENR = mmio(Address + 0x00000018, 32, packed struct {
        AFIOEN: u1, // bit offset: 0 desc: Alternate function I/O clock enable
        reserved1: u1 = 0,
        IOPAEN: u1, // bit offset: 2 desc: I/O port A clock enable
        IOPBEN: u1, // bit offset: 3 desc: I/O port B clock enable
        IOPCEN: u1, // bit offset: 4 desc: I/O port C clock enable
        IOPDEN: u1, // bit offset: 5 desc: I/O port D clock enable
        IOPEEN: u1, // bit offset: 6 desc: I/O port E clock enable
        IOPFEN: u1, // bit offset: 7 desc: I/O port F clock enable
        IOPGEN: u1, // bit offset: 8 desc: I/O port G clock enable
        ADC1EN: u1, // bit offset: 9 desc: ADC 1 interface clock enable
        ADC2EN: u1, // bit offset: 10 desc: ADC 2 interface clock enable
        TIM1EN: u1, // bit offset: 11 desc: TIM1 Timer clock enable
        SPI1EN: u1, // bit offset: 12 desc: SPI 1 clock enable
        TIM8EN: u1, // bit offset: 13 desc: TIM8 Timer clock enable
        USART1EN: u1, // bit offset: 14 desc: USART1 clock enable
        ADC3EN: u1, // bit offset: 15 desc: ADC3 interface clock enable
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TIM9EN: u1, // bit offset: 19 desc: TIM9 Timer clock enable
        TIM10EN: u1, // bit offset: 20 desc: TIM10 Timer clock enable
        TIM11EN: u1, // bit offset: 21 desc: TIM11 Timer clock enable
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 APB1 peripheral clock enable register (RCC_APB1ENR)
    pub const APB1ENR = mmio(Address + 0x0000001c, 32, packed struct {
        TIM2EN: u1, // bit offset: 0 desc: Timer 2 clock enable
        TIM3EN: u1, // bit offset: 1 desc: Timer 3 clock enable
        TIM4EN: u1, // bit offset: 2 desc: Timer 4 clock enable
        TIM5EN: u1, // bit offset: 3 desc: Timer 5 clock enable
        TIM6EN: u1, // bit offset: 4 desc: Timer 6 clock enable
        TIM7EN: u1, // bit offset: 5 desc: Timer 7 clock enable
        TIM12EN: u1, // bit offset: 6 desc: Timer 12 clock enable
        TIM13EN: u1, // bit offset: 7 desc: Timer 13 clock enable
        TIM14EN: u1, // bit offset: 8 desc: Timer 14 clock enable
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        WWDGEN: u1, // bit offset: 11 desc: Window watchdog clock enable
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        SPI2EN: u1, // bit offset: 14 desc: SPI 2 clock enable
        SPI3EN: u1, // bit offset: 15 desc: SPI 3 clock enable
        reserved5: u1 = 0,
        USART2EN: u1, // bit offset: 17 desc: USART 2 clock enable
        USART3EN: u1, // bit offset: 18 desc: USART 3 clock enable
        UART4EN: u1, // bit offset: 19 desc: UART 4 clock enable
        UART5EN: u1, // bit offset: 20 desc: UART 5 clock enable
        I2C1EN: u1, // bit offset: 21 desc: I2C 1 clock enable
        I2C2EN: u1, // bit offset: 22 desc: I2C 2 clock enable
        USBEN: u1, // bit offset: 23 desc: USB clock enable
        reserved6: u1 = 0,
        CANEN: u1, // bit offset: 25 desc: CAN clock enable
        reserved7: u1 = 0,
        BKPEN: u1, // bit offset: 27 desc: Backup interface clock enable
        PWREN: u1, // bit offset: 28 desc: Power interface clock enable
        DACEN: u1, // bit offset: 29 desc: DAC interface clock enable
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Backup domain control register (RCC_BDCR)
    pub const BDCR = mmio(Address + 0x00000020, 32, packed struct {
        LSEON: u1, // bit offset: 0 desc: External Low Speed oscillator enable
        LSERDY: u1, // bit offset: 1 desc: External Low Speed oscillator ready
        LSEBYP: u1, // bit offset: 2 desc: External Low Speed oscillator bypass
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        RTCSEL: u2, // bit offset: 8 desc: RTC clock source selection
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        RTCEN: u1, // bit offset: 15 desc: RTC clock enable
        BDRST: u1, // bit offset: 16 desc: Backup domain software reset
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Control/status register (RCC_CSR)
    pub const CSR = mmio(Address + 0x00000024, 32, packed struct {
        LSION: u1, // bit offset: 0 desc: Internal low speed oscillator enable
        LSIRDY: u1, // bit offset: 1 desc: Internal low speed oscillator ready
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        RMVF: u1, // bit offset: 24 desc: Remove reset flag
        reserved23: u1 = 0,
        PINRSTF: u1, // bit offset: 26 desc: PIN reset flag
        PORRSTF: u1, // bit offset: 27 desc: POR/PDR reset flag
        SFTRSTF: u1, // bit offset: 28 desc: Software reset flag
        IWDGRSTF: u1, // bit offset: 29 desc: Independent watchdog reset flag
        WWDGRSTF: u1, // bit offset: 30 desc: Window watchdog reset flag
        LPWRRSTF: u1, // bit offset: 31 desc: Low-power reset flag
    });
};
pub const GPIOA = extern struct {
    pub const Address: u32 = 0x40010800;
    // byte offset: 0 Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        MODE0: u2, // bit offset: 0 desc: Port n.0 mode bits
        CNF0: u2, // bit offset: 2 desc: Port n.0 configuration bits
        MODE1: u2, // bit offset: 4 desc: Port n.1 mode bits
        CNF1: u2, // bit offset: 6 desc: Port n.1 configuration bits
        MODE2: u2, // bit offset: 8 desc: Port n.2 mode bits
        CNF2: u2, // bit offset: 10 desc: Port n.2 configuration bits
        MODE3: u2, // bit offset: 12 desc: Port n.3 mode bits
        CNF3: u2, // bit offset: 14 desc: Port n.3 configuration bits
        MODE4: u2, // bit offset: 16 desc: Port n.4 mode bits
        CNF4: u2, // bit offset: 18 desc: Port n.4 configuration bits
        MODE5: u2, // bit offset: 20 desc: Port n.5 mode bits
        CNF5: u2, // bit offset: 22 desc: Port n.5 configuration bits
        MODE6: u2, // bit offset: 24 desc: Port n.6 mode bits
        CNF6: u2, // bit offset: 26 desc: Port n.6 configuration bits
        MODE7: u2, // bit offset: 28 desc: Port n.7 mode bits
        CNF7: u2, // bit offset: 30 desc: Port n.7 configuration bits
    });
    // byte offset: 4 Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        MODE8: u2, // bit offset: 0 desc: Port n.8 mode bits
        CNF8: u2, // bit offset: 2 desc: Port n.8 configuration bits
        MODE9: u2, // bit offset: 4 desc: Port n.9 mode bits
        CNF9: u2, // bit offset: 6 desc: Port n.9 configuration bits
        MODE10: u2, // bit offset: 8 desc: Port n.10 mode bits
        CNF10: u2, // bit offset: 10 desc: Port n.10 configuration bits
        MODE11: u2, // bit offset: 12 desc: Port n.11 mode bits
        CNF11: u2, // bit offset: 14 desc: Port n.11 configuration bits
        MODE12: u2, // bit offset: 16 desc: Port n.12 mode bits
        CNF12: u2, // bit offset: 18 desc: Port n.12 configuration bits
        MODE13: u2, // bit offset: 20 desc: Port n.13 mode bits
        CNF13: u2, // bit offset: 22 desc: Port n.13 configuration bits
        MODE14: u2, // bit offset: 24 desc: Port n.14 mode bits
        CNF14: u2, // bit offset: 26 desc: Port n.14 configuration bits
        MODE15: u2, // bit offset: 28 desc: Port n.15 mode bits
        CNF15: u2, // bit offset: 30 desc: Port n.15 configuration bits
    });
    // byte offset: 8 Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data
        IDR1: u1, // bit offset: 1 desc: Port input data
        IDR2: u1, // bit offset: 2 desc: Port input data
        IDR3: u1, // bit offset: 3 desc: Port input data
        IDR4: u1, // bit offset: 4 desc: Port input data
        IDR5: u1, // bit offset: 5 desc: Port input data
        IDR6: u1, // bit offset: 6 desc: Port input data
        IDR7: u1, // bit offset: 7 desc: Port input data
        IDR8: u1, // bit offset: 8 desc: Port input data
        IDR9: u1, // bit offset: 9 desc: Port input data
        IDR10: u1, // bit offset: 10 desc: Port input data
        IDR11: u1, // bit offset: 11 desc: Port input data
        IDR12: u1, // bit offset: 12 desc: Port input data
        IDR13: u1, // bit offset: 13 desc: Port input data
        IDR14: u1, // bit offset: 14 desc: Port input data
        IDR15: u1, // bit offset: 15 desc: Port input data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data
        ODR1: u1, // bit offset: 1 desc: Port output data
        ODR2: u1, // bit offset: 2 desc: Port output data
        ODR3: u1, // bit offset: 3 desc: Port output data
        ODR4: u1, // bit offset: 4 desc: Port output data
        ODR5: u1, // bit offset: 5 desc: Port output data
        ODR6: u1, // bit offset: 6 desc: Port output data
        ODR7: u1, // bit offset: 7 desc: Port output data
        ODR8: u1, // bit offset: 8 desc: Port output data
        ODR9: u1, // bit offset: 9 desc: Port output data
        ODR10: u1, // bit offset: 10 desc: Port output data
        ODR11: u1, // bit offset: 11 desc: Port output data
        ODR12: u1, // bit offset: 12 desc: Port output data
        ODR13: u1, // bit offset: 13 desc: Port output data
        ODR14: u1, // bit offset: 14 desc: Port output data
        ODR15: u1, // bit offset: 15 desc: Port output data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Set bit 0
        BS1: u1, // bit offset: 1 desc: Set bit 1
        BS2: u1, // bit offset: 2 desc: Set bit 1
        BS3: u1, // bit offset: 3 desc: Set bit 3
        BS4: u1, // bit offset: 4 desc: Set bit 4
        BS5: u1, // bit offset: 5 desc: Set bit 5
        BS6: u1, // bit offset: 6 desc: Set bit 6
        BS7: u1, // bit offset: 7 desc: Set bit 7
        BS8: u1, // bit offset: 8 desc: Set bit 8
        BS9: u1, // bit offset: 9 desc: Set bit 9
        BS10: u1, // bit offset: 10 desc: Set bit 10
        BS11: u1, // bit offset: 11 desc: Set bit 11
        BS12: u1, // bit offset: 12 desc: Set bit 12
        BS13: u1, // bit offset: 13 desc: Set bit 13
        BS14: u1, // bit offset: 14 desc: Set bit 14
        BS15: u1, // bit offset: 15 desc: Set bit 15
        BR0: u1, // bit offset: 16 desc: Reset bit 0
        BR1: u1, // bit offset: 17 desc: Reset bit 1
        BR2: u1, // bit offset: 18 desc: Reset bit 2
        BR3: u1, // bit offset: 19 desc: Reset bit 3
        BR4: u1, // bit offset: 20 desc: Reset bit 4
        BR5: u1, // bit offset: 21 desc: Reset bit 5
        BR6: u1, // bit offset: 22 desc: Reset bit 6
        BR7: u1, // bit offset: 23 desc: Reset bit 7
        BR8: u1, // bit offset: 24 desc: Reset bit 8
        BR9: u1, // bit offset: 25 desc: Reset bit 9
        BR10: u1, // bit offset: 26 desc: Reset bit 10
        BR11: u1, // bit offset: 27 desc: Reset bit 11
        BR12: u1, // bit offset: 28 desc: Reset bit 12
        BR13: u1, // bit offset: 29 desc: Reset bit 13
        BR14: u1, // bit offset: 30 desc: Reset bit 14
        BR15: u1, // bit offset: 31 desc: Reset bit 15
    });
    // byte offset: 20 Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Reset bit 0
        BR1: u1, // bit offset: 1 desc: Reset bit 1
        BR2: u1, // bit offset: 2 desc: Reset bit 1
        BR3: u1, // bit offset: 3 desc: Reset bit 3
        BR4: u1, // bit offset: 4 desc: Reset bit 4
        BR5: u1, // bit offset: 5 desc: Reset bit 5
        BR6: u1, // bit offset: 6 desc: Reset bit 6
        BR7: u1, // bit offset: 7 desc: Reset bit 7
        BR8: u1, // bit offset: 8 desc: Reset bit 8
        BR9: u1, // bit offset: 9 desc: Reset bit 9
        BR10: u1, // bit offset: 10 desc: Reset bit 10
        BR11: u1, // bit offset: 11 desc: Reset bit 11
        BR12: u1, // bit offset: 12 desc: Reset bit 12
        BR13: u1, // bit offset: 13 desc: Reset bit 13
        BR14: u1, // bit offset: 14 desc: Reset bit 14
        BR15: u1, // bit offset: 15 desc: Reset bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port A Lock bit 0
        LCK1: u1, // bit offset: 1 desc: Port A Lock bit 1
        LCK2: u1, // bit offset: 2 desc: Port A Lock bit 2
        LCK3: u1, // bit offset: 3 desc: Port A Lock bit 3
        LCK4: u1, // bit offset: 4 desc: Port A Lock bit 4
        LCK5: u1, // bit offset: 5 desc: Port A Lock bit 5
        LCK6: u1, // bit offset: 6 desc: Port A Lock bit 6
        LCK7: u1, // bit offset: 7 desc: Port A Lock bit 7
        LCK8: u1, // bit offset: 8 desc: Port A Lock bit 8
        LCK9: u1, // bit offset: 9 desc: Port A Lock bit 9
        LCK10: u1, // bit offset: 10 desc: Port A Lock bit 10
        LCK11: u1, // bit offset: 11 desc: Port A Lock bit 11
        LCK12: u1, // bit offset: 12 desc: Port A Lock bit 12
        LCK13: u1, // bit offset: 13 desc: Port A Lock bit 13
        LCK14: u1, // bit offset: 14 desc: Port A Lock bit 14
        LCK15: u1, // bit offset: 15 desc: Port A Lock bit 15
        LCKK: u1, // bit offset: 16 desc: Lock key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const GPIOB = extern struct {
    pub const Address: u32 = 0x40010c00;
    // byte offset: 0 Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        MODE0: u2, // bit offset: 0 desc: Port n.0 mode bits
        CNF0: u2, // bit offset: 2 desc: Port n.0 configuration bits
        MODE1: u2, // bit offset: 4 desc: Port n.1 mode bits
        CNF1: u2, // bit offset: 6 desc: Port n.1 configuration bits
        MODE2: u2, // bit offset: 8 desc: Port n.2 mode bits
        CNF2: u2, // bit offset: 10 desc: Port n.2 configuration bits
        MODE3: u2, // bit offset: 12 desc: Port n.3 mode bits
        CNF3: u2, // bit offset: 14 desc: Port n.3 configuration bits
        MODE4: u2, // bit offset: 16 desc: Port n.4 mode bits
        CNF4: u2, // bit offset: 18 desc: Port n.4 configuration bits
        MODE5: u2, // bit offset: 20 desc: Port n.5 mode bits
        CNF5: u2, // bit offset: 22 desc: Port n.5 configuration bits
        MODE6: u2, // bit offset: 24 desc: Port n.6 mode bits
        CNF6: u2, // bit offset: 26 desc: Port n.6 configuration bits
        MODE7: u2, // bit offset: 28 desc: Port n.7 mode bits
        CNF7: u2, // bit offset: 30 desc: Port n.7 configuration bits
    });
    // byte offset: 4 Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        MODE8: u2, // bit offset: 0 desc: Port n.8 mode bits
        CNF8: u2, // bit offset: 2 desc: Port n.8 configuration bits
        MODE9: u2, // bit offset: 4 desc: Port n.9 mode bits
        CNF9: u2, // bit offset: 6 desc: Port n.9 configuration bits
        MODE10: u2, // bit offset: 8 desc: Port n.10 mode bits
        CNF10: u2, // bit offset: 10 desc: Port n.10 configuration bits
        MODE11: u2, // bit offset: 12 desc: Port n.11 mode bits
        CNF11: u2, // bit offset: 14 desc: Port n.11 configuration bits
        MODE12: u2, // bit offset: 16 desc: Port n.12 mode bits
        CNF12: u2, // bit offset: 18 desc: Port n.12 configuration bits
        MODE13: u2, // bit offset: 20 desc: Port n.13 mode bits
        CNF13: u2, // bit offset: 22 desc: Port n.13 configuration bits
        MODE14: u2, // bit offset: 24 desc: Port n.14 mode bits
        CNF14: u2, // bit offset: 26 desc: Port n.14 configuration bits
        MODE15: u2, // bit offset: 28 desc: Port n.15 mode bits
        CNF15: u2, // bit offset: 30 desc: Port n.15 configuration bits
    });
    // byte offset: 8 Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data
        IDR1: u1, // bit offset: 1 desc: Port input data
        IDR2: u1, // bit offset: 2 desc: Port input data
        IDR3: u1, // bit offset: 3 desc: Port input data
        IDR4: u1, // bit offset: 4 desc: Port input data
        IDR5: u1, // bit offset: 5 desc: Port input data
        IDR6: u1, // bit offset: 6 desc: Port input data
        IDR7: u1, // bit offset: 7 desc: Port input data
        IDR8: u1, // bit offset: 8 desc: Port input data
        IDR9: u1, // bit offset: 9 desc: Port input data
        IDR10: u1, // bit offset: 10 desc: Port input data
        IDR11: u1, // bit offset: 11 desc: Port input data
        IDR12: u1, // bit offset: 12 desc: Port input data
        IDR13: u1, // bit offset: 13 desc: Port input data
        IDR14: u1, // bit offset: 14 desc: Port input data
        IDR15: u1, // bit offset: 15 desc: Port input data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data
        ODR1: u1, // bit offset: 1 desc: Port output data
        ODR2: u1, // bit offset: 2 desc: Port output data
        ODR3: u1, // bit offset: 3 desc: Port output data
        ODR4: u1, // bit offset: 4 desc: Port output data
        ODR5: u1, // bit offset: 5 desc: Port output data
        ODR6: u1, // bit offset: 6 desc: Port output data
        ODR7: u1, // bit offset: 7 desc: Port output data
        ODR8: u1, // bit offset: 8 desc: Port output data
        ODR9: u1, // bit offset: 9 desc: Port output data
        ODR10: u1, // bit offset: 10 desc: Port output data
        ODR11: u1, // bit offset: 11 desc: Port output data
        ODR12: u1, // bit offset: 12 desc: Port output data
        ODR13: u1, // bit offset: 13 desc: Port output data
        ODR14: u1, // bit offset: 14 desc: Port output data
        ODR15: u1, // bit offset: 15 desc: Port output data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Set bit 0
        BS1: u1, // bit offset: 1 desc: Set bit 1
        BS2: u1, // bit offset: 2 desc: Set bit 1
        BS3: u1, // bit offset: 3 desc: Set bit 3
        BS4: u1, // bit offset: 4 desc: Set bit 4
        BS5: u1, // bit offset: 5 desc: Set bit 5
        BS6: u1, // bit offset: 6 desc: Set bit 6
        BS7: u1, // bit offset: 7 desc: Set bit 7
        BS8: u1, // bit offset: 8 desc: Set bit 8
        BS9: u1, // bit offset: 9 desc: Set bit 9
        BS10: u1, // bit offset: 10 desc: Set bit 10
        BS11: u1, // bit offset: 11 desc: Set bit 11
        BS12: u1, // bit offset: 12 desc: Set bit 12
        BS13: u1, // bit offset: 13 desc: Set bit 13
        BS14: u1, // bit offset: 14 desc: Set bit 14
        BS15: u1, // bit offset: 15 desc: Set bit 15
        BR0: u1, // bit offset: 16 desc: Reset bit 0
        BR1: u1, // bit offset: 17 desc: Reset bit 1
        BR2: u1, // bit offset: 18 desc: Reset bit 2
        BR3: u1, // bit offset: 19 desc: Reset bit 3
        BR4: u1, // bit offset: 20 desc: Reset bit 4
        BR5: u1, // bit offset: 21 desc: Reset bit 5
        BR6: u1, // bit offset: 22 desc: Reset bit 6
        BR7: u1, // bit offset: 23 desc: Reset bit 7
        BR8: u1, // bit offset: 24 desc: Reset bit 8
        BR9: u1, // bit offset: 25 desc: Reset bit 9
        BR10: u1, // bit offset: 26 desc: Reset bit 10
        BR11: u1, // bit offset: 27 desc: Reset bit 11
        BR12: u1, // bit offset: 28 desc: Reset bit 12
        BR13: u1, // bit offset: 29 desc: Reset bit 13
        BR14: u1, // bit offset: 30 desc: Reset bit 14
        BR15: u1, // bit offset: 31 desc: Reset bit 15
    });
    // byte offset: 20 Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Reset bit 0
        BR1: u1, // bit offset: 1 desc: Reset bit 1
        BR2: u1, // bit offset: 2 desc: Reset bit 1
        BR3: u1, // bit offset: 3 desc: Reset bit 3
        BR4: u1, // bit offset: 4 desc: Reset bit 4
        BR5: u1, // bit offset: 5 desc: Reset bit 5
        BR6: u1, // bit offset: 6 desc: Reset bit 6
        BR7: u1, // bit offset: 7 desc: Reset bit 7
        BR8: u1, // bit offset: 8 desc: Reset bit 8
        BR9: u1, // bit offset: 9 desc: Reset bit 9
        BR10: u1, // bit offset: 10 desc: Reset bit 10
        BR11: u1, // bit offset: 11 desc: Reset bit 11
        BR12: u1, // bit offset: 12 desc: Reset bit 12
        BR13: u1, // bit offset: 13 desc: Reset bit 13
        BR14: u1, // bit offset: 14 desc: Reset bit 14
        BR15: u1, // bit offset: 15 desc: Reset bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port A Lock bit 0
        LCK1: u1, // bit offset: 1 desc: Port A Lock bit 1
        LCK2: u1, // bit offset: 2 desc: Port A Lock bit 2
        LCK3: u1, // bit offset: 3 desc: Port A Lock bit 3
        LCK4: u1, // bit offset: 4 desc: Port A Lock bit 4
        LCK5: u1, // bit offset: 5 desc: Port A Lock bit 5
        LCK6: u1, // bit offset: 6 desc: Port A Lock bit 6
        LCK7: u1, // bit offset: 7 desc: Port A Lock bit 7
        LCK8: u1, // bit offset: 8 desc: Port A Lock bit 8
        LCK9: u1, // bit offset: 9 desc: Port A Lock bit 9
        LCK10: u1, // bit offset: 10 desc: Port A Lock bit 10
        LCK11: u1, // bit offset: 11 desc: Port A Lock bit 11
        LCK12: u1, // bit offset: 12 desc: Port A Lock bit 12
        LCK13: u1, // bit offset: 13 desc: Port A Lock bit 13
        LCK14: u1, // bit offset: 14 desc: Port A Lock bit 14
        LCK15: u1, // bit offset: 15 desc: Port A Lock bit 15
        LCKK: u1, // bit offset: 16 desc: Lock key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const GPIOC = extern struct {
    pub const Address: u32 = 0x40011000;
    // byte offset: 0 Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        MODE0: u2, // bit offset: 0 desc: Port n.0 mode bits
        CNF0: u2, // bit offset: 2 desc: Port n.0 configuration bits
        MODE1: u2, // bit offset: 4 desc: Port n.1 mode bits
        CNF1: u2, // bit offset: 6 desc: Port n.1 configuration bits
        MODE2: u2, // bit offset: 8 desc: Port n.2 mode bits
        CNF2: u2, // bit offset: 10 desc: Port n.2 configuration bits
        MODE3: u2, // bit offset: 12 desc: Port n.3 mode bits
        CNF3: u2, // bit offset: 14 desc: Port n.3 configuration bits
        MODE4: u2, // bit offset: 16 desc: Port n.4 mode bits
        CNF4: u2, // bit offset: 18 desc: Port n.4 configuration bits
        MODE5: u2, // bit offset: 20 desc: Port n.5 mode bits
        CNF5: u2, // bit offset: 22 desc: Port n.5 configuration bits
        MODE6: u2, // bit offset: 24 desc: Port n.6 mode bits
        CNF6: u2, // bit offset: 26 desc: Port n.6 configuration bits
        MODE7: u2, // bit offset: 28 desc: Port n.7 mode bits
        CNF7: u2, // bit offset: 30 desc: Port n.7 configuration bits
    });
    // byte offset: 4 Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        MODE8: u2, // bit offset: 0 desc: Port n.8 mode bits
        CNF8: u2, // bit offset: 2 desc: Port n.8 configuration bits
        MODE9: u2, // bit offset: 4 desc: Port n.9 mode bits
        CNF9: u2, // bit offset: 6 desc: Port n.9 configuration bits
        MODE10: u2, // bit offset: 8 desc: Port n.10 mode bits
        CNF10: u2, // bit offset: 10 desc: Port n.10 configuration bits
        MODE11: u2, // bit offset: 12 desc: Port n.11 mode bits
        CNF11: u2, // bit offset: 14 desc: Port n.11 configuration bits
        MODE12: u2, // bit offset: 16 desc: Port n.12 mode bits
        CNF12: u2, // bit offset: 18 desc: Port n.12 configuration bits
        MODE13: u2, // bit offset: 20 desc: Port n.13 mode bits
        CNF13: u2, // bit offset: 22 desc: Port n.13 configuration bits
        MODE14: u2, // bit offset: 24 desc: Port n.14 mode bits
        CNF14: u2, // bit offset: 26 desc: Port n.14 configuration bits
        MODE15: u2, // bit offset: 28 desc: Port n.15 mode bits
        CNF15: u2, // bit offset: 30 desc: Port n.15 configuration bits
    });
    // byte offset: 8 Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data
        IDR1: u1, // bit offset: 1 desc: Port input data
        IDR2: u1, // bit offset: 2 desc: Port input data
        IDR3: u1, // bit offset: 3 desc: Port input data
        IDR4: u1, // bit offset: 4 desc: Port input data
        IDR5: u1, // bit offset: 5 desc: Port input data
        IDR6: u1, // bit offset: 6 desc: Port input data
        IDR7: u1, // bit offset: 7 desc: Port input data
        IDR8: u1, // bit offset: 8 desc: Port input data
        IDR9: u1, // bit offset: 9 desc: Port input data
        IDR10: u1, // bit offset: 10 desc: Port input data
        IDR11: u1, // bit offset: 11 desc: Port input data
        IDR12: u1, // bit offset: 12 desc: Port input data
        IDR13: u1, // bit offset: 13 desc: Port input data
        IDR14: u1, // bit offset: 14 desc: Port input data
        IDR15: u1, // bit offset: 15 desc: Port input data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data
        ODR1: u1, // bit offset: 1 desc: Port output data
        ODR2: u1, // bit offset: 2 desc: Port output data
        ODR3: u1, // bit offset: 3 desc: Port output data
        ODR4: u1, // bit offset: 4 desc: Port output data
        ODR5: u1, // bit offset: 5 desc: Port output data
        ODR6: u1, // bit offset: 6 desc: Port output data
        ODR7: u1, // bit offset: 7 desc: Port output data
        ODR8: u1, // bit offset: 8 desc: Port output data
        ODR9: u1, // bit offset: 9 desc: Port output data
        ODR10: u1, // bit offset: 10 desc: Port output data
        ODR11: u1, // bit offset: 11 desc: Port output data
        ODR12: u1, // bit offset: 12 desc: Port output data
        ODR13: u1, // bit offset: 13 desc: Port output data
        ODR14: u1, // bit offset: 14 desc: Port output data
        ODR15: u1, // bit offset: 15 desc: Port output data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Set bit 0
        BS1: u1, // bit offset: 1 desc: Set bit 1
        BS2: u1, // bit offset: 2 desc: Set bit 1
        BS3: u1, // bit offset: 3 desc: Set bit 3
        BS4: u1, // bit offset: 4 desc: Set bit 4
        BS5: u1, // bit offset: 5 desc: Set bit 5
        BS6: u1, // bit offset: 6 desc: Set bit 6
        BS7: u1, // bit offset: 7 desc: Set bit 7
        BS8: u1, // bit offset: 8 desc: Set bit 8
        BS9: u1, // bit offset: 9 desc: Set bit 9
        BS10: u1, // bit offset: 10 desc: Set bit 10
        BS11: u1, // bit offset: 11 desc: Set bit 11
        BS12: u1, // bit offset: 12 desc: Set bit 12
        BS13: u1, // bit offset: 13 desc: Set bit 13
        BS14: u1, // bit offset: 14 desc: Set bit 14
        BS15: u1, // bit offset: 15 desc: Set bit 15
        BR0: u1, // bit offset: 16 desc: Reset bit 0
        BR1: u1, // bit offset: 17 desc: Reset bit 1
        BR2: u1, // bit offset: 18 desc: Reset bit 2
        BR3: u1, // bit offset: 19 desc: Reset bit 3
        BR4: u1, // bit offset: 20 desc: Reset bit 4
        BR5: u1, // bit offset: 21 desc: Reset bit 5
        BR6: u1, // bit offset: 22 desc: Reset bit 6
        BR7: u1, // bit offset: 23 desc: Reset bit 7
        BR8: u1, // bit offset: 24 desc: Reset bit 8
        BR9: u1, // bit offset: 25 desc: Reset bit 9
        BR10: u1, // bit offset: 26 desc: Reset bit 10
        BR11: u1, // bit offset: 27 desc: Reset bit 11
        BR12: u1, // bit offset: 28 desc: Reset bit 12
        BR13: u1, // bit offset: 29 desc: Reset bit 13
        BR14: u1, // bit offset: 30 desc: Reset bit 14
        BR15: u1, // bit offset: 31 desc: Reset bit 15
    });
    // byte offset: 20 Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Reset bit 0
        BR1: u1, // bit offset: 1 desc: Reset bit 1
        BR2: u1, // bit offset: 2 desc: Reset bit 1
        BR3: u1, // bit offset: 3 desc: Reset bit 3
        BR4: u1, // bit offset: 4 desc: Reset bit 4
        BR5: u1, // bit offset: 5 desc: Reset bit 5
        BR6: u1, // bit offset: 6 desc: Reset bit 6
        BR7: u1, // bit offset: 7 desc: Reset bit 7
        BR8: u1, // bit offset: 8 desc: Reset bit 8
        BR9: u1, // bit offset: 9 desc: Reset bit 9
        BR10: u1, // bit offset: 10 desc: Reset bit 10
        BR11: u1, // bit offset: 11 desc: Reset bit 11
        BR12: u1, // bit offset: 12 desc: Reset bit 12
        BR13: u1, // bit offset: 13 desc: Reset bit 13
        BR14: u1, // bit offset: 14 desc: Reset bit 14
        BR15: u1, // bit offset: 15 desc: Reset bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port A Lock bit 0
        LCK1: u1, // bit offset: 1 desc: Port A Lock bit 1
        LCK2: u1, // bit offset: 2 desc: Port A Lock bit 2
        LCK3: u1, // bit offset: 3 desc: Port A Lock bit 3
        LCK4: u1, // bit offset: 4 desc: Port A Lock bit 4
        LCK5: u1, // bit offset: 5 desc: Port A Lock bit 5
        LCK6: u1, // bit offset: 6 desc: Port A Lock bit 6
        LCK7: u1, // bit offset: 7 desc: Port A Lock bit 7
        LCK8: u1, // bit offset: 8 desc: Port A Lock bit 8
        LCK9: u1, // bit offset: 9 desc: Port A Lock bit 9
        LCK10: u1, // bit offset: 10 desc: Port A Lock bit 10
        LCK11: u1, // bit offset: 11 desc: Port A Lock bit 11
        LCK12: u1, // bit offset: 12 desc: Port A Lock bit 12
        LCK13: u1, // bit offset: 13 desc: Port A Lock bit 13
        LCK14: u1, // bit offset: 14 desc: Port A Lock bit 14
        LCK15: u1, // bit offset: 15 desc: Port A Lock bit 15
        LCKK: u1, // bit offset: 16 desc: Lock key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const GPIOD = extern struct {
    pub const Address: u32 = 0x40011400;
    // byte offset: 0 Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        MODE0: u2, // bit offset: 0 desc: Port n.0 mode bits
        CNF0: u2, // bit offset: 2 desc: Port n.0 configuration bits
        MODE1: u2, // bit offset: 4 desc: Port n.1 mode bits
        CNF1: u2, // bit offset: 6 desc: Port n.1 configuration bits
        MODE2: u2, // bit offset: 8 desc: Port n.2 mode bits
        CNF2: u2, // bit offset: 10 desc: Port n.2 configuration bits
        MODE3: u2, // bit offset: 12 desc: Port n.3 mode bits
        CNF3: u2, // bit offset: 14 desc: Port n.3 configuration bits
        MODE4: u2, // bit offset: 16 desc: Port n.4 mode bits
        CNF4: u2, // bit offset: 18 desc: Port n.4 configuration bits
        MODE5: u2, // bit offset: 20 desc: Port n.5 mode bits
        CNF5: u2, // bit offset: 22 desc: Port n.5 configuration bits
        MODE6: u2, // bit offset: 24 desc: Port n.6 mode bits
        CNF6: u2, // bit offset: 26 desc: Port n.6 configuration bits
        MODE7: u2, // bit offset: 28 desc: Port n.7 mode bits
        CNF7: u2, // bit offset: 30 desc: Port n.7 configuration bits
    });
    // byte offset: 4 Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        MODE8: u2, // bit offset: 0 desc: Port n.8 mode bits
        CNF8: u2, // bit offset: 2 desc: Port n.8 configuration bits
        MODE9: u2, // bit offset: 4 desc: Port n.9 mode bits
        CNF9: u2, // bit offset: 6 desc: Port n.9 configuration bits
        MODE10: u2, // bit offset: 8 desc: Port n.10 mode bits
        CNF10: u2, // bit offset: 10 desc: Port n.10 configuration bits
        MODE11: u2, // bit offset: 12 desc: Port n.11 mode bits
        CNF11: u2, // bit offset: 14 desc: Port n.11 configuration bits
        MODE12: u2, // bit offset: 16 desc: Port n.12 mode bits
        CNF12: u2, // bit offset: 18 desc: Port n.12 configuration bits
        MODE13: u2, // bit offset: 20 desc: Port n.13 mode bits
        CNF13: u2, // bit offset: 22 desc: Port n.13 configuration bits
        MODE14: u2, // bit offset: 24 desc: Port n.14 mode bits
        CNF14: u2, // bit offset: 26 desc: Port n.14 configuration bits
        MODE15: u2, // bit offset: 28 desc: Port n.15 mode bits
        CNF15: u2, // bit offset: 30 desc: Port n.15 configuration bits
    });
    // byte offset: 8 Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data
        IDR1: u1, // bit offset: 1 desc: Port input data
        IDR2: u1, // bit offset: 2 desc: Port input data
        IDR3: u1, // bit offset: 3 desc: Port input data
        IDR4: u1, // bit offset: 4 desc: Port input data
        IDR5: u1, // bit offset: 5 desc: Port input data
        IDR6: u1, // bit offset: 6 desc: Port input data
        IDR7: u1, // bit offset: 7 desc: Port input data
        IDR8: u1, // bit offset: 8 desc: Port input data
        IDR9: u1, // bit offset: 9 desc: Port input data
        IDR10: u1, // bit offset: 10 desc: Port input data
        IDR11: u1, // bit offset: 11 desc: Port input data
        IDR12: u1, // bit offset: 12 desc: Port input data
        IDR13: u1, // bit offset: 13 desc: Port input data
        IDR14: u1, // bit offset: 14 desc: Port input data
        IDR15: u1, // bit offset: 15 desc: Port input data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data
        ODR1: u1, // bit offset: 1 desc: Port output data
        ODR2: u1, // bit offset: 2 desc: Port output data
        ODR3: u1, // bit offset: 3 desc: Port output data
        ODR4: u1, // bit offset: 4 desc: Port output data
        ODR5: u1, // bit offset: 5 desc: Port output data
        ODR6: u1, // bit offset: 6 desc: Port output data
        ODR7: u1, // bit offset: 7 desc: Port output data
        ODR8: u1, // bit offset: 8 desc: Port output data
        ODR9: u1, // bit offset: 9 desc: Port output data
        ODR10: u1, // bit offset: 10 desc: Port output data
        ODR11: u1, // bit offset: 11 desc: Port output data
        ODR12: u1, // bit offset: 12 desc: Port output data
        ODR13: u1, // bit offset: 13 desc: Port output data
        ODR14: u1, // bit offset: 14 desc: Port output data
        ODR15: u1, // bit offset: 15 desc: Port output data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Set bit 0
        BS1: u1, // bit offset: 1 desc: Set bit 1
        BS2: u1, // bit offset: 2 desc: Set bit 1
        BS3: u1, // bit offset: 3 desc: Set bit 3
        BS4: u1, // bit offset: 4 desc: Set bit 4
        BS5: u1, // bit offset: 5 desc: Set bit 5
        BS6: u1, // bit offset: 6 desc: Set bit 6
        BS7: u1, // bit offset: 7 desc: Set bit 7
        BS8: u1, // bit offset: 8 desc: Set bit 8
        BS9: u1, // bit offset: 9 desc: Set bit 9
        BS10: u1, // bit offset: 10 desc: Set bit 10
        BS11: u1, // bit offset: 11 desc: Set bit 11
        BS12: u1, // bit offset: 12 desc: Set bit 12
        BS13: u1, // bit offset: 13 desc: Set bit 13
        BS14: u1, // bit offset: 14 desc: Set bit 14
        BS15: u1, // bit offset: 15 desc: Set bit 15
        BR0: u1, // bit offset: 16 desc: Reset bit 0
        BR1: u1, // bit offset: 17 desc: Reset bit 1
        BR2: u1, // bit offset: 18 desc: Reset bit 2
        BR3: u1, // bit offset: 19 desc: Reset bit 3
        BR4: u1, // bit offset: 20 desc: Reset bit 4
        BR5: u1, // bit offset: 21 desc: Reset bit 5
        BR6: u1, // bit offset: 22 desc: Reset bit 6
        BR7: u1, // bit offset: 23 desc: Reset bit 7
        BR8: u1, // bit offset: 24 desc: Reset bit 8
        BR9: u1, // bit offset: 25 desc: Reset bit 9
        BR10: u1, // bit offset: 26 desc: Reset bit 10
        BR11: u1, // bit offset: 27 desc: Reset bit 11
        BR12: u1, // bit offset: 28 desc: Reset bit 12
        BR13: u1, // bit offset: 29 desc: Reset bit 13
        BR14: u1, // bit offset: 30 desc: Reset bit 14
        BR15: u1, // bit offset: 31 desc: Reset bit 15
    });
    // byte offset: 20 Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Reset bit 0
        BR1: u1, // bit offset: 1 desc: Reset bit 1
        BR2: u1, // bit offset: 2 desc: Reset bit 1
        BR3: u1, // bit offset: 3 desc: Reset bit 3
        BR4: u1, // bit offset: 4 desc: Reset bit 4
        BR5: u1, // bit offset: 5 desc: Reset bit 5
        BR6: u1, // bit offset: 6 desc: Reset bit 6
        BR7: u1, // bit offset: 7 desc: Reset bit 7
        BR8: u1, // bit offset: 8 desc: Reset bit 8
        BR9: u1, // bit offset: 9 desc: Reset bit 9
        BR10: u1, // bit offset: 10 desc: Reset bit 10
        BR11: u1, // bit offset: 11 desc: Reset bit 11
        BR12: u1, // bit offset: 12 desc: Reset bit 12
        BR13: u1, // bit offset: 13 desc: Reset bit 13
        BR14: u1, // bit offset: 14 desc: Reset bit 14
        BR15: u1, // bit offset: 15 desc: Reset bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port A Lock bit 0
        LCK1: u1, // bit offset: 1 desc: Port A Lock bit 1
        LCK2: u1, // bit offset: 2 desc: Port A Lock bit 2
        LCK3: u1, // bit offset: 3 desc: Port A Lock bit 3
        LCK4: u1, // bit offset: 4 desc: Port A Lock bit 4
        LCK5: u1, // bit offset: 5 desc: Port A Lock bit 5
        LCK6: u1, // bit offset: 6 desc: Port A Lock bit 6
        LCK7: u1, // bit offset: 7 desc: Port A Lock bit 7
        LCK8: u1, // bit offset: 8 desc: Port A Lock bit 8
        LCK9: u1, // bit offset: 9 desc: Port A Lock bit 9
        LCK10: u1, // bit offset: 10 desc: Port A Lock bit 10
        LCK11: u1, // bit offset: 11 desc: Port A Lock bit 11
        LCK12: u1, // bit offset: 12 desc: Port A Lock bit 12
        LCK13: u1, // bit offset: 13 desc: Port A Lock bit 13
        LCK14: u1, // bit offset: 14 desc: Port A Lock bit 14
        LCK15: u1, // bit offset: 15 desc: Port A Lock bit 15
        LCKK: u1, // bit offset: 16 desc: Lock key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const GPIOE = extern struct {
    pub const Address: u32 = 0x40011800;
    // byte offset: 0 Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        MODE0: u2, // bit offset: 0 desc: Port n.0 mode bits
        CNF0: u2, // bit offset: 2 desc: Port n.0 configuration bits
        MODE1: u2, // bit offset: 4 desc: Port n.1 mode bits
        CNF1: u2, // bit offset: 6 desc: Port n.1 configuration bits
        MODE2: u2, // bit offset: 8 desc: Port n.2 mode bits
        CNF2: u2, // bit offset: 10 desc: Port n.2 configuration bits
        MODE3: u2, // bit offset: 12 desc: Port n.3 mode bits
        CNF3: u2, // bit offset: 14 desc: Port n.3 configuration bits
        MODE4: u2, // bit offset: 16 desc: Port n.4 mode bits
        CNF4: u2, // bit offset: 18 desc: Port n.4 configuration bits
        MODE5: u2, // bit offset: 20 desc: Port n.5 mode bits
        CNF5: u2, // bit offset: 22 desc: Port n.5 configuration bits
        MODE6: u2, // bit offset: 24 desc: Port n.6 mode bits
        CNF6: u2, // bit offset: 26 desc: Port n.6 configuration bits
        MODE7: u2, // bit offset: 28 desc: Port n.7 mode bits
        CNF7: u2, // bit offset: 30 desc: Port n.7 configuration bits
    });
    // byte offset: 4 Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        MODE8: u2, // bit offset: 0 desc: Port n.8 mode bits
        CNF8: u2, // bit offset: 2 desc: Port n.8 configuration bits
        MODE9: u2, // bit offset: 4 desc: Port n.9 mode bits
        CNF9: u2, // bit offset: 6 desc: Port n.9 configuration bits
        MODE10: u2, // bit offset: 8 desc: Port n.10 mode bits
        CNF10: u2, // bit offset: 10 desc: Port n.10 configuration bits
        MODE11: u2, // bit offset: 12 desc: Port n.11 mode bits
        CNF11: u2, // bit offset: 14 desc: Port n.11 configuration bits
        MODE12: u2, // bit offset: 16 desc: Port n.12 mode bits
        CNF12: u2, // bit offset: 18 desc: Port n.12 configuration bits
        MODE13: u2, // bit offset: 20 desc: Port n.13 mode bits
        CNF13: u2, // bit offset: 22 desc: Port n.13 configuration bits
        MODE14: u2, // bit offset: 24 desc: Port n.14 mode bits
        CNF14: u2, // bit offset: 26 desc: Port n.14 configuration bits
        MODE15: u2, // bit offset: 28 desc: Port n.15 mode bits
        CNF15: u2, // bit offset: 30 desc: Port n.15 configuration bits
    });
    // byte offset: 8 Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data
        IDR1: u1, // bit offset: 1 desc: Port input data
        IDR2: u1, // bit offset: 2 desc: Port input data
        IDR3: u1, // bit offset: 3 desc: Port input data
        IDR4: u1, // bit offset: 4 desc: Port input data
        IDR5: u1, // bit offset: 5 desc: Port input data
        IDR6: u1, // bit offset: 6 desc: Port input data
        IDR7: u1, // bit offset: 7 desc: Port input data
        IDR8: u1, // bit offset: 8 desc: Port input data
        IDR9: u1, // bit offset: 9 desc: Port input data
        IDR10: u1, // bit offset: 10 desc: Port input data
        IDR11: u1, // bit offset: 11 desc: Port input data
        IDR12: u1, // bit offset: 12 desc: Port input data
        IDR13: u1, // bit offset: 13 desc: Port input data
        IDR14: u1, // bit offset: 14 desc: Port input data
        IDR15: u1, // bit offset: 15 desc: Port input data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data
        ODR1: u1, // bit offset: 1 desc: Port output data
        ODR2: u1, // bit offset: 2 desc: Port output data
        ODR3: u1, // bit offset: 3 desc: Port output data
        ODR4: u1, // bit offset: 4 desc: Port output data
        ODR5: u1, // bit offset: 5 desc: Port output data
        ODR6: u1, // bit offset: 6 desc: Port output data
        ODR7: u1, // bit offset: 7 desc: Port output data
        ODR8: u1, // bit offset: 8 desc: Port output data
        ODR9: u1, // bit offset: 9 desc: Port output data
        ODR10: u1, // bit offset: 10 desc: Port output data
        ODR11: u1, // bit offset: 11 desc: Port output data
        ODR12: u1, // bit offset: 12 desc: Port output data
        ODR13: u1, // bit offset: 13 desc: Port output data
        ODR14: u1, // bit offset: 14 desc: Port output data
        ODR15: u1, // bit offset: 15 desc: Port output data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Set bit 0
        BS1: u1, // bit offset: 1 desc: Set bit 1
        BS2: u1, // bit offset: 2 desc: Set bit 1
        BS3: u1, // bit offset: 3 desc: Set bit 3
        BS4: u1, // bit offset: 4 desc: Set bit 4
        BS5: u1, // bit offset: 5 desc: Set bit 5
        BS6: u1, // bit offset: 6 desc: Set bit 6
        BS7: u1, // bit offset: 7 desc: Set bit 7
        BS8: u1, // bit offset: 8 desc: Set bit 8
        BS9: u1, // bit offset: 9 desc: Set bit 9
        BS10: u1, // bit offset: 10 desc: Set bit 10
        BS11: u1, // bit offset: 11 desc: Set bit 11
        BS12: u1, // bit offset: 12 desc: Set bit 12
        BS13: u1, // bit offset: 13 desc: Set bit 13
        BS14: u1, // bit offset: 14 desc: Set bit 14
        BS15: u1, // bit offset: 15 desc: Set bit 15
        BR0: u1, // bit offset: 16 desc: Reset bit 0
        BR1: u1, // bit offset: 17 desc: Reset bit 1
        BR2: u1, // bit offset: 18 desc: Reset bit 2
        BR3: u1, // bit offset: 19 desc: Reset bit 3
        BR4: u1, // bit offset: 20 desc: Reset bit 4
        BR5: u1, // bit offset: 21 desc: Reset bit 5
        BR6: u1, // bit offset: 22 desc: Reset bit 6
        BR7: u1, // bit offset: 23 desc: Reset bit 7
        BR8: u1, // bit offset: 24 desc: Reset bit 8
        BR9: u1, // bit offset: 25 desc: Reset bit 9
        BR10: u1, // bit offset: 26 desc: Reset bit 10
        BR11: u1, // bit offset: 27 desc: Reset bit 11
        BR12: u1, // bit offset: 28 desc: Reset bit 12
        BR13: u1, // bit offset: 29 desc: Reset bit 13
        BR14: u1, // bit offset: 30 desc: Reset bit 14
        BR15: u1, // bit offset: 31 desc: Reset bit 15
    });
    // byte offset: 20 Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Reset bit 0
        BR1: u1, // bit offset: 1 desc: Reset bit 1
        BR2: u1, // bit offset: 2 desc: Reset bit 1
        BR3: u1, // bit offset: 3 desc: Reset bit 3
        BR4: u1, // bit offset: 4 desc: Reset bit 4
        BR5: u1, // bit offset: 5 desc: Reset bit 5
        BR6: u1, // bit offset: 6 desc: Reset bit 6
        BR7: u1, // bit offset: 7 desc: Reset bit 7
        BR8: u1, // bit offset: 8 desc: Reset bit 8
        BR9: u1, // bit offset: 9 desc: Reset bit 9
        BR10: u1, // bit offset: 10 desc: Reset bit 10
        BR11: u1, // bit offset: 11 desc: Reset bit 11
        BR12: u1, // bit offset: 12 desc: Reset bit 12
        BR13: u1, // bit offset: 13 desc: Reset bit 13
        BR14: u1, // bit offset: 14 desc: Reset bit 14
        BR15: u1, // bit offset: 15 desc: Reset bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port A Lock bit 0
        LCK1: u1, // bit offset: 1 desc: Port A Lock bit 1
        LCK2: u1, // bit offset: 2 desc: Port A Lock bit 2
        LCK3: u1, // bit offset: 3 desc: Port A Lock bit 3
        LCK4: u1, // bit offset: 4 desc: Port A Lock bit 4
        LCK5: u1, // bit offset: 5 desc: Port A Lock bit 5
        LCK6: u1, // bit offset: 6 desc: Port A Lock bit 6
        LCK7: u1, // bit offset: 7 desc: Port A Lock bit 7
        LCK8: u1, // bit offset: 8 desc: Port A Lock bit 8
        LCK9: u1, // bit offset: 9 desc: Port A Lock bit 9
        LCK10: u1, // bit offset: 10 desc: Port A Lock bit 10
        LCK11: u1, // bit offset: 11 desc: Port A Lock bit 11
        LCK12: u1, // bit offset: 12 desc: Port A Lock bit 12
        LCK13: u1, // bit offset: 13 desc: Port A Lock bit 13
        LCK14: u1, // bit offset: 14 desc: Port A Lock bit 14
        LCK15: u1, // bit offset: 15 desc: Port A Lock bit 15
        LCKK: u1, // bit offset: 16 desc: Lock key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const GPIOF = extern struct {
    pub const Address: u32 = 0x40011c00;
    // byte offset: 0 Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        MODE0: u2, // bit offset: 0 desc: Port n.0 mode bits
        CNF0: u2, // bit offset: 2 desc: Port n.0 configuration bits
        MODE1: u2, // bit offset: 4 desc: Port n.1 mode bits
        CNF1: u2, // bit offset: 6 desc: Port n.1 configuration bits
        MODE2: u2, // bit offset: 8 desc: Port n.2 mode bits
        CNF2: u2, // bit offset: 10 desc: Port n.2 configuration bits
        MODE3: u2, // bit offset: 12 desc: Port n.3 mode bits
        CNF3: u2, // bit offset: 14 desc: Port n.3 configuration bits
        MODE4: u2, // bit offset: 16 desc: Port n.4 mode bits
        CNF4: u2, // bit offset: 18 desc: Port n.4 configuration bits
        MODE5: u2, // bit offset: 20 desc: Port n.5 mode bits
        CNF5: u2, // bit offset: 22 desc: Port n.5 configuration bits
        MODE6: u2, // bit offset: 24 desc: Port n.6 mode bits
        CNF6: u2, // bit offset: 26 desc: Port n.6 configuration bits
        MODE7: u2, // bit offset: 28 desc: Port n.7 mode bits
        CNF7: u2, // bit offset: 30 desc: Port n.7 configuration bits
    });
    // byte offset: 4 Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        MODE8: u2, // bit offset: 0 desc: Port n.8 mode bits
        CNF8: u2, // bit offset: 2 desc: Port n.8 configuration bits
        MODE9: u2, // bit offset: 4 desc: Port n.9 mode bits
        CNF9: u2, // bit offset: 6 desc: Port n.9 configuration bits
        MODE10: u2, // bit offset: 8 desc: Port n.10 mode bits
        CNF10: u2, // bit offset: 10 desc: Port n.10 configuration bits
        MODE11: u2, // bit offset: 12 desc: Port n.11 mode bits
        CNF11: u2, // bit offset: 14 desc: Port n.11 configuration bits
        MODE12: u2, // bit offset: 16 desc: Port n.12 mode bits
        CNF12: u2, // bit offset: 18 desc: Port n.12 configuration bits
        MODE13: u2, // bit offset: 20 desc: Port n.13 mode bits
        CNF13: u2, // bit offset: 22 desc: Port n.13 configuration bits
        MODE14: u2, // bit offset: 24 desc: Port n.14 mode bits
        CNF14: u2, // bit offset: 26 desc: Port n.14 configuration bits
        MODE15: u2, // bit offset: 28 desc: Port n.15 mode bits
        CNF15: u2, // bit offset: 30 desc: Port n.15 configuration bits
    });
    // byte offset: 8 Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data
        IDR1: u1, // bit offset: 1 desc: Port input data
        IDR2: u1, // bit offset: 2 desc: Port input data
        IDR3: u1, // bit offset: 3 desc: Port input data
        IDR4: u1, // bit offset: 4 desc: Port input data
        IDR5: u1, // bit offset: 5 desc: Port input data
        IDR6: u1, // bit offset: 6 desc: Port input data
        IDR7: u1, // bit offset: 7 desc: Port input data
        IDR8: u1, // bit offset: 8 desc: Port input data
        IDR9: u1, // bit offset: 9 desc: Port input data
        IDR10: u1, // bit offset: 10 desc: Port input data
        IDR11: u1, // bit offset: 11 desc: Port input data
        IDR12: u1, // bit offset: 12 desc: Port input data
        IDR13: u1, // bit offset: 13 desc: Port input data
        IDR14: u1, // bit offset: 14 desc: Port input data
        IDR15: u1, // bit offset: 15 desc: Port input data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data
        ODR1: u1, // bit offset: 1 desc: Port output data
        ODR2: u1, // bit offset: 2 desc: Port output data
        ODR3: u1, // bit offset: 3 desc: Port output data
        ODR4: u1, // bit offset: 4 desc: Port output data
        ODR5: u1, // bit offset: 5 desc: Port output data
        ODR6: u1, // bit offset: 6 desc: Port output data
        ODR7: u1, // bit offset: 7 desc: Port output data
        ODR8: u1, // bit offset: 8 desc: Port output data
        ODR9: u1, // bit offset: 9 desc: Port output data
        ODR10: u1, // bit offset: 10 desc: Port output data
        ODR11: u1, // bit offset: 11 desc: Port output data
        ODR12: u1, // bit offset: 12 desc: Port output data
        ODR13: u1, // bit offset: 13 desc: Port output data
        ODR14: u1, // bit offset: 14 desc: Port output data
        ODR15: u1, // bit offset: 15 desc: Port output data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Set bit 0
        BS1: u1, // bit offset: 1 desc: Set bit 1
        BS2: u1, // bit offset: 2 desc: Set bit 1
        BS3: u1, // bit offset: 3 desc: Set bit 3
        BS4: u1, // bit offset: 4 desc: Set bit 4
        BS5: u1, // bit offset: 5 desc: Set bit 5
        BS6: u1, // bit offset: 6 desc: Set bit 6
        BS7: u1, // bit offset: 7 desc: Set bit 7
        BS8: u1, // bit offset: 8 desc: Set bit 8
        BS9: u1, // bit offset: 9 desc: Set bit 9
        BS10: u1, // bit offset: 10 desc: Set bit 10
        BS11: u1, // bit offset: 11 desc: Set bit 11
        BS12: u1, // bit offset: 12 desc: Set bit 12
        BS13: u1, // bit offset: 13 desc: Set bit 13
        BS14: u1, // bit offset: 14 desc: Set bit 14
        BS15: u1, // bit offset: 15 desc: Set bit 15
        BR0: u1, // bit offset: 16 desc: Reset bit 0
        BR1: u1, // bit offset: 17 desc: Reset bit 1
        BR2: u1, // bit offset: 18 desc: Reset bit 2
        BR3: u1, // bit offset: 19 desc: Reset bit 3
        BR4: u1, // bit offset: 20 desc: Reset bit 4
        BR5: u1, // bit offset: 21 desc: Reset bit 5
        BR6: u1, // bit offset: 22 desc: Reset bit 6
        BR7: u1, // bit offset: 23 desc: Reset bit 7
        BR8: u1, // bit offset: 24 desc: Reset bit 8
        BR9: u1, // bit offset: 25 desc: Reset bit 9
        BR10: u1, // bit offset: 26 desc: Reset bit 10
        BR11: u1, // bit offset: 27 desc: Reset bit 11
        BR12: u1, // bit offset: 28 desc: Reset bit 12
        BR13: u1, // bit offset: 29 desc: Reset bit 13
        BR14: u1, // bit offset: 30 desc: Reset bit 14
        BR15: u1, // bit offset: 31 desc: Reset bit 15
    });
    // byte offset: 20 Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Reset bit 0
        BR1: u1, // bit offset: 1 desc: Reset bit 1
        BR2: u1, // bit offset: 2 desc: Reset bit 1
        BR3: u1, // bit offset: 3 desc: Reset bit 3
        BR4: u1, // bit offset: 4 desc: Reset bit 4
        BR5: u1, // bit offset: 5 desc: Reset bit 5
        BR6: u1, // bit offset: 6 desc: Reset bit 6
        BR7: u1, // bit offset: 7 desc: Reset bit 7
        BR8: u1, // bit offset: 8 desc: Reset bit 8
        BR9: u1, // bit offset: 9 desc: Reset bit 9
        BR10: u1, // bit offset: 10 desc: Reset bit 10
        BR11: u1, // bit offset: 11 desc: Reset bit 11
        BR12: u1, // bit offset: 12 desc: Reset bit 12
        BR13: u1, // bit offset: 13 desc: Reset bit 13
        BR14: u1, // bit offset: 14 desc: Reset bit 14
        BR15: u1, // bit offset: 15 desc: Reset bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port A Lock bit 0
        LCK1: u1, // bit offset: 1 desc: Port A Lock bit 1
        LCK2: u1, // bit offset: 2 desc: Port A Lock bit 2
        LCK3: u1, // bit offset: 3 desc: Port A Lock bit 3
        LCK4: u1, // bit offset: 4 desc: Port A Lock bit 4
        LCK5: u1, // bit offset: 5 desc: Port A Lock bit 5
        LCK6: u1, // bit offset: 6 desc: Port A Lock bit 6
        LCK7: u1, // bit offset: 7 desc: Port A Lock bit 7
        LCK8: u1, // bit offset: 8 desc: Port A Lock bit 8
        LCK9: u1, // bit offset: 9 desc: Port A Lock bit 9
        LCK10: u1, // bit offset: 10 desc: Port A Lock bit 10
        LCK11: u1, // bit offset: 11 desc: Port A Lock bit 11
        LCK12: u1, // bit offset: 12 desc: Port A Lock bit 12
        LCK13: u1, // bit offset: 13 desc: Port A Lock bit 13
        LCK14: u1, // bit offset: 14 desc: Port A Lock bit 14
        LCK15: u1, // bit offset: 15 desc: Port A Lock bit 15
        LCKK: u1, // bit offset: 16 desc: Lock key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const GPIOG = extern struct {
    pub const Address: u32 = 0x40012000;
    // byte offset: 0 Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        MODE0: u2, // bit offset: 0 desc: Port n.0 mode bits
        CNF0: u2, // bit offset: 2 desc: Port n.0 configuration bits
        MODE1: u2, // bit offset: 4 desc: Port n.1 mode bits
        CNF1: u2, // bit offset: 6 desc: Port n.1 configuration bits
        MODE2: u2, // bit offset: 8 desc: Port n.2 mode bits
        CNF2: u2, // bit offset: 10 desc: Port n.2 configuration bits
        MODE3: u2, // bit offset: 12 desc: Port n.3 mode bits
        CNF3: u2, // bit offset: 14 desc: Port n.3 configuration bits
        MODE4: u2, // bit offset: 16 desc: Port n.4 mode bits
        CNF4: u2, // bit offset: 18 desc: Port n.4 configuration bits
        MODE5: u2, // bit offset: 20 desc: Port n.5 mode bits
        CNF5: u2, // bit offset: 22 desc: Port n.5 configuration bits
        MODE6: u2, // bit offset: 24 desc: Port n.6 mode bits
        CNF6: u2, // bit offset: 26 desc: Port n.6 configuration bits
        MODE7: u2, // bit offset: 28 desc: Port n.7 mode bits
        CNF7: u2, // bit offset: 30 desc: Port n.7 configuration bits
    });
    // byte offset: 4 Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        MODE8: u2, // bit offset: 0 desc: Port n.8 mode bits
        CNF8: u2, // bit offset: 2 desc: Port n.8 configuration bits
        MODE9: u2, // bit offset: 4 desc: Port n.9 mode bits
        CNF9: u2, // bit offset: 6 desc: Port n.9 configuration bits
        MODE10: u2, // bit offset: 8 desc: Port n.10 mode bits
        CNF10: u2, // bit offset: 10 desc: Port n.10 configuration bits
        MODE11: u2, // bit offset: 12 desc: Port n.11 mode bits
        CNF11: u2, // bit offset: 14 desc: Port n.11 configuration bits
        MODE12: u2, // bit offset: 16 desc: Port n.12 mode bits
        CNF12: u2, // bit offset: 18 desc: Port n.12 configuration bits
        MODE13: u2, // bit offset: 20 desc: Port n.13 mode bits
        CNF13: u2, // bit offset: 22 desc: Port n.13 configuration bits
        MODE14: u2, // bit offset: 24 desc: Port n.14 mode bits
        CNF14: u2, // bit offset: 26 desc: Port n.14 configuration bits
        MODE15: u2, // bit offset: 28 desc: Port n.15 mode bits
        CNF15: u2, // bit offset: 30 desc: Port n.15 configuration bits
    });
    // byte offset: 8 Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data
        IDR1: u1, // bit offset: 1 desc: Port input data
        IDR2: u1, // bit offset: 2 desc: Port input data
        IDR3: u1, // bit offset: 3 desc: Port input data
        IDR4: u1, // bit offset: 4 desc: Port input data
        IDR5: u1, // bit offset: 5 desc: Port input data
        IDR6: u1, // bit offset: 6 desc: Port input data
        IDR7: u1, // bit offset: 7 desc: Port input data
        IDR8: u1, // bit offset: 8 desc: Port input data
        IDR9: u1, // bit offset: 9 desc: Port input data
        IDR10: u1, // bit offset: 10 desc: Port input data
        IDR11: u1, // bit offset: 11 desc: Port input data
        IDR12: u1, // bit offset: 12 desc: Port input data
        IDR13: u1, // bit offset: 13 desc: Port input data
        IDR14: u1, // bit offset: 14 desc: Port input data
        IDR15: u1, // bit offset: 15 desc: Port input data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data
        ODR1: u1, // bit offset: 1 desc: Port output data
        ODR2: u1, // bit offset: 2 desc: Port output data
        ODR3: u1, // bit offset: 3 desc: Port output data
        ODR4: u1, // bit offset: 4 desc: Port output data
        ODR5: u1, // bit offset: 5 desc: Port output data
        ODR6: u1, // bit offset: 6 desc: Port output data
        ODR7: u1, // bit offset: 7 desc: Port output data
        ODR8: u1, // bit offset: 8 desc: Port output data
        ODR9: u1, // bit offset: 9 desc: Port output data
        ODR10: u1, // bit offset: 10 desc: Port output data
        ODR11: u1, // bit offset: 11 desc: Port output data
        ODR12: u1, // bit offset: 12 desc: Port output data
        ODR13: u1, // bit offset: 13 desc: Port output data
        ODR14: u1, // bit offset: 14 desc: Port output data
        ODR15: u1, // bit offset: 15 desc: Port output data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Set bit 0
        BS1: u1, // bit offset: 1 desc: Set bit 1
        BS2: u1, // bit offset: 2 desc: Set bit 1
        BS3: u1, // bit offset: 3 desc: Set bit 3
        BS4: u1, // bit offset: 4 desc: Set bit 4
        BS5: u1, // bit offset: 5 desc: Set bit 5
        BS6: u1, // bit offset: 6 desc: Set bit 6
        BS7: u1, // bit offset: 7 desc: Set bit 7
        BS8: u1, // bit offset: 8 desc: Set bit 8
        BS9: u1, // bit offset: 9 desc: Set bit 9
        BS10: u1, // bit offset: 10 desc: Set bit 10
        BS11: u1, // bit offset: 11 desc: Set bit 11
        BS12: u1, // bit offset: 12 desc: Set bit 12
        BS13: u1, // bit offset: 13 desc: Set bit 13
        BS14: u1, // bit offset: 14 desc: Set bit 14
        BS15: u1, // bit offset: 15 desc: Set bit 15
        BR0: u1, // bit offset: 16 desc: Reset bit 0
        BR1: u1, // bit offset: 17 desc: Reset bit 1
        BR2: u1, // bit offset: 18 desc: Reset bit 2
        BR3: u1, // bit offset: 19 desc: Reset bit 3
        BR4: u1, // bit offset: 20 desc: Reset bit 4
        BR5: u1, // bit offset: 21 desc: Reset bit 5
        BR6: u1, // bit offset: 22 desc: Reset bit 6
        BR7: u1, // bit offset: 23 desc: Reset bit 7
        BR8: u1, // bit offset: 24 desc: Reset bit 8
        BR9: u1, // bit offset: 25 desc: Reset bit 9
        BR10: u1, // bit offset: 26 desc: Reset bit 10
        BR11: u1, // bit offset: 27 desc: Reset bit 11
        BR12: u1, // bit offset: 28 desc: Reset bit 12
        BR13: u1, // bit offset: 29 desc: Reset bit 13
        BR14: u1, // bit offset: 30 desc: Reset bit 14
        BR15: u1, // bit offset: 31 desc: Reset bit 15
    });
    // byte offset: 20 Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Reset bit 0
        BR1: u1, // bit offset: 1 desc: Reset bit 1
        BR2: u1, // bit offset: 2 desc: Reset bit 1
        BR3: u1, // bit offset: 3 desc: Reset bit 3
        BR4: u1, // bit offset: 4 desc: Reset bit 4
        BR5: u1, // bit offset: 5 desc: Reset bit 5
        BR6: u1, // bit offset: 6 desc: Reset bit 6
        BR7: u1, // bit offset: 7 desc: Reset bit 7
        BR8: u1, // bit offset: 8 desc: Reset bit 8
        BR9: u1, // bit offset: 9 desc: Reset bit 9
        BR10: u1, // bit offset: 10 desc: Reset bit 10
        BR11: u1, // bit offset: 11 desc: Reset bit 11
        BR12: u1, // bit offset: 12 desc: Reset bit 12
        BR13: u1, // bit offset: 13 desc: Reset bit 13
        BR14: u1, // bit offset: 14 desc: Reset bit 14
        BR15: u1, // bit offset: 15 desc: Reset bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port A Lock bit 0
        LCK1: u1, // bit offset: 1 desc: Port A Lock bit 1
        LCK2: u1, // bit offset: 2 desc: Port A Lock bit 2
        LCK3: u1, // bit offset: 3 desc: Port A Lock bit 3
        LCK4: u1, // bit offset: 4 desc: Port A Lock bit 4
        LCK5: u1, // bit offset: 5 desc: Port A Lock bit 5
        LCK6: u1, // bit offset: 6 desc: Port A Lock bit 6
        LCK7: u1, // bit offset: 7 desc: Port A Lock bit 7
        LCK8: u1, // bit offset: 8 desc: Port A Lock bit 8
        LCK9: u1, // bit offset: 9 desc: Port A Lock bit 9
        LCK10: u1, // bit offset: 10 desc: Port A Lock bit 10
        LCK11: u1, // bit offset: 11 desc: Port A Lock bit 11
        LCK12: u1, // bit offset: 12 desc: Port A Lock bit 12
        LCK13: u1, // bit offset: 13 desc: Port A Lock bit 13
        LCK14: u1, // bit offset: 14 desc: Port A Lock bit 14
        LCK15: u1, // bit offset: 15 desc: Port A Lock bit 15
        LCKK: u1, // bit offset: 16 desc: Lock key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const AFIO = extern struct {
    pub const Address: u32 = 0x40010000;
    // byte offset: 0 Event Control Register (AFIO_EVCR)
    pub const EVCR = mmio(Address + 0x00000000, 32, packed struct {
        PIN: u4, // bit offset: 0 desc: Pin selection
        PORT: u3, // bit offset: 4 desc: Port selection
        EVOE: u1, // bit offset: 7 desc: Event Output Enable
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 AF remap and debug I/O configuration register (AFIO_MAPR)
    pub const MAPR = mmio(Address + 0x00000004, 32, packed struct {
        SPI1_REMAP: u1, // bit offset: 0 desc: SPI1 remapping
        I2C1_REMAP: u1, // bit offset: 1 desc: I2C1 remapping
        USART1_REMAP: u1, // bit offset: 2 desc: USART1 remapping
        USART2_REMAP: u1, // bit offset: 3 desc: USART2 remapping
        USART3_REMAP: u2, // bit offset: 4 desc: USART3 remapping
        TIM1_REMAP: u2, // bit offset: 6 desc: TIM1 remapping
        TIM2_REMAP: u2, // bit offset: 8 desc: TIM2 remapping
        TIM3_REMAP: u2, // bit offset: 10 desc: TIM3 remapping
        TIM4_REMAP: u1, // bit offset: 12 desc: TIM4 remapping
        CAN_REMAP: u2, // bit offset: 13 desc: CAN1 remapping
        PD01_REMAP: u1, // bit offset: 15 desc: Port D0/Port D1 mapping on OSCIN/OSCOUT
        TIM5CH4_IREMAP: u1, // bit offset: 16 desc: Set and cleared by software
        ADC1_ETRGINJ_REMAP: u1, // bit offset: 17 desc: ADC 1 External trigger injected conversion remapping
        ADC1_ETRGREG_REMAP: u1, // bit offset: 18 desc: ADC 1 external trigger regular conversion remapping
        ADC2_ETRGINJ_REMAP: u1, // bit offset: 19 desc: ADC 2 external trigger injected conversion remapping
        ADC2_ETRGREG_REMAP: u1, // bit offset: 20 desc: ADC 2 external trigger regular conversion remapping
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SWJ_CFG: u3, // bit offset: 24 desc: Serial wire JTAG configuration
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 External interrupt configuration register 1 (AFIO_EXTICR1)
    pub const EXTICR1 = mmio(Address + 0x00000008, 32, packed struct {
        EXTI0: u4, // bit offset: 0 desc: EXTI0 configuration
        EXTI1: u4, // bit offset: 4 desc: EXTI1 configuration
        EXTI2: u4, // bit offset: 8 desc: EXTI2 configuration
        EXTI3: u4, // bit offset: 12 desc: EXTI3 configuration
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 External interrupt configuration register 2 (AFIO_EXTICR2)
    pub const EXTICR2 = mmio(Address + 0x0000000c, 32, packed struct {
        EXTI4: u4, // bit offset: 0 desc: EXTI4 configuration
        EXTI5: u4, // bit offset: 4 desc: EXTI5 configuration
        EXTI6: u4, // bit offset: 8 desc: EXTI6 configuration
        EXTI7: u4, // bit offset: 12 desc: EXTI7 configuration
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 External interrupt configuration register 3 (AFIO_EXTICR3)
    pub const EXTICR3 = mmio(Address + 0x00000010, 32, packed struct {
        EXTI8: u4, // bit offset: 0 desc: EXTI8 configuration
        EXTI9: u4, // bit offset: 4 desc: EXTI9 configuration
        EXTI10: u4, // bit offset: 8 desc: EXTI10 configuration
        EXTI11: u4, // bit offset: 12 desc: EXTI11 configuration
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 External interrupt configuration register 4 (AFIO_EXTICR4)
    pub const EXTICR4 = mmio(Address + 0x00000014, 32, packed struct {
        EXTI12: u4, // bit offset: 0 desc: EXTI12 configuration
        EXTI13: u4, // bit offset: 4 desc: EXTI13 configuration
        EXTI14: u4, // bit offset: 8 desc: EXTI14 configuration
        EXTI15: u4, // bit offset: 12 desc: EXTI15 configuration
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 AF remap and debug I/O configuration register
    pub const MAPR2 = mmio(Address + 0x0000001c, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIM9_REMAP: u1, // bit offset: 5 desc: TIM9 remapping
        TIM10_REMAP: u1, // bit offset: 6 desc: TIM10 remapping
        TIM11_REMAP: u1, // bit offset: 7 desc: TIM11 remapping
        TIM13_REMAP: u1, // bit offset: 8 desc: TIM13 remapping
        TIM14_REMAP: u1, // bit offset: 9 desc: TIM14 remapping
        FSMC_NADV: u1, // bit offset: 10 desc: NADV connect/disconnect
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const EXTI = extern struct {
    pub const Address: u32 = 0x40010400;
    // byte offset: 0 Interrupt mask register (EXTI_IMR)
    pub const IMR = mmio(Address + 0x00000000, 32, packed struct {
        MR0: u1, // bit offset: 0 desc: Interrupt Mask on line 0
        MR1: u1, // bit offset: 1 desc: Interrupt Mask on line 1
        MR2: u1, // bit offset: 2 desc: Interrupt Mask on line 2
        MR3: u1, // bit offset: 3 desc: Interrupt Mask on line 3
        MR4: u1, // bit offset: 4 desc: Interrupt Mask on line 4
        MR5: u1, // bit offset: 5 desc: Interrupt Mask on line 5
        MR6: u1, // bit offset: 6 desc: Interrupt Mask on line 6
        MR7: u1, // bit offset: 7 desc: Interrupt Mask on line 7
        MR8: u1, // bit offset: 8 desc: Interrupt Mask on line 8
        MR9: u1, // bit offset: 9 desc: Interrupt Mask on line 9
        MR10: u1, // bit offset: 10 desc: Interrupt Mask on line 10
        MR11: u1, // bit offset: 11 desc: Interrupt Mask on line 11
        MR12: u1, // bit offset: 12 desc: Interrupt Mask on line 12
        MR13: u1, // bit offset: 13 desc: Interrupt Mask on line 13
        MR14: u1, // bit offset: 14 desc: Interrupt Mask on line 14
        MR15: u1, // bit offset: 15 desc: Interrupt Mask on line 15
        MR16: u1, // bit offset: 16 desc: Interrupt Mask on line 16
        MR17: u1, // bit offset: 17 desc: Interrupt Mask on line 17
        MR18: u1, // bit offset: 18 desc: Interrupt Mask on line 18
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Event mask register (EXTI_EMR)
    pub const EMR = mmio(Address + 0x00000004, 32, packed struct {
        MR0: u1, // bit offset: 0 desc: Event Mask on line 0
        MR1: u1, // bit offset: 1 desc: Event Mask on line 1
        MR2: u1, // bit offset: 2 desc: Event Mask on line 2
        MR3: u1, // bit offset: 3 desc: Event Mask on line 3
        MR4: u1, // bit offset: 4 desc: Event Mask on line 4
        MR5: u1, // bit offset: 5 desc: Event Mask on line 5
        MR6: u1, // bit offset: 6 desc: Event Mask on line 6
        MR7: u1, // bit offset: 7 desc: Event Mask on line 7
        MR8: u1, // bit offset: 8 desc: Event Mask on line 8
        MR9: u1, // bit offset: 9 desc: Event Mask on line 9
        MR10: u1, // bit offset: 10 desc: Event Mask on line 10
        MR11: u1, // bit offset: 11 desc: Event Mask on line 11
        MR12: u1, // bit offset: 12 desc: Event Mask on line 12
        MR13: u1, // bit offset: 13 desc: Event Mask on line 13
        MR14: u1, // bit offset: 14 desc: Event Mask on line 14
        MR15: u1, // bit offset: 15 desc: Event Mask on line 15
        MR16: u1, // bit offset: 16 desc: Event Mask on line 16
        MR17: u1, // bit offset: 17 desc: Event Mask on line 17
        MR18: u1, // bit offset: 18 desc: Event Mask on line 18
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Rising Trigger selection register (EXTI_RTSR)
    pub const RTSR = mmio(Address + 0x00000008, 32, packed struct {
        TR0: u1, // bit offset: 0 desc: Rising trigger event configuration of line 0
        TR1: u1, // bit offset: 1 desc: Rising trigger event configuration of line 1
        TR2: u1, // bit offset: 2 desc: Rising trigger event configuration of line 2
        TR3: u1, // bit offset: 3 desc: Rising trigger event configuration of line 3
        TR4: u1, // bit offset: 4 desc: Rising trigger event configuration of line 4
        TR5: u1, // bit offset: 5 desc: Rising trigger event configuration of line 5
        TR6: u1, // bit offset: 6 desc: Rising trigger event configuration of line 6
        TR7: u1, // bit offset: 7 desc: Rising trigger event configuration of line 7
        TR8: u1, // bit offset: 8 desc: Rising trigger event configuration of line 8
        TR9: u1, // bit offset: 9 desc: Rising trigger event configuration of line 9
        TR10: u1, // bit offset: 10 desc: Rising trigger event configuration of line 10
        TR11: u1, // bit offset: 11 desc: Rising trigger event configuration of line 11
        TR12: u1, // bit offset: 12 desc: Rising trigger event configuration of line 12
        TR13: u1, // bit offset: 13 desc: Rising trigger event configuration of line 13
        TR14: u1, // bit offset: 14 desc: Rising trigger event configuration of line 14
        TR15: u1, // bit offset: 15 desc: Rising trigger event configuration of line 15
        TR16: u1, // bit offset: 16 desc: Rising trigger event configuration of line 16
        TR17: u1, // bit offset: 17 desc: Rising trigger event configuration of line 17
        TR18: u1, // bit offset: 18 desc: Rising trigger event configuration of line 18
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Falling Trigger selection register (EXTI_FTSR)
    pub const FTSR = mmio(Address + 0x0000000c, 32, packed struct {
        TR0: u1, // bit offset: 0 desc: Falling trigger event configuration of line 0
        TR1: u1, // bit offset: 1 desc: Falling trigger event configuration of line 1
        TR2: u1, // bit offset: 2 desc: Falling trigger event configuration of line 2
        TR3: u1, // bit offset: 3 desc: Falling trigger event configuration of line 3
        TR4: u1, // bit offset: 4 desc: Falling trigger event configuration of line 4
        TR5: u1, // bit offset: 5 desc: Falling trigger event configuration of line 5
        TR6: u1, // bit offset: 6 desc: Falling trigger event configuration of line 6
        TR7: u1, // bit offset: 7 desc: Falling trigger event configuration of line 7
        TR8: u1, // bit offset: 8 desc: Falling trigger event configuration of line 8
        TR9: u1, // bit offset: 9 desc: Falling trigger event configuration of line 9
        TR10: u1, // bit offset: 10 desc: Falling trigger event configuration of line 10
        TR11: u1, // bit offset: 11 desc: Falling trigger event configuration of line 11
        TR12: u1, // bit offset: 12 desc: Falling trigger event configuration of line 12
        TR13: u1, // bit offset: 13 desc: Falling trigger event configuration of line 13
        TR14: u1, // bit offset: 14 desc: Falling trigger event configuration of line 14
        TR15: u1, // bit offset: 15 desc: Falling trigger event configuration of line 15
        TR16: u1, // bit offset: 16 desc: Falling trigger event configuration of line 16
        TR17: u1, // bit offset: 17 desc: Falling trigger event configuration of line 17
        TR18: u1, // bit offset: 18 desc: Falling trigger event configuration of line 18
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Software interrupt event register (EXTI_SWIER)
    pub const SWIER = mmio(Address + 0x00000010, 32, packed struct {
        SWIER0: u1, // bit offset: 0 desc: Software Interrupt on line 0
        SWIER1: u1, // bit offset: 1 desc: Software Interrupt on line 1
        SWIER2: u1, // bit offset: 2 desc: Software Interrupt on line 2
        SWIER3: u1, // bit offset: 3 desc: Software Interrupt on line 3
        SWIER4: u1, // bit offset: 4 desc: Software Interrupt on line 4
        SWIER5: u1, // bit offset: 5 desc: Software Interrupt on line 5
        SWIER6: u1, // bit offset: 6 desc: Software Interrupt on line 6
        SWIER7: u1, // bit offset: 7 desc: Software Interrupt on line 7
        SWIER8: u1, // bit offset: 8 desc: Software Interrupt on line 8
        SWIER9: u1, // bit offset: 9 desc: Software Interrupt on line 9
        SWIER10: u1, // bit offset: 10 desc: Software Interrupt on line 10
        SWIER11: u1, // bit offset: 11 desc: Software Interrupt on line 11
        SWIER12: u1, // bit offset: 12 desc: Software Interrupt on line 12
        SWIER13: u1, // bit offset: 13 desc: Software Interrupt on line 13
        SWIER14: u1, // bit offset: 14 desc: Software Interrupt on line 14
        SWIER15: u1, // bit offset: 15 desc: Software Interrupt on line 15
        SWIER16: u1, // bit offset: 16 desc: Software Interrupt on line 16
        SWIER17: u1, // bit offset: 17 desc: Software Interrupt on line 17
        SWIER18: u1, // bit offset: 18 desc: Software Interrupt on line 18
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Pending register (EXTI_PR)
    pub const PR = mmio(Address + 0x00000014, 32, packed struct {
        PR0: u1, // bit offset: 0 desc: Pending bit 0
        PR1: u1, // bit offset: 1 desc: Pending bit 1
        PR2: u1, // bit offset: 2 desc: Pending bit 2
        PR3: u1, // bit offset: 3 desc: Pending bit 3
        PR4: u1, // bit offset: 4 desc: Pending bit 4
        PR5: u1, // bit offset: 5 desc: Pending bit 5
        PR6: u1, // bit offset: 6 desc: Pending bit 6
        PR7: u1, // bit offset: 7 desc: Pending bit 7
        PR8: u1, // bit offset: 8 desc: Pending bit 8
        PR9: u1, // bit offset: 9 desc: Pending bit 9
        PR10: u1, // bit offset: 10 desc: Pending bit 10
        PR11: u1, // bit offset: 11 desc: Pending bit 11
        PR12: u1, // bit offset: 12 desc: Pending bit 12
        PR13: u1, // bit offset: 13 desc: Pending bit 13
        PR14: u1, // bit offset: 14 desc: Pending bit 14
        PR15: u1, // bit offset: 15 desc: Pending bit 15
        PR16: u1, // bit offset: 16 desc: Pending bit 16
        PR17: u1, // bit offset: 17 desc: Pending bit 17
        PR18: u1, // bit offset: 18 desc: Pending bit 18
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const DMA1 = extern struct {
    pub const Address: u32 = 0x40020000;
    // byte offset: 0 DMA interrupt status register (DMA_ISR)
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        GIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt flag
        TCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete flag
        HTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer Complete flag
        TEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error flag
        GIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt flag
        TCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete flag
        HTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer Complete flag
        TEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error flag
        GIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt flag
        TCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete flag
        HTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer Complete flag
        TEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error flag
        GIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt flag
        TCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete flag
        HTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer Complete flag
        TEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error flag
        GIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt flag
        TCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete flag
        HTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer Complete flag
        TEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error flag
        GIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt flag
        TCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete flag
        HTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer Complete flag
        TEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error flag
        GIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt flag
        TCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete flag
        HTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer Complete flag
        TEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error flag
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 DMA interrupt flag clear register (DMA_IFCR)
    pub const IFCR = mmio(Address + 0x00000004, 32, packed struct {
        CGIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt clear
        CTCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete clear
        CHTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer clear
        CTEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error clear
        CGIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt clear
        CTCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete clear
        CHTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer clear
        CTEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error clear
        CGIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt clear
        CTCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete clear
        CHTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer clear
        CTEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error clear
        CGIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt clear
        CTCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete clear
        CHTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer clear
        CTEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error clear
        CGIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt clear
        CTCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete clear
        CHTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer clear
        CTEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error clear
        CGIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt clear
        CTCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete clear
        CHTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer clear
        CTEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error clear
        CGIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt clear
        CTCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete clear
        CHTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer clear
        CTEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error clear
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 DMA channel configuration register (DMA_CCR)
    pub const CCR1 = mmio(Address + 0x00000008, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA channel 1 number of data register
    pub const CNDTR1 = mmio(Address + 0x0000000c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 DMA channel 1 peripheral address register
    pub const CPAR1 = mmio(Address + 0x00000010, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 20 DMA channel 1 memory address register
    pub const CMAR1 = mmio(Address + 0x00000014, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 28 DMA channel configuration register (DMA_CCR)
    pub const CCR2 = mmio(Address + 0x0000001c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 DMA channel 2 number of data register
    pub const CNDTR2 = mmio(Address + 0x00000020, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 DMA channel 2 peripheral address register
    pub const CPAR2 = mmio(Address + 0x00000024, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 40 DMA channel 2 memory address register
    pub const CMAR2 = mmio(Address + 0x00000028, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 48 DMA channel configuration register (DMA_CCR)
    pub const CCR3 = mmio(Address + 0x00000030, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 DMA channel 3 number of data register
    pub const CNDTR3 = mmio(Address + 0x00000034, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 DMA channel 3 peripheral address register
    pub const CPAR3 = mmio(Address + 0x00000038, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 60 DMA channel 3 memory address register
    pub const CMAR3 = mmio(Address + 0x0000003c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 68 DMA channel configuration register (DMA_CCR)
    pub const CCR4 = mmio(Address + 0x00000044, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA channel 4 number of data register
    pub const CNDTR4 = mmio(Address + 0x00000048, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA channel 4 peripheral address register
    pub const CPAR4 = mmio(Address + 0x0000004c, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 80 DMA channel 4 memory address register
    pub const CMAR4 = mmio(Address + 0x00000050, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 88 DMA channel configuration register (DMA_CCR)
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 92 DMA channel 5 number of data register
    pub const CNDTR5 = mmio(Address + 0x0000005c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 DMA channel 5 peripheral address register
    pub const CPAR5 = mmio(Address + 0x00000060, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 100 DMA channel 5 memory address register
    pub const CMAR5 = mmio(Address + 0x00000064, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 108 DMA channel configuration register (DMA_CCR)
    pub const CCR6 = mmio(Address + 0x0000006c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 112 DMA channel 6 number of data register
    pub const CNDTR6 = mmio(Address + 0x00000070, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 116 DMA channel 6 peripheral address register
    pub const CPAR6 = mmio(Address + 0x00000074, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 120 DMA channel 6 memory address register
    pub const CMAR6 = mmio(Address + 0x00000078, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 128 DMA channel configuration register (DMA_CCR)
    pub const CCR7 = mmio(Address + 0x00000080, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 DMA channel 7 number of data register
    pub const CNDTR7 = mmio(Address + 0x00000084, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 DMA channel 7 peripheral address register
    pub const CPAR7 = mmio(Address + 0x00000088, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 140 DMA channel 7 memory address register
    pub const CMAR7 = mmio(Address + 0x0000008c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
};
pub const DMA2 = extern struct {
    pub const Address: u32 = 0x40020400;
    // byte offset: 0 DMA interrupt status register (DMA_ISR)
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        GIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt flag
        TCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete flag
        HTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer Complete flag
        TEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error flag
        GIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt flag
        TCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete flag
        HTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer Complete flag
        TEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error flag
        GIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt flag
        TCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete flag
        HTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer Complete flag
        TEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error flag
        GIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt flag
        TCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete flag
        HTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer Complete flag
        TEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error flag
        GIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt flag
        TCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete flag
        HTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer Complete flag
        TEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error flag
        GIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt flag
        TCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete flag
        HTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer Complete flag
        TEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error flag
        GIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt flag
        TCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete flag
        HTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer Complete flag
        TEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error flag
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 DMA interrupt flag clear register (DMA_IFCR)
    pub const IFCR = mmio(Address + 0x00000004, 32, packed struct {
        CGIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt clear
        CTCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete clear
        CHTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer clear
        CTEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error clear
        CGIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt clear
        CTCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete clear
        CHTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer clear
        CTEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error clear
        CGIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt clear
        CTCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete clear
        CHTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer clear
        CTEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error clear
        CGIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt clear
        CTCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete clear
        CHTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer clear
        CTEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error clear
        CGIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt clear
        CTCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete clear
        CHTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer clear
        CTEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error clear
        CGIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt clear
        CTCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete clear
        CHTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer clear
        CTEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error clear
        CGIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt clear
        CTCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete clear
        CHTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer clear
        CTEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error clear
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 DMA channel configuration register (DMA_CCR)
    pub const CCR1 = mmio(Address + 0x00000008, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA channel 1 number of data register
    pub const CNDTR1 = mmio(Address + 0x0000000c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 DMA channel 1 peripheral address register
    pub const CPAR1 = mmio(Address + 0x00000010, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 20 DMA channel 1 memory address register
    pub const CMAR1 = mmio(Address + 0x00000014, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 28 DMA channel configuration register (DMA_CCR)
    pub const CCR2 = mmio(Address + 0x0000001c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 DMA channel 2 number of data register
    pub const CNDTR2 = mmio(Address + 0x00000020, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 DMA channel 2 peripheral address register
    pub const CPAR2 = mmio(Address + 0x00000024, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 40 DMA channel 2 memory address register
    pub const CMAR2 = mmio(Address + 0x00000028, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 48 DMA channel configuration register (DMA_CCR)
    pub const CCR3 = mmio(Address + 0x00000030, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 DMA channel 3 number of data register
    pub const CNDTR3 = mmio(Address + 0x00000034, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 DMA channel 3 peripheral address register
    pub const CPAR3 = mmio(Address + 0x00000038, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 60 DMA channel 3 memory address register
    pub const CMAR3 = mmio(Address + 0x0000003c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 68 DMA channel configuration register (DMA_CCR)
    pub const CCR4 = mmio(Address + 0x00000044, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA channel 4 number of data register
    pub const CNDTR4 = mmio(Address + 0x00000048, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA channel 4 peripheral address register
    pub const CPAR4 = mmio(Address + 0x0000004c, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 80 DMA channel 4 memory address register
    pub const CMAR4 = mmio(Address + 0x00000050, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 88 DMA channel configuration register (DMA_CCR)
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 92 DMA channel 5 number of data register
    pub const CNDTR5 = mmio(Address + 0x0000005c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 DMA channel 5 peripheral address register
    pub const CPAR5 = mmio(Address + 0x00000060, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 100 DMA channel 5 memory address register
    pub const CMAR5 = mmio(Address + 0x00000064, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 108 DMA channel configuration register (DMA_CCR)
    pub const CCR6 = mmio(Address + 0x0000006c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 112 DMA channel 6 number of data register
    pub const CNDTR6 = mmio(Address + 0x00000070, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 116 DMA channel 6 peripheral address register
    pub const CPAR6 = mmio(Address + 0x00000074, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 120 DMA channel 6 memory address register
    pub const CMAR6 = mmio(Address + 0x00000078, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 128 DMA channel configuration register (DMA_CCR)
    pub const CCR7 = mmio(Address + 0x00000080, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 DMA channel 7 number of data register
    pub const CNDTR7 = mmio(Address + 0x00000084, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 DMA channel 7 peripheral address register
    pub const CPAR7 = mmio(Address + 0x00000088, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 140 DMA channel 7 memory address register
    pub const CMAR7 = mmio(Address + 0x0000008c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
};
pub const SDIO = extern struct {
    pub const Address: u32 = 0x40018000;
    // byte offset: 0 Bits 1:0 = PWRCTRL: Power supply control bits
    pub const POWER = mmio(Address + 0x00000000, 32, packed struct {
        PWRCTRL: u2, // bit offset: 0 desc: PWRCTRL
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 SDI clock control register (SDIO_CLKCR)
    pub const CLKCR = mmio(Address + 0x00000004, 32, packed struct {
        CLKDIV: u8, // bit offset: 0 desc: Clock divide factor
        CLKEN: u1, // bit offset: 8 desc: Clock enable bit
        PWRSAV: u1, // bit offset: 9 desc: Power saving configuration bit
        BYPASS: u1, // bit offset: 10 desc: Clock divider bypass enable bit
        WIDBUS: u2, // bit offset: 11 desc: Wide bus mode enable bit
        NEGEDGE: u1, // bit offset: 13 desc: SDIO_CK dephasing selection bit
        HWFC_EN: u1, // bit offset: 14 desc: HW Flow Control enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Bits 31:0 = : Command argument
    pub const ARG = mmio(Address + 0x00000008, 32, packed struct {
        CMDARG: u32, // bit offset: 0 desc: Command argument
    });
    // byte offset: 12 SDIO command register (SDIO_CMD)
    pub const CMD = mmio(Address + 0x0000000c, 32, packed struct {
        CMDINDEX: u6, // bit offset: 0 desc: CMDINDEX
        WAITRESP: u2, // bit offset: 6 desc: WAITRESP
        WAITINT: u1, // bit offset: 8 desc: WAITINT
        WAITPEND: u1, // bit offset: 9 desc: WAITPEND
        CPSMEN: u1, // bit offset: 10 desc: CPSMEN
        SDIOSuspend: u1, // bit offset: 11 desc: SDIOSuspend
        ENCMDcompl: u1, // bit offset: 12 desc: ENCMDcompl
        nIEN: u1, // bit offset: 13 desc: nIEN
        CE_ATACMD: u1, // bit offset: 14 desc: CE_ATACMD
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 SDIO command register
    pub const RESPCMD = mmio(Address + 0x00000010, 32, packed struct {
        RESPCMD: u6, // bit offset: 0 desc: RESPCMD
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Bits 31:0 = CARDSTATUS1
    pub const RESPI1 = mmio(Address + 0x00000014, 32, packed struct {
        CARDSTATUS1: u32, // bit offset: 0 desc: CARDSTATUS1
    });
    // byte offset: 24 Bits 31:0 = CARDSTATUS2
    pub const RESP2 = mmio(Address + 0x00000018, 32, packed struct {
        CARDSTATUS2: u32, // bit offset: 0 desc: CARDSTATUS2
    });
    // byte offset: 28 Bits 31:0 = CARDSTATUS3
    pub const RESP3 = mmio(Address + 0x0000001c, 32, packed struct {
        CARDSTATUS3: u32, // bit offset: 0 desc: CARDSTATUS3
    });
    // byte offset: 32 Bits 31:0 = CARDSTATUS4
    pub const RESP4 = mmio(Address + 0x00000020, 32, packed struct {
        CARDSTATUS4: u32, // bit offset: 0 desc: CARDSTATUS4
    });
    // byte offset: 36 Bits 31:0 = DATATIME: Data timeout period
    pub const DTIMER = mmio(Address + 0x00000024, 32, packed struct {
        DATATIME: u32, // bit offset: 0 desc: Data timeout period
    });
    // byte offset: 40 Bits 24:0 = DATALENGTH: Data length value
    pub const DLEN = mmio(Address + 0x00000028, 32, packed struct {
        DATALENGTH: u25, // bit offset: 0 desc: Data length value
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 SDIO data control register (SDIO_DCTRL)
    pub const DCTRL = mmio(Address + 0x0000002c, 32, packed struct {
        DTEN: u1, // bit offset: 0 desc: DTEN
        DTDIR: u1, // bit offset: 1 desc: DTDIR
        DTMODE: u1, // bit offset: 2 desc: DTMODE
        DMAEN: u1, // bit offset: 3 desc: DMAEN
        DBLOCKSIZE: u4, // bit offset: 4 desc: DBLOCKSIZE
        PWSTART: u1, // bit offset: 8 desc: PWSTART
        PWSTOP: u1, // bit offset: 9 desc: PWSTOP
        RWMOD: u1, // bit offset: 10 desc: RWMOD
        SDIOEN: u1, // bit offset: 11 desc: SDIOEN
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 Bits 24:0 = DATACOUNT: Data count value
    pub const DCOUNT = mmio(Address + 0x00000030, 32, packed struct {
        DATACOUNT: u25, // bit offset: 0 desc: Data count value
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 SDIO status register (SDIO_STA)
    pub const STA = mmio(Address + 0x00000034, 32, packed struct {
        CCRCFAIL: u1, // bit offset: 0 desc: CCRCFAIL
        DCRCFAIL: u1, // bit offset: 1 desc: DCRCFAIL
        CTIMEOUT: u1, // bit offset: 2 desc: CTIMEOUT
        DTIMEOUT: u1, // bit offset: 3 desc: DTIMEOUT
        TXUNDERR: u1, // bit offset: 4 desc: TXUNDERR
        RXOVERR: u1, // bit offset: 5 desc: RXOVERR
        CMDREND: u1, // bit offset: 6 desc: CMDREND
        CMDSENT: u1, // bit offset: 7 desc: CMDSENT
        DATAEND: u1, // bit offset: 8 desc: DATAEND
        STBITERR: u1, // bit offset: 9 desc: STBITERR
        DBCKEND: u1, // bit offset: 10 desc: DBCKEND
        CMDACT: u1, // bit offset: 11 desc: CMDACT
        TXACT: u1, // bit offset: 12 desc: TXACT
        RXACT: u1, // bit offset: 13 desc: RXACT
        TXFIFOHE: u1, // bit offset: 14 desc: TXFIFOHE
        RXFIFOHF: u1, // bit offset: 15 desc: RXFIFOHF
        TXFIFOF: u1, // bit offset: 16 desc: TXFIFOF
        RXFIFOF: u1, // bit offset: 17 desc: RXFIFOF
        TXFIFOE: u1, // bit offset: 18 desc: TXFIFOE
        RXFIFOE: u1, // bit offset: 19 desc: RXFIFOE
        TXDAVL: u1, // bit offset: 20 desc: TXDAVL
        RXDAVL: u1, // bit offset: 21 desc: RXDAVL
        SDIOIT: u1, // bit offset: 22 desc: SDIOIT
        CEATAEND: u1, // bit offset: 23 desc: CEATAEND
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 SDIO interrupt clear register (SDIO_ICR)
    pub const ICR = mmio(Address + 0x00000038, 32, packed struct {
        CCRCFAILC: u1, // bit offset: 0 desc: CCRCFAILC
        DCRCFAILC: u1, // bit offset: 1 desc: DCRCFAILC
        CTIMEOUTC: u1, // bit offset: 2 desc: CTIMEOUTC
        DTIMEOUTC: u1, // bit offset: 3 desc: DTIMEOUTC
        TXUNDERRC: u1, // bit offset: 4 desc: TXUNDERRC
        RXOVERRC: u1, // bit offset: 5 desc: RXOVERRC
        CMDRENDC: u1, // bit offset: 6 desc: CMDRENDC
        CMDSENTC: u1, // bit offset: 7 desc: CMDSENTC
        DATAENDC: u1, // bit offset: 8 desc: DATAENDC
        STBITERRC: u1, // bit offset: 9 desc: STBITERRC
        DBCKENDC: u1, // bit offset: 10 desc: DBCKENDC
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SDIOITC: u1, // bit offset: 22 desc: SDIOITC
        CEATAENDC: u1, // bit offset: 23 desc: CEATAENDC
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 SDIO mask register (SDIO_MASK)
    pub const MASK = mmio(Address + 0x0000003c, 32, packed struct {
        CCRCFAILIE: u1, // bit offset: 0 desc: CCRCFAILIE
        DCRCFAILIE: u1, // bit offset: 1 desc: DCRCFAILIE
        CTIMEOUTIE: u1, // bit offset: 2 desc: CTIMEOUTIE
        DTIMEOUTIE: u1, // bit offset: 3 desc: DTIMEOUTIE
        TXUNDERRIE: u1, // bit offset: 4 desc: TXUNDERRIE
        RXOVERRIE: u1, // bit offset: 5 desc: RXOVERRIE
        CMDRENDIE: u1, // bit offset: 6 desc: CMDRENDIE
        CMDSENTIE: u1, // bit offset: 7 desc: CMDSENTIE
        DATAENDIE: u1, // bit offset: 8 desc: DATAENDIE
        STBITERRIE: u1, // bit offset: 9 desc: STBITERRIE
        DBACKENDIE: u1, // bit offset: 10 desc: DBACKENDIE
        CMDACTIE: u1, // bit offset: 11 desc: CMDACTIE
        TXACTIE: u1, // bit offset: 12 desc: TXACTIE
        RXACTIE: u1, // bit offset: 13 desc: RXACTIE
        TXFIFOHEIE: u1, // bit offset: 14 desc: TXFIFOHEIE
        RXFIFOHFIE: u1, // bit offset: 15 desc: RXFIFOHFIE
        TXFIFOFIE: u1, // bit offset: 16 desc: TXFIFOFIE
        RXFIFOFIE: u1, // bit offset: 17 desc: RXFIFOFIE
        TXFIFOEIE: u1, // bit offset: 18 desc: TXFIFOEIE
        RXFIFOEIE: u1, // bit offset: 19 desc: RXFIFOEIE
        TXDAVLIE: u1, // bit offset: 20 desc: TXDAVLIE
        RXDAVLIE: u1, // bit offset: 21 desc: RXDAVLIE
        SDIOITIE: u1, // bit offset: 22 desc: SDIOITIE
        CEATENDIE: u1, // bit offset: 23 desc: CEATENDIE
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 Bits 23:0 = FIFOCOUNT: Remaining number of words to be written to or read from the FIFO
    pub const FIFOCNT = mmio(Address + 0x00000048, 32, packed struct {
        FIF0COUNT: u24, // bit offset: 0 desc: FIF0COUNT
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 128 bits 31:0 = FIFOData: Receive and transmit FIFO data
    pub const FIFO = mmio(Address + 0x00000080, 32, packed struct {
        FIFOData: u32, // bit offset: 0 desc: FIFOData
    });
};
pub const RTC = extern struct {
    pub const Address: u32 = 0x40002800;
    // byte offset: 0 RTC Control Register High
    pub const CRH = mmio(Address + 0x00000000, 32, packed struct {
        SECIE: u1, // bit offset: 0 desc: Second interrupt Enable
        ALRIE: u1, // bit offset: 1 desc: Alarm interrupt Enable
        OWIE: u1, // bit offset: 2 desc: Overflow interrupt Enable
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 RTC Control Register Low
    pub const CRL = mmio(Address + 0x00000004, 32, packed struct {
        SECF: u1, // bit offset: 0 desc: Second Flag
        ALRF: u1, // bit offset: 1 desc: Alarm Flag
        OWF: u1, // bit offset: 2 desc: Overflow Flag
        RSF: u1, // bit offset: 3 desc: Registers Synchronized Flag
        CNF: u1, // bit offset: 4 desc: Configuration Flag
        RTOFF: u1, // bit offset: 5 desc: RTC operation OFF
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 RTC Prescaler Load Register High
    pub const PRLH = mmio(Address + 0x00000008, 32, packed struct {
        PRLH: u4, // bit offset: 0 desc: RTC Prescaler Load Register High
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 RTC Prescaler Load Register Low
    pub const PRLL = mmio(Address + 0x0000000c, 32, packed struct {
        PRLL: u16, // bit offset: 0 desc: RTC Prescaler Divider Register Low
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 RTC Prescaler Divider Register High
    pub const DIVH = mmio(Address + 0x00000010, 32, packed struct {
        DIVH: u4, // bit offset: 0 desc: RTC prescaler divider register high
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RTC Prescaler Divider Register Low
    pub const DIVL = mmio(Address + 0x00000014, 32, packed struct {
        DIVL: u16, // bit offset: 0 desc: RTC prescaler divider register Low
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 RTC Counter Register High
    pub const CNTH = mmio(Address + 0x00000018, 32, packed struct {
        CNTH: u16, // bit offset: 0 desc: RTC counter register high
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 RTC Counter Register Low
    pub const CNTL = mmio(Address + 0x0000001c, 32, packed struct {
        CNTL: u16, // bit offset: 0 desc: RTC counter register Low
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 RTC Alarm Register High
    pub const ALRH = mmio(Address + 0x00000020, 32, packed struct {
        ALRH: u16, // bit offset: 0 desc: RTC alarm register high
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 RTC Alarm Register Low
    pub const ALRL = mmio(Address + 0x00000024, 32, packed struct {
        ALRL: u16, // bit offset: 0 desc: RTC alarm register low
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const BKP = extern struct {
    pub const Address: u32 = 0x40006c04;
    // byte offset: 0 Backup data register (BKP_DR)
    pub const DR1 = mmio(Address + 0x00000000, 32, packed struct {
        D1: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Backup data register (BKP_DR)
    pub const DR2 = mmio(Address + 0x00000004, 32, packed struct {
        D2: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Backup data register (BKP_DR)
    pub const DR3 = mmio(Address + 0x00000008, 32, packed struct {
        D3: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Backup data register (BKP_DR)
    pub const DR4 = mmio(Address + 0x0000000c, 32, packed struct {
        D4: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Backup data register (BKP_DR)
    pub const DR5 = mmio(Address + 0x00000010, 32, packed struct {
        D5: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Backup data register (BKP_DR)
    pub const DR6 = mmio(Address + 0x00000014, 32, packed struct {
        D6: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Backup data register (BKP_DR)
    pub const DR7 = mmio(Address + 0x00000018, 32, packed struct {
        D7: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 Backup data register (BKP_DR)
    pub const DR8 = mmio(Address + 0x0000001c, 32, packed struct {
        D8: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Backup data register (BKP_DR)
    pub const DR9 = mmio(Address + 0x00000020, 32, packed struct {
        D9: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Backup data register (BKP_DR)
    pub const DR10 = mmio(Address + 0x00000024, 32, packed struct {
        D10: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 RTC clock calibration register (BKP_RTCCR)
    pub const RTCCR = mmio(Address + 0x00000028, 32, packed struct {
        CAL: u7, // bit offset: 0 desc: Calibration value
        CCO: u1, // bit offset: 7 desc: Calibration Clock Output
        ASOE: u1, // bit offset: 8 desc: Alarm or second output enable
        ASOS: u1, // bit offset: 9 desc: Alarm or second output selection
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 Backup control register (BKP_CR)
    pub const CR = mmio(Address + 0x0000002c, 32, packed struct {
        TPE: u1, // bit offset: 0 desc: Tamper pin enable
        TPAL: u1, // bit offset: 1 desc: Tamper pin active level
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 BKP_CSR control/status register (BKP_CSR)
    pub const CSR = mmio(Address + 0x00000030, 32, packed struct {
        CTE: u1, // bit offset: 0 desc: Clear Tamper event
        CTI: u1, // bit offset: 1 desc: Clear Tamper Interrupt
        TPIE: u1, // bit offset: 2 desc: Tamper Pin interrupt enable
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TEF: u1, // bit offset: 8 desc: Tamper Event Flag
        TIF: u1, // bit offset: 9 desc: Tamper Interrupt Flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 Backup data register (BKP_DR)
    pub const DR11 = mmio(Address + 0x0000003c, 32, packed struct {
        DR11: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 Backup data register (BKP_DR)
    pub const DR12 = mmio(Address + 0x00000040, 32, packed struct {
        DR12: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 Backup data register (BKP_DR)
    pub const DR13 = mmio(Address + 0x00000044, 32, packed struct {
        DR13: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 Backup data register (BKP_DR)
    pub const DR14 = mmio(Address + 0x00000048, 32, packed struct {
        D14: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 Backup data register (BKP_DR)
    pub const DR15 = mmio(Address + 0x0000004c, 32, packed struct {
        D15: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 80 Backup data register (BKP_DR)
    pub const DR16 = mmio(Address + 0x00000050, 32, packed struct {
        D16: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 84 Backup data register (BKP_DR)
    pub const DR17 = mmio(Address + 0x00000054, 32, packed struct {
        D17: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 88 Backup data register (BKP_DR)
    pub const DR18 = mmio(Address + 0x00000058, 32, packed struct {
        D18: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 92 Backup data register (BKP_DR)
    pub const DR19 = mmio(Address + 0x0000005c, 32, packed struct {
        D19: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 Backup data register (BKP_DR)
    pub const DR20 = mmio(Address + 0x00000060, 32, packed struct {
        D20: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 100 Backup data register (BKP_DR)
    pub const DR21 = mmio(Address + 0x00000064, 32, packed struct {
        D21: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 104 Backup data register (BKP_DR)
    pub const DR22 = mmio(Address + 0x00000068, 32, packed struct {
        D22: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 108 Backup data register (BKP_DR)
    pub const DR23 = mmio(Address + 0x0000006c, 32, packed struct {
        D23: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 112 Backup data register (BKP_DR)
    pub const DR24 = mmio(Address + 0x00000070, 32, packed struct {
        D24: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 116 Backup data register (BKP_DR)
    pub const DR25 = mmio(Address + 0x00000074, 32, packed struct {
        D25: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 120 Backup data register (BKP_DR)
    pub const DR26 = mmio(Address + 0x00000078, 32, packed struct {
        D26: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 124 Backup data register (BKP_DR)
    pub const DR27 = mmio(Address + 0x0000007c, 32, packed struct {
        D27: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 128 Backup data register (BKP_DR)
    pub const DR28 = mmio(Address + 0x00000080, 32, packed struct {
        D28: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 Backup data register (BKP_DR)
    pub const DR29 = mmio(Address + 0x00000084, 32, packed struct {
        D29: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 Backup data register (BKP_DR)
    pub const DR30 = mmio(Address + 0x00000088, 32, packed struct {
        D30: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 140 Backup data register (BKP_DR)
    pub const DR31 = mmio(Address + 0x0000008c, 32, packed struct {
        D31: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 144 Backup data register (BKP_DR)
    pub const DR32 = mmio(Address + 0x00000090, 32, packed struct {
        D32: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 148 Backup data register (BKP_DR)
    pub const DR33 = mmio(Address + 0x00000094, 32, packed struct {
        D33: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 152 Backup data register (BKP_DR)
    pub const DR34 = mmio(Address + 0x00000098, 32, packed struct {
        D34: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 156 Backup data register (BKP_DR)
    pub const DR35 = mmio(Address + 0x0000009c, 32, packed struct {
        D35: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 160 Backup data register (BKP_DR)
    pub const DR36 = mmio(Address + 0x000000a0, 32, packed struct {
        D36: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 164 Backup data register (BKP_DR)
    pub const DR37 = mmio(Address + 0x000000a4, 32, packed struct {
        D37: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 168 Backup data register (BKP_DR)
    pub const DR38 = mmio(Address + 0x000000a8, 32, packed struct {
        D38: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 172 Backup data register (BKP_DR)
    pub const DR39 = mmio(Address + 0x000000ac, 32, packed struct {
        D39: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 176 Backup data register (BKP_DR)
    pub const DR40 = mmio(Address + 0x000000b0, 32, packed struct {
        D40: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 180 Backup data register (BKP_DR)
    pub const DR41 = mmio(Address + 0x000000b4, 32, packed struct {
        D41: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 184 Backup data register (BKP_DR)
    pub const DR42 = mmio(Address + 0x000000b8, 32, packed struct {
        D42: u16, // bit offset: 0 desc: Backup data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const IWDG = extern struct {
    pub const Address: u32 = 0x40003000;
    // byte offset: 0 Key register (IWDG_KR)
    pub const KR = mmio(Address + 0x00000000, 32, packed struct {
        KEY: u16, // bit offset: 0 desc: Key value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Prescaler register (IWDG_PR)
    pub const PR = mmio(Address + 0x00000004, 32, packed struct {
        PR: u3, // bit offset: 0 desc: Prescaler divider
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Reload register (IWDG_RLR)
    pub const RLR = mmio(Address + 0x00000008, 32, packed struct {
        RL: u12, // bit offset: 0 desc: Watchdog counter reload value
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Status register (IWDG_SR)
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        PVU: u1, // bit offset: 0 desc: Watchdog prescaler value update
        RVU: u1, // bit offset: 1 desc: Watchdog counter reload value update
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const WWDG = extern struct {
    pub const Address: u32 = 0x40002c00;
    // byte offset: 0 Control register (WWDG_CR)
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        T: u7, // bit offset: 0 desc: 7-bit counter (MSB to LSB)
        WDGA: u1, // bit offset: 7 desc: Activation bit
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Configuration register (WWDG_CFR)
    pub const CFR = mmio(Address + 0x00000004, 32, packed struct {
        W: u7, // bit offset: 0 desc: 7-bit window value
        WDGTB: u2, // bit offset: 7 desc: Timer Base
        EWI: u1, // bit offset: 9 desc: Early Wakeup Interrupt
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Status register (WWDG_SR)
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        EWI: u1, // bit offset: 0 desc: Early Wakeup Interrupt
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM1 = extern struct {
    pub const Address: u32 = 0x40012c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
        OIS2: u1, // bit offset: 10 desc: Output Idle state 2
        OIS2N: u1, // bit offset: 11 desc: Output Idle state 2
        OIS3: u1, // bit offset: 12 desc: Output Idle state 3
        OIS3N: u1, // bit offset: 13 desc: Output Idle state 3
        OIS4: u1, // bit offset: 14 desc: Output Idle state 4
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        reserved1: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output Compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output Compare 2 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        ICPCS: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PCS: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        OC4CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        CC2NE: u1, // bit offset: 6 desc: Capture/Compare 2 complementary output enable
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        CC3NE: u1, // bit offset: 10 desc: Capture/Compare 3 complementary output enable
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u8, // bit offset: 0 desc: Repetition counter value
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM8 = extern struct {
    pub const Address: u32 = 0x40013400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
        OIS2: u1, // bit offset: 10 desc: Output Idle state 2
        OIS2N: u1, // bit offset: 11 desc: Output Idle state 2
        OIS3: u1, // bit offset: 12 desc: Output Idle state 3
        OIS3N: u1, // bit offset: 13 desc: Output Idle state 3
        OIS4: u1, // bit offset: 14 desc: Output Idle state 4
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        reserved1: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output Compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output Compare 2 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        ICPCS: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PCS: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        OC4CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        CC2NE: u1, // bit offset: 6 desc: Capture/Compare 2 complementary output enable
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        CC3NE: u1, // bit offset: 10 desc: Capture/Compare 3 complementary output enable
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u8, // bit offset: 0 desc: Repetition counter value
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM2 = extern struct {
    pub const Address: u32 = 0x40000000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        reserved2: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        reserved3: u1 = 0,
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output compare 2 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        O24CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM3 = extern struct {
    pub const Address: u32 = 0x40000400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        reserved2: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        reserved3: u1 = 0,
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output compare 2 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        O24CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM4 = extern struct {
    pub const Address: u32 = 0x40000800;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        reserved2: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        reserved3: u1 = 0,
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output compare 2 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        O24CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM5 = extern struct {
    pub const Address: u32 = 0x40000c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        reserved2: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        reserved3: u1 = 0,
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output compare 2 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        O24CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM9 = extern struct {
    pub const Address: u32 = 0x40014c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        reserved1: u1 = 0,
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved2: u1 = 0,
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM12 = extern struct {
    pub const Address: u32 = 0x40001800;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        reserved1: u1 = 0,
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved2: u1 = 0,
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM10 = extern struct {
    pub const Address: u32 = 0x40015000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        reserved1: u1 = 0,
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM11 = extern struct {
    pub const Address: u32 = 0x40015400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        reserved1: u1 = 0,
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM13 = extern struct {
    pub const Address: u32 = 0x40001c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        reserved1: u1 = 0,
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM14 = extern struct {
    pub const Address: u32 = 0x40002000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        reserved1: u1 = 0,
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM6 = extern struct {
    pub const Address: u32 = 0x40001000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: Low counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Low Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const TIM7 = extern struct {
    pub const Address: u32 = 0x40001400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: Low counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Low Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const I2C1 = extern struct {
    pub const Address: u32 = 0x40005400;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Peripheral enable
        SMBUS: u1, // bit offset: 1 desc: SMBus mode
        reserved1: u1 = 0,
        SMBTYPE: u1, // bit offset: 3 desc: SMBus type
        ENARP: u1, // bit offset: 4 desc: ARP enable
        ENPEC: u1, // bit offset: 5 desc: PEC enable
        ENGC: u1, // bit offset: 6 desc: General call enable
        NOSTRETCH: u1, // bit offset: 7 desc: Clock stretching disable (Slave mode)
        START: u1, // bit offset: 8 desc: Start generation
        STOP: u1, // bit offset: 9 desc: Stop generation
        ACK: u1, // bit offset: 10 desc: Acknowledge enable
        POS: u1, // bit offset: 11 desc: Acknowledge/PEC Position (for data reception)
        PEC: u1, // bit offset: 12 desc: Packet error checking
        ALERT: u1, // bit offset: 13 desc: SMBus alert
        reserved2: u1 = 0,
        SWRST: u1, // bit offset: 15 desc: Software reset
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        FREQ: u6, // bit offset: 0 desc: Peripheral clock frequency
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ITERREN: u1, // bit offset: 8 desc: Error interrupt enable
        ITEVTEN: u1, // bit offset: 9 desc: Event interrupt enable
        ITBUFEN: u1, // bit offset: 10 desc: Buffer interrupt enable
        DMAEN: u1, // bit offset: 11 desc: DMA requests enable
        LAST: u1, // bit offset: 12 desc: DMA last transfer
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        ADD0: u1, // bit offset: 0 desc: Interface address
        ADD7: u7, // bit offset: 1 desc: Interface address
        ADD10: u2, // bit offset: 8 desc: Interface address
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDMODE: u1, // bit offset: 15 desc: Addressing mode (slave mode)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        ENDUAL: u1, // bit offset: 0 desc: Dual addressing mode enable
        ADD2: u7, // bit offset: 1 desc: Interface address
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Data register
    pub const DR = mmio(Address + 0x00000010, 32, packed struct {
        DR: u8, // bit offset: 0 desc: 8-bit data register
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Status register 1
    pub const SR1 = mmio(Address + 0x00000014, 32, packed struct {
        SB: u1, // bit offset: 0 desc: Start bit (Master mode)
        ADDR: u1, // bit offset: 1 desc: Address sent (master mode)/matched (slave mode)
        BTF: u1, // bit offset: 2 desc: Byte transfer finished
        ADD10: u1, // bit offset: 3 desc: 10-bit header sent (Master mode)
        STOPF: u1, // bit offset: 4 desc: Stop detection (slave mode)
        reserved1: u1 = 0,
        RxNE: u1, // bit offset: 6 desc: Data register not empty (receivers)
        TxE: u1, // bit offset: 7 desc: Data register empty (transmitters)
        BERR: u1, // bit offset: 8 desc: Bus error
        ARLO: u1, // bit offset: 9 desc: Arbitration lost (master mode)
        AF: u1, // bit offset: 10 desc: Acknowledge failure
        OVR: u1, // bit offset: 11 desc: Overrun/Underrun
        PECERR: u1, // bit offset: 12 desc: PEC Error in reception
        reserved2: u1 = 0,
        TIMEOUT: u1, // bit offset: 14 desc: Timeout or Tlow error
        SMBALERT: u1, // bit offset: 15 desc: SMBus alert
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Status register 2
    pub const SR2 = mmio(Address + 0x00000018, 32, packed struct {
        MSL: u1, // bit offset: 0 desc: Master/slave
        BUSY: u1, // bit offset: 1 desc: Bus busy
        TRA: u1, // bit offset: 2 desc: Transmitter/receiver
        reserved1: u1 = 0,
        GENCALL: u1, // bit offset: 4 desc: General call address (Slave mode)
        SMBDEFAULT: u1, // bit offset: 5 desc: SMBus device default address (Slave mode)
        SMBHOST: u1, // bit offset: 6 desc: SMBus host header (Slave mode)
        DUALF: u1, // bit offset: 7 desc: Dual flag (Slave mode)
        PEC: u8, // bit offset: 8 desc: acket error checking register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 Clock control register
    pub const CCR = mmio(Address + 0x0000001c, 32, packed struct {
        CCR: u12, // bit offset: 0 desc: Clock control register in Fast/Standard mode (Master mode)
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DUTY: u1, // bit offset: 14 desc: Fast mode duty cycle
        F_S: u1, // bit offset: 15 desc: I2C master mode selection
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 TRISE register
    pub const TRISE = mmio(Address + 0x00000020, 32, packed struct {
        TRISE: u6, // bit offset: 0 desc: Maximum rise time in Fast/Standard mode (Master mode)
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const I2C2 = extern struct {
    pub const Address: u32 = 0x40005800;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Peripheral enable
        SMBUS: u1, // bit offset: 1 desc: SMBus mode
        reserved1: u1 = 0,
        SMBTYPE: u1, // bit offset: 3 desc: SMBus type
        ENARP: u1, // bit offset: 4 desc: ARP enable
        ENPEC: u1, // bit offset: 5 desc: PEC enable
        ENGC: u1, // bit offset: 6 desc: General call enable
        NOSTRETCH: u1, // bit offset: 7 desc: Clock stretching disable (Slave mode)
        START: u1, // bit offset: 8 desc: Start generation
        STOP: u1, // bit offset: 9 desc: Stop generation
        ACK: u1, // bit offset: 10 desc: Acknowledge enable
        POS: u1, // bit offset: 11 desc: Acknowledge/PEC Position (for data reception)
        PEC: u1, // bit offset: 12 desc: Packet error checking
        ALERT: u1, // bit offset: 13 desc: SMBus alert
        reserved2: u1 = 0,
        SWRST: u1, // bit offset: 15 desc: Software reset
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        FREQ: u6, // bit offset: 0 desc: Peripheral clock frequency
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ITERREN: u1, // bit offset: 8 desc: Error interrupt enable
        ITEVTEN: u1, // bit offset: 9 desc: Event interrupt enable
        ITBUFEN: u1, // bit offset: 10 desc: Buffer interrupt enable
        DMAEN: u1, // bit offset: 11 desc: DMA requests enable
        LAST: u1, // bit offset: 12 desc: DMA last transfer
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        ADD0: u1, // bit offset: 0 desc: Interface address
        ADD7: u7, // bit offset: 1 desc: Interface address
        ADD10: u2, // bit offset: 8 desc: Interface address
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDMODE: u1, // bit offset: 15 desc: Addressing mode (slave mode)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        ENDUAL: u1, // bit offset: 0 desc: Dual addressing mode enable
        ADD2: u7, // bit offset: 1 desc: Interface address
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Data register
    pub const DR = mmio(Address + 0x00000010, 32, packed struct {
        DR: u8, // bit offset: 0 desc: 8-bit data register
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Status register 1
    pub const SR1 = mmio(Address + 0x00000014, 32, packed struct {
        SB: u1, // bit offset: 0 desc: Start bit (Master mode)
        ADDR: u1, // bit offset: 1 desc: Address sent (master mode)/matched (slave mode)
        BTF: u1, // bit offset: 2 desc: Byte transfer finished
        ADD10: u1, // bit offset: 3 desc: 10-bit header sent (Master mode)
        STOPF: u1, // bit offset: 4 desc: Stop detection (slave mode)
        reserved1: u1 = 0,
        RxNE: u1, // bit offset: 6 desc: Data register not empty (receivers)
        TxE: u1, // bit offset: 7 desc: Data register empty (transmitters)
        BERR: u1, // bit offset: 8 desc: Bus error
        ARLO: u1, // bit offset: 9 desc: Arbitration lost (master mode)
        AF: u1, // bit offset: 10 desc: Acknowledge failure
        OVR: u1, // bit offset: 11 desc: Overrun/Underrun
        PECERR: u1, // bit offset: 12 desc: PEC Error in reception
        reserved2: u1 = 0,
        TIMEOUT: u1, // bit offset: 14 desc: Timeout or Tlow error
        SMBALERT: u1, // bit offset: 15 desc: SMBus alert
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Status register 2
    pub const SR2 = mmio(Address + 0x00000018, 32, packed struct {
        MSL: u1, // bit offset: 0 desc: Master/slave
        BUSY: u1, // bit offset: 1 desc: Bus busy
        TRA: u1, // bit offset: 2 desc: Transmitter/receiver
        reserved1: u1 = 0,
        GENCALL: u1, // bit offset: 4 desc: General call address (Slave mode)
        SMBDEFAULT: u1, // bit offset: 5 desc: SMBus device default address (Slave mode)
        SMBHOST: u1, // bit offset: 6 desc: SMBus host header (Slave mode)
        DUALF: u1, // bit offset: 7 desc: Dual flag (Slave mode)
        PEC: u8, // bit offset: 8 desc: acket error checking register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 Clock control register
    pub const CCR = mmio(Address + 0x0000001c, 32, packed struct {
        CCR: u12, // bit offset: 0 desc: Clock control register in Fast/Standard mode (Master mode)
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DUTY: u1, // bit offset: 14 desc: Fast mode duty cycle
        F_S: u1, // bit offset: 15 desc: I2C master mode selection
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 TRISE register
    pub const TRISE = mmio(Address + 0x00000020, 32, packed struct {
        TRISE: u6, // bit offset: 0 desc: Maximum rise time in Fast/Standard mode (Master mode)
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const SPI1 = extern struct {
    pub const Address: u32 = 0x40013000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        DFF: u1, // bit offset: 11 desc: Data frame format
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const SPI2 = extern struct {
    pub const Address: u32 = 0x40003800;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        DFF: u1, // bit offset: 11 desc: Data frame format
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const SPI3 = extern struct {
    pub const Address: u32 = 0x40003c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        DFF: u1, // bit offset: 11 desc: Data frame format
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const USART1 = extern struct {
    pub const Address: u32 = 0x40013800;
    // byte offset: 0 Status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NE: u1, // bit offset: 2 desc: Noise error flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: IDLE line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBD: u1, // bit offset: 8 desc: LIN break detection flag
        CTS: u1, // bit offset: 9 desc: CTS flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Data register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        DR: u9, // bit offset: 0 desc: Data value
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Baud rate register
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Control register 1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SBK: u1, // bit offset: 0 desc: Send break
        RWU: u1, // bit offset: 1 desc: Receiver wakeup
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: TXE interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Wakeup method
        M: u1, // bit offset: 12 desc: Word length
        UE: u1, // bit offset: 13 desc: USART enable
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Control register 2
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        ADD: u4, // bit offset: 0 desc: Address of the USART node
        reserved1: u1 = 0,
        LBDL: u1, // bit offset: 5 desc: lin break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved2: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Control register 3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000018, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const USART2 = extern struct {
    pub const Address: u32 = 0x40004400;
    // byte offset: 0 Status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NE: u1, // bit offset: 2 desc: Noise error flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: IDLE line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBD: u1, // bit offset: 8 desc: LIN break detection flag
        CTS: u1, // bit offset: 9 desc: CTS flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Data register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        DR: u9, // bit offset: 0 desc: Data value
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Baud rate register
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Control register 1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SBK: u1, // bit offset: 0 desc: Send break
        RWU: u1, // bit offset: 1 desc: Receiver wakeup
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: TXE interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Wakeup method
        M: u1, // bit offset: 12 desc: Word length
        UE: u1, // bit offset: 13 desc: USART enable
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Control register 2
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        ADD: u4, // bit offset: 0 desc: Address of the USART node
        reserved1: u1 = 0,
        LBDL: u1, // bit offset: 5 desc: lin break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved2: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Control register 3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000018, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const USART3 = extern struct {
    pub const Address: u32 = 0x40004800;
    // byte offset: 0 Status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NE: u1, // bit offset: 2 desc: Noise error flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: IDLE line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBD: u1, // bit offset: 8 desc: LIN break detection flag
        CTS: u1, // bit offset: 9 desc: CTS flag
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Data register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        DR: u9, // bit offset: 0 desc: Data value
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Baud rate register
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Control register 1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SBK: u1, // bit offset: 0 desc: Send break
        RWU: u1, // bit offset: 1 desc: Receiver wakeup
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: TXE interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Wakeup method
        M: u1, // bit offset: 12 desc: Word length
        UE: u1, // bit offset: 13 desc: USART enable
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Control register 2
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        ADD: u4, // bit offset: 0 desc: Address of the USART node
        reserved1: u1 = 0,
        LBDL: u1, // bit offset: 5 desc: lin break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved2: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Control register 3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000018, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const ADC1 = extern struct {
    pub const Address: u32 = 0x40012400;
    // byte offset: 0 status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        AWD: u1, // bit offset: 0 desc: Analog watchdog flag
        EOC: u1, // bit offset: 1 desc: Regular channel end of conversion
        JEOC: u1, // bit offset: 2 desc: Injected channel end of conversion
        JSTRT: u1, // bit offset: 3 desc: Injected channel start flag
        STRT: u1, // bit offset: 4 desc: Regular channel start flag
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 1
    pub const CR1 = mmio(Address + 0x00000004, 32, packed struct {
        AWDCH: u5, // bit offset: 0 desc: Analog watchdog channel select bits
        EOCIE: u1, // bit offset: 5 desc: Interrupt enable for EOC
        AWDIE: u1, // bit offset: 6 desc: Analog watchdog interrupt enable
        JEOCIE: u1, // bit offset: 7 desc: Interrupt enable for injected channels
        SCAN: u1, // bit offset: 8 desc: Scan mode
        AWDSGL: u1, // bit offset: 9 desc: Enable the watchdog on a single channel in scan mode
        JAUTO: u1, // bit offset: 10 desc: Automatic injected group conversion
        DISCEN: u1, // bit offset: 11 desc: Discontinuous mode on regular channels
        JDISCEN: u1, // bit offset: 12 desc: Discontinuous mode on injected channels
        DISCNUM: u3, // bit offset: 13 desc: Discontinuous mode channel count
        DUALMOD: u4, // bit offset: 16 desc: Dual mode selection
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        JAWDEN: u1, // bit offset: 22 desc: Analog watchdog enable on injected channels
        AWDEN: u1, // bit offset: 23 desc: Analog watchdog enable on regular channels
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 control register 2
    pub const CR2 = mmio(Address + 0x00000008, 32, packed struct {
        ADON: u1, // bit offset: 0 desc: A/D converter ON / OFF
        CONT: u1, // bit offset: 1 desc: Continuous conversion
        CAL: u1, // bit offset: 2 desc: A/D calibration
        RSTCAL: u1, // bit offset: 3 desc: Reset calibration
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DMA: u1, // bit offset: 8 desc: Direct memory access mode
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        ALIGN: u1, // bit offset: 11 desc: Data alignment
        JEXTSEL: u3, // bit offset: 12 desc: External event select for injected group
        JEXTTRIG: u1, // bit offset: 15 desc: External trigger conversion mode for injected channels
        reserved7: u1 = 0,
        EXTSEL: u3, // bit offset: 17 desc: External event select for regular group
        EXTTRIG: u1, // bit offset: 20 desc: External trigger conversion mode for regular channels
        JSWSTART: u1, // bit offset: 21 desc: Start conversion of injected channels
        SWSTART: u1, // bit offset: 22 desc: Start conversion of regular channels
        TSVREFE: u1, // bit offset: 23 desc: Temperature sensor and VREFINT enable
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 sample time register 1
    pub const SMPR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SMP10: u3, // bit offset: 0 desc: Channel 10 sample time selection
        SMP11: u3, // bit offset: 3 desc: Channel 11 sample time selection
        SMP12: u3, // bit offset: 6 desc: Channel 12 sample time selection
        SMP13: u3, // bit offset: 9 desc: Channel 13 sample time selection
        SMP14: u3, // bit offset: 12 desc: Channel 14 sample time selection
        SMP15: u3, // bit offset: 15 desc: Channel 15 sample time selection
        SMP16: u3, // bit offset: 18 desc: Channel 16 sample time selection
        SMP17: u3, // bit offset: 21 desc: Channel 17 sample time selection
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000010, 32, packed struct {
        SMP0: u3, // bit offset: 0 desc: Channel 0 sample time selection
        SMP1: u3, // bit offset: 3 desc: Channel 1 sample time selection
        SMP2: u3, // bit offset: 6 desc: Channel 2 sample time selection
        SMP3: u3, // bit offset: 9 desc: Channel 3 sample time selection
        SMP4: u3, // bit offset: 12 desc: Channel 4 sample time selection
        SMP5: u3, // bit offset: 15 desc: Channel 5 sample time selection
        SMP6: u3, // bit offset: 18 desc: Channel 6 sample time selection
        SMP7: u3, // bit offset: 21 desc: Channel 7 sample time selection
        SMP8: u3, // bit offset: 24 desc: Channel 8 sample time selection
        SMP9: u3, // bit offset: 27 desc: Channel 9 sample time selection
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 injected channel data offset register x
    pub const JOFR1 = mmio(Address + 0x00000014, 32, packed struct {
        JOFFSET1: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 injected channel data offset register x
    pub const JOFR2 = mmio(Address + 0x00000018, 32, packed struct {
        JOFFSET2: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 injected channel data offset register x
    pub const JOFR3 = mmio(Address + 0x0000001c, 32, packed struct {
        JOFFSET3: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 injected channel data offset register x
    pub const JOFR4 = mmio(Address + 0x00000020, 32, packed struct {
        JOFFSET4: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 watchdog higher threshold register
    pub const HTR = mmio(Address + 0x00000024, 32, packed struct {
        HT: u12, // bit offset: 0 desc: Analog watchdog higher threshold
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 watchdog lower threshold register
    pub const LTR = mmio(Address + 0x00000028, 32, packed struct {
        LT: u12, // bit offset: 0 desc: Analog watchdog lower threshold
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 regular sequence register 1
    pub const SQR1 = mmio(Address + 0x0000002c, 32, packed struct {
        SQ13: u5, // bit offset: 0 desc: 13th conversion in regular sequence
        SQ14: u5, // bit offset: 5 desc: 14th conversion in regular sequence
        SQ15: u5, // bit offset: 10 desc: 15th conversion in regular sequence
        SQ16: u5, // bit offset: 15 desc: 16th conversion in regular sequence
        L: u4, // bit offset: 20 desc: Regular channel sequence length
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000030, 32, packed struct {
        SQ7: u5, // bit offset: 0 desc: 7th conversion in regular sequence
        SQ8: u5, // bit offset: 5 desc: 8th conversion in regular sequence
        SQ9: u5, // bit offset: 10 desc: 9th conversion in regular sequence
        SQ10: u5, // bit offset: 15 desc: 10th conversion in regular sequence
        SQ11: u5, // bit offset: 20 desc: 11th conversion in regular sequence
        SQ12: u5, // bit offset: 25 desc: 12th conversion in regular sequence
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000034, 32, packed struct {
        SQ1: u5, // bit offset: 0 desc: 1st conversion in regular sequence
        SQ2: u5, // bit offset: 5 desc: 2nd conversion in regular sequence
        SQ3: u5, // bit offset: 10 desc: 3rd conversion in regular sequence
        SQ4: u5, // bit offset: 15 desc: 4th conversion in regular sequence
        SQ5: u5, // bit offset: 20 desc: 5th conversion in regular sequence
        SQ6: u5, // bit offset: 25 desc: 6th conversion in regular sequence
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 injected sequence register
    pub const JSQR = mmio(Address + 0x00000038, 32, packed struct {
        JSQ1: u5, // bit offset: 0 desc: 1st conversion in injected sequence
        JSQ2: u5, // bit offset: 5 desc: 2nd conversion in injected sequence
        JSQ3: u5, // bit offset: 10 desc: 3rd conversion in injected sequence
        JSQ4: u5, // bit offset: 15 desc: 4th conversion in injected sequence
        JL: u2, // bit offset: 20 desc: Injected sequence length
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 injected data register x
    pub const JDR1 = mmio(Address + 0x0000003c, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 injected data register x
    pub const JDR2 = mmio(Address + 0x00000040, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 injected data register x
    pub const JDR3 = mmio(Address + 0x00000044, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 injected data register x
    pub const JDR4 = mmio(Address + 0x00000048, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 regular data register
    pub const DR = mmio(Address + 0x0000004c, 32, packed struct {
        DATA: u16, // bit offset: 0 desc: Regular data
        ADC2DATA: u16, // bit offset: 16 desc: ADC2 data
    });
};
pub const ADC2 = extern struct {
    pub const Address: u32 = 0x40012800;
    // byte offset: 0 status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        AWD: u1, // bit offset: 0 desc: Analog watchdog flag
        EOC: u1, // bit offset: 1 desc: Regular channel end of conversion
        JEOC: u1, // bit offset: 2 desc: Injected channel end of conversion
        JSTRT: u1, // bit offset: 3 desc: Injected channel start flag
        STRT: u1, // bit offset: 4 desc: Regular channel start flag
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 1
    pub const CR1 = mmio(Address + 0x00000004, 32, packed struct {
        AWDCH: u5, // bit offset: 0 desc: Analog watchdog channel select bits
        EOCIE: u1, // bit offset: 5 desc: Interrupt enable for EOC
        AWDIE: u1, // bit offset: 6 desc: Analog watchdog interrupt enable
        JEOCIE: u1, // bit offset: 7 desc: Interrupt enable for injected channels
        SCAN: u1, // bit offset: 8 desc: Scan mode
        AWDSGL: u1, // bit offset: 9 desc: Enable the watchdog on a single channel in scan mode
        JAUTO: u1, // bit offset: 10 desc: Automatic injected group conversion
        DISCEN: u1, // bit offset: 11 desc: Discontinuous mode on regular channels
        JDISCEN: u1, // bit offset: 12 desc: Discontinuous mode on injected channels
        DISCNUM: u3, // bit offset: 13 desc: Discontinuous mode channel count
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        JAWDEN: u1, // bit offset: 22 desc: Analog watchdog enable on injected channels
        AWDEN: u1, // bit offset: 23 desc: Analog watchdog enable on regular channels
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 control register 2
    pub const CR2 = mmio(Address + 0x00000008, 32, packed struct {
        ADON: u1, // bit offset: 0 desc: A/D converter ON / OFF
        CONT: u1, // bit offset: 1 desc: Continuous conversion
        CAL: u1, // bit offset: 2 desc: A/D calibration
        RSTCAL: u1, // bit offset: 3 desc: Reset calibration
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DMA: u1, // bit offset: 8 desc: Direct memory access mode
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        ALIGN: u1, // bit offset: 11 desc: Data alignment
        JEXTSEL: u3, // bit offset: 12 desc: External event select for injected group
        JEXTTRIG: u1, // bit offset: 15 desc: External trigger conversion mode for injected channels
        reserved7: u1 = 0,
        EXTSEL: u3, // bit offset: 17 desc: External event select for regular group
        EXTTRIG: u1, // bit offset: 20 desc: External trigger conversion mode for regular channels
        JSWSTART: u1, // bit offset: 21 desc: Start conversion of injected channels
        SWSTART: u1, // bit offset: 22 desc: Start conversion of regular channels
        TSVREFE: u1, // bit offset: 23 desc: Temperature sensor and VREFINT enable
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 sample time register 1
    pub const SMPR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SMP10: u3, // bit offset: 0 desc: Channel 10 sample time selection
        SMP11: u3, // bit offset: 3 desc: Channel 11 sample time selection
        SMP12: u3, // bit offset: 6 desc: Channel 12 sample time selection
        SMP13: u3, // bit offset: 9 desc: Channel 13 sample time selection
        SMP14: u3, // bit offset: 12 desc: Channel 14 sample time selection
        SMP15: u3, // bit offset: 15 desc: Channel 15 sample time selection
        SMP16: u3, // bit offset: 18 desc: Channel 16 sample time selection
        SMP17: u3, // bit offset: 21 desc: Channel 17 sample time selection
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000010, 32, packed struct {
        SMP0: u3, // bit offset: 0 desc: Channel 0 sample time selection
        SMP1: u3, // bit offset: 3 desc: Channel 1 sample time selection
        SMP2: u3, // bit offset: 6 desc: Channel 2 sample time selection
        SMP3: u3, // bit offset: 9 desc: Channel 3 sample time selection
        SMP4: u3, // bit offset: 12 desc: Channel 4 sample time selection
        SMP5: u3, // bit offset: 15 desc: Channel 5 sample time selection
        SMP6: u3, // bit offset: 18 desc: Channel 6 sample time selection
        SMP7: u3, // bit offset: 21 desc: Channel 7 sample time selection
        SMP8: u3, // bit offset: 24 desc: Channel 8 sample time selection
        SMP9: u3, // bit offset: 27 desc: Channel 9 sample time selection
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 injected channel data offset register x
    pub const JOFR1 = mmio(Address + 0x00000014, 32, packed struct {
        JOFFSET1: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 injected channel data offset register x
    pub const JOFR2 = mmio(Address + 0x00000018, 32, packed struct {
        JOFFSET2: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 injected channel data offset register x
    pub const JOFR3 = mmio(Address + 0x0000001c, 32, packed struct {
        JOFFSET3: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 injected channel data offset register x
    pub const JOFR4 = mmio(Address + 0x00000020, 32, packed struct {
        JOFFSET4: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 watchdog higher threshold register
    pub const HTR = mmio(Address + 0x00000024, 32, packed struct {
        HT: u12, // bit offset: 0 desc: Analog watchdog higher threshold
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 watchdog lower threshold register
    pub const LTR = mmio(Address + 0x00000028, 32, packed struct {
        LT: u12, // bit offset: 0 desc: Analog watchdog lower threshold
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 regular sequence register 1
    pub const SQR1 = mmio(Address + 0x0000002c, 32, packed struct {
        SQ13: u5, // bit offset: 0 desc: 13th conversion in regular sequence
        SQ14: u5, // bit offset: 5 desc: 14th conversion in regular sequence
        SQ15: u5, // bit offset: 10 desc: 15th conversion in regular sequence
        SQ16: u5, // bit offset: 15 desc: 16th conversion in regular sequence
        L: u4, // bit offset: 20 desc: Regular channel sequence length
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000030, 32, packed struct {
        SQ7: u5, // bit offset: 0 desc: 7th conversion in regular sequence
        SQ8: u5, // bit offset: 5 desc: 8th conversion in regular sequence
        SQ9: u5, // bit offset: 10 desc: 9th conversion in regular sequence
        SQ10: u5, // bit offset: 15 desc: 10th conversion in regular sequence
        SQ11: u5, // bit offset: 20 desc: 11th conversion in regular sequence
        SQ12: u5, // bit offset: 25 desc: 12th conversion in regular sequence
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000034, 32, packed struct {
        SQ1: u5, // bit offset: 0 desc: 1st conversion in regular sequence
        SQ2: u5, // bit offset: 5 desc: 2nd conversion in regular sequence
        SQ3: u5, // bit offset: 10 desc: 3rd conversion in regular sequence
        SQ4: u5, // bit offset: 15 desc: 4th conversion in regular sequence
        SQ5: u5, // bit offset: 20 desc: 5th conversion in regular sequence
        SQ6: u5, // bit offset: 25 desc: 6th conversion in regular sequence
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 injected sequence register
    pub const JSQR = mmio(Address + 0x00000038, 32, packed struct {
        JSQ1: u5, // bit offset: 0 desc: 1st conversion in injected sequence
        JSQ2: u5, // bit offset: 5 desc: 2nd conversion in injected sequence
        JSQ3: u5, // bit offset: 10 desc: 3rd conversion in injected sequence
        JSQ4: u5, // bit offset: 15 desc: 4th conversion in injected sequence
        JL: u2, // bit offset: 20 desc: Injected sequence length
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 injected data register x
    pub const JDR1 = mmio(Address + 0x0000003c, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 injected data register x
    pub const JDR2 = mmio(Address + 0x00000040, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 injected data register x
    pub const JDR3 = mmio(Address + 0x00000044, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 injected data register x
    pub const JDR4 = mmio(Address + 0x00000048, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 regular data register
    pub const DR = mmio(Address + 0x0000004c, 32, packed struct {
        DATA: u16, // bit offset: 0 desc: Regular data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const ADC3 = extern struct {
    pub const Address: u32 = 0x40013c00;
    // byte offset: 0 status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        AWD: u1, // bit offset: 0 desc: Analog watchdog flag
        EOC: u1, // bit offset: 1 desc: Regular channel end of conversion
        JEOC: u1, // bit offset: 2 desc: Injected channel end of conversion
        JSTRT: u1, // bit offset: 3 desc: Injected channel start flag
        STRT: u1, // bit offset: 4 desc: Regular channel start flag
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 1
    pub const CR1 = mmio(Address + 0x00000004, 32, packed struct {
        AWDCH: u5, // bit offset: 0 desc: Analog watchdog channel select bits
        EOCIE: u1, // bit offset: 5 desc: Interrupt enable for EOC
        AWDIE: u1, // bit offset: 6 desc: Analog watchdog interrupt enable
        JEOCIE: u1, // bit offset: 7 desc: Interrupt enable for injected channels
        SCAN: u1, // bit offset: 8 desc: Scan mode
        AWDSGL: u1, // bit offset: 9 desc: Enable the watchdog on a single channel in scan mode
        JAUTO: u1, // bit offset: 10 desc: Automatic injected group conversion
        DISCEN: u1, // bit offset: 11 desc: Discontinuous mode on regular channels
        JDISCEN: u1, // bit offset: 12 desc: Discontinuous mode on injected channels
        DISCNUM: u3, // bit offset: 13 desc: Discontinuous mode channel count
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        JAWDEN: u1, // bit offset: 22 desc: Analog watchdog enable on injected channels
        AWDEN: u1, // bit offset: 23 desc: Analog watchdog enable on regular channels
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 control register 2
    pub const CR2 = mmio(Address + 0x00000008, 32, packed struct {
        ADON: u1, // bit offset: 0 desc: A/D converter ON / OFF
        CONT: u1, // bit offset: 1 desc: Continuous conversion
        CAL: u1, // bit offset: 2 desc: A/D calibration
        RSTCAL: u1, // bit offset: 3 desc: Reset calibration
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DMA: u1, // bit offset: 8 desc: Direct memory access mode
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        ALIGN: u1, // bit offset: 11 desc: Data alignment
        JEXTSEL: u3, // bit offset: 12 desc: External event select for injected group
        JEXTTRIG: u1, // bit offset: 15 desc: External trigger conversion mode for injected channels
        reserved7: u1 = 0,
        EXTSEL: u3, // bit offset: 17 desc: External event select for regular group
        EXTTRIG: u1, // bit offset: 20 desc: External trigger conversion mode for regular channels
        JSWSTART: u1, // bit offset: 21 desc: Start conversion of injected channels
        SWSTART: u1, // bit offset: 22 desc: Start conversion of regular channels
        TSVREFE: u1, // bit offset: 23 desc: Temperature sensor and VREFINT enable
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 sample time register 1
    pub const SMPR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SMP10: u3, // bit offset: 0 desc: Channel 10 sample time selection
        SMP11: u3, // bit offset: 3 desc: Channel 11 sample time selection
        SMP12: u3, // bit offset: 6 desc: Channel 12 sample time selection
        SMP13: u3, // bit offset: 9 desc: Channel 13 sample time selection
        SMP14: u3, // bit offset: 12 desc: Channel 14 sample time selection
        SMP15: u3, // bit offset: 15 desc: Channel 15 sample time selection
        SMP16: u3, // bit offset: 18 desc: Channel 16 sample time selection
        SMP17: u3, // bit offset: 21 desc: Channel 17 sample time selection
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000010, 32, packed struct {
        SMP0: u3, // bit offset: 0 desc: Channel 0 sample time selection
        SMP1: u3, // bit offset: 3 desc: Channel 1 sample time selection
        SMP2: u3, // bit offset: 6 desc: Channel 2 sample time selection
        SMP3: u3, // bit offset: 9 desc: Channel 3 sample time selection
        SMP4: u3, // bit offset: 12 desc: Channel 4 sample time selection
        SMP5: u3, // bit offset: 15 desc: Channel 5 sample time selection
        SMP6: u3, // bit offset: 18 desc: Channel 6 sample time selection
        SMP7: u3, // bit offset: 21 desc: Channel 7 sample time selection
        SMP8: u3, // bit offset: 24 desc: Channel 8 sample time selection
        SMP9: u3, // bit offset: 27 desc: Channel 9 sample time selection
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 injected channel data offset register x
    pub const JOFR1 = mmio(Address + 0x00000014, 32, packed struct {
        JOFFSET1: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 injected channel data offset register x
    pub const JOFR2 = mmio(Address + 0x00000018, 32, packed struct {
        JOFFSET2: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 injected channel data offset register x
    pub const JOFR3 = mmio(Address + 0x0000001c, 32, packed struct {
        JOFFSET3: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 injected channel data offset register x
    pub const JOFR4 = mmio(Address + 0x00000020, 32, packed struct {
        JOFFSET4: u12, // bit offset: 0 desc: Data offset for injected channel x
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 watchdog higher threshold register
    pub const HTR = mmio(Address + 0x00000024, 32, packed struct {
        HT: u12, // bit offset: 0 desc: Analog watchdog higher threshold
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 watchdog lower threshold register
    pub const LTR = mmio(Address + 0x00000028, 32, packed struct {
        LT: u12, // bit offset: 0 desc: Analog watchdog lower threshold
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 regular sequence register 1
    pub const SQR1 = mmio(Address + 0x0000002c, 32, packed struct {
        SQ13: u5, // bit offset: 0 desc: 13th conversion in regular sequence
        SQ14: u5, // bit offset: 5 desc: 14th conversion in regular sequence
        SQ15: u5, // bit offset: 10 desc: 15th conversion in regular sequence
        SQ16: u5, // bit offset: 15 desc: 16th conversion in regular sequence
        L: u4, // bit offset: 20 desc: Regular channel sequence length
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000030, 32, packed struct {
        SQ7: u5, // bit offset: 0 desc: 7th conversion in regular sequence
        SQ8: u5, // bit offset: 5 desc: 8th conversion in regular sequence
        SQ9: u5, // bit offset: 10 desc: 9th conversion in regular sequence
        SQ10: u5, // bit offset: 15 desc: 10th conversion in regular sequence
        SQ11: u5, // bit offset: 20 desc: 11th conversion in regular sequence
        SQ12: u5, // bit offset: 25 desc: 12th conversion in regular sequence
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000034, 32, packed struct {
        SQ1: u5, // bit offset: 0 desc: 1st conversion in regular sequence
        SQ2: u5, // bit offset: 5 desc: 2nd conversion in regular sequence
        SQ3: u5, // bit offset: 10 desc: 3rd conversion in regular sequence
        SQ4: u5, // bit offset: 15 desc: 4th conversion in regular sequence
        SQ5: u5, // bit offset: 20 desc: 5th conversion in regular sequence
        SQ6: u5, // bit offset: 25 desc: 6th conversion in regular sequence
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 injected sequence register
    pub const JSQR = mmio(Address + 0x00000038, 32, packed struct {
        JSQ1: u5, // bit offset: 0 desc: 1st conversion in injected sequence
        JSQ2: u5, // bit offset: 5 desc: 2nd conversion in injected sequence
        JSQ3: u5, // bit offset: 10 desc: 3rd conversion in injected sequence
        JSQ4: u5, // bit offset: 15 desc: 4th conversion in injected sequence
        JL: u2, // bit offset: 20 desc: Injected sequence length
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 injected data register x
    pub const JDR1 = mmio(Address + 0x0000003c, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 injected data register x
    pub const JDR2 = mmio(Address + 0x00000040, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 injected data register x
    pub const JDR3 = mmio(Address + 0x00000044, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 injected data register x
    pub const JDR4 = mmio(Address + 0x00000048, 32, packed struct {
        JDATA: u16, // bit offset: 0 desc: Injected data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 regular data register
    pub const DR = mmio(Address + 0x0000004c, 32, packed struct {
        DATA: u16, // bit offset: 0 desc: Regular data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const CAN = extern struct {
    pub const Address: u32 = 0x40006400;
    // byte offset: 0 CAN_MCR
    pub const CAN_MCR = mmio(Address + 0x00000000, 32, packed struct {
        INRQ: u1, // bit offset: 0 desc: INRQ
        SLEEP: u1, // bit offset: 1 desc: SLEEP
        TXFP: u1, // bit offset: 2 desc: TXFP
        RFLM: u1, // bit offset: 3 desc: RFLM
        NART: u1, // bit offset: 4 desc: NART
        AWUM: u1, // bit offset: 5 desc: AWUM
        ABOM: u1, // bit offset: 6 desc: ABOM
        TTCM: u1, // bit offset: 7 desc: TTCM
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        RESET: u1, // bit offset: 15 desc: RESET
        DBF: u1, // bit offset: 16 desc: DBF
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 CAN_MSR
    pub const CAN_MSR = mmio(Address + 0x00000004, 32, packed struct {
        INAK: u1, // bit offset: 0 desc: INAK
        SLAK: u1, // bit offset: 1 desc: SLAK
        ERRI: u1, // bit offset: 2 desc: ERRI
        WKUI: u1, // bit offset: 3 desc: WKUI
        SLAKI: u1, // bit offset: 4 desc: SLAKI
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TXM: u1, // bit offset: 8 desc: TXM
        RXM: u1, // bit offset: 9 desc: RXM
        SAMP: u1, // bit offset: 10 desc: SAMP
        RX: u1, // bit offset: 11 desc: RX
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 CAN_TSR
    pub const CAN_TSR = mmio(Address + 0x00000008, 32, packed struct {
        RQCP0: u1, // bit offset: 0 desc: RQCP0
        TXOK0: u1, // bit offset: 1 desc: TXOK0
        ALST0: u1, // bit offset: 2 desc: ALST0
        TERR0: u1, // bit offset: 3 desc: TERR0
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ABRQ0: u1, // bit offset: 7 desc: ABRQ0
        RQCP1: u1, // bit offset: 8 desc: RQCP1
        TXOK1: u1, // bit offset: 9 desc: TXOK1
        ALST1: u1, // bit offset: 10 desc: ALST1
        TERR1: u1, // bit offset: 11 desc: TERR1
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        ABRQ1: u1, // bit offset: 15 desc: ABRQ1
        RQCP2: u1, // bit offset: 16 desc: RQCP2
        TXOK2: u1, // bit offset: 17 desc: TXOK2
        ALST2: u1, // bit offset: 18 desc: ALST2
        TERR2: u1, // bit offset: 19 desc: TERR2
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        ABRQ2: u1, // bit offset: 23 desc: ABRQ2
        CODE: u2, // bit offset: 24 desc: CODE
        TME0: u1, // bit offset: 26 desc: Lowest priority flag for mailbox 0
        TME1: u1, // bit offset: 27 desc: Lowest priority flag for mailbox 1
        TME2: u1, // bit offset: 28 desc: Lowest priority flag for mailbox 2
        LOW0: u1, // bit offset: 29 desc: Lowest priority flag for mailbox 0
        LOW1: u1, // bit offset: 30 desc: Lowest priority flag for mailbox 1
        LOW2: u1, // bit offset: 31 desc: Lowest priority flag for mailbox 2
    });
    // byte offset: 12 CAN_RF0R
    pub const CAN_RF0R = mmio(Address + 0x0000000c, 32, packed struct {
        FMP0: u2, // bit offset: 0 desc: FMP0
        reserved1: u1 = 0,
        FULL0: u1, // bit offset: 3 desc: FULL0
        FOVR0: u1, // bit offset: 4 desc: FOVR0
        RFOM0: u1, // bit offset: 5 desc: RFOM0
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CAN_RF1R
    pub const CAN_RF1R = mmio(Address + 0x00000010, 32, packed struct {
        FMP1: u2, // bit offset: 0 desc: FMP1
        reserved1: u1 = 0,
        FULL1: u1, // bit offset: 3 desc: FULL1
        FOVR1: u1, // bit offset: 4 desc: FOVR1
        RFOM1: u1, // bit offset: 5 desc: RFOM1
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 CAN_IER
    pub const CAN_IER = mmio(Address + 0x00000014, 32, packed struct {
        TMEIE: u1, // bit offset: 0 desc: TMEIE
        FMPIE0: u1, // bit offset: 1 desc: FMPIE0
        FFIE0: u1, // bit offset: 2 desc: FFIE0
        FOVIE0: u1, // bit offset: 3 desc: FOVIE0
        FMPIE1: u1, // bit offset: 4 desc: FMPIE1
        FFIE1: u1, // bit offset: 5 desc: FFIE1
        FOVIE1: u1, // bit offset: 6 desc: FOVIE1
        reserved1: u1 = 0,
        EWGIE: u1, // bit offset: 8 desc: EWGIE
        EPVIE: u1, // bit offset: 9 desc: EPVIE
        BOFIE: u1, // bit offset: 10 desc: BOFIE
        LECIE: u1, // bit offset: 11 desc: LECIE
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        ERRIE: u1, // bit offset: 15 desc: ERRIE
        WKUIE: u1, // bit offset: 16 desc: WKUIE
        SLKIE: u1, // bit offset: 17 desc: SLKIE
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 CAN_ESR
    pub const CAN_ESR = mmio(Address + 0x00000018, 32, packed struct {
        EWGF: u1, // bit offset: 0 desc: EWGF
        EPVF: u1, // bit offset: 1 desc: EPVF
        BOFF: u1, // bit offset: 2 desc: BOFF
        reserved1: u1 = 0,
        LEC: u3, // bit offset: 4 desc: LEC
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TEC: u8, // bit offset: 16 desc: TEC
        REC: u8, // bit offset: 24 desc: REC
    });
    // byte offset: 28 CAN_BTR
    pub const CAN_BTR = mmio(Address + 0x0000001c, 32, packed struct {
        BRP: u10, // bit offset: 0 desc: BRP
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TS1: u4, // bit offset: 16 desc: TS1
        TS2: u3, // bit offset: 20 desc: TS2
        reserved7: u1 = 0,
        SJW: u2, // bit offset: 24 desc: SJW
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        LBKM: u1, // bit offset: 30 desc: LBKM
        SILM: u1, // bit offset: 31 desc: SILM
    });
    // byte offset: 384 CAN_TI0R
    pub const CAN_TI0R = mmio(Address + 0x00000180, 32, packed struct {
        TXRQ: u1, // bit offset: 0 desc: TXRQ
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 388 CAN_TDT0R
    pub const CAN_TDT0R = mmio(Address + 0x00000184, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TGT: u1, // bit offset: 8 desc: TGT
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 392 CAN_TDL0R
    pub const CAN_TDL0R = mmio(Address + 0x00000188, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 396 CAN_TDH0R
    pub const CAN_TDH0R = mmio(Address + 0x0000018c, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 400 CAN_TI1R
    pub const CAN_TI1R = mmio(Address + 0x00000190, 32, packed struct {
        TXRQ: u1, // bit offset: 0 desc: TXRQ
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 404 CAN_TDT1R
    pub const CAN_TDT1R = mmio(Address + 0x00000194, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TGT: u1, // bit offset: 8 desc: TGT
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 408 CAN_TDL1R
    pub const CAN_TDL1R = mmio(Address + 0x00000198, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 412 CAN_TDH1R
    pub const CAN_TDH1R = mmio(Address + 0x0000019c, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 416 CAN_TI2R
    pub const CAN_TI2R = mmio(Address + 0x000001a0, 32, packed struct {
        TXRQ: u1, // bit offset: 0 desc: TXRQ
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 420 CAN_TDT2R
    pub const CAN_TDT2R = mmio(Address + 0x000001a4, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TGT: u1, // bit offset: 8 desc: TGT
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 424 CAN_TDL2R
    pub const CAN_TDL2R = mmio(Address + 0x000001a8, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 428 CAN_TDH2R
    pub const CAN_TDH2R = mmio(Address + 0x000001ac, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 432 CAN_RI0R
    pub const CAN_RI0R = mmio(Address + 0x000001b0, 32, packed struct {
        reserved1: u1 = 0,
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 436 CAN_RDT0R
    pub const CAN_RDT0R = mmio(Address + 0x000001b4, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        FMI: u8, // bit offset: 8 desc: FMI
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 440 CAN_RDL0R
    pub const CAN_RDL0R = mmio(Address + 0x000001b8, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 444 CAN_RDH0R
    pub const CAN_RDH0R = mmio(Address + 0x000001bc, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 448 CAN_RI1R
    pub const CAN_RI1R = mmio(Address + 0x000001c0, 32, packed struct {
        reserved1: u1 = 0,
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 452 CAN_RDT1R
    pub const CAN_RDT1R = mmio(Address + 0x000001c4, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        FMI: u8, // bit offset: 8 desc: FMI
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 456 CAN_RDL1R
    pub const CAN_RDL1R = mmio(Address + 0x000001c8, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 460 CAN_RDH1R
    pub const CAN_RDH1R = mmio(Address + 0x000001cc, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 512 CAN_FMR
    pub const CAN_FMR = mmio(Address + 0x00000200, 32, packed struct {
        FINIT: u1, // bit offset: 0 desc: FINIT
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 516 CAN_FM1R
    pub const CAN_FM1R = mmio(Address + 0x00000204, 32, packed struct {
        FBM0: u1, // bit offset: 0 desc: Filter mode
        FBM1: u1, // bit offset: 1 desc: Filter mode
        FBM2: u1, // bit offset: 2 desc: Filter mode
        FBM3: u1, // bit offset: 3 desc: Filter mode
        FBM4: u1, // bit offset: 4 desc: Filter mode
        FBM5: u1, // bit offset: 5 desc: Filter mode
        FBM6: u1, // bit offset: 6 desc: Filter mode
        FBM7: u1, // bit offset: 7 desc: Filter mode
        FBM8: u1, // bit offset: 8 desc: Filter mode
        FBM9: u1, // bit offset: 9 desc: Filter mode
        FBM10: u1, // bit offset: 10 desc: Filter mode
        FBM11: u1, // bit offset: 11 desc: Filter mode
        FBM12: u1, // bit offset: 12 desc: Filter mode
        FBM13: u1, // bit offset: 13 desc: Filter mode
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 524 CAN_FS1R
    pub const CAN_FS1R = mmio(Address + 0x0000020c, 32, packed struct {
        FSC0: u1, // bit offset: 0 desc: Filter scale configuration
        FSC1: u1, // bit offset: 1 desc: Filter scale configuration
        FSC2: u1, // bit offset: 2 desc: Filter scale configuration
        FSC3: u1, // bit offset: 3 desc: Filter scale configuration
        FSC4: u1, // bit offset: 4 desc: Filter scale configuration
        FSC5: u1, // bit offset: 5 desc: Filter scale configuration
        FSC6: u1, // bit offset: 6 desc: Filter scale configuration
        FSC7: u1, // bit offset: 7 desc: Filter scale configuration
        FSC8: u1, // bit offset: 8 desc: Filter scale configuration
        FSC9: u1, // bit offset: 9 desc: Filter scale configuration
        FSC10: u1, // bit offset: 10 desc: Filter scale configuration
        FSC11: u1, // bit offset: 11 desc: Filter scale configuration
        FSC12: u1, // bit offset: 12 desc: Filter scale configuration
        FSC13: u1, // bit offset: 13 desc: Filter scale configuration
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 532 CAN_FFA1R
    pub const CAN_FFA1R = mmio(Address + 0x00000214, 32, packed struct {
        FFA0: u1, // bit offset: 0 desc: Filter FIFO assignment for filter 0
        FFA1: u1, // bit offset: 1 desc: Filter FIFO assignment for filter 1
        FFA2: u1, // bit offset: 2 desc: Filter FIFO assignment for filter 2
        FFA3: u1, // bit offset: 3 desc: Filter FIFO assignment for filter 3
        FFA4: u1, // bit offset: 4 desc: Filter FIFO assignment for filter 4
        FFA5: u1, // bit offset: 5 desc: Filter FIFO assignment for filter 5
        FFA6: u1, // bit offset: 6 desc: Filter FIFO assignment for filter 6
        FFA7: u1, // bit offset: 7 desc: Filter FIFO assignment for filter 7
        FFA8: u1, // bit offset: 8 desc: Filter FIFO assignment for filter 8
        FFA9: u1, // bit offset: 9 desc: Filter FIFO assignment for filter 9
        FFA10: u1, // bit offset: 10 desc: Filter FIFO assignment for filter 10
        FFA11: u1, // bit offset: 11 desc: Filter FIFO assignment for filter 11
        FFA12: u1, // bit offset: 12 desc: Filter FIFO assignment for filter 12
        FFA13: u1, // bit offset: 13 desc: Filter FIFO assignment for filter 13
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 540 CAN_FA1R
    pub const CAN_FA1R = mmio(Address + 0x0000021c, 32, packed struct {
        FACT0: u1, // bit offset: 0 desc: Filter active
        FACT1: u1, // bit offset: 1 desc: Filter active
        FACT2: u1, // bit offset: 2 desc: Filter active
        FACT3: u1, // bit offset: 3 desc: Filter active
        FACT4: u1, // bit offset: 4 desc: Filter active
        FACT5: u1, // bit offset: 5 desc: Filter active
        FACT6: u1, // bit offset: 6 desc: Filter active
        FACT7: u1, // bit offset: 7 desc: Filter active
        FACT8: u1, // bit offset: 8 desc: Filter active
        FACT9: u1, // bit offset: 9 desc: Filter active
        FACT10: u1, // bit offset: 10 desc: Filter active
        FACT11: u1, // bit offset: 11 desc: Filter active
        FACT12: u1, // bit offset: 12 desc: Filter active
        FACT13: u1, // bit offset: 13 desc: Filter active
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 576 Filter bank 0 register 1
    pub const F0R1 = mmio(Address + 0x00000240, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 580 Filter bank 0 register 2
    pub const F0R2 = mmio(Address + 0x00000244, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 584 Filter bank 1 register 1
    pub const F1R1 = mmio(Address + 0x00000248, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 588 Filter bank 1 register 2
    pub const F1R2 = mmio(Address + 0x0000024c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 592 Filter bank 2 register 1
    pub const F2R1 = mmio(Address + 0x00000250, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 596 Filter bank 2 register 2
    pub const F2R2 = mmio(Address + 0x00000254, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 600 Filter bank 3 register 1
    pub const F3R1 = mmio(Address + 0x00000258, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 604 Filter bank 3 register 2
    pub const F3R2 = mmio(Address + 0x0000025c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 608 Filter bank 4 register 1
    pub const F4R1 = mmio(Address + 0x00000260, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 612 Filter bank 4 register 2
    pub const F4R2 = mmio(Address + 0x00000264, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 616 Filter bank 5 register 1
    pub const F5R1 = mmio(Address + 0x00000268, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 620 Filter bank 5 register 2
    pub const F5R2 = mmio(Address + 0x0000026c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 624 Filter bank 6 register 1
    pub const F6R1 = mmio(Address + 0x00000270, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 628 Filter bank 6 register 2
    pub const F6R2 = mmio(Address + 0x00000274, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 632 Filter bank 7 register 1
    pub const F7R1 = mmio(Address + 0x00000278, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 636 Filter bank 7 register 2
    pub const F7R2 = mmio(Address + 0x0000027c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 640 Filter bank 8 register 1
    pub const F8R1 = mmio(Address + 0x00000280, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 644 Filter bank 8 register 2
    pub const F8R2 = mmio(Address + 0x00000284, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 648 Filter bank 9 register 1
    pub const F9R1 = mmio(Address + 0x00000288, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 652 Filter bank 9 register 2
    pub const F9R2 = mmio(Address + 0x0000028c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 656 Filter bank 10 register 1
    pub const F10R1 = mmio(Address + 0x00000290, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 660 Filter bank 10 register 2
    pub const F10R2 = mmio(Address + 0x00000294, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 664 Filter bank 11 register 1
    pub const F11R1 = mmio(Address + 0x00000298, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 668 Filter bank 11 register 2
    pub const F11R2 = mmio(Address + 0x0000029c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 672 Filter bank 4 register 1
    pub const F12R1 = mmio(Address + 0x000002a0, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 676 Filter bank 12 register 2
    pub const F12R2 = mmio(Address + 0x000002a4, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 680 Filter bank 13 register 1
    pub const F13R1 = mmio(Address + 0x000002a8, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 684 Filter bank 13 register 2
    pub const F13R2 = mmio(Address + 0x000002ac, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
};
pub const DAC = extern struct {
    pub const Address: u32 = 0x40007400;
    // byte offset: 0 Control register (DAC_CR)
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        EN1: u1, // bit offset: 0 desc: DAC channel1 enable
        BOFF1: u1, // bit offset: 1 desc: DAC channel1 output buffer disable
        TEN1: u1, // bit offset: 2 desc: DAC channel1 trigger enable
        TSEL1: u3, // bit offset: 3 desc: DAC channel1 trigger selection
        WAVE1: u2, // bit offset: 6 desc: DAC channel1 noise/triangle wave generation enable
        MAMP1: u4, // bit offset: 8 desc: DAC channel1 mask/amplitude selector
        DMAEN1: u1, // bit offset: 12 desc: DAC channel1 DMA enable
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        EN2: u1, // bit offset: 16 desc: DAC channel2 enable
        BOFF2: u1, // bit offset: 17 desc: DAC channel2 output buffer disable
        TEN2: u1, // bit offset: 18 desc: DAC channel2 trigger enable
        TSEL2: u3, // bit offset: 19 desc: DAC channel2 trigger selection
        WAVE2: u2, // bit offset: 22 desc: DAC channel2 noise/triangle wave generation enable
        MAMP2: u4, // bit offset: 24 desc: DAC channel2 mask/amplitude selector
        DMAEN2: u1, // bit offset: 28 desc: DAC channel2 DMA enable
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 DAC software trigger register (DAC_SWTRIGR)
    pub const SWTRIGR = mmio(Address + 0x00000004, 32, packed struct {
        SWTRIG1: u1, // bit offset: 0 desc: DAC channel1 software trigger
        SWTRIG2: u1, // bit offset: 1 desc: DAC channel2 software trigger
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 DAC channel1 12-bit right-aligned data holding register(DAC_DHR12R1)
    pub const DHR12R1 = mmio(Address + 0x00000008, 32, packed struct {
        DACC1DHR: u12, // bit offset: 0 desc: DAC channel1 12-bit right-aligned data
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DAC channel1 12-bit left aligned data holding register (DAC_DHR12L1)
    pub const DHR12L1 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC1DHR: u12, // bit offset: 4 desc: DAC channel1 12-bit left-aligned data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 DAC channel1 8-bit right aligned data holding register (DAC_DHR8R1)
    pub const DHR8R1 = mmio(Address + 0x00000010, 32, packed struct {
        DACC1DHR: u8, // bit offset: 0 desc: DAC channel1 8-bit right-aligned data
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 DAC channel2 12-bit right aligned data holding register (DAC_DHR12R2)
    pub const DHR12R2 = mmio(Address + 0x00000014, 32, packed struct {
        DACC2DHR: u12, // bit offset: 0 desc: DAC channel2 12-bit right-aligned data
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 DAC channel2 12-bit left aligned data holding register (DAC_DHR12L2)
    pub const DHR12L2 = mmio(Address + 0x00000018, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC2DHR: u12, // bit offset: 4 desc: DAC channel2 12-bit left-aligned data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 DAC channel2 8-bit right-aligned data holding register (DAC_DHR8R2)
    pub const DHR8R2 = mmio(Address + 0x0000001c, 32, packed struct {
        DACC2DHR: u8, // bit offset: 0 desc: DAC channel2 8-bit right-aligned data
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Dual DAC 12-bit right-aligned data holding register (DAC_DHR12RD), Bits 31:28 Reserved, Bits 15:12 Reserved
    pub const DHR12RD = mmio(Address + 0x00000020, 32, packed struct {
        DACC1DHR: u12, // bit offset: 0 desc: DAC channel1 12-bit right-aligned data
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC2DHR: u12, // bit offset: 16 desc: DAC channel2 12-bit right-aligned data
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 DUAL DAC 12-bit left aligned data holding register (DAC_DHR12LD), Bits 19:16 Reserved, Bits 3:0 Reserved
    pub const DHR12LD = mmio(Address + 0x00000024, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC1DHR: u12, // bit offset: 4 desc: DAC channel1 12-bit left-aligned data
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        DACC2DHR: u12, // bit offset: 20 desc: DAC channel2 12-bit right-aligned data
    });
    // byte offset: 40 DUAL DAC 8-bit right aligned data holding register (DAC_DHR8RD), Bits 31:16 Reserved
    pub const DHR8RD = mmio(Address + 0x00000028, 32, packed struct {
        DACC1DHR: u8, // bit offset: 0 desc: DAC channel1 8-bit right-aligned data
        DACC2DHR: u8, // bit offset: 8 desc: DAC channel2 8-bit right-aligned data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 DAC channel1 data output register (DAC_DOR1)
    pub const DOR1 = mmio(Address + 0x0000002c, 32, packed struct {
        DACC1DOR: u12, // bit offset: 0 desc: DAC channel1 data output
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 DAC channel2 data output register (DAC_DOR2)
    pub const DOR2 = mmio(Address + 0x00000030, 32, packed struct {
        DACC2DOR: u12, // bit offset: 0 desc: DAC channel2 data output
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const DBG = extern struct {
    pub const Address: u32 = 0xe0042000;
    // byte offset: 0 DBGMCU_IDCODE
    pub const IDCODE = mmio(Address + 0x00000000, 32, packed struct {
        DEV_ID: u12, // bit offset: 0 desc: DEV_ID
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        REV_ID: u16, // bit offset: 16 desc: REV_ID
    });
    // byte offset: 4 DBGMCU_CR
    pub const CR = mmio(Address + 0x00000004, 32, packed struct {
        DBG_SLEEP: u1, // bit offset: 0 desc: DBG_SLEEP
        DBG_STOP: u1, // bit offset: 1 desc: DBG_STOP
        DBG_STANDBY: u1, // bit offset: 2 desc: DBG_STANDBY
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TRACE_IOEN: u1, // bit offset: 5 desc: TRACE_IOEN
        TRACE_MODE: u2, // bit offset: 6 desc: TRACE_MODE
        DBG_IWDG_STOP: u1, // bit offset: 8 desc: DBG_IWDG_STOP
        DBG_WWDG_STOP: u1, // bit offset: 9 desc: DBG_WWDG_STOP
        DBG_TIM1_STOP: u1, // bit offset: 10 desc: DBG_TIM1_STOP
        DBG_TIM2_STOP: u1, // bit offset: 11 desc: DBG_TIM2_STOP
        DBG_TIM3_STOP: u1, // bit offset: 12 desc: DBG_TIM3_STOP
        DBG_TIM4_STOP: u1, // bit offset: 13 desc: DBG_TIM4_STOP
        DBG_CAN1_STOP: u1, // bit offset: 14 desc: DBG_CAN1_STOP
        DBG_I2C1_SMBUS_TIMEOUT: u1, // bit offset: 15 desc: DBG_I2C1_SMBUS_TIMEOUT
        DBG_I2C2_SMBUS_TIMEOUT: u1, // bit offset: 16 desc: DBG_I2C2_SMBUS_TIMEOUT
        DBG_TIM8_STOP: u1, // bit offset: 17 desc: DBG_TIM8_STOP
        DBG_TIM5_STOP: u1, // bit offset: 18 desc: DBG_TIM5_STOP
        DBG_TIM6_STOP: u1, // bit offset: 19 desc: DBG_TIM6_STOP
        DBG_TIM7_STOP: u1, // bit offset: 20 desc: DBG_TIM7_STOP
        DBG_CAN2_STOP: u1, // bit offset: 21 desc: DBG_CAN2_STOP
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const UART4 = extern struct {
    pub const Address: u32 = 0x40004c00;
    // byte offset: 0 UART4_SR
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NE: u1, // bit offset: 2 desc: Noise error flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: IDLE line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBD: u1, // bit offset: 8 desc: LIN break detection flag
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 UART4_DR
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        DR: u9, // bit offset: 0 desc: DR
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 UART4_BRR
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: DIV_Fraction
        DIV_Mantissa: u12, // bit offset: 4 desc: DIV_Mantissa
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 UART4_CR1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SBK: u1, // bit offset: 0 desc: Send break
        RWU: u1, // bit offset: 1 desc: Receiver wakeup
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: TXE interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Wakeup method
        M: u1, // bit offset: 12 desc: Word length
        UE: u1, // bit offset: 13 desc: USART enable
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 UART4_CR2
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        ADD: u4, // bit offset: 0 desc: Address of the USART node
        reserved1: u1 = 0,
        LBDL: u1, // bit offset: 5 desc: lin break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 UART4_CR3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const UART5 = extern struct {
    pub const Address: u32 = 0x40005000;
    // byte offset: 0 UART4_SR
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: PE
        FE: u1, // bit offset: 1 desc: FE
        NE: u1, // bit offset: 2 desc: NE
        ORE: u1, // bit offset: 3 desc: ORE
        IDLE: u1, // bit offset: 4 desc: IDLE
        RXNE: u1, // bit offset: 5 desc: RXNE
        TC: u1, // bit offset: 6 desc: TC
        TXE: u1, // bit offset: 7 desc: TXE
        LBD: u1, // bit offset: 8 desc: LBD
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 UART4_DR
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        DR: u9, // bit offset: 0 desc: DR
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 UART4_BRR
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: DIV_Fraction
        DIV_Mantissa: u12, // bit offset: 4 desc: DIV_Mantissa
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 UART4_CR1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        SBK: u1, // bit offset: 0 desc: SBK
        RWU: u1, // bit offset: 1 desc: RWU
        RE: u1, // bit offset: 2 desc: RE
        TE: u1, // bit offset: 3 desc: TE
        IDLEIE: u1, // bit offset: 4 desc: IDLEIE
        RXNEIE: u1, // bit offset: 5 desc: RXNEIE
        TCIE: u1, // bit offset: 6 desc: TCIE
        TXEIE: u1, // bit offset: 7 desc: TXEIE
        PEIE: u1, // bit offset: 8 desc: PEIE
        PS: u1, // bit offset: 9 desc: PS
        PCE: u1, // bit offset: 10 desc: PCE
        WAKE: u1, // bit offset: 11 desc: WAKE
        M: u1, // bit offset: 12 desc: M
        UE: u1, // bit offset: 13 desc: UE
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 UART4_CR2
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        ADD: u4, // bit offset: 0 desc: ADD
        reserved1: u1 = 0,
        LBDL: u1, // bit offset: 5 desc: LBDL
        LBDIE: u1, // bit offset: 6 desc: LBDIE
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        STOP: u2, // bit offset: 12 desc: STOP
        LINEN: u1, // bit offset: 14 desc: LINEN
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 UART4_CR3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const CRC = extern struct {
    pub const Address: u32 = 0x40023000;
    // byte offset: 0 Data register
    pub const DR = mmio(Address + 0x00000000, 32, packed struct {
        DR: u32, // bit offset: 0 desc: Data Register
    });
    // byte offset: 4 Independent Data register
    pub const IDR = mmio(Address + 0x00000004, 32, packed struct {
        IDR: u8, // bit offset: 0 desc: Independent Data register
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        RESET: u1, // bit offset: 0 desc: Reset bit
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const FLASH = extern struct {
    pub const Address: u32 = 0x40022000;
    // byte offset: 0 Flash access control register
    pub const ACR = mmio(Address + 0x00000000, 32, packed struct {
        LATENCY: u3, // bit offset: 0 desc: Latency
        HLFCYA: u1, // bit offset: 3 desc: Flash half cycle access enable
        PRFTBE: u1, // bit offset: 4 desc: Prefetch buffer enable
        PRFTBS: u1, // bit offset: 5 desc: Prefetch buffer status
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Flash key register
    pub const KEYR = mmio(Address + 0x00000004, 32, packed struct {
        KEY: u32, // bit offset: 0 desc: FPEC key
    });
    // byte offset: 8 Flash option key register
    pub const OPTKEYR = mmio(Address + 0x00000008, 32, packed struct {
        OPTKEY: u32, // bit offset: 0 desc: Option byte key
    });
    // byte offset: 12 Status register
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        BSY: u1, // bit offset: 0 desc: Busy
        reserved1: u1 = 0,
        PGERR: u1, // bit offset: 2 desc: Programming error
        reserved2: u1 = 0,
        WRPRTERR: u1, // bit offset: 4 desc: Write protection error
        EOP: u1, // bit offset: 5 desc: End of operation
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Control register
    pub const CR = mmio(Address + 0x00000010, 32, packed struct {
        PG: u1, // bit offset: 0 desc: Programming
        PER: u1, // bit offset: 1 desc: Page Erase
        MER: u1, // bit offset: 2 desc: Mass Erase
        reserved1: u1 = 0,
        OPTPG: u1, // bit offset: 4 desc: Option byte programming
        OPTER: u1, // bit offset: 5 desc: Option byte erase
        STRT: u1, // bit offset: 6 desc: Start
        LOCK: u1, // bit offset: 7 desc: Lock
        reserved2: u1 = 0,
        OPTWRE: u1, // bit offset: 9 desc: Option bytes write enable
        ERRIE: u1, // bit offset: 10 desc: Error interrupt enable
        reserved3: u1 = 0,
        EOPIE: u1, // bit offset: 12 desc: End of operation interrupt enable
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Flash address register
    pub const AR = mmio(Address + 0x00000014, 32, packed struct {
        FAR: u32, // bit offset: 0 desc: Flash Address
    });
    // byte offset: 28 Option byte register
    pub const OBR = mmio(Address + 0x0000001c, 32, packed struct {
        OPTERR: u1, // bit offset: 0 desc: Option byte error
        RDPRT: u1, // bit offset: 1 desc: Read protection
        WDG_SW: u1, // bit offset: 2 desc: WDG_SW
        nRST_STOP: u1, // bit offset: 3 desc: nRST_STOP
        nRST_STDBY: u1, // bit offset: 4 desc: nRST_STDBY
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        Data0: u8, // bit offset: 10 desc: Data0
        Data1: u8, // bit offset: 18 desc: Data1
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Write protection register
    pub const WRPR = mmio(Address + 0x00000020, 32, packed struct {
        WRP: u32, // bit offset: 0 desc: Write protect
    });
};
pub const NVIC = extern struct {
    pub const Address: u32 = 0xe000e000;
    // byte offset: 4 Interrupt Controller Type Register
    pub const ICTR = mmio(Address + 0x00000004, 32, packed struct {
        INTLINESNUM: u4, // bit offset: 0 desc: Total number of interrupt lines in groups
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 256 Interrupt Set-Enable Register
    pub const ISER0 = mmio(Address + 0x00000100, 32, packed struct {
        SETENA: u32, // bit offset: 0 desc: SETENA
    });
    // byte offset: 260 Interrupt Set-Enable Register
    pub const ISER1 = mmio(Address + 0x00000104, 32, packed struct {
        SETENA: u32, // bit offset: 0 desc: SETENA
    });
    // byte offset: 384 Interrupt Clear-Enable Register
    pub const ICER0 = mmio(Address + 0x00000180, 32, packed struct {
        CLRENA: u32, // bit offset: 0 desc: CLRENA
    });
    // byte offset: 388 Interrupt Clear-Enable Register
    pub const ICER1 = mmio(Address + 0x00000184, 32, packed struct {
        CLRENA: u32, // bit offset: 0 desc: CLRENA
    });
    // byte offset: 512 Interrupt Set-Pending Register
    pub const ISPR0 = mmio(Address + 0x00000200, 32, packed struct {
        SETPEND: u32, // bit offset: 0 desc: SETPEND
    });
    // byte offset: 516 Interrupt Set-Pending Register
    pub const ISPR1 = mmio(Address + 0x00000204, 32, packed struct {
        SETPEND: u32, // bit offset: 0 desc: SETPEND
    });
    // byte offset: 640 Interrupt Clear-Pending Register
    pub const ICPR0 = mmio(Address + 0x00000280, 32, packed struct {
        CLRPEND: u32, // bit offset: 0 desc: CLRPEND
    });
    // byte offset: 644 Interrupt Clear-Pending Register
    pub const ICPR1 = mmio(Address + 0x00000284, 32, packed struct {
        CLRPEND: u32, // bit offset: 0 desc: CLRPEND
    });
    // byte offset: 768 Interrupt Active Bit Register
    pub const IABR0 = mmio(Address + 0x00000300, 32, packed struct {
        ACTIVE: u32, // bit offset: 0 desc: ACTIVE
    });
    // byte offset: 772 Interrupt Active Bit Register
    pub const IABR1 = mmio(Address + 0x00000304, 32, packed struct {
        ACTIVE: u32, // bit offset: 0 desc: ACTIVE
    });
    // byte offset: 1024 Interrupt Priority Register
    pub const IPR0 = mmio(Address + 0x00000400, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1028 Interrupt Priority Register
    pub const IPR1 = mmio(Address + 0x00000404, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1032 Interrupt Priority Register
    pub const IPR2 = mmio(Address + 0x00000408, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1036 Interrupt Priority Register
    pub const IPR3 = mmio(Address + 0x0000040c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1040 Interrupt Priority Register
    pub const IPR4 = mmio(Address + 0x00000410, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1044 Interrupt Priority Register
    pub const IPR5 = mmio(Address + 0x00000414, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1048 Interrupt Priority Register
    pub const IPR6 = mmio(Address + 0x00000418, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1052 Interrupt Priority Register
    pub const IPR7 = mmio(Address + 0x0000041c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1056 Interrupt Priority Register
    pub const IPR8 = mmio(Address + 0x00000420, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1060 Interrupt Priority Register
    pub const IPR9 = mmio(Address + 0x00000424, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1064 Interrupt Priority Register
    pub const IPR10 = mmio(Address + 0x00000428, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1068 Interrupt Priority Register
    pub const IPR11 = mmio(Address + 0x0000042c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1072 Interrupt Priority Register
    pub const IPR12 = mmio(Address + 0x00000430, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1076 Interrupt Priority Register
    pub const IPR13 = mmio(Address + 0x00000434, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 1080 Interrupt Priority Register
    pub const IPR14 = mmio(Address + 0x00000438, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 3840 Software Triggered Interrupt Register
    pub const STIR = mmio(Address + 0x00000f00, 32, packed struct {
        INTID: u9, // bit offset: 0 desc: interrupt to be triggered
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const USB = extern struct {
    pub const Address: u32 = 0x40005c00;
    // byte offset: 0 endpoint 0 register
    pub const EP0R = mmio(Address + 0x00000000, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 endpoint 1 register
    pub const EP1R = mmio(Address + 0x00000004, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 endpoint 2 register
    pub const EP2R = mmio(Address + 0x00000008, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 endpoint 3 register
    pub const EP3R = mmio(Address + 0x0000000c, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 endpoint 4 register
    pub const EP4R = mmio(Address + 0x00000010, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 endpoint 5 register
    pub const EP5R = mmio(Address + 0x00000014, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 endpoint 6 register
    pub const EP6R = mmio(Address + 0x00000018, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 endpoint 7 register
    pub const EP7R = mmio(Address + 0x0000001c, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 control register
    pub const CNTR = mmio(Address + 0x00000040, 32, packed struct {
        FRES: u1, // bit offset: 0 desc: Force USB Reset
        PDWN: u1, // bit offset: 1 desc: Power down
        LPMODE: u1, // bit offset: 2 desc: Low-power mode
        FSUSP: u1, // bit offset: 3 desc: Force suspend
        RESUME: u1, // bit offset: 4 desc: Resume request
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ESOFM: u1, // bit offset: 8 desc: Expected start of frame interrupt mask
        SOFM: u1, // bit offset: 9 desc: Start of frame interrupt mask
        RESETM: u1, // bit offset: 10 desc: USB reset interrupt mask
        SUSPM: u1, // bit offset: 11 desc: Suspend mode interrupt mask
        WKUPM: u1, // bit offset: 12 desc: Wakeup interrupt mask
        ERRM: u1, // bit offset: 13 desc: Error interrupt mask
        PMAOVRM: u1, // bit offset: 14 desc: Packet memory area over / underrun interrupt mask
        CTRM: u1, // bit offset: 15 desc: Correct transfer interrupt mask
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 interrupt status register
    pub const ISTR = mmio(Address + 0x00000044, 32, packed struct {
        EP_ID: u4, // bit offset: 0 desc: Endpoint Identifier
        DIR: u1, // bit offset: 4 desc: Direction of transaction
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ESOF: u1, // bit offset: 8 desc: Expected start frame
        SOF: u1, // bit offset: 9 desc: start of frame
        RESET: u1, // bit offset: 10 desc: reset request
        SUSP: u1, // bit offset: 11 desc: Suspend mode request
        WKUP: u1, // bit offset: 12 desc: Wakeup
        ERR: u1, // bit offset: 13 desc: Error
        PMAOVR: u1, // bit offset: 14 desc: Packet memory area over / underrun
        CTR: u1, // bit offset: 15 desc: Correct transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 frame number register
    pub const FNR = mmio(Address + 0x00000048, 32, packed struct {
        FN: u11, // bit offset: 0 desc: Frame number
        LSOF: u2, // bit offset: 11 desc: Lost SOF
        LCK: u1, // bit offset: 13 desc: Locked
        RXDM: u1, // bit offset: 14 desc: Receive data - line status
        RXDP: u1, // bit offset: 15 desc: Receive data + line status
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 device address
    pub const DADDR = mmio(Address + 0x0000004c, 32, packed struct {
        ADD: u7, // bit offset: 0 desc: Device address
        EF: u1, // bit offset: 7 desc: Enable function
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 80 Buffer table address
    pub const BTABLE = mmio(Address + 0x00000050, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        BTABLE: u13, // bit offset: 3 desc: Buffer table
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

const std = @import("std");
const root = @import("root");
const cpu = @import("cpu");
const config = @import("microzig-config");
const InterruptVector = extern union {
    C: fn () callconv(.C) void,
    Naked: fn () callconv(.Naked) void,
    // Interrupt is not supported on arm
};

fn makeUnhandledHandler(comptime str: []const u8) InterruptVector {
    return InterruptVector{
        .C = struct {
            fn unhandledInterrupt() callconv(.C) noreturn {
                @panic("unhandled interrupt: " ++ str);
            }
        }.unhandledInterrupt,
    };
}

pub const VectorTable = extern struct {
    initial_stack_pointer: u32 = config.end_of_stack,
    Reset: InterruptVector = InterruptVector{ .C = cpu.startup_logic._start },
    NMI: InterruptVector = makeUnhandledHandler("NMI"),
    HardFault: InterruptVector = makeUnhandledHandler("HardFault"),
    MemManage: InterruptVector = makeUnhandledHandler("MemManage"),
    BusFault: InterruptVector = makeUnhandledHandler("BusFault"),
    UsageFault: InterruptVector = makeUnhandledHandler("UsageFault"),

    reserved: [4]u32 = .{ 0, 0, 0, 0 },
    SVCall: InterruptVector = makeUnhandledHandler("SVCall"),
    DebugMonitor: InterruptVector = makeUnhandledHandler("DebugMonitor"),
    reserved1: u32 = 0,

    PendSV: InterruptVector = makeUnhandledHandler("PendSV"),
    SysTick: InterruptVector = makeUnhandledHandler("SysTick"),

    /// Window Watchdog interrupt
    WWDG: InterruptVector = makeUnhandledHandler("WWDG"),

    /// PVD through EXTI line detection interrupt
    PVD: InterruptVector = makeUnhandledHandler("PVD"),

    /// Tamper interrupt
    TAMPER: InterruptVector = makeUnhandledHandler("TAMPER"),

    /// RTC global interrupt
    RTC: InterruptVector = makeUnhandledHandler("RTC"),

    /// Flash global interrupt
    FLASH: InterruptVector = makeUnhandledHandler("FLASH"),

    /// RCC global interrupt
    RCC: InterruptVector = makeUnhandledHandler("RCC"),

    /// EXTI Line0 interrupt
    EXTI0: InterruptVector = makeUnhandledHandler("EXTI0"),

    /// EXTI Line1 interrupt
    EXTI1: InterruptVector = makeUnhandledHandler("EXTI1"),

    /// EXTI Line2 interrupt
    EXTI2: InterruptVector = makeUnhandledHandler("EXTI2"),

    /// EXTI Line3 interrupt
    EXTI3: InterruptVector = makeUnhandledHandler("EXTI3"),

    /// EXTI Line4 interrupt
    EXTI4: InterruptVector = makeUnhandledHandler("EXTI4"),

    /// DMA1 Channel1 global interrupt
    DMA1_Channel1: InterruptVector = makeUnhandledHandler("DMA1_Channel1"),

    /// DMA1 Channel2 global interrupt
    DMA1_Channel2: InterruptVector = makeUnhandledHandler("DMA1_Channel2"),

    /// DMA1 Channel3 global interrupt
    DMA1_Channel3: InterruptVector = makeUnhandledHandler("DMA1_Channel3"),

    /// DMA1 Channel4 global interrupt
    DMA1_Channel4: InterruptVector = makeUnhandledHandler("DMA1_Channel4"),

    /// DMA1 Channel5 global interrupt
    DMA1_Channel5: InterruptVector = makeUnhandledHandler("DMA1_Channel5"),

    /// DMA1 Channel6 global interrupt
    DMA1_Channel6: InterruptVector = makeUnhandledHandler("DMA1_Channel6"),

    /// DMA1 Channel7 global interrupt
    DMA1_Channel7: InterruptVector = makeUnhandledHandler("DMA1_Channel7"),

    /// ADC1 global interrupt; ADC2 global interrupt
    ADC: InterruptVector = makeUnhandledHandler("ADC"),

    /// CAN1 TX interrupts
    CAN1_TX: InterruptVector = makeUnhandledHandler("CAN1_TX"),

    /// CAN1 RX0 interrupts
    CAN1_RX0: InterruptVector = makeUnhandledHandler("CAN1_RX0"),

    /// CAN1 RX1 interrupt
    CAN1_RX1: InterruptVector = makeUnhandledHandler("CAN1_RX1"),

    /// CAN1 SCE interrupt
    CAN1_SCE: InterruptVector = makeUnhandledHandler("CAN1_SCE"),

    /// EXTI Line[9:5] interrupts
    EXTI9_5: InterruptVector = makeUnhandledHandler("EXTI9_5"),

    /// TIM1 Break interrupt and TIM9 global interrupt
    TIM1_BRK_TIM9: InterruptVector = makeUnhandledHandler("TIM1_BRK_TIM9"),

    /// TIM1 Update interrupt and TIM10 global interrupt
    TIM1_UP_TIM10: InterruptVector = makeUnhandledHandler("TIM1_UP_TIM10"),

    /// TIM1 Trigger and Commutation interrupts and TIM11 global interrupt
    TIM1_TRG_COM_TIM11: InterruptVector = makeUnhandledHandler("TIM1_TRG_COM_TIM11"),

    /// TIM1 Capture Compare interrupt
    TIM1_CC: InterruptVector = makeUnhandledHandler("TIM1_CC"),

    /// TIM2 global interrupt
    TIM2: InterruptVector = makeUnhandledHandler("TIM2"),

    /// TIM3 global interrupt
    TIM3: InterruptVector = makeUnhandledHandler("TIM3"),

    /// TIM4 global interrupt
    TIM4: InterruptVector = makeUnhandledHandler("TIM4"),

    /// I2C1 event interrupt
    I2C1_EV: InterruptVector = makeUnhandledHandler("I2C1_EV"),

    /// I2C1 error interrupt
    I2C1_ER: InterruptVector = makeUnhandledHandler("I2C1_ER"),

    /// I2C2 event interrupt
    I2C2_EV: InterruptVector = makeUnhandledHandler("I2C2_EV"),

    /// I2C2 error interrupt
    I2C2_ER: InterruptVector = makeUnhandledHandler("I2C2_ER"),

    /// SPI1 global interrupt
    SPI1: InterruptVector = makeUnhandledHandler("SPI1"),

    /// SPI2 global interrupt
    SPI2: InterruptVector = makeUnhandledHandler("SPI2"),

    /// USART1 global interrupt
    USART1: InterruptVector = makeUnhandledHandler("USART1"),

    /// USART2 global interrupt
    USART2: InterruptVector = makeUnhandledHandler("USART2"),

    /// USART3 global interrupt
    USART3: InterruptVector = makeUnhandledHandler("USART3"),

    /// EXTI Line[15:10] interrupts
    EXTI15_10: InterruptVector = makeUnhandledHandler("EXTI15_10"),

    /// RTC Alarms through EXTI line interrupt
    RTCAlarm: InterruptVector = makeUnhandledHandler("RTCAlarm"),

    /// USB Device FS Wakeup through EXTI line interrupt
    USB_FS_WKUP: InterruptVector = makeUnhandledHandler("USB_FS_WKUP"),

    /// TIM8 Break interrupt and TIM12 global interrupt
    TIM8_BRK_TIM12: InterruptVector = makeUnhandledHandler("TIM8_BRK_TIM12"),

    /// TIM8 Update interrupt and TIM13 global interrupt
    TIM8_UP_TIM13: InterruptVector = makeUnhandledHandler("TIM8_UP_TIM13"),

    /// TIM8 Trigger and Commutation interrupts and TIM14 global interrupt
    TIM8_TRG_COM_TIM14: InterruptVector = makeUnhandledHandler("TIM8_TRG_COM_TIM14"),

    /// TIM8 Capture Compare interrupt
    TIM8_CC: InterruptVector = makeUnhandledHandler("TIM8_CC"),

    /// ADC3 global interrupt
    ADC3: InterruptVector = makeUnhandledHandler("ADC3"),

    /// FSMC global interrupt
    FSMC: InterruptVector = makeUnhandledHandler("FSMC"),

    /// SDIO global interrupt
    SDIO: InterruptVector = makeUnhandledHandler("SDIO"),

    /// TIM5 global interrupt
    TIM5: InterruptVector = makeUnhandledHandler("TIM5"),

    /// SPI3 global interrupt
    SPI3: InterruptVector = makeUnhandledHandler("SPI3"),

    /// UART4 global interrupt
    UART4: InterruptVector = makeUnhandledHandler("UART4"),

    /// UART5 global interrupt
    UART5: InterruptVector = makeUnhandledHandler("UART5"),

    /// TIM6 global interrupt
    TIM6: InterruptVector = makeUnhandledHandler("TIM6"),

    /// TIM7 global interrupt
    TIM7: InterruptVector = makeUnhandledHandler("TIM7"),

    /// DMA2 Channel1 global interrupt
    DMA2_Channel1: InterruptVector = makeUnhandledHandler("DMA2_Channel1"),

    /// DMA2 Channel2 global interrupt
    DMA2_Channel2: InterruptVector = makeUnhandledHandler("DMA2_Channel2"),

    /// DMA2 Channel3 global interrupt
    DMA2_Channel3: InterruptVector = makeUnhandledHandler("DMA2_Channel3"),

    /// DMA2 Channel4 and DMA2 Channel5 global interrupt
    DMA2_Channel4_5: InterruptVector = makeUnhandledHandler("DMA2_Channel4_5"),
};

fn isValidField(field_name: []const u8) bool {
    return !std.mem.startsWith(u8, field_name, "reserved") and
        !std.mem.eql(u8, field_name, "initial_stack_pointer") and
        !std.mem.eql(u8, field_name, "reset");
}

export const vectors: VectorTable linksection("microzig_flash_start") = blk: {
    var temp: VectorTable = .{};
    if (@hasDecl(root, "vector_table")) {
        const vector_table = root.vector_table;
        if (@typeInfo(vector_table) != .Struct)
            @compileLog("root.vector_table must be a struct");

        inline for (@typeInfo(vector_table).Struct.decls) |decl| {
            const calling_convention = @typeInfo(@TypeOf(@field(vector_table, decl.name))).Fn.calling_convention;
            const handler = @field(vector_table, decl.name);

            if (!@hasField(VectorTable, decl.name)) {
                var msg: []const u8 = "There is no such interrupt as '" ++ decl.name ++ "', declarations in 'root.vector_table' must be one of:\n";
                inline for (std.meta.fields(VectorTable)) |field| {
                    if (isValidField(field.name)) {
                        msg = msg ++ "    " ++ field.name ++ "\n";
                    }
                }

                @compileError(msg);
            }

            if (!isValidField(decl.name))
                @compileError("You are not allowed to specify '" ++ decl.name ++ "' in the vector table, for your sins you must now pay a $5 fine to the ZSF: https://github.com/sponsors/ziglang");

            @field(temp, decl.name) = switch (calling_convention) {
                .C => .{ .C = handler },
                .Naked => .{ .Naked = handler },
                // for unspecified calling convention we are going to generate small wrapper
                .Unspecified => .{
                    .C = struct {
                        fn wrapper() callconv(.C) void {
                            if (calling_convention == .Unspecified) // TODO: workaround for some weird stage1 bug
                                @call(.{ .modifier = .always_inline }, handler, .{});
                        }
                    }.wrapper,
                },

                else => @compileError("unsupported calling convention for function " ++ decl.name),
            };
        }
    }
    break :blk temp;
};

