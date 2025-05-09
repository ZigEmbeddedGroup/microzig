const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Cluster BANK%s, containing KEYR?, CR?, SR?, CCR?, PRAR_CUR?, PRAR_PRG?, SCAR_CUR?, SCAR_PRG?, WPSN_CUR?R, WPSN_PRG?R, CRCCR?, CRCSADD?R, CRCEADD?R, ECC_FA?R
pub const BANK = extern struct {
    /// FLASH key register for bank 1
    /// offset: 0x00
    KEYR: u32,
    /// offset: 0x04
    reserved4: [4]u8,
    /// FLASH control register for bank 1
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 configuration lock bit
        LOCK: u1,
        /// Bank 1 program enable bit
        PG: u1,
        /// Bank 1 sector erase request
        SER: u1,
        /// Bank 1 erase request
        BER: u1,
        /// Bank 1 write forcing control bit
        FW: u1,
        /// Bank 1 bank or sector erase start control bit
        START: u1,
        /// Bank 1 sector erase selection number
        SSN: u7,
        reserved15: u2 = 0,
        /// Bank 1 CRC control bit
        CRC_EN: u1,
        /// Bank 1 end-of-program interrupt control bit
        EOPIE: u1,
        /// Bank 1 write protection error interrupt enable bit
        WRPERRIE: u1,
        /// Bank 1 programming sequence error interrupt enable bit
        PGSERRIE: u1,
        /// Bank 1 strobe error interrupt enable bit
        STRBERRIE: u1,
        reserved21: u1 = 0,
        /// Bank 1 inconsistency error interrupt enable bit
        INCERRIE: u1,
        /// Bank 1 write/erase error interrupt enable bit
        OPERRIE: u1,
        /// Bank 1 read protection error interrupt enable bit
        RDPERRIE: u1,
        /// Bank 1 secure error interrupt enable bit
        RDSERRIE: u1,
        /// Bank 1 ECC single correction error interrupt enable bit
        SNECCERRIE: u1,
        /// Bank 1 ECC double detection error interrupt enable bit
        DBECCERRIE: u1,
        /// Bank 1 end of CRC calculation interrupt enable bit
        CRCENDIE: u1,
        /// Bank 1 CRC read error interrupt enable bit
        CRCRDERRIE: u1,
        padding: u3 = 0,
    }),
    /// FLASH status register for bank 1
    /// offset: 0x0c
    SR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 ongoing program flag
        BSY: u1,
        /// Bank 1 write buffer not empty flag
        WBNE: u1,
        /// Bank 1 wait queue flag
        QW: u1,
        /// Bank 1 CRC busy flag
        CRC_BUSY: u1,
        reserved16: u12 = 0,
        /// Bank 1 end-of-program flag
        EOP: u1,
        /// Bank 1 write protection error flag
        WRPERR: u1,
        /// Bank 1 programming sequence error flag
        PGSERR: u1,
        /// Bank 1 strobe error flag
        STRBERR: u1,
        reserved21: u1 = 0,
        /// Bank 1 inconsistency error flag
        INCERR: u1,
        /// Bank 1 write/erase error flag
        OPERR: u1,
        /// Bank 1 read protection error flag
        RDPERR: u1,
        /// Bank 1 secure error flag
        RDSERR: u1,
        /// Bank 1 single correction error flag
        SNECCERR1: u1,
        /// Bank 1 ECC double detection error flag
        DBECCERR: u1,
        /// Bank 1 CRC-complete flag
        CRCEND: u1,
        /// Bank 1 CRC read error flag
        CRCRDERR: u1,
        padding: u3 = 0,
    }),
    /// FLASH clear control register for bank 1
    /// offset: 0x10
    CCR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Bank 1 EOP1 flag clear bit
        CLR_EOP: u1,
        /// Bank 1 WRPERR1 flag clear bit
        CLR_WRPERR: u1,
        /// Bank 1 PGSERR1 flag clear bi
        CLR_PGSERR: u1,
        /// Bank 1 STRBERR1 flag clear bit
        CLR_STRBERR: u1,
        reserved21: u1 = 0,
        /// Bank 1 INCERR1 flag clear bit
        CLR_INCERR: u1,
        /// Bank 1 OPERR1 flag clear bit
        CLR_OPERR: u1,
        /// Bank 1 RDPERR1 flag clear bit
        CLR_RDPERR: u1,
        /// Bank 1 RDSERR1 flag clear bit
        CLR_RDSERR: u1,
        /// Bank 1 SNECCERR1 flag clear bit
        CLR_SNECCERR: u1,
        /// Bank 1 DBECCERR1 flag clear bit
        CLR_DBECCERR: u1,
        /// Bank 1 CRCEND1 flag clear bit
        CLR_CRCEND: u1,
        /// Bank 1 CRC read error clear bit
        CLR_CRCRDERR: u1,
        padding: u3 = 0,
    }),
    /// offset: 0x14
    reserved20: [16]u8,
    /// FLASH protection address for bank 1
    /// offset: 0x24
    PRAR_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 lowest PCROP protected address
        PROT_AREA_START: u12,
        reserved16: u4 = 0,
        /// Bank 1 highest PCROP protected address
        PROT_AREA_END: u12,
        reserved31: u3 = 0,
        /// Bank 1 PCROP protected erase enable option status bit
        DMEP: u1,
    }),
    /// FLASH protection address for bank 1
    /// offset: 0x28
    PRAR_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank 1 lowest PCROP protected address configuration
        PROT_AREA_START: u12,
        reserved16: u4 = 0,
        /// Bank 1 highest PCROP protected address configuration
        PROT_AREA_END: u12,
        reserved31: u3 = 0,
        /// Bank 1 PCROP protected erase enable option configuration bit
        DMEP: u1,
    }),
    /// FLASH secure address for bank 1
    /// offset: 0x2c
    SCAR_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 lowest secure protected address
        SEC_AREA_START: u12,
        reserved16: u4 = 0,
        /// Bank 1 highest secure protected address
        SEC_AREA_END: u12,
        reserved31: u3 = 0,
        /// Bank 1 secure protected erase enable option status bit
        DMES: u1,
    }),
    /// FLASH secure address for bank 1
    /// offset: 0x30
    SCAR_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank 1 lowest secure protected address configuration
        SEC_AREA_START: u12,
        reserved16: u4 = 0,
        /// Bank 1 highest secure protected address configuration
        SEC_AREA_END: u12,
        reserved31: u3 = 0,
        /// Bank 1 secure protected erase enable option configuration bit
        DMES: u1,
    }),
    /// FLASH write sector protection for bank 1
    /// offset: 0x34
    WPSN_CURR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 sector write protection option status byte
        WRPSn: u8,
        padding: u24 = 0,
    }),
    /// FLASH write sector protection for bank 1
    /// offset: 0x38
    WPSN_PRGR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 sector write protection configuration byte
        WRPSn: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x3c
    reserved60: [16]u8,
    /// FLASH CRC control register for bank 1
    /// offset: 0x4c
    CRCCR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 CRC sector number
        CRC_SECT: u3,
        reserved7: u4 = 0,
        /// Bank 1 CRC select bit
        ALL_BANK: u1,
        /// Bank 1 CRC sector mode select bit
        CRC_BY_SECT: u1,
        /// Bank 1 CRC sector select bit
        ADD_SECT: u1,
        /// Bank 1 CRC sector list clear bit
        CLEAN_SECT: u1,
        reserved16: u5 = 0,
        /// Bank 1 CRC start bit
        START_CRC: u1,
        /// Bank 1 CRC clear bit
        CLEAN_CRC: u1,
        reserved20: u2 = 0,
        /// Bank 1 CRC burst size
        CRC_BURST: u2,
        padding: u10 = 0,
    }),
    /// FLASH CRC start address register for bank 1
    /// offset: 0x50
    CRCSADDR: mmio.Mmio(packed struct(u32) {
        /// CRC start address on bank 1
        CRC_START_ADDR: u32,
    }),
    /// FLASH CRC end address register for bank 1
    /// offset: 0x54
    CRCEADDR: mmio.Mmio(packed struct(u32) {
        /// CRC end address on bank 1
        CRC_END_ADDR: u32,
    }),
    /// offset: 0x58
    reserved88: [4]u8,
    /// FLASH ECC fail address for bank 1
    /// offset: 0x5c
    FAR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 ECC error address
        FAIL_ECC_ADDR: u15,
        padding: u17 = 0,
    }),
};

/// Flash
pub const FLASH = extern struct {
    /// Access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Read latency
        LATENCY: u3,
        reserved4: u1 = 0,
        /// Flash signal delay
        WRHIGHFREQ: u2,
        padding: u26 = 0,
    }),
    /// Cluster BANK%s, containing KEYR?, CR?, SR?, CCR?, PRAR_CUR?, PRAR_PRG?, SCAR_CUR?, SCAR_PRG?, WPSN_CUR?R, WPSN_PRG?R, CRCCR?, CRCSADD?R, CRCEADD?R, ECC_FA?R
    /// offset: 0x04
    BANK: u32,
    /// FLASH option key register
    /// offset: 0x08
    OPTKEYR: u32,
    /// offset: 0x0c
    reserved12: [12]u8,
    /// FLASH option control register
    /// offset: 0x18
    OPTCR: mmio.Mmio(packed struct(u32) {
        /// FLASH_OPTCR lock option configuration bit
        OPTLOCK: u1,
        /// Option byte start change option configuration bit
        OPTSTART: u1,
        reserved4: u2 = 0,
        /// Flash mass erase enable bit
        MER: u1,
        /// OTP program control bit
        PG_OTP: u1,
        reserved30: u24 = 0,
        /// Option byte change error interrupt enable bit
        OPTCHANGEERRIE: u1,
        /// Bank swapping configuration bit
        SWAP_BANK: u1,
    }),
    /// FLASH option status register
    /// offset: 0x1c
    OPTSR_CUR: mmio.Mmio(packed struct(u32) {
        /// Option byte change ongoing flag
        OPT_BUSY: u1,
        reserved2: u1 = 0,
        /// Brownout level option status bit
        BOR_LEV: u2,
        /// IWDG1 control option status bit
        IWDG1_HW: u1,
        reserved6: u1 = 0,
        /// D1 DStop entry reset option status bit
        nRST_STOP_D1: u1,
        /// D1 DStandby entry reset option status bit
        nRST_STBY_D1: u1,
        /// Readout protection level option status byte
        RDP: u8,
        reserved17: u1 = 0,
        /// IWDG Stop mode freeze option status bit
        FZ_IWDG_STOP: u1,
        /// IWDG Standby mode freeze option status bit
        FZ_IWDG_SDBY: u1,
        /// DTCM RAM size option status
        ST_RAM_SIZE: u2,
        /// Security enable option status bit
        SECURITY: u1,
        reserved26: u4 = 0,
        /// User option bit 1
        RSS1: u1,
        reserved28: u1 = 0,
        /// Device personalization status bit
        PERSO_OK: u1,
        /// I/O high-speed at low-voltage status bit (PRODUCT_BELOW_25V)
        IO_HSLV: u1,
        /// Option byte change error flag
        OPTCHANGEERR: u1,
        /// Bank swapping option status bit
        SWAP_BANK_OPT: u1,
    }),
    /// FLASH option status register
    /// offset: 0x20
    OPTSR_PRG: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// BOR reset level option configuration bits
        BOR_LEV: u2,
        /// IWDG1 option configuration bit
        IWDG1_HW: u1,
        reserved6: u1 = 0,
        /// Option byte erase after D1 DStop option configuration bit
        nRST_STOP_D1: u1,
        /// Option byte erase after D1 DStandby option configuration bit
        nRST_STBY_D1: u1,
        /// Readout protection level option configuration byte
        RDP: u8,
        reserved17: u1 = 0,
        /// IWDG Stop mode freeze option configuration bit
        FZ_IWDG_STOP: u1,
        /// IWDG Standby mode freeze option configuration bit
        FZ_IWDG_SDBY: u1,
        /// DTCM size select option configuration bits
        ST_RAM_SIZE: u2,
        /// Security option configuration bit
        SECURITY: u1,
        reserved26: u4 = 0,
        /// User option configuration bit 1
        RSS1: u1,
        /// User option configuration bit 2
        RSS2: u1,
        reserved29: u1 = 0,
        /// I/O high-speed at low-voltage (PRODUCT_BELOW_25V)
        IO_HSLV: u1,
        reserved31: u1 = 0,
        /// Bank swapping option configuration bit
        SWAP_BANK_OPT: u1,
    }),
    /// FLASH option clear control register
    /// offset: 0x24
    OPTCCR: mmio.Mmio(packed struct(u32) {
        reserved30: u30 = 0,
        /// OPTCHANGEERR reset bit
        CLR_OPTCHANGEERR: u1,
        padding: u1 = 0,
    }),
    /// offset: 0x28
    reserved40: [24]u8,
    /// FLASH register with boot address
    /// offset: 0x40
    BOOT_CURR: mmio.Mmio(packed struct(u32) {
        /// Boot address 0
        BOOT_ADD0: u16,
        /// Boot address 1
        BOOT_ADD1: u16,
    }),
    /// FLASH register with boot address
    /// offset: 0x44
    BOOT_PRGR: mmio.Mmio(packed struct(u32) {
        /// Boot address 0
        BOOT_ADD0: u16,
        /// Boot address 1
        BOOT_ADD1: u16,
    }),
    /// offset: 0x48
    reserved72: [20]u8,
    /// FLASH CRC data register
    /// offset: 0x5c
    CRCDATAR: mmio.Mmio(packed struct(u32) {
        /// CRC result
        CRC_DATA: u32,
    }),
};
