// generated using svd2zig.py
// DO NOT EDIT
// based on nrf52 version 1
const microzig_mmio = @import("microzig-mmio");
const mmio = microzig_mmio.mmio;
const MMIO = microzig_mmio.MMIO;
const Name = "nrf52";

/// Factory Information Configuration Registers
pub const FICR = extern struct {
    pub const Address: u32 = 0x10000000;

    /// Code memory page size
    pub const CODEPAGESIZE = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Code memory size
    pub const CODESIZE = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Device address type
    pub const DEVICEADDRTYPE = mmio(Address + 0x000000a0, 32, packed struct {
        /// Device address type
        DEVICEADDRTYPE: u1 = 0,
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
    /// Description collection[0]: Device identifier
    pub const DEVICEID = @intToPtr(*volatile [2]u32, Address + 0x00000060);
    /// Description collection[0]: Encryption Root, word 0
    pub const ER = @intToPtr(*volatile [4]u32, Address + 0x00000080);
    /// Description collection[0]: Identity Root, word 0
    pub const IR = @intToPtr(*volatile [4]u32, Address + 0x00000090);
    /// Description collection[0]: Device address 0
    pub const DEVICEADDR = @intToPtr(*volatile [2]u32, Address + 0x000000a4);

    pub const INFO = struct {

        /// Part code
        pub const PART = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Part Variant, Hardware version and Production configuration
        pub const VARIANT = @intToPtr(*volatile u32, Address + 0x00000004);

        /// Package option
        pub const PACKAGE = @intToPtr(*volatile u32, Address + 0x00000008);

        /// RAM variant
        pub const RAM = @intToPtr(*volatile u32, Address + 0x0000000c);

        /// Flash variant
        pub const FLASH = @intToPtr(*volatile u32, Address + 0x00000010);
        /// Description collection[0]: Unspecified
        pub const UNUSED0 = @intToPtr(*volatile [3]u32, Address + 0x00000014);
    };

    pub const TEMP = struct {

        /// Slope definition A0.
        pub const A0 = mmio(Address + 0x00000000, 32, packed struct {
            /// A (slope definition) register.
            A: u12 = 0,
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

        /// Slope definition A1.
        pub const A1 = mmio(Address + 0x00000004, 32, packed struct {
            /// A (slope definition) register.
            A: u12 = 0,
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

        /// Slope definition A2.
        pub const A2 = mmio(Address + 0x00000008, 32, packed struct {
            /// A (slope definition) register.
            A: u12 = 0,
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

        /// Slope definition A3.
        pub const A3 = mmio(Address + 0x0000000c, 32, packed struct {
            /// A (slope definition) register.
            A: u12 = 0,
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

        /// Slope definition A4.
        pub const A4 = mmio(Address + 0x00000010, 32, packed struct {
            /// A (slope definition) register.
            A: u12 = 0,
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

        /// Slope definition A5.
        pub const A5 = mmio(Address + 0x00000014, 32, packed struct {
            /// A (slope definition) register.
            A: u12 = 0,
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

        /// y-intercept B0.
        pub const B0 = mmio(Address + 0x00000018, 32, packed struct {
            /// B (y-intercept)
            B: u14 = 0,
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

        /// y-intercept B1.
        pub const B1 = mmio(Address + 0x0000001c, 32, packed struct {
            /// B (y-intercept)
            B: u14 = 0,
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

        /// y-intercept B2.
        pub const B2 = mmio(Address + 0x00000020, 32, packed struct {
            /// B (y-intercept)
            B: u14 = 0,
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

        /// y-intercept B3.
        pub const B3 = mmio(Address + 0x00000024, 32, packed struct {
            /// B (y-intercept)
            B: u14 = 0,
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

        /// y-intercept B4.
        pub const B4 = mmio(Address + 0x00000028, 32, packed struct {
            /// B (y-intercept)
            B: u14 = 0,
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

        /// y-intercept B5.
        pub const B5 = mmio(Address + 0x0000002c, 32, packed struct {
            /// B (y-intercept)
            B: u14 = 0,
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

        /// Segment end T0.
        pub const T0 = mmio(Address + 0x00000030, 32, packed struct {
            /// T (segment end)register.
            T: u8 = 0,
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

        /// Segment end T1.
        pub const T1 = mmio(Address + 0x00000034, 32, packed struct {
            /// T (segment end)register.
            T: u8 = 0,
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

        /// Segment end T2.
        pub const T2 = mmio(Address + 0x00000038, 32, packed struct {
            /// T (segment end)register.
            T: u8 = 0,
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

        /// Segment end T3.
        pub const T3 = mmio(Address + 0x0000003c, 32, packed struct {
            /// T (segment end)register.
            T: u8 = 0,
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

        /// Segment end T4.
        pub const T4 = mmio(Address + 0x00000040, 32, packed struct {
            /// T (segment end)register.
            T: u8 = 0,
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

    pub const NFC = struct {

        /// Default header for NFC Tag. Software can read these values to populate
        /// NFCID1_3RD_LAST, NFCID1_2ND_LAST and NFCID1_LAST.
        pub const TAGHEADER0 = mmio(Address + 0x00000000, 32, packed struct {
            /// Default Manufacturer ID: Nordic Semiconductor ASA has ICM 0x5F
            MFGID: u8 = 0,
            /// Unique identifier byte 1
            UD1: u8 = 0,
            /// Unique identifier byte 2
            UD2: u8 = 0,
            /// Unique identifier byte 3
            UD3: u8 = 0,
        });

        /// Default header for NFC Tag. Software can read these values to populate
        /// NFCID1_3RD_LAST, NFCID1_2ND_LAST and NFCID1_LAST.
        pub const TAGHEADER1 = mmio(Address + 0x00000004, 32, packed struct {
            /// Unique identifier byte 4
            UD4: u8 = 0,
            /// Unique identifier byte 5
            UD5: u8 = 0,
            /// Unique identifier byte 6
            UD6: u8 = 0,
            /// Unique identifier byte 7
            UD7: u8 = 0,
        });

        /// Default header for NFC Tag. Software can read these values to populate
        /// NFCID1_3RD_LAST, NFCID1_2ND_LAST and NFCID1_LAST.
        pub const TAGHEADER2 = mmio(Address + 0x00000008, 32, packed struct {
            /// Unique identifier byte 8
            UD8: u8 = 0,
            /// Unique identifier byte 9
            UD9: u8 = 0,
            /// Unique identifier byte 10
            UD10: u8 = 0,
            /// Unique identifier byte 11
            UD11: u8 = 0,
        });

        /// Default header for NFC Tag. Software can read these values to populate
        /// NFCID1_3RD_LAST, NFCID1_2ND_LAST and NFCID1_LAST.
        pub const TAGHEADER3 = mmio(Address + 0x0000000c, 32, packed struct {
            /// Unique identifier byte 12
            UD12: u8 = 0,
            /// Unique identifier byte 13
            UD13: u8 = 0,
            /// Unique identifier byte 14
            UD14: u8 = 0,
            /// Unique identifier byte 15
            UD15: u8 = 0,
        });
    };
};

/// User Information Configuration Registers
pub const UICR = extern struct {
    pub const Address: u32 = 0x10001000;

    /// Unspecified
    pub const UNUSED0 = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Unspecified
    pub const UNUSED1 = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Unspecified
    pub const UNUSED2 = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Unspecified
    pub const UNUSED3 = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Access Port protection
    pub const APPROTECT = mmio(Address + 0x00000208, 32, packed struct {
        /// Enable or disable Access Port protection. Any other value than 0xFF being
        /// written to this field will enable protection.
        PALL: u8 = 0,
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

    /// Setting of pins dedicated to NFC functionality: NFC antenna or GPIO
    pub const NFCPINS = mmio(Address + 0x0000020c, 32, packed struct {
        /// Setting of pins dedicated to NFC functionality
        PROTECT: u1 = 0,
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
    /// Description collection[0]: Reserved for Nordic firmware design
    pub const NRFFW = @intToPtr(*volatile [15]u32, Address + 0x00000014);
    /// Description collection[0]: Reserved for Nordic hardware design
    pub const NRFHW = @intToPtr(*volatile [12]u32, Address + 0x00000050);
    /// Description collection[0]: Reserved for customer
    pub const CUSTOMER = @intToPtr(*volatile [32]u32, Address + 0x00000080);
    /// Description collection[0]: Mapping of the nRESET function (see POWER chapter
    /// for details)
    pub const PSELRESET = @intToPtr(*volatile [2]MMIO(32, packed struct {
        /// GPIO number P0.n onto which Reset is exposed
        PIN: u6 = 0,
        reserved25: u1 = 0,
        reserved24: u1 = 0,
        reserved23: u1 = 0,
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
        /// Connection
        CONNECT: u1 = 0,
    }), Address + 0x00000200);
};

/// Block Protect
pub const BPROT = extern struct {
    pub const Address: u32 = 0x40000000;

    /// Block protect configuration register 0
    pub const CONFIG0 = mmio(Address + 0x00000600, 32, packed struct {
        /// Enable protection for region 0. Write '0' has no effect.
        REGION0: u1 = 0,
        /// Enable protection for region 1. Write '0' has no effect.
        REGION1: u1 = 0,
        /// Enable protection for region 2. Write '0' has no effect.
        REGION2: u1 = 0,
        /// Enable protection for region 3. Write '0' has no effect.
        REGION3: u1 = 0,
        /// Enable protection for region 4. Write '0' has no effect.
        REGION4: u1 = 0,
        /// Enable protection for region 5. Write '0' has no effect.
        REGION5: u1 = 0,
        /// Enable protection for region 6. Write '0' has no effect.
        REGION6: u1 = 0,
        /// Enable protection for region 7. Write '0' has no effect.
        REGION7: u1 = 0,
        /// Enable protection for region 8. Write '0' has no effect.
        REGION8: u1 = 0,
        /// Enable protection for region 9. Write '0' has no effect.
        REGION9: u1 = 0,
        /// Enable protection for region 10. Write '0' has no effect.
        REGION10: u1 = 0,
        /// Enable protection for region 11. Write '0' has no effect.
        REGION11: u1 = 0,
        /// Enable protection for region 12. Write '0' has no effect.
        REGION12: u1 = 0,
        /// Enable protection for region 13. Write '0' has no effect.
        REGION13: u1 = 0,
        /// Enable protection for region 14. Write '0' has no effect.
        REGION14: u1 = 0,
        /// Enable protection for region 15. Write '0' has no effect.
        REGION15: u1 = 0,
        /// Enable protection for region 16. Write '0' has no effect.
        REGION16: u1 = 0,
        /// Enable protection for region 17. Write '0' has no effect.
        REGION17: u1 = 0,
        /// Enable protection for region 18. Write '0' has no effect.
        REGION18: u1 = 0,
        /// Enable protection for region 19. Write '0' has no effect.
        REGION19: u1 = 0,
        /// Enable protection for region 20. Write '0' has no effect.
        REGION20: u1 = 0,
        /// Enable protection for region 21. Write '0' has no effect.
        REGION21: u1 = 0,
        /// Enable protection for region 22. Write '0' has no effect.
        REGION22: u1 = 0,
        /// Enable protection for region 23. Write '0' has no effect.
        REGION23: u1 = 0,
        /// Enable protection for region 24. Write '0' has no effect.
        REGION24: u1 = 0,
        /// Enable protection for region 25. Write '0' has no effect.
        REGION25: u1 = 0,
        /// Enable protection for region 26. Write '0' has no effect.
        REGION26: u1 = 0,
        /// Enable protection for region 27. Write '0' has no effect.
        REGION27: u1 = 0,
        /// Enable protection for region 28. Write '0' has no effect.
        REGION28: u1 = 0,
        /// Enable protection for region 29. Write '0' has no effect.
        REGION29: u1 = 0,
        /// Enable protection for region 30. Write '0' has no effect.
        REGION30: u1 = 0,
        /// Enable protection for region 31. Write '0' has no effect.
        REGION31: u1 = 0,
    });

    /// Block protect configuration register 1
    pub const CONFIG1 = mmio(Address + 0x00000604, 32, packed struct {
        /// Enable protection for region 32. Write '0' has no effect.
        REGION32: u1 = 0,
        /// Enable protection for region 33. Write '0' has no effect.
        REGION33: u1 = 0,
        /// Enable protection for region 34. Write '0' has no effect.
        REGION34: u1 = 0,
        /// Enable protection for region 35. Write '0' has no effect.
        REGION35: u1 = 0,
        /// Enable protection for region 36. Write '0' has no effect.
        REGION36: u1 = 0,
        /// Enable protection for region 37. Write '0' has no effect.
        REGION37: u1 = 0,
        /// Enable protection for region 38. Write '0' has no effect.
        REGION38: u1 = 0,
        /// Enable protection for region 39. Write '0' has no effect.
        REGION39: u1 = 0,
        /// Enable protection for region 40. Write '0' has no effect.
        REGION40: u1 = 0,
        /// Enable protection for region 41. Write '0' has no effect.
        REGION41: u1 = 0,
        /// Enable protection for region 42. Write '0' has no effect.
        REGION42: u1 = 0,
        /// Enable protection for region 43. Write '0' has no effect.
        REGION43: u1 = 0,
        /// Enable protection for region 44. Write '0' has no effect.
        REGION44: u1 = 0,
        /// Enable protection for region 45. Write '0' has no effect.
        REGION45: u1 = 0,
        /// Enable protection for region 46. Write '0' has no effect.
        REGION46: u1 = 0,
        /// Enable protection for region 47. Write '0' has no effect.
        REGION47: u1 = 0,
        /// Enable protection for region 48. Write '0' has no effect.
        REGION48: u1 = 0,
        /// Enable protection for region 49. Write '0' has no effect.
        REGION49: u1 = 0,
        /// Enable protection for region 50. Write '0' has no effect.
        REGION50: u1 = 0,
        /// Enable protection for region 51. Write '0' has no effect.
        REGION51: u1 = 0,
        /// Enable protection for region 52. Write '0' has no effect.
        REGION52: u1 = 0,
        /// Enable protection for region 53. Write '0' has no effect.
        REGION53: u1 = 0,
        /// Enable protection for region 54. Write '0' has no effect.
        REGION54: u1 = 0,
        /// Enable protection for region 55. Write '0' has no effect.
        REGION55: u1 = 0,
        /// Enable protection for region 56. Write '0' has no effect.
        REGION56: u1 = 0,
        /// Enable protection for region 57. Write '0' has no effect.
        REGION57: u1 = 0,
        /// Enable protection for region 58. Write '0' has no effect.
        REGION58: u1 = 0,
        /// Enable protection for region 59. Write '0' has no effect.
        REGION59: u1 = 0,
        /// Enable protection for region 60. Write '0' has no effect.
        REGION60: u1 = 0,
        /// Enable protection for region 61. Write '0' has no effect.
        REGION61: u1 = 0,
        /// Enable protection for region 62. Write '0' has no effect.
        REGION62: u1 = 0,
        /// Enable protection for region 63. Write '0' has no effect.
        REGION63: u1 = 0,
    });

    /// Disable protection mechanism in debug interface mode
    pub const DISABLEINDEBUG = mmio(Address + 0x00000608, 32, packed struct {
        /// Disable the protection mechanism for NVM regions while in debug interface
        /// mode. This register will only disable the protection mechanism if the device
        /// is in debug interface mode.
        DISABLEINDEBUG: u1 = 0,
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

    /// Unspecified
    pub const UNUSED0 = @intToPtr(*volatile u32, Address + 0x0000060c);

    /// Block protect configuration register 2
    pub const CONFIG2 = mmio(Address + 0x00000610, 32, packed struct {
        /// Enable protection for region 64. Write '0' has no effect.
        REGION64: u1 = 0,
        /// Enable protection for region 65. Write '0' has no effect.
        REGION65: u1 = 0,
        /// Enable protection for region 66. Write '0' has no effect.
        REGION66: u1 = 0,
        /// Enable protection for region 67. Write '0' has no effect.
        REGION67: u1 = 0,
        /// Enable protection for region 68. Write '0' has no effect.
        REGION68: u1 = 0,
        /// Enable protection for region 69. Write '0' has no effect.
        REGION69: u1 = 0,
        /// Enable protection for region 70. Write '0' has no effect.
        REGION70: u1 = 0,
        /// Enable protection for region 71. Write '0' has no effect.
        REGION71: u1 = 0,
        /// Enable protection for region 72. Write '0' has no effect.
        REGION72: u1 = 0,
        /// Enable protection for region 73. Write '0' has no effect.
        REGION73: u1 = 0,
        /// Enable protection for region 74. Write '0' has no effect.
        REGION74: u1 = 0,
        /// Enable protection for region 75. Write '0' has no effect.
        REGION75: u1 = 0,
        /// Enable protection for region 76. Write '0' has no effect.
        REGION76: u1 = 0,
        /// Enable protection for region 77. Write '0' has no effect.
        REGION77: u1 = 0,
        /// Enable protection for region 78. Write '0' has no effect.
        REGION78: u1 = 0,
        /// Enable protection for region 79. Write '0' has no effect.
        REGION79: u1 = 0,
        /// Enable protection for region 80. Write '0' has no effect.
        REGION80: u1 = 0,
        /// Enable protection for region 81. Write '0' has no effect.
        REGION81: u1 = 0,
        /// Enable protection for region 82. Write '0' has no effect.
        REGION82: u1 = 0,
        /// Enable protection for region 83. Write '0' has no effect.
        REGION83: u1 = 0,
        /// Enable protection for region 84. Write '0' has no effect.
        REGION84: u1 = 0,
        /// Enable protection for region 85. Write '0' has no effect.
        REGION85: u1 = 0,
        /// Enable protection for region 86. Write '0' has no effect.
        REGION86: u1 = 0,
        /// Enable protection for region 87. Write '0' has no effect.
        REGION87: u1 = 0,
        /// Enable protection for region 88. Write '0' has no effect.
        REGION88: u1 = 0,
        /// Enable protection for region 89. Write '0' has no effect.
        REGION89: u1 = 0,
        /// Enable protection for region 90. Write '0' has no effect.
        REGION90: u1 = 0,
        /// Enable protection for region 91. Write '0' has no effect.
        REGION91: u1 = 0,
        /// Enable protection for region 92. Write '0' has no effect.
        REGION92: u1 = 0,
        /// Enable protection for region 93. Write '0' has no effect.
        REGION93: u1 = 0,
        /// Enable protection for region 94. Write '0' has no effect.
        REGION94: u1 = 0,
        /// Enable protection for region 95. Write '0' has no effect.
        REGION95: u1 = 0,
    });

    /// Block protect configuration register 3
    pub const CONFIG3 = mmio(Address + 0x00000614, 32, packed struct {
        /// Enable protection for region 96. Write '0' has no effect.
        REGION96: u1 = 0,
        /// Enable protection for region 97. Write '0' has no effect.
        REGION97: u1 = 0,
        /// Enable protection for region 98. Write '0' has no effect.
        REGION98: u1 = 0,
        /// Enable protection for region 99. Write '0' has no effect.
        REGION99: u1 = 0,
        /// Enable protection for region 100. Write '0' has no effect.
        REGION100: u1 = 0,
        /// Enable protection for region 101. Write '0' has no effect.
        REGION101: u1 = 0,
        /// Enable protection for region 102. Write '0' has no effect.
        REGION102: u1 = 0,
        /// Enable protection for region 103. Write '0' has no effect.
        REGION103: u1 = 0,
        /// Enable protection for region 104. Write '0' has no effect.
        REGION104: u1 = 0,
        /// Enable protection for region 105. Write '0' has no effect.
        REGION105: u1 = 0,
        /// Enable protection for region 106. Write '0' has no effect.
        REGION106: u1 = 0,
        /// Enable protection for region 107. Write '0' has no effect.
        REGION107: u1 = 0,
        /// Enable protection for region 108. Write '0' has no effect.
        REGION108: u1 = 0,
        /// Enable protection for region 109. Write '0' has no effect.
        REGION109: u1 = 0,
        /// Enable protection for region 110. Write '0' has no effect.
        REGION110: u1 = 0,
        /// Enable protection for region 111. Write '0' has no effect.
        REGION111: u1 = 0,
        /// Enable protection for region 112. Write '0' has no effect.
        REGION112: u1 = 0,
        /// Enable protection for region 113. Write '0' has no effect.
        REGION113: u1 = 0,
        /// Enable protection for region 114. Write '0' has no effect.
        REGION114: u1 = 0,
        /// Enable protection for region 115. Write '0' has no effect.
        REGION115: u1 = 0,
        /// Enable protection for region 116. Write '0' has no effect.
        REGION116: u1 = 0,
        /// Enable protection for region 117. Write '0' has no effect.
        REGION117: u1 = 0,
        /// Enable protection for region 118. Write '0' has no effect.
        REGION118: u1 = 0,
        /// Enable protection for region 119. Write '0' has no effect.
        REGION119: u1 = 0,
        /// Enable protection for region 120. Write '0' has no effect.
        REGION120: u1 = 0,
        /// Enable protection for region 121. Write '0' has no effect.
        REGION121: u1 = 0,
        /// Enable protection for region 122. Write '0' has no effect.
        REGION122: u1 = 0,
        /// Enable protection for region 123. Write '0' has no effect.
        REGION123: u1 = 0,
        /// Enable protection for region 124. Write '0' has no effect.
        REGION124: u1 = 0,
        /// Enable protection for region 125. Write '0' has no effect.
        REGION125: u1 = 0,
        /// Enable protection for region 126. Write '0' has no effect.
        REGION126: u1 = 0,
        /// Enable protection for region 127. Write '0' has no effect.
        REGION127: u1 = 0,
    });
};

/// Power control
pub const POWER = extern struct {
    pub const Address: u32 = 0x40000000;

    /// Enable constant latency mode
    pub const TASKS_CONSTLAT = @intToPtr(*volatile u32, Address + 0x00000078);

    /// Enable low power mode (variable latency)
    pub const TASKS_LOWPWR = @intToPtr(*volatile u32, Address + 0x0000007c);

    /// Power failure warning
    pub const EVENTS_POFWARN = @intToPtr(*volatile u32, Address + 0x00000108);

    /// CPU entered WFI/WFE sleep
    pub const EVENTS_SLEEPENTER = @intToPtr(*volatile u32, Address + 0x00000114);

    /// CPU exited WFI/WFE sleep
    pub const EVENTS_SLEEPEXIT = @intToPtr(*volatile u32, Address + 0x00000118);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for POFWARN event
        POFWARN: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Write '1' to Enable interrupt for SLEEPENTER event
        SLEEPENTER: u1 = 0,
        /// Write '1' to Enable interrupt for SLEEPEXIT event
        SLEEPEXIT: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for POFWARN event
        POFWARN: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Write '1' to Disable interrupt for SLEEPENTER event
        SLEEPENTER: u1 = 0,
        /// Write '1' to Disable interrupt for SLEEPEXIT event
        SLEEPEXIT: u1 = 0,
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

    /// Reset reason
    pub const RESETREAS = mmio(Address + 0x00000400, 32, packed struct {
        /// Reset from pin-reset detected
        RESETPIN: u1 = 0,
        /// Reset from watchdog detected
        DOG: u1 = 0,
        /// Reset from soft reset detected
        SREQ: u1 = 0,
        /// Reset from CPU lock-up detected
        LOCKUP: u1 = 0,
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
        /// Reset due to wake up from System OFF mode when wakeup is triggered from
        /// DETECT signal from GPIO
        OFF: u1 = 0,
        /// Reset due to wake up from System OFF mode when wakeup is triggered from
        /// ANADETECT signal from LPCOMP
        LPCOMP: u1 = 0,
        /// Reset due to wake up from System OFF mode when wakeup is triggered from
        /// entering into debug interface mode
        DIF: u1 = 0,
        /// Reset due to wake up from System OFF mode by NFC field detect
        NFC: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Deprecated register - RAM status register
    pub const RAMSTATUS = mmio(Address + 0x00000428, 32, packed struct {
        /// RAM block 0 is on or off/powering up
        RAMBLOCK0: u1 = 0,
        /// RAM block 1 is on or off/powering up
        RAMBLOCK1: u1 = 0,
        /// RAM block 2 is on or off/powering up
        RAMBLOCK2: u1 = 0,
        /// RAM block 3 is on or off/powering up
        RAMBLOCK3: u1 = 0,
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

    /// System OFF register
    pub const SYSTEMOFF = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable System OFF mode
        SYSTEMOFF: u1 = 0,
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

    /// Power failure comparator configuration
    pub const POFCON = mmio(Address + 0x00000510, 32, packed struct {
        /// Enable or disable power failure comparator
        POF: u1 = 0,
        /// Power failure comparator threshold setting
        THRESHOLD: u4 = 0,
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

    /// General purpose retention register
    pub const GPREGRET = mmio(Address + 0x0000051c, 32, packed struct {
        /// General purpose retention register
        GPREGRET: u8 = 0,
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

    /// General purpose retention register
    pub const GPREGRET2 = mmio(Address + 0x00000520, 32, packed struct {
        /// General purpose retention register
        GPREGRET: u8 = 0,
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

    /// Deprecated register - RAM on/off register (this register is retained)
    pub const RAMON = mmio(Address + 0x00000524, 32, packed struct {
        /// Keep RAM block 0 on or off in system ON Mode
        ONRAM0: u1 = 0,
        /// Keep RAM block 1 on or off in system ON Mode
        ONRAM1: u1 = 0,
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
        /// Keep retention on RAM block 0 when RAM block is switched off
        OFFRAM0: u1 = 0,
        /// Keep retention on RAM block 1 when RAM block is switched off
        OFFRAM1: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Deprecated register - RAM on/off register (this register is retained)
    pub const RAMONB = mmio(Address + 0x00000554, 32, packed struct {
        /// Keep RAM block 2 on or off in system ON Mode
        ONRAM2: u1 = 0,
        /// Keep RAM block 3 on or off in system ON Mode
        ONRAM3: u1 = 0,
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
        /// Keep retention on RAM block 2 when RAM block is switched off
        OFFRAM2: u1 = 0,
        /// Keep retention on RAM block 3 when RAM block is switched off
        OFFRAM3: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DC/DC enable register
    pub const DCDCEN = mmio(Address + 0x00000578, 32, packed struct {
        /// Enable or disable DC/DC converter
        DCDCEN: u1 = 0,
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

/// Clock control
pub const CLOCK = extern struct {
    pub const Address: u32 = 0x40000000;

    /// Start HFCLK crystal oscillator
    pub const TASKS_HFCLKSTART = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop HFCLK crystal oscillator
    pub const TASKS_HFCLKSTOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Start LFCLK source
    pub const TASKS_LFCLKSTART = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop LFCLK source
    pub const TASKS_LFCLKSTOP = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Start calibration of LFRC oscillator
    pub const TASKS_CAL = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Start calibration timer
    pub const TASKS_CTSTART = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Stop calibration timer
    pub const TASKS_CTSTOP = @intToPtr(*volatile u32, Address + 0x00000018);

    /// HFCLK oscillator started
    pub const EVENTS_HFCLKSTARTED = @intToPtr(*volatile u32, Address + 0x00000100);

    /// LFCLK started
    pub const EVENTS_LFCLKSTARTED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Calibration of LFCLK RC oscillator complete event
    pub const EVENTS_DONE = @intToPtr(*volatile u32, Address + 0x0000010c);

    /// Calibration timer timeout
    pub const EVENTS_CTTO = @intToPtr(*volatile u32, Address + 0x00000110);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for HFCLKSTARTED event
        HFCLKSTARTED: u1 = 0,
        /// Write '1' to Enable interrupt for LFCLKSTARTED event
        LFCLKSTARTED: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for DONE event
        DONE: u1 = 0,
        /// Write '1' to Enable interrupt for CTTO event
        CTTO: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for HFCLKSTARTED event
        HFCLKSTARTED: u1 = 0,
        /// Write '1' to Disable interrupt for LFCLKSTARTED event
        LFCLKSTARTED: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for DONE event
        DONE: u1 = 0,
        /// Write '1' to Disable interrupt for CTTO event
        CTTO: u1 = 0,
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

    /// Status indicating that HFCLKSTART task has been triggered
    pub const HFCLKRUN = mmio(Address + 0x00000408, 32, packed struct {
        /// HFCLKSTART task triggered or not
        STATUS: u1 = 0,
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

    /// HFCLK status
    pub const HFCLKSTAT = mmio(Address + 0x0000040c, 32, packed struct {
        /// Source of HFCLK
        SRC: u1 = 0,
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
        /// HFCLK state
        STATE: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Status indicating that LFCLKSTART task has been triggered
    pub const LFCLKRUN = mmio(Address + 0x00000414, 32, packed struct {
        /// LFCLKSTART task triggered or not
        STATUS: u1 = 0,
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

    /// LFCLK status
    pub const LFCLKSTAT = mmio(Address + 0x00000418, 32, packed struct {
        /// Source of LFCLK
        SRC: u2 = 0,
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
        /// LFCLK state
        STATE: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Copy of LFCLKSRC register, set when LFCLKSTART task was triggered
    pub const LFCLKSRCCOPY = mmio(Address + 0x0000041c, 32, packed struct {
        /// Clock source
        SRC: u2 = 0,
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

    /// Clock source for the LFCLK
    pub const LFCLKSRC = mmio(Address + 0x00000518, 32, packed struct {
        /// Clock source
        SRC: u2 = 0,
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
        /// Enable or disable bypass of LFCLK crystal oscillator with external clock
        /// source
        BYPASS: u1 = 0,
        /// Enable or disable external source for LFCLK
        EXTERNAL: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Calibration timer interval
    pub const CTIV = mmio(Address + 0x00000538, 32, packed struct {
        /// Calibration timer interval in multiple of 0.25 seconds. Range: 0.25 seconds
        /// to 31.75 seconds.
        CTIV: u7 = 0,
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

    /// Clocking options for the Trace Port debug interface
    pub const TRACECONFIG = mmio(Address + 0x0000055c, 32, packed struct {
        /// Speed of Trace Port clock. Note that the TRACECLK pin will output this clock
        /// divided by two.
        TRACEPORTSPEED: u2 = 0,
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
        /// Pin multiplexing of trace signals.
        TRACEMUX: u2 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

/// 2.4 GHz Radio
pub const RADIO = extern struct {
    pub const Address: u32 = 0x40001000;

    /// Enable RADIO in TX mode
    pub const TASKS_TXEN = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Enable RADIO in RX mode
    pub const TASKS_RXEN = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Start RADIO
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop RADIO
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Disable RADIO
    pub const TASKS_DISABLE = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Start the RSSI and take one single sample of the receive signal strength.
    pub const TASKS_RSSISTART = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Stop the RSSI measurement
    pub const TASKS_RSSISTOP = @intToPtr(*volatile u32, Address + 0x00000018);

    /// Start the bit counter
    pub const TASKS_BCSTART = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Stop the bit counter
    pub const TASKS_BCSTOP = @intToPtr(*volatile u32, Address + 0x00000020);

    /// RADIO has ramped up and is ready to be started
    pub const EVENTS_READY = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Address sent or received
    pub const EVENTS_ADDRESS = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Packet payload sent or received
    pub const EVENTS_PAYLOAD = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Packet sent or received
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x0000010c);

    /// RADIO has been disabled
    pub const EVENTS_DISABLED = @intToPtr(*volatile u32, Address + 0x00000110);

    /// A device address match occurred on the last received packet
    pub const EVENTS_DEVMATCH = @intToPtr(*volatile u32, Address + 0x00000114);

    /// No device address match occurred on the last received packet
    pub const EVENTS_DEVMISS = @intToPtr(*volatile u32, Address + 0x00000118);

    /// Sampling of receive signal strength complete.
    pub const EVENTS_RSSIEND = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// Bit counter reached bit count value.
    pub const EVENTS_BCMATCH = @intToPtr(*volatile u32, Address + 0x00000128);

    /// Packet received with CRC ok
    pub const EVENTS_CRCOK = @intToPtr(*volatile u32, Address + 0x00000130);

    /// Packet received with CRC error
    pub const EVENTS_CRCERROR = @intToPtr(*volatile u32, Address + 0x00000134);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between READY event and START task
        READY_START: u1 = 0,
        /// Shortcut between END event and DISABLE task
        END_DISABLE: u1 = 0,
        /// Shortcut between DISABLED event and TXEN task
        DISABLED_TXEN: u1 = 0,
        /// Shortcut between DISABLED event and RXEN task
        DISABLED_RXEN: u1 = 0,
        /// Shortcut between ADDRESS event and RSSISTART task
        ADDRESS_RSSISTART: u1 = 0,
        /// Shortcut between END event and START task
        END_START: u1 = 0,
        /// Shortcut between ADDRESS event and BCSTART task
        ADDRESS_BCSTART: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between DISABLED event and RSSISTOP task
        DISABLED_RSSISTOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Enable interrupt for ADDRESS event
        ADDRESS: u1 = 0,
        /// Write '1' to Enable interrupt for PAYLOAD event
        PAYLOAD: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        /// Write '1' to Enable interrupt for DISABLED event
        DISABLED: u1 = 0,
        /// Write '1' to Enable interrupt for DEVMATCH event
        DEVMATCH: u1 = 0,
        /// Write '1' to Enable interrupt for DEVMISS event
        DEVMISS: u1 = 0,
        /// Write '1' to Enable interrupt for RSSIEND event
        RSSIEND: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for BCMATCH event
        BCMATCH: u1 = 0,
        reserved3: u1 = 0,
        /// Write '1' to Enable interrupt for CRCOK event
        CRCOK: u1 = 0,
        /// Write '1' to Enable interrupt for CRCERROR event
        CRCERROR: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Disable interrupt for ADDRESS event
        ADDRESS: u1 = 0,
        /// Write '1' to Disable interrupt for PAYLOAD event
        PAYLOAD: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        /// Write '1' to Disable interrupt for DISABLED event
        DISABLED: u1 = 0,
        /// Write '1' to Disable interrupt for DEVMATCH event
        DEVMATCH: u1 = 0,
        /// Write '1' to Disable interrupt for DEVMISS event
        DEVMISS: u1 = 0,
        /// Write '1' to Disable interrupt for RSSIEND event
        RSSIEND: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for BCMATCH event
        BCMATCH: u1 = 0,
        reserved3: u1 = 0,
        /// Write '1' to Disable interrupt for CRCOK event
        CRCOK: u1 = 0,
        /// Write '1' to Disable interrupt for CRCERROR event
        CRCERROR: u1 = 0,
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

    /// CRC status
    pub const CRCSTATUS = mmio(Address + 0x00000400, 32, packed struct {
        /// CRC status of packet received
        CRCSTATUS: u1 = 0,
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

    /// Received address
    pub const RXMATCH = mmio(Address + 0x00000408, 32, packed struct {
        /// Received address
        RXMATCH: u3 = 0,
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

    /// CRC field of previously received packet
    pub const RXCRC = mmio(Address + 0x0000040c, 32, packed struct {
        /// CRC field of previously received packet
        RXCRC: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Device address match index
    pub const DAI = mmio(Address + 0x00000410, 32, packed struct {
        /// Device address match index
        DAI: u3 = 0,
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

    /// Packet pointer
    pub const PACKETPTR = @intToPtr(*volatile u32, Address + 0x00000504);

    /// Frequency
    pub const FREQUENCY = mmio(Address + 0x00000508, 32, packed struct {
        /// Radio channel frequency
        FREQUENCY: u7 = 0,
        reserved1: u1 = 0,
        /// Channel map selection.
        MAP: u1 = 0,
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

    /// Output power
    pub const TXPOWER = mmio(Address + 0x0000050c, 32, packed struct {
        /// RADIO output power.
        TXPOWER: u8 = 0,
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

    /// Data rate and modulation
    pub const MODE = mmio(Address + 0x00000510, 32, packed struct {
        /// Radio data rate and modulation setting. The radio supports Frequency-shift
        /// Keying (FSK) modulation.
        MODE: u4 = 0,
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

    /// Packet configuration register 0
    pub const PCNF0 = mmio(Address + 0x00000514, 32, packed struct {
        /// Length on air of LENGTH field in number of bits.
        LFLEN: u4 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Length on air of S0 field in number of bytes.
        S0LEN: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Length on air of S1 field in number of bits.
        S1LEN: u4 = 0,
        /// Include or exclude S1 field in RAM
        S1INCL: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        /// Length of preamble on air. Decision point: TASKS_START task
        PLEN: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Packet configuration register 1
    pub const PCNF1 = mmio(Address + 0x00000518, 32, packed struct {
        /// Maximum length of packet payload. If the packet payload is larger than
        /// MAXLEN, the radio will truncate the payload to MAXLEN.
        MAXLEN: u8 = 0,
        /// Static length in number of bytes
        STATLEN: u8 = 0,
        /// Base address length in number of bytes
        BALEN: u3 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// On air endianness of packet, this applies to the S0, LENGTH, S1 and the
        /// PAYLOAD fields.
        ENDIAN: u1 = 0,
        /// Enable or disable packet whitening
        WHITEEN: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Base address 0
    pub const BASE0 = @intToPtr(*volatile u32, Address + 0x0000051c);

    /// Base address 1
    pub const BASE1 = @intToPtr(*volatile u32, Address + 0x00000520);

    /// Prefixes bytes for logical addresses 0-3
    pub const PREFIX0 = mmio(Address + 0x00000524, 32, packed struct {
        /// Address prefix 0.
        AP0: u8 = 0,
        /// Address prefix 1.
        AP1: u8 = 0,
        /// Address prefix 2.
        AP2: u8 = 0,
        /// Address prefix 3.
        AP3: u8 = 0,
    });

    /// Prefixes bytes for logical addresses 4-7
    pub const PREFIX1 = mmio(Address + 0x00000528, 32, packed struct {
        /// Address prefix 4.
        AP4: u8 = 0,
        /// Address prefix 5.
        AP5: u8 = 0,
        /// Address prefix 6.
        AP6: u8 = 0,
        /// Address prefix 7.
        AP7: u8 = 0,
    });

    /// Transmit address select
    pub const TXADDRESS = mmio(Address + 0x0000052c, 32, packed struct {
        /// Transmit address select
        TXADDRESS: u3 = 0,
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

    /// Receive address select
    pub const RXADDRESSES = mmio(Address + 0x00000530, 32, packed struct {
        /// Enable or disable reception on logical address 0.
        ADDR0: u1 = 0,
        /// Enable or disable reception on logical address 1.
        ADDR1: u1 = 0,
        /// Enable or disable reception on logical address 2.
        ADDR2: u1 = 0,
        /// Enable or disable reception on logical address 3.
        ADDR3: u1 = 0,
        /// Enable or disable reception on logical address 4.
        ADDR4: u1 = 0,
        /// Enable or disable reception on logical address 5.
        ADDR5: u1 = 0,
        /// Enable or disable reception on logical address 6.
        ADDR6: u1 = 0,
        /// Enable or disable reception on logical address 7.
        ADDR7: u1 = 0,
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

    /// CRC configuration
    pub const CRCCNF = mmio(Address + 0x00000534, 32, packed struct {
        /// CRC length in number of bytes.
        LEN: u2 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Include or exclude packet address field out of CRC calculation.
        SKIPADDR: u1 = 0,
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

    /// CRC polynomial
    pub const CRCPOLY = mmio(Address + 0x00000538, 32, packed struct {
        /// CRC polynomial
        CRCPOLY: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CRC initial value
    pub const CRCINIT = mmio(Address + 0x0000053c, 32, packed struct {
        /// CRC initial value
        CRCINIT: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Unspecified
    pub const UNUSED0 = @intToPtr(*volatile u32, Address + 0x00000540);

    /// Inter Frame Spacing in us
    pub const TIFS = mmio(Address + 0x00000544, 32, packed struct {
        /// Inter Frame Spacing in us
        TIFS: u8 = 0,
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

    /// RSSI sample
    pub const RSSISAMPLE = mmio(Address + 0x00000548, 32, packed struct {
        /// RSSI sample
        RSSISAMPLE: u7 = 0,
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

    /// Current radio state
    pub const STATE = mmio(Address + 0x00000550, 32, packed struct {
        /// Current radio state
        STATE: u4 = 0,
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

    /// Data whitening initial value
    pub const DATAWHITEIV = mmio(Address + 0x00000554, 32, packed struct {
        /// Data whitening initial value. Bit 6 is hard-wired to '1', writing '0' to it
        /// has no effect, and it will always be read back and used by the device as
        /// '1'.
        DATAWHITEIV: u7 = 0,
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

    /// Bit counter compare
    pub const BCC = @intToPtr(*volatile u32, Address + 0x00000560);

    /// Device address match configuration
    pub const DACNF = mmio(Address + 0x00000640, 32, packed struct {
        /// Enable or disable device address matching using device address 0
        ENA0: u1 = 0,
        /// Enable or disable device address matching using device address 1
        ENA1: u1 = 0,
        /// Enable or disable device address matching using device address 2
        ENA2: u1 = 0,
        /// Enable or disable device address matching using device address 3
        ENA3: u1 = 0,
        /// Enable or disable device address matching using device address 4
        ENA4: u1 = 0,
        /// Enable or disable device address matching using device address 5
        ENA5: u1 = 0,
        /// Enable or disable device address matching using device address 6
        ENA6: u1 = 0,
        /// Enable or disable device address matching using device address 7
        ENA7: u1 = 0,
        /// TxAdd for device address 0
        TXADD0: u1 = 0,
        /// TxAdd for device address 1
        TXADD1: u1 = 0,
        /// TxAdd for device address 2
        TXADD2: u1 = 0,
        /// TxAdd for device address 3
        TXADD3: u1 = 0,
        /// TxAdd for device address 4
        TXADD4: u1 = 0,
        /// TxAdd for device address 5
        TXADD5: u1 = 0,
        /// TxAdd for device address 6
        TXADD6: u1 = 0,
        /// TxAdd for device address 7
        TXADD7: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Radio mode configuration register 0
    pub const MODECNF0 = mmio(Address + 0x00000650, 32, packed struct {
        /// Radio ramp-up time
        RU: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Default TX value
        DTX: u2 = 0,
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

    /// Peripheral power control
    pub const POWER = mmio(Address + 0x00000ffc, 32, packed struct {
        /// Peripheral power control. The peripheral and its registers will be reset to
        /// its initial state by switching the peripheral off and then back on again.
        POWER: u1 = 0,
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
    /// Description collection[0]: Device address base segment 0
    pub const DAB = @intToPtr(*volatile [8]u32, Address + 0x00000600);
    /// Description collection[0]: Device address prefix 0
    pub const DAP = @intToPtr(*volatile [8]MMIO(32, packed struct {
        /// Device address prefix 0
        DAP: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    }), Address + 0x00000620);
};

/// UART with EasyDMA
pub const UARTE0 = extern struct {
    pub const Address: u32 = 0x40002000;

    /// Start UART receiver
    pub const TASKS_STARTRX = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop UART receiver
    pub const TASKS_STOPRX = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Start UART transmitter
    pub const TASKS_STARTTX = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop UART transmitter
    pub const TASKS_STOPTX = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Flush RX FIFO into RX buffer
    pub const TASKS_FLUSHRX = @intToPtr(*volatile u32, Address + 0x0000002c);

    /// CTS is activated (set low). Clear To Send.
    pub const EVENTS_CTS = @intToPtr(*volatile u32, Address + 0x00000100);

    /// CTS is deactivated (set high). Not Clear To Send.
    pub const EVENTS_NCTS = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Data received in RXD (but potentially not yet transferred to Data RAM)
    pub const EVENTS_RXDRDY = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Receive buffer is filled up
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x00000110);

    /// Data sent from TXD
    pub const EVENTS_TXDRDY = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// Last TX byte transmitted
    pub const EVENTS_ENDTX = @intToPtr(*volatile u32, Address + 0x00000120);

    /// Error detected
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// Receiver timeout
    pub const EVENTS_RXTO = @intToPtr(*volatile u32, Address + 0x00000144);

    /// UART receiver has started
    pub const EVENTS_RXSTARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// UART transmitter has started
    pub const EVENTS_TXSTARTED = @intToPtr(*volatile u32, Address + 0x00000150);

    /// Transmitter stopped
    pub const EVENTS_TXSTOPPED = @intToPtr(*volatile u32, Address + 0x00000158);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between ENDRX event and STARTRX task
        ENDRX_STARTRX: u1 = 0,
        /// Shortcut between ENDRX event and STOPRX task
        ENDRX_STOPRX: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for CTS event
        CTS: u1 = 0,
        /// Enable or disable interrupt for NCTS event
        NCTS: u1 = 0,
        /// Enable or disable interrupt for RXDRDY event
        RXDRDY: u1 = 0,
        reserved1: u1 = 0,
        /// Enable or disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Enable or disable interrupt for TXDRDY event
        TXDRDY: u1 = 0,
        /// Enable or disable interrupt for ENDTX event
        ENDTX: u1 = 0,
        /// Enable or disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Enable or disable interrupt for RXTO event
        RXTO: u1 = 0,
        reserved11: u1 = 0,
        /// Enable or disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Enable or disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved12: u1 = 0,
        /// Enable or disable interrupt for TXSTOPPED event
        TXSTOPPED: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for CTS event
        CTS: u1 = 0,
        /// Write '1' to Enable interrupt for NCTS event
        NCTS: u1 = 0,
        /// Write '1' to Enable interrupt for RXDRDY event
        RXDRDY: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for TXDRDY event
        TXDRDY: u1 = 0,
        /// Write '1' to Enable interrupt for ENDTX event
        ENDTX: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for RXTO event
        RXTO: u1 = 0,
        reserved11: u1 = 0,
        /// Write '1' to Enable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Enable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved12: u1 = 0,
        /// Write '1' to Enable interrupt for TXSTOPPED event
        TXSTOPPED: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for CTS event
        CTS: u1 = 0,
        /// Write '1' to Disable interrupt for NCTS event
        NCTS: u1 = 0,
        /// Write '1' to Disable interrupt for RXDRDY event
        RXDRDY: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for TXDRDY event
        TXDRDY: u1 = 0,
        /// Write '1' to Disable interrupt for ENDTX event
        ENDTX: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for RXTO event
        RXTO: u1 = 0,
        reserved11: u1 = 0,
        /// Write '1' to Disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved12: u1 = 0,
        /// Write '1' to Disable interrupt for TXSTOPPED event
        TXSTOPPED: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x00000480, 32, packed struct {
        /// Overrun error
        OVERRUN: u1 = 0,
        /// Parity error
        PARITY: u1 = 0,
        /// Framing error occurred
        FRAMING: u1 = 0,
        /// Break condition
        BREAK: u1 = 0,
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

    /// Enable UART
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable UARTE
        ENABLE: u4 = 0,
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

    /// Baud rate. Accuracy depends on the HFCLK source selected.
    pub const BAUDRATE = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration of parity and hardware flow control
    pub const CONFIG = mmio(Address + 0x0000056c, 32, packed struct {
        /// Hardware flow control
        HWFC: u1 = 0,
        /// Parity
        PARITY: u3 = 0,
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

    pub const PSEL = struct {

        /// Pin select for RTS signal
        pub const RTS = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for TXD signal
        pub const TXD = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for CTS signal
        pub const CTS = mmio(Address + 0x00000008, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for RXD signal
        pub const RXD = mmio(Address + 0x0000000c, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };

    pub const RXD = struct {

        /// Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in receive buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in receive buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last transaction
            AMOUNT: u8 = 0,
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

    pub const TXD = struct {

        /// Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in transmit buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in transmit buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last transaction
            AMOUNT: u8 = 0,
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
};

/// Universal Asynchronous Receiver/Transmitter
pub const UART0 = extern struct {
    pub const Address: u32 = 0x40002000;

    /// Start UART receiver
    pub const TASKS_STARTRX = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop UART receiver
    pub const TASKS_STOPRX = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Start UART transmitter
    pub const TASKS_STARTTX = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop UART transmitter
    pub const TASKS_STOPTX = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Suspend UART
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// CTS is activated (set low). Clear To Send.
    pub const EVENTS_CTS = @intToPtr(*volatile u32, Address + 0x00000100);

    /// CTS is deactivated (set high). Not Clear To Send.
    pub const EVENTS_NCTS = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Data received in RXD
    pub const EVENTS_RXDRDY = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Data sent from TXD
    pub const EVENTS_TXDRDY = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// Error detected
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// Receiver timeout
    pub const EVENTS_RXTO = @intToPtr(*volatile u32, Address + 0x00000144);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between CTS event and STARTRX task
        CTS_STARTRX: u1 = 0,
        /// Shortcut between NCTS event and STOPRX task
        NCTS_STOPRX: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for CTS event
        CTS: u1 = 0,
        /// Write '1' to Enable interrupt for NCTS event
        NCTS: u1 = 0,
        /// Write '1' to Enable interrupt for RXDRDY event
        RXDRDY: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for TXDRDY event
        TXDRDY: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        /// Write '1' to Enable interrupt for RXTO event
        RXTO: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for CTS event
        CTS: u1 = 0,
        /// Write '1' to Disable interrupt for NCTS event
        NCTS: u1 = 0,
        /// Write '1' to Disable interrupt for RXDRDY event
        RXDRDY: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for TXDRDY event
        TXDRDY: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        /// Write '1' to Disable interrupt for RXTO event
        RXTO: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x00000480, 32, packed struct {
        /// Overrun error
        OVERRUN: u1 = 0,
        /// Parity error
        PARITY: u1 = 0,
        /// Framing error occurred
        FRAMING: u1 = 0,
        /// Break condition
        BREAK: u1 = 0,
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

    /// Enable UART
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable UART
        ENABLE: u4 = 0,
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

    /// Pin select for RTS
    pub const PSELRTS = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Pin select for TXD
    pub const PSELTXD = @intToPtr(*volatile u32, Address + 0x0000050c);

    /// Pin select for CTS
    pub const PSELCTS = @intToPtr(*volatile u32, Address + 0x00000510);

    /// Pin select for RXD
    pub const PSELRXD = @intToPtr(*volatile u32, Address + 0x00000514);

    /// RXD register
    pub const RXD = mmio(Address + 0x00000518, 32, packed struct {
        /// RX data received in previous transfers, double buffered
        RXD: u8 = 0,
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

    /// TXD register
    pub const TXD = mmio(Address + 0x0000051c, 32, packed struct {
        /// TX data to be transferred
        TXD: u8 = 0,
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

    /// Baud rate
    pub const BAUDRATE = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration of parity and hardware flow control
    pub const CONFIG = mmio(Address + 0x0000056c, 32, packed struct {
        /// Hardware flow control
        HWFC: u1 = 0,
        /// Parity
        PARITY: u3 = 0,
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

/// Serial Peripheral Interface Master with EasyDMA 0
pub const SPIM0 = extern struct {
    pub const Address: u32 = 0x40003000;

    /// Start SPI transaction
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Stop SPI transaction
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend SPI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume SPI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// SPI transaction has stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// End of RXD buffer reached
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x00000110);

    /// End of RXD buffer and TXD buffer reached
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000118);

    /// End of TXD buffer reached
    pub const EVENTS_ENDTX = @intToPtr(*volatile u32, Address + 0x00000120);

    /// Transaction started
    pub const EVENTS_STARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
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
        /// Shortcut between END event and START task
        END_START: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Enable interrupt for ENDTX event
        ENDTX: u1 = 0,
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
        /// Write '1' to Enable interrupt for STARTED event
        STARTED: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Disable interrupt for ENDTX event
        ENDTX: u1 = 0,
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
        /// Write '1' to Disable interrupt for STARTED event
        STARTED: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable SPIM
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPIM
        ENABLE: u4 = 0,
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

    /// SPI frequency. Accuracy depends on the HFCLK source selected.
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

    /// Over-read character. Character clocked out in case and over-read of the TXD
    /// buffer.
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character clocked out in case and over-read of the TXD
        /// buffer.
        ORC: u8 = 0,
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

    pub const PSEL = struct {

        /// Pin select for SCK
        pub const SCK = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for MOSI signal
        pub const MOSI = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for MISO signal
        pub const MISO = mmio(Address + 0x00000008, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };

    pub const RXD = struct {

        /// Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in receive buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in receive buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last transaction
            AMOUNT: u8 = 0,
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

        /// EasyDMA list type
        pub const LIST = mmio(Address + 0x0000000c, 32, packed struct {
            /// List type
            LIST: u3 = 0,
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

    pub const TXD = struct {

        /// Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in transmit buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in transmit buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last transaction
            AMOUNT: u8 = 0,
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

        /// EasyDMA list type
        pub const LIST = mmio(Address + 0x0000000c, 32, packed struct {
            /// List type
            LIST: u3 = 0,
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
};

/// SPI Slave 0
pub const SPIS0 = extern struct {
    pub const Address: u32 = 0x40003000;

    /// Acquire SPI semaphore
    pub const TASKS_ACQUIRE = @intToPtr(*volatile u32, Address + 0x00000024);

    /// Release SPI semaphore, enabling the SPI slave to acquire it
    pub const TASKS_RELEASE = @intToPtr(*volatile u32, Address + 0x00000028);

    /// Granted transaction completed
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000104);

    /// End of RXD buffer reached
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x00000110);

    /// Semaphore acquired
    pub const EVENTS_ACQUIRED = @intToPtr(*volatile u32, Address + 0x00000128);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between END event and ACQUIRE task
        END_ACQUIRE: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for ACQUIRED event
        ACQUIRED: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for ACQUIRED event
        ACQUIRED: u1 = 0,
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

    /// Semaphore status register
    pub const SEMSTAT = mmio(Address + 0x00000400, 32, packed struct {
        /// Semaphore status
        SEMSTAT: u2 = 0,
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

    /// Status from last transaction
    pub const STATUS = mmio(Address + 0x00000440, 32, packed struct {
        /// TX buffer over-read detected, and prevented
        OVERREAD: u1 = 0,
        /// RX buffer overflow detected, and prevented
        OVERFLOW: u1 = 0,
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

    /// Enable SPI slave
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPI slave
        ENABLE: u4 = 0,
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

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

    /// Default character. Character clocked out in case of an ignored transaction.
    pub const DEF = mmio(Address + 0x0000055c, 32, packed struct {
        /// Default character. Character clocked out in case of an ignored transaction.
        DEF: u8 = 0,
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

    /// Over-read character
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character clocked out after an over-read of the
        /// transmit buffer.
        ORC: u8 = 0,
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

    pub const PSEL = struct {

        /// Pin select for SCK
        pub const SCK = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for MISO signal
        pub const MISO = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for MOSI signal
        pub const MOSI = mmio(Address + 0x00000008, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for CSN signal
        pub const CSN = mmio(Address + 0x0000000c, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };

    pub const RXD = struct {

        /// RXD data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in receive buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in receive buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes received in last granted transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes received in the last granted transaction
            AMOUNT: u8 = 0,
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

    pub const TXD = struct {

        /// TXD data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in transmit buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in transmit buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transmitted in last granted transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transmitted in last granted transaction
            AMOUNT: u8 = 0,
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
};

/// I2C compatible Two-Wire Master Interface with EasyDMA 0
pub const TWIM0 = extern struct {
    pub const Address: u32 = 0x40003000;

    /// Start TWI receive sequence
    pub const TASKS_STARTRX = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Start TWI transmit sequence
    pub const TASKS_STARTTX = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop TWI transaction. Must be issued while the TWI master is not suspended.
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend TWI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume TWI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// TWI stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// TWI error
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// Last byte has been sent out after the SUSPEND task has been issued, TWI
    /// traffic is now suspended.
    pub const EVENTS_SUSPENDED = @intToPtr(*volatile u32, Address + 0x00000148);

    /// Receive sequence started
    pub const EVENTS_RXSTARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// Transmit sequence started
    pub const EVENTS_TXSTARTED = @intToPtr(*volatile u32, Address + 0x00000150);

    /// Byte boundary, starting to receive the last byte
    pub const EVENTS_LASTRX = @intToPtr(*volatile u32, Address + 0x0000015c);

    /// Byte boundary, starting to transmit the last byte
    pub const EVENTS_LASTTX = @intToPtr(*volatile u32, Address + 0x00000160);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between LASTTX event and STARTRX task
        LASTTX_STARTRX: u1 = 0,
        /// Shortcut between LASTTX event and SUSPEND task
        LASTTX_SUSPEND: u1 = 0,
        /// Shortcut between LASTTX event and STOP task
        LASTTX_STOP: u1 = 0,
        /// Shortcut between LASTRX event and STARTTX task
        LASTRX_STARTTX: u1 = 0,
        reserved8: u1 = 0,
        /// Shortcut between LASTRX event and STOP task
        LASTRX_STOP: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Enable or disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Enable or disable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        /// Enable or disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Enable or disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        /// Enable or disable interrupt for LASTRX event
        LASTRX: u1 = 0,
        /// Enable or disable interrupt for LASTTX event
        LASTTX: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Enable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        /// Write '1' to Enable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Enable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        /// Write '1' to Enable interrupt for LASTRX event
        LASTRX: u1 = 0,
        /// Write '1' to Enable interrupt for LASTTX event
        LASTTX: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Disable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        /// Write '1' to Disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        /// Write '1' to Disable interrupt for LASTRX event
        LASTRX: u1 = 0,
        /// Write '1' to Disable interrupt for LASTTX event
        LASTTX: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x000004c4, 32, packed struct {
        /// Overrun error
        OVERRUN: u1 = 0,
        /// NACK received after sending the address (write '1' to clear)
        ANACK: u1 = 0,
        /// NACK received after sending a data byte (write '1' to clear)
        DNACK: u1 = 0,
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

    /// Enable TWIM
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable TWIM
        ENABLE: u4 = 0,
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

    /// TWI frequency
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Address used in the TWI transfer
    pub const ADDRESS = mmio(Address + 0x00000588, 32, packed struct {
        /// Address used in the TWI transfer
        ADDRESS: u7 = 0,
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

    pub const PSEL = struct {

        /// Pin select for SCL signal
        pub const SCL = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for SDA signal
        pub const SDA = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };

    pub const RXD = struct {

        /// Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in receive buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in receive buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last transaction. In case of NACK error,
            /// includes the NACK'ed byte.
            AMOUNT: u8 = 0,
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

        /// EasyDMA list type
        pub const LIST = mmio(Address + 0x0000000c, 32, packed struct {
            /// List type
            LIST: u3 = 0,
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

    pub const TXD = struct {

        /// Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in transmit buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in transmit buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last transaction. In case of NACK error,
            /// includes the NACK'ed byte.
            AMOUNT: u8 = 0,
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

        /// EasyDMA list type
        pub const LIST = mmio(Address + 0x0000000c, 32, packed struct {
            /// List type
            LIST: u3 = 0,
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
};

/// I2C compatible Two-Wire Slave Interface with EasyDMA 0
pub const TWIS0 = extern struct {
    pub const Address: u32 = 0x40003000;

    /// Stop TWI transaction
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend TWI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume TWI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// Prepare the TWI slave to respond to a write command
    pub const TASKS_PREPARERX = @intToPtr(*volatile u32, Address + 0x00000030);

    /// Prepare the TWI slave to respond to a read command
    pub const TASKS_PREPARETX = @intToPtr(*volatile u32, Address + 0x00000034);

    /// TWI stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// TWI error
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// Receive sequence started
    pub const EVENTS_RXSTARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// Transmit sequence started
    pub const EVENTS_TXSTARTED = @intToPtr(*volatile u32, Address + 0x00000150);

    /// Write command received
    pub const EVENTS_WRITE = @intToPtr(*volatile u32, Address + 0x00000164);

    /// Read command received
    pub const EVENTS_READ = @intToPtr(*volatile u32, Address + 0x00000168);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
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
        /// Shortcut between WRITE event and SUSPEND task
        WRITE_SUSPEND: u1 = 0,
        /// Shortcut between READ event and SUSPEND task
        READ_SUSPEND: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Enable or disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Enable or disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Enable or disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        /// Enable or disable interrupt for WRITE event
        WRITE: u1 = 0,
        /// Enable or disable interrupt for READ event
        READ: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Enable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Enable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        /// Write '1' to Enable interrupt for WRITE event
        WRITE: u1 = 0,
        /// Write '1' to Enable interrupt for READ event
        READ: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        /// Write '1' to Disable interrupt for WRITE event
        WRITE: u1 = 0,
        /// Write '1' to Disable interrupt for READ event
        READ: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x000004d0, 32, packed struct {
        /// RX buffer overflow detected, and prevented
        OVERFLOW: u1 = 0,
        reserved1: u1 = 0,
        /// NACK sent after receiving a data byte
        DNACK: u1 = 0,
        /// TX buffer over-read detected, and prevented
        OVERREAD: u1 = 0,
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

    /// Status register indicating which address had a match
    pub const MATCH = mmio(Address + 0x000004d4, 32, packed struct {
        /// Which of the addresses in {ADDRESS} matched the incoming address
        MATCH: u1 = 0,
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

    /// Enable TWIS
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable TWIS
        ENABLE: u4 = 0,
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

    /// Configuration register for the address match mechanism
    pub const CONFIG = mmio(Address + 0x00000594, 32, packed struct {
        /// Enable or disable address matching on ADDRESS[0]
        ADDRESS0: u1 = 0,
        /// Enable or disable address matching on ADDRESS[1]
        ADDRESS1: u1 = 0,
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

    /// Over-read character. Character sent out in case of an over-read of the
    /// transmit buffer.
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character sent out in case of an over-read of the
        /// transmit buffer.
        ORC: u8 = 0,
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
    /// Description collection[0]: TWI slave address 0
    pub const ADDRESS = @intToPtr(*volatile [2]MMIO(32, packed struct {
        /// TWI slave address
        ADDRESS: u7 = 0,
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
    }), Address + 0x00000588);

    pub const PSEL = struct {

        /// Pin select for SCL signal
        pub const SCL = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for SDA signal
        pub const SDA = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };

    pub const RXD = struct {

        /// RXD Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in RXD buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in RXD buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last RXD transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last RXD transaction
            AMOUNT: u8 = 0,
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

    pub const TXD = struct {

        /// TXD Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of bytes in TXD buffer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of bytes in TXD buffer
            MAXCNT: u8 = 0,
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

        /// Number of bytes transferred in the last TXD transaction
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of bytes transferred in the last TXD transaction
            AMOUNT: u8 = 0,
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
};

/// Serial Peripheral Interface 0
pub const SPI0 = extern struct {
    pub const Address: u32 = 0x40003000;

    /// TXD byte sent and RXD byte received
    pub const EVENTS_READY = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for READY event
        READY: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for READY event
        READY: u1 = 0,
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

    /// Enable SPI
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPI
        ENABLE: u4 = 0,
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

    /// RXD register
    pub const RXD = mmio(Address + 0x00000518, 32, packed struct {
        /// RX data received. Double buffered
        RXD: u8 = 0,
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

    /// TXD register
    pub const TXD = mmio(Address + 0x0000051c, 32, packed struct {
        /// TX data to send. Double buffered
        TXD: u8 = 0,
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

    /// SPI frequency
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

    pub const PSEL = struct {

        /// Pin select for SCK
        pub const SCK = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number configuration for SPI SCK signal
            PSELSCK: u32 = 0,
        });

        /// Pin select for MOSI
        pub const MOSI = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number configuration for SPI MOSI signal
            PSELMOSI: u32 = 0,
        });

        /// Pin select for MISO
        pub const MISO = mmio(Address + 0x00000008, 32, packed struct {
            /// Pin number configuration for SPI MISO signal
            PSELMISO: u32 = 0,
        });
    };
};

/// I2C compatible Two-Wire Interface 0
pub const TWI0 = extern struct {
    pub const Address: u32 = 0x40003000;

    /// Start TWI receive sequence
    pub const TASKS_STARTRX = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Start TWI transmit sequence
    pub const TASKS_STARTTX = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop TWI transaction
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend TWI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume TWI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// TWI stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// TWI RXD byte received
    pub const EVENTS_RXDREADY = @intToPtr(*volatile u32, Address + 0x00000108);

    /// TWI TXD byte sent
    pub const EVENTS_TXDSENT = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// TWI error
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// TWI byte boundary, generated before each byte that is sent or received
    pub const EVENTS_BB = @intToPtr(*volatile u32, Address + 0x00000138);

    /// TWI entered the suspended state
    pub const EVENTS_SUSPENDED = @intToPtr(*volatile u32, Address + 0x00000148);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between BB event and SUSPEND task
        BB_SUSPEND: u1 = 0,
        /// Shortcut between BB event and STOP task
        BB_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Enable interrupt for RXDREADY event
        RXDREADY: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for TXDSENT event
        TXDSENT: u1 = 0,
        reserved6: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// Write '1' to Enable interrupt for BB event
        BB: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        /// Write '1' to Enable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Disable interrupt for RXDREADY event
        RXDREADY: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for TXDSENT event
        TXDSENT: u1 = 0,
        reserved6: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// Write '1' to Disable interrupt for BB event
        BB: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        /// Write '1' to Disable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x000004c4, 32, packed struct {
        /// Overrun error
        OVERRUN: u1 = 0,
        /// NACK received after sending the address (write '1' to clear)
        ANACK: u1 = 0,
        /// NACK received after sending a data byte (write '1' to clear)
        DNACK: u1 = 0,
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

    /// Enable TWI
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable TWI
        ENABLE: u4 = 0,
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

    /// Pin select for SCL
    pub const PSELSCL = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Pin select for SDA
    pub const PSELSDA = @intToPtr(*volatile u32, Address + 0x0000050c);

    /// RXD register
    pub const RXD = mmio(Address + 0x00000518, 32, packed struct {
        /// RXD register
        RXD: u8 = 0,
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

    /// TXD register
    pub const TXD = mmio(Address + 0x0000051c, 32, packed struct {
        /// TXD register
        TXD: u8 = 0,
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

    /// TWI frequency
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Address used in the TWI transfer
    pub const ADDRESS = mmio(Address + 0x00000588, 32, packed struct {
        /// Address used in the TWI transfer
        ADDRESS: u7 = 0,
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

/// Serial Peripheral Interface Master with EasyDMA 1
pub const SPIM1 = extern struct {
    pub const Address: u32 = 0x40004000;

    /// Start SPI transaction
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Stop SPI transaction
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend SPI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume SPI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// SPI transaction has stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// End of RXD buffer reached
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x00000110);

    /// End of RXD buffer and TXD buffer reached
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000118);

    /// End of TXD buffer reached
    pub const EVENTS_ENDTX = @intToPtr(*volatile u32, Address + 0x00000120);

    /// Transaction started
    pub const EVENTS_STARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
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
        /// Shortcut between END event and START task
        END_START: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Enable interrupt for ENDTX event
        ENDTX: u1 = 0,
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
        /// Write '1' to Enable interrupt for STARTED event
        STARTED: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Disable interrupt for ENDTX event
        ENDTX: u1 = 0,
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
        /// Write '1' to Disable interrupt for STARTED event
        STARTED: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable SPIM
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPIM
        ENABLE: u4 = 0,
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

    /// SPI frequency. Accuracy depends on the HFCLK source selected.
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

    /// Over-read character. Character clocked out in case and over-read of the TXD
    /// buffer.
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character clocked out in case and over-read of the TXD
        /// buffer.
        ORC: u8 = 0,
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

/// SPI Slave 1
pub const SPIS1 = extern struct {
    pub const Address: u32 = 0x40004000;

    /// Acquire SPI semaphore
    pub const TASKS_ACQUIRE = @intToPtr(*volatile u32, Address + 0x00000024);

    /// Release SPI semaphore, enabling the SPI slave to acquire it
    pub const TASKS_RELEASE = @intToPtr(*volatile u32, Address + 0x00000028);

    /// Granted transaction completed
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000104);

    /// End of RXD buffer reached
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x00000110);

    /// Semaphore acquired
    pub const EVENTS_ACQUIRED = @intToPtr(*volatile u32, Address + 0x00000128);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between END event and ACQUIRE task
        END_ACQUIRE: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for ACQUIRED event
        ACQUIRED: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for ACQUIRED event
        ACQUIRED: u1 = 0,
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

    /// Semaphore status register
    pub const SEMSTAT = mmio(Address + 0x00000400, 32, packed struct {
        /// Semaphore status
        SEMSTAT: u2 = 0,
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

    /// Status from last transaction
    pub const STATUS = mmio(Address + 0x00000440, 32, packed struct {
        /// TX buffer over-read detected, and prevented
        OVERREAD: u1 = 0,
        /// RX buffer overflow detected, and prevented
        OVERFLOW: u1 = 0,
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

    /// Enable SPI slave
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPI slave
        ENABLE: u4 = 0,
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

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

    /// Default character. Character clocked out in case of an ignored transaction.
    pub const DEF = mmio(Address + 0x0000055c, 32, packed struct {
        /// Default character. Character clocked out in case of an ignored transaction.
        DEF: u8 = 0,
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

    /// Over-read character
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character clocked out after an over-read of the
        /// transmit buffer.
        ORC: u8 = 0,
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

/// I2C compatible Two-Wire Master Interface with EasyDMA 1
pub const TWIM1 = extern struct {
    pub const Address: u32 = 0x40004000;

    /// Start TWI receive sequence
    pub const TASKS_STARTRX = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Start TWI transmit sequence
    pub const TASKS_STARTTX = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop TWI transaction. Must be issued while the TWI master is not suspended.
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend TWI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume TWI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// TWI stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// TWI error
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// Last byte has been sent out after the SUSPEND task has been issued, TWI
    /// traffic is now suspended.
    pub const EVENTS_SUSPENDED = @intToPtr(*volatile u32, Address + 0x00000148);

    /// Receive sequence started
    pub const EVENTS_RXSTARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// Transmit sequence started
    pub const EVENTS_TXSTARTED = @intToPtr(*volatile u32, Address + 0x00000150);

    /// Byte boundary, starting to receive the last byte
    pub const EVENTS_LASTRX = @intToPtr(*volatile u32, Address + 0x0000015c);

    /// Byte boundary, starting to transmit the last byte
    pub const EVENTS_LASTTX = @intToPtr(*volatile u32, Address + 0x00000160);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between LASTTX event and STARTRX task
        LASTTX_STARTRX: u1 = 0,
        /// Shortcut between LASTTX event and SUSPEND task
        LASTTX_SUSPEND: u1 = 0,
        /// Shortcut between LASTTX event and STOP task
        LASTTX_STOP: u1 = 0,
        /// Shortcut between LASTRX event and STARTTX task
        LASTRX_STARTTX: u1 = 0,
        reserved8: u1 = 0,
        /// Shortcut between LASTRX event and STOP task
        LASTRX_STOP: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Enable or disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Enable or disable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        /// Enable or disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Enable or disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        /// Enable or disable interrupt for LASTRX event
        LASTRX: u1 = 0,
        /// Enable or disable interrupt for LASTTX event
        LASTTX: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Enable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        /// Write '1' to Enable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Enable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        /// Write '1' to Enable interrupt for LASTRX event
        LASTRX: u1 = 0,
        /// Write '1' to Enable interrupt for LASTTX event
        LASTTX: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Disable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        /// Write '1' to Disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        /// Write '1' to Disable interrupt for LASTRX event
        LASTRX: u1 = 0,
        /// Write '1' to Disable interrupt for LASTTX event
        LASTTX: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x000004c4, 32, packed struct {
        /// Overrun error
        OVERRUN: u1 = 0,
        /// NACK received after sending the address (write '1' to clear)
        ANACK: u1 = 0,
        /// NACK received after sending a data byte (write '1' to clear)
        DNACK: u1 = 0,
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

    /// Enable TWIM
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable TWIM
        ENABLE: u4 = 0,
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

    /// TWI frequency
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Address used in the TWI transfer
    pub const ADDRESS = mmio(Address + 0x00000588, 32, packed struct {
        /// Address used in the TWI transfer
        ADDRESS: u7 = 0,
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

/// I2C compatible Two-Wire Slave Interface with EasyDMA 1
pub const TWIS1 = extern struct {
    pub const Address: u32 = 0x40004000;

    /// Stop TWI transaction
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend TWI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume TWI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// Prepare the TWI slave to respond to a write command
    pub const TASKS_PREPARERX = @intToPtr(*volatile u32, Address + 0x00000030);

    /// Prepare the TWI slave to respond to a read command
    pub const TASKS_PREPARETX = @intToPtr(*volatile u32, Address + 0x00000034);

    /// TWI stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// TWI error
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// Receive sequence started
    pub const EVENTS_RXSTARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// Transmit sequence started
    pub const EVENTS_TXSTARTED = @intToPtr(*volatile u32, Address + 0x00000150);

    /// Write command received
    pub const EVENTS_WRITE = @intToPtr(*volatile u32, Address + 0x00000164);

    /// Read command received
    pub const EVENTS_READ = @intToPtr(*volatile u32, Address + 0x00000168);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
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
        /// Shortcut between WRITE event and SUSPEND task
        WRITE_SUSPEND: u1 = 0,
        /// Shortcut between READ event and SUSPEND task
        READ_SUSPEND: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Enable or disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Enable or disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Enable or disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        /// Enable or disable interrupt for WRITE event
        WRITE: u1 = 0,
        /// Enable or disable interrupt for READ event
        READ: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Enable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Enable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        /// Write '1' to Enable interrupt for WRITE event
        WRITE: u1 = 0,
        /// Write '1' to Enable interrupt for READ event
        READ: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Write '1' to Disable interrupt for RXSTARTED event
        RXSTARTED: u1 = 0,
        /// Write '1' to Disable interrupt for TXSTARTED event
        TXSTARTED: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        /// Write '1' to Disable interrupt for WRITE event
        WRITE: u1 = 0,
        /// Write '1' to Disable interrupt for READ event
        READ: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x000004d0, 32, packed struct {
        /// RX buffer overflow detected, and prevented
        OVERFLOW: u1 = 0,
        reserved1: u1 = 0,
        /// NACK sent after receiving a data byte
        DNACK: u1 = 0,
        /// TX buffer over-read detected, and prevented
        OVERREAD: u1 = 0,
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

    /// Status register indicating which address had a match
    pub const MATCH = mmio(Address + 0x000004d4, 32, packed struct {
        /// Which of the addresses in {ADDRESS} matched the incoming address
        MATCH: u1 = 0,
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

    /// Enable TWIS
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable TWIS
        ENABLE: u4 = 0,
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

    /// Configuration register for the address match mechanism
    pub const CONFIG = mmio(Address + 0x00000594, 32, packed struct {
        /// Enable or disable address matching on ADDRESS[0]
        ADDRESS0: u1 = 0,
        /// Enable or disable address matching on ADDRESS[1]
        ADDRESS1: u1 = 0,
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

    /// Over-read character. Character sent out in case of an over-read of the
    /// transmit buffer.
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character sent out in case of an over-read of the
        /// transmit buffer.
        ORC: u8 = 0,
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
    /// Description collection[0]: TWI slave address 0
    pub const ADDRESS = @intToPtr(*volatile [2]MMIO(32, packed struct {
        /// TWI slave address
        ADDRESS: u7 = 0,
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
    }), Address + 0x00000588);
};

/// Serial Peripheral Interface 1
pub const SPI1 = extern struct {
    pub const Address: u32 = 0x40004000;

    /// TXD byte sent and RXD byte received
    pub const EVENTS_READY = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for READY event
        READY: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for READY event
        READY: u1 = 0,
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

    /// Enable SPI
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPI
        ENABLE: u4 = 0,
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

    /// RXD register
    pub const RXD = mmio(Address + 0x00000518, 32, packed struct {
        /// RX data received. Double buffered
        RXD: u8 = 0,
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

    /// TXD register
    pub const TXD = mmio(Address + 0x0000051c, 32, packed struct {
        /// TX data to send. Double buffered
        TXD: u8 = 0,
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

    /// SPI frequency
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

/// I2C compatible Two-Wire Interface 1
pub const TWI1 = extern struct {
    pub const Address: u32 = 0x40004000;

    /// Start TWI receive sequence
    pub const TASKS_STARTRX = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Start TWI transmit sequence
    pub const TASKS_STARTTX = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Stop TWI transaction
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend TWI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume TWI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// TWI stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// TWI RXD byte received
    pub const EVENTS_RXDREADY = @intToPtr(*volatile u32, Address + 0x00000108);

    /// TWI TXD byte sent
    pub const EVENTS_TXDSENT = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// TWI error
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000124);

    /// TWI byte boundary, generated before each byte that is sent or received
    pub const EVENTS_BB = @intToPtr(*volatile u32, Address + 0x00000138);

    /// TWI entered the suspended state
    pub const EVENTS_SUSPENDED = @intToPtr(*volatile u32, Address + 0x00000148);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between BB event and SUSPEND task
        BB_SUSPEND: u1 = 0,
        /// Shortcut between BB event and STOP task
        BB_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Enable interrupt for RXDREADY event
        RXDREADY: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for TXDSENT event
        TXDSENT: u1 = 0,
        reserved6: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// Write '1' to Enable interrupt for BB event
        BB: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        /// Write '1' to Enable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Disable interrupt for RXDREADY event
        RXDREADY: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for TXDSENT event
        TXDSENT: u1 = 0,
        reserved6: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// Write '1' to Disable interrupt for BB event
        BB: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        /// Write '1' to Disable interrupt for SUSPENDED event
        SUSPENDED: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Error source
    pub const ERRORSRC = mmio(Address + 0x000004c4, 32, packed struct {
        /// Overrun error
        OVERRUN: u1 = 0,
        /// NACK received after sending the address (write '1' to clear)
        ANACK: u1 = 0,
        /// NACK received after sending a data byte (write '1' to clear)
        DNACK: u1 = 0,
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

    /// Enable TWI
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable TWI
        ENABLE: u4 = 0,
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

    /// Pin select for SCL
    pub const PSELSCL = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Pin select for SDA
    pub const PSELSDA = @intToPtr(*volatile u32, Address + 0x0000050c);

    /// RXD register
    pub const RXD = mmio(Address + 0x00000518, 32, packed struct {
        /// RXD register
        RXD: u8 = 0,
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

    /// TXD register
    pub const TXD = mmio(Address + 0x0000051c, 32, packed struct {
        /// TXD register
        TXD: u8 = 0,
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

    /// TWI frequency
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Address used in the TWI transfer
    pub const ADDRESS = mmio(Address + 0x00000588, 32, packed struct {
        /// Address used in the TWI transfer
        ADDRESS: u7 = 0,
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

/// NFC-A compatible radio
pub const NFCT = extern struct {
    pub const Address: u32 = 0x40005000;

    /// Activate NFC peripheral for incoming and outgoing frames, change state to
    /// activated
    pub const TASKS_ACTIVATE = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Disable NFC peripheral
    pub const TASKS_DISABLE = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Enable NFC sense field mode, change state to sense mode
    pub const TASKS_SENSE = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Start transmission of a outgoing frame, change state to transmit
    pub const TASKS_STARTTX = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Initializes the EasyDMA for receive.
    pub const TASKS_ENABLERXDATA = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Force state machine to IDLE state
    pub const TASKS_GOIDLE = @intToPtr(*volatile u32, Address + 0x00000024);

    /// Force state machine to SLEEP_A state
    pub const TASKS_GOSLEEP = @intToPtr(*volatile u32, Address + 0x00000028);

    /// The NFC peripheral is ready to receive and send frames
    pub const EVENTS_READY = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Remote NFC field detected
    pub const EVENTS_FIELDDETECTED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Remote NFC field lost
    pub const EVENTS_FIELDLOST = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Marks the start of the first symbol of a transmitted frame
    pub const EVENTS_TXFRAMESTART = @intToPtr(*volatile u32, Address + 0x0000010c);

    /// Marks the end of the last transmitted on-air symbol of a frame
    pub const EVENTS_TXFRAMEEND = @intToPtr(*volatile u32, Address + 0x00000110);

    /// Marks the end of the first symbol of a received frame
    pub const EVENTS_RXFRAMESTART = @intToPtr(*volatile u32, Address + 0x00000114);

    /// Received data have been checked (CRC, parity) and transferred to RAM, and
    /// EasyDMA has ended accessing the RX buffer
    pub const EVENTS_RXFRAMEEND = @intToPtr(*volatile u32, Address + 0x00000118);

    /// NFC error reported. The ERRORSTATUS register contains details on the source
    /// of the error.
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// NFC RX frame error reported. The FRAMESTATUS.RX register contains details on
    /// the source of the error.
    pub const EVENTS_RXERROR = @intToPtr(*volatile u32, Address + 0x00000128);

    /// RX buffer (as defined by PACKETPTR and MAXLEN) in Data RAM full.
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x0000012c);

    /// Transmission of data in RAM has ended, and EasyDMA has ended accessing the
    /// TX buffer
    pub const EVENTS_ENDTX = @intToPtr(*volatile u32, Address + 0x00000130);

    /// Auto collision resolution process has started
    pub const EVENTS_AUTOCOLRESSTARTED = @intToPtr(*volatile u32, Address + 0x00000138);

    /// NFC Auto collision resolution error reported.
    pub const EVENTS_COLLISION = @intToPtr(*volatile u32, Address + 0x00000148);

    /// NFC Auto collision resolution successfully completed
    pub const EVENTS_SELECTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// EasyDMA is ready to receive or send frames.
    pub const EVENTS_STARTED = @intToPtr(*volatile u32, Address + 0x00000150);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between FIELDDETECTED event and ACTIVATE task
        FIELDDETECTED_ACTIVATE: u1 = 0,
        /// Shortcut between FIELDLOST event and SENSE task
        FIELDLOST_SENSE: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for READY event
        READY: u1 = 0,
        /// Enable or disable interrupt for FIELDDETECTED event
        FIELDDETECTED: u1 = 0,
        /// Enable or disable interrupt for FIELDLOST event
        FIELDLOST: u1 = 0,
        /// Enable or disable interrupt for TXFRAMESTART event
        TXFRAMESTART: u1 = 0,
        /// Enable or disable interrupt for TXFRAMEEND event
        TXFRAMEEND: u1 = 0,
        /// Enable or disable interrupt for RXFRAMESTART event
        RXFRAMESTART: u1 = 0,
        /// Enable or disable interrupt for RXFRAMEEND event
        RXFRAMEEND: u1 = 0,
        /// Enable or disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Enable or disable interrupt for RXERROR event
        RXERROR: u1 = 0,
        /// Enable or disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        /// Enable or disable interrupt for ENDTX event
        ENDTX: u1 = 0,
        reserved3: u1 = 0,
        /// Enable or disable interrupt for AUTOCOLRESSTARTED event
        AUTOCOLRESSTARTED: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Enable or disable interrupt for COLLISION event
        COLLISION: u1 = 0,
        /// Enable or disable interrupt for SELECTED event
        SELECTED: u1 = 0,
        /// Enable or disable interrupt for STARTED event
        STARTED: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Enable interrupt for FIELDDETECTED event
        FIELDDETECTED: u1 = 0,
        /// Write '1' to Enable interrupt for FIELDLOST event
        FIELDLOST: u1 = 0,
        /// Write '1' to Enable interrupt for TXFRAMESTART event
        TXFRAMESTART: u1 = 0,
        /// Write '1' to Enable interrupt for TXFRAMEEND event
        TXFRAMEEND: u1 = 0,
        /// Write '1' to Enable interrupt for RXFRAMESTART event
        RXFRAMESTART: u1 = 0,
        /// Write '1' to Enable interrupt for RXFRAMEEND event
        RXFRAMEEND: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for RXERROR event
        RXERROR: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        /// Write '1' to Enable interrupt for ENDTX event
        ENDTX: u1 = 0,
        reserved3: u1 = 0,
        /// Write '1' to Enable interrupt for AUTOCOLRESSTARTED event
        AUTOCOLRESSTARTED: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for COLLISION event
        COLLISION: u1 = 0,
        /// Write '1' to Enable interrupt for SELECTED event
        SELECTED: u1 = 0,
        /// Write '1' to Enable interrupt for STARTED event
        STARTED: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Disable interrupt for FIELDDETECTED event
        FIELDDETECTED: u1 = 0,
        /// Write '1' to Disable interrupt for FIELDLOST event
        FIELDLOST: u1 = 0,
        /// Write '1' to Disable interrupt for TXFRAMESTART event
        TXFRAMESTART: u1 = 0,
        /// Write '1' to Disable interrupt for TXFRAMEEND event
        TXFRAMEEND: u1 = 0,
        /// Write '1' to Disable interrupt for RXFRAMESTART event
        RXFRAMESTART: u1 = 0,
        /// Write '1' to Disable interrupt for RXFRAMEEND event
        RXFRAMEEND: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for RXERROR event
        RXERROR: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        /// Write '1' to Disable interrupt for ENDTX event
        ENDTX: u1 = 0,
        reserved3: u1 = 0,
        /// Write '1' to Disable interrupt for AUTOCOLRESSTARTED event
        AUTOCOLRESSTARTED: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for COLLISION event
        COLLISION: u1 = 0,
        /// Write '1' to Disable interrupt for SELECTED event
        SELECTED: u1 = 0,
        /// Write '1' to Disable interrupt for STARTED event
        STARTED: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// NFC Error Status register
    pub const ERRORSTATUS = mmio(Address + 0x00000404, 32, packed struct {
        /// No STARTTX task triggered before expiration of the time set in FRAMEDELAYMAX
        FRAMEDELAYTIMEOUT: u1 = 0,
        reserved1: u1 = 0,
        /// Field level is too high at max load resistance
        NFCFIELDTOOSTRONG: u1 = 0,
        /// Field level is too low at min load resistance
        NFCFIELDTOOWEAK: u1 = 0,
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

    /// Current value driven to the NFC Load Control
    pub const CURRENTLOADCTRL = mmio(Address + 0x00000430, 32, packed struct {
        /// Current value driven to the NFC Load Control
        CURRENTLOADCTRL: u6 = 0,
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

    /// Indicates the presence or not of a valid field
    pub const FIELDPRESENT = mmio(Address + 0x0000043c, 32, packed struct {
        /// Indicates the presence or not of a valid field. Available only in the
        /// activated state.
        FIELDPRESENT: u1 = 0,
        /// Indicates if the low level has locked to the field
        LOCKDETECT: u1 = 0,
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

    /// Minimum frame delay
    pub const FRAMEDELAYMIN = mmio(Address + 0x00000504, 32, packed struct {
        /// Minimum frame delay in number of 13.56 MHz clocks
        FRAMEDELAYMIN: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Maximum frame delay
    pub const FRAMEDELAYMAX = mmio(Address + 0x00000508, 32, packed struct {
        /// Maximum frame delay in number of 13.56 MHz clocks
        FRAMEDELAYMAX: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Configuration register for the Frame Delay Timer
    pub const FRAMEDELAYMODE = mmio(Address + 0x0000050c, 32, packed struct {
        /// Configuration register for the Frame Delay Timer
        FRAMEDELAYMODE: u2 = 0,
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

    /// Packet pointer for TXD and RXD data storage in Data RAM
    pub const PACKETPTR = mmio(Address + 0x00000510, 32, packed struct {
        /// Packet pointer for TXD and RXD data storage in Data RAM. This address is a
        /// byte aligned RAM address.
        PTR: u32 = 0,
    });

    /// Size of allocated for TXD and RXD data storage buffer in Data RAM
    pub const MAXLEN = mmio(Address + 0x00000514, 32, packed struct {
        /// Size of allocated for TXD and RXD data storage buffer in Data RAM
        MAXLEN: u9 = 0,
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

    /// Last NFCID1 part (4, 7 or 10 bytes ID)
    pub const NFCID1_LAST = mmio(Address + 0x00000590, 32, packed struct {
        /// NFCID1 byte Z (very last byte sent)
        NFCID1_Z: u8 = 0,
        /// NFCID1 byte Y
        NFCID1_Y: u8 = 0,
        /// NFCID1 byte X
        NFCID1_X: u8 = 0,
        /// NFCID1 byte W
        NFCID1_W: u8 = 0,
    });

    /// Second last NFCID1 part (7 or 10 bytes ID)
    pub const NFCID1_2ND_LAST = mmio(Address + 0x00000594, 32, packed struct {
        /// NFCID1 byte V
        NFCID1_V: u8 = 0,
        /// NFCID1 byte U
        NFCID1_U: u8 = 0,
        /// NFCID1 byte T
        NFCID1_T: u8 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Third last NFCID1 part (10 bytes ID)
    pub const NFCID1_3RD_LAST = mmio(Address + 0x00000598, 32, packed struct {
        /// NFCID1 byte S
        NFCID1_S: u8 = 0,
        /// NFCID1 byte R
        NFCID1_R: u8 = 0,
        /// NFCID1 byte Q
        NFCID1_Q: u8 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// NFC-A SENS_RES auto-response settings
    pub const SENSRES = mmio(Address + 0x000005a0, 32, packed struct {
        /// Bit frame SDD as defined by the b5:b1 of byte 1 in SENS_RES response in the
        /// NFC Forum, NFC Digital Protocol Technical Specification
        BITFRAMESDD: u5 = 0,
        /// Reserved for future use. Shall be 0.
        RFU5: u1 = 0,
        /// NFCID1 size. This value is used by the Auto collision resolution engine.
        NFCIDSIZE: u2 = 0,
        /// Tag platform configuration as defined by the b4:b1 of byte 2 in SENS_RES
        /// response in the NFC Forum, NFC Digital Protocol Technical Specification
        PLATFCONFIG: u4 = 0,
        /// Reserved for future use. Shall be 0.
        RFU74: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// NFC-A SEL_RES auto-response settings
    pub const SELRES = mmio(Address + 0x000005a4, 32, packed struct {
        /// Reserved for future use. Shall be 0.
        RFU10: u2 = 0,
        /// Cascade bit (controlled by hardware, write has no effect)
        CASCADE: u1 = 0,
        /// Reserved for future use. Shall be 0.
        RFU43: u2 = 0,
        /// Protocol as defined by the b7:b6 of SEL_RES response in the NFC Forum, NFC
        /// Digital Protocol Technical Specification
        PROTOCOL: u2 = 0,
        /// Reserved for future use. Shall be 0.
        RFU7: u1 = 0,
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

    pub const FRAMESTATUS = struct {

        /// Result of last incoming frames
        pub const RX = mmio(Address + 0x00000000, 32, packed struct {
            /// No valid End of Frame detected
            CRCERROR: u1 = 0,
            reserved1: u1 = 0,
            /// Parity status of received frame
            PARITYSTATUS: u1 = 0,
            /// Overrun detected
            OVERRUN: u1 = 0,
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

    pub const TXD = struct {

        /// Configuration of outgoing frames
        pub const FRAMECONFIG = mmio(Address + 0x00000000, 32, packed struct {
            /// Adding parity or not in the frame
            PARITY: u1 = 0,
            /// Discarding unused bits in start or at end of a Frame
            DISCARDMODE: u1 = 0,
            /// Adding SoF or not in TX frames
            SOF: u1 = 0,
            reserved1: u1 = 0,
            /// CRC mode for outgoing frames
            CRCMODETX: u1 = 0,
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

        /// Size of outgoing frame
        pub const AMOUNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Number of bits in the last or first byte read from RAM that shall be
            /// included in the frame (excluding parity bit).
            TXDATABITS: u3 = 0,
            /// Number of complete bytes that shall be included in the frame, excluding CRC,
            /// parity and framing
            TXDATABYTES: u9 = 0,
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

    pub const RXD = struct {

        /// Configuration of incoming frames
        pub const FRAMECONFIG = mmio(Address + 0x00000000, 32, packed struct {
            /// Parity expected or not in RX frame
            PARITY: u1 = 0,
            reserved1: u1 = 0,
            /// SoF expected or not in RX frames
            SOF: u1 = 0,
            reserved2: u1 = 0,
            /// CRC mode for incoming frames
            CRCMODERX: u1 = 0,
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

        /// Size of last incoming frame
        pub const AMOUNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Number of bits in the last byte in the frame, if less than 8 (including CRC,
            /// but excluding parity and SoF/EoF framing).
            RXDATABITS: u3 = 0,
            /// Number of complete bytes received in the frame (including CRC, but excluding
            /// parity and SoF/EoF framing)
            RXDATABYTES: u9 = 0,
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
};

/// GPIO Tasks and Events
pub const GPIOTE = extern struct {
    pub const Address: u32 = 0x40006000;

    /// Event generated from multiple input GPIO pins with SENSE mechanism enabled
    pub const EVENTS_PORT = @intToPtr(*volatile u32, Address + 0x0000017c);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for IN[0] event
        IN0: u1 = 0,
        /// Write '1' to Enable interrupt for IN[1] event
        IN1: u1 = 0,
        /// Write '1' to Enable interrupt for IN[2] event
        IN2: u1 = 0,
        /// Write '1' to Enable interrupt for IN[3] event
        IN3: u1 = 0,
        /// Write '1' to Enable interrupt for IN[4] event
        IN4: u1 = 0,
        /// Write '1' to Enable interrupt for IN[5] event
        IN5: u1 = 0,
        /// Write '1' to Enable interrupt for IN[6] event
        IN6: u1 = 0,
        /// Write '1' to Enable interrupt for IN[7] event
        IN7: u1 = 0,
        reserved23: u1 = 0,
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
        /// Write '1' to Enable interrupt for PORT event
        PORT: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for IN[0] event
        IN0: u1 = 0,
        /// Write '1' to Disable interrupt for IN[1] event
        IN1: u1 = 0,
        /// Write '1' to Disable interrupt for IN[2] event
        IN2: u1 = 0,
        /// Write '1' to Disable interrupt for IN[3] event
        IN3: u1 = 0,
        /// Write '1' to Disable interrupt for IN[4] event
        IN4: u1 = 0,
        /// Write '1' to Disable interrupt for IN[5] event
        IN5: u1 = 0,
        /// Write '1' to Disable interrupt for IN[6] event
        IN6: u1 = 0,
        /// Write '1' to Disable interrupt for IN[7] event
        IN7: u1 = 0,
        reserved23: u1 = 0,
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
        /// Write '1' to Disable interrupt for PORT event
        PORT: u1 = 0,
    });
    /// Description collection[0]: Task for writing to pin specified in
    /// CONFIG[0].PSEL. Action on pin is configured in CONFIG[0].POLARITY.
    pub const TASKS_OUT = @intToPtr(*volatile [8]u32, Address + 0x00000000);
    /// Description collection[0]: Task for writing to pin specified in
    /// CONFIG[0].PSEL. Action on pin is to set it high.
    pub const TASKS_SET = @intToPtr(*volatile [8]u32, Address + 0x00000030);
    /// Description collection[0]: Task for writing to pin specified in
    /// CONFIG[0].PSEL. Action on pin is to set it low.
    pub const TASKS_CLR = @intToPtr(*volatile [8]u32, Address + 0x00000060);
    /// Description collection[0]: Event generated from pin specified in
    /// CONFIG[0].PSEL
    pub const EVENTS_IN = @intToPtr(*volatile [8]u32, Address + 0x00000100);
    /// Description collection[0]: Configuration for OUT[n], SET[n] and CLR[n] tasks
    /// and IN[n] event
    pub const CONFIG = @intToPtr(*volatile [8]MMIO(32, packed struct {
        /// Mode
        MODE: u2 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// GPIO number associated with SET[n], CLR[n] and OUT[n] tasks and IN[n] event
        PSEL: u5 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// When In task mode: Operation to be performed on output when OUT[n] task is
        /// triggered. When In event mode: Operation on input that shall trigger IN[n]
        /// event.
        POLARITY: u2 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        /// When in task mode: Initial value of the output when the GPIOTE channel is
        /// configured. When in event mode: No effect.
        OUTINIT: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    }), Address + 0x00000510);
};

/// Analog to Digital Converter
pub const SAADC = extern struct {
    pub const Address: u32 = 0x40007000;

    /// Start the ADC and prepare the result buffer in RAM
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Take one ADC sample, if scan is enabled all channels are sampled
    pub const TASKS_SAMPLE = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Stop the ADC and terminate any on-going conversion
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Starts offset auto-calibration
    pub const TASKS_CALIBRATEOFFSET = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// The ADC has started
    pub const EVENTS_STARTED = @intToPtr(*volatile u32, Address + 0x00000100);

    /// The ADC has filled up the Result buffer
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000104);

    /// A conversion task has been completed. Depending on the mode, multiple
    /// conversions might be needed for a result to be transferred to RAM.
    pub const EVENTS_DONE = @intToPtr(*volatile u32, Address + 0x00000108);

    /// A result is ready to get transferred to RAM.
    pub const EVENTS_RESULTDONE = @intToPtr(*volatile u32, Address + 0x0000010c);

    /// Calibration is complete
    pub const EVENTS_CALIBRATEDONE = @intToPtr(*volatile u32, Address + 0x00000110);

    /// The ADC has stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000114);

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for STARTED event
        STARTED: u1 = 0,
        /// Enable or disable interrupt for END event
        END: u1 = 0,
        /// Enable or disable interrupt for DONE event
        DONE: u1 = 0,
        /// Enable or disable interrupt for RESULTDONE event
        RESULTDONE: u1 = 0,
        /// Enable or disable interrupt for CALIBRATEDONE event
        CALIBRATEDONE: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Enable or disable interrupt for CH[0].LIMITH event
        CH0LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[0].LIMITL event
        CH0LIMITL: u1 = 0,
        /// Enable or disable interrupt for CH[1].LIMITH event
        CH1LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[1].LIMITL event
        CH1LIMITL: u1 = 0,
        /// Enable or disable interrupt for CH[2].LIMITH event
        CH2LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[2].LIMITL event
        CH2LIMITL: u1 = 0,
        /// Enable or disable interrupt for CH[3].LIMITH event
        CH3LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[3].LIMITL event
        CH3LIMITL: u1 = 0,
        /// Enable or disable interrupt for CH[4].LIMITH event
        CH4LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[4].LIMITL event
        CH4LIMITL: u1 = 0,
        /// Enable or disable interrupt for CH[5].LIMITH event
        CH5LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[5].LIMITL event
        CH5LIMITL: u1 = 0,
        /// Enable or disable interrupt for CH[6].LIMITH event
        CH6LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[6].LIMITL event
        CH6LIMITL: u1 = 0,
        /// Enable or disable interrupt for CH[7].LIMITH event
        CH7LIMITH: u1 = 0,
        /// Enable or disable interrupt for CH[7].LIMITL event
        CH7LIMITL: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for STARTED event
        STARTED: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        /// Write '1' to Enable interrupt for DONE event
        DONE: u1 = 0,
        /// Write '1' to Enable interrupt for RESULTDONE event
        RESULTDONE: u1 = 0,
        /// Write '1' to Enable interrupt for CALIBRATEDONE event
        CALIBRATEDONE: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Enable interrupt for CH[0].LIMITH event
        CH0LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[0].LIMITL event
        CH0LIMITL: u1 = 0,
        /// Write '1' to Enable interrupt for CH[1].LIMITH event
        CH1LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[1].LIMITL event
        CH1LIMITL: u1 = 0,
        /// Write '1' to Enable interrupt for CH[2].LIMITH event
        CH2LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[2].LIMITL event
        CH2LIMITL: u1 = 0,
        /// Write '1' to Enable interrupt for CH[3].LIMITH event
        CH3LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[3].LIMITL event
        CH3LIMITL: u1 = 0,
        /// Write '1' to Enable interrupt for CH[4].LIMITH event
        CH4LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[4].LIMITL event
        CH4LIMITL: u1 = 0,
        /// Write '1' to Enable interrupt for CH[5].LIMITH event
        CH5LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[5].LIMITL event
        CH5LIMITL: u1 = 0,
        /// Write '1' to Enable interrupt for CH[6].LIMITH event
        CH6LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[6].LIMITL event
        CH6LIMITL: u1 = 0,
        /// Write '1' to Enable interrupt for CH[7].LIMITH event
        CH7LIMITH: u1 = 0,
        /// Write '1' to Enable interrupt for CH[7].LIMITL event
        CH7LIMITL: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for STARTED event
        STARTED: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        /// Write '1' to Disable interrupt for DONE event
        DONE: u1 = 0,
        /// Write '1' to Disable interrupt for RESULTDONE event
        RESULTDONE: u1 = 0,
        /// Write '1' to Disable interrupt for CALIBRATEDONE event
        CALIBRATEDONE: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Disable interrupt for CH[0].LIMITH event
        CH0LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[0].LIMITL event
        CH0LIMITL: u1 = 0,
        /// Write '1' to Disable interrupt for CH[1].LIMITH event
        CH1LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[1].LIMITL event
        CH1LIMITL: u1 = 0,
        /// Write '1' to Disable interrupt for CH[2].LIMITH event
        CH2LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[2].LIMITL event
        CH2LIMITL: u1 = 0,
        /// Write '1' to Disable interrupt for CH[3].LIMITH event
        CH3LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[3].LIMITL event
        CH3LIMITL: u1 = 0,
        /// Write '1' to Disable interrupt for CH[4].LIMITH event
        CH4LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[4].LIMITL event
        CH4LIMITL: u1 = 0,
        /// Write '1' to Disable interrupt for CH[5].LIMITH event
        CH5LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[5].LIMITL event
        CH5LIMITL: u1 = 0,
        /// Write '1' to Disable interrupt for CH[6].LIMITH event
        CH6LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[6].LIMITL event
        CH6LIMITL: u1 = 0,
        /// Write '1' to Disable interrupt for CH[7].LIMITH event
        CH7LIMITH: u1 = 0,
        /// Write '1' to Disable interrupt for CH[7].LIMITL event
        CH7LIMITL: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Status
    pub const STATUS = mmio(Address + 0x00000400, 32, packed struct {
        /// Status
        STATUS: u1 = 0,
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

    /// Enable or disable ADC
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable ADC
        ENABLE: u1 = 0,
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

    /// Resolution configuration
    pub const RESOLUTION = mmio(Address + 0x000005f0, 32, packed struct {
        /// Set the resolution
        VAL: u3 = 0,
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

    /// Oversampling configuration. OVERSAMPLE should not be combined with SCAN. The
    /// RESOLUTION is applied before averaging, thus for high OVERSAMPLE a higher
    /// RESOLUTION should be used.
    pub const OVERSAMPLE = mmio(Address + 0x000005f4, 32, packed struct {
        /// Oversample control
        OVERSAMPLE: u4 = 0,
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

    /// Controls normal or continuous sample rate
    pub const SAMPLERATE = mmio(Address + 0x000005f8, 32, packed struct {
        /// Capture and compare value. Sample rate is 16 MHz/CC
        CC: u11 = 0,
        reserved1: u1 = 0,
        /// Select mode for sample rate control
        MODE: u1 = 0,
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

    pub const RESULT = struct {

        /// Data pointer
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);

        /// Maximum number of buffer words to transfer
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Maximum number of buffer words to transfer
            MAXCNT: u15 = 0,
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

        /// Number of buffer words transferred since last START
        pub const AMOUNT = mmio(Address + 0x00000008, 32, packed struct {
            /// Number of buffer words transferred since last START. This register can be
            /// read after an END or STOPPED event.
            AMOUNT: u15 = 0,
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
};

/// Timer/Counter 0
pub const TIMER0 = extern struct {
    pub const Address: u32 = 0x40008000;

    /// Start Timer
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop Timer
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Increment Timer (Counter mode only)
    pub const TASKS_COUNT = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Clear time
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Deprecated register - Shut down timer
    pub const TASKS_SHUTDOWN = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between COMPARE[0] event and CLEAR task
        COMPARE0_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[1] event and CLEAR task
        COMPARE1_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[2] event and CLEAR task
        COMPARE2_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[3] event and CLEAR task
        COMPARE3_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[4] event and CLEAR task
        COMPARE4_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[5] event and CLEAR task
        COMPARE5_CLEAR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between COMPARE[0] event and STOP task
        COMPARE0_STOP: u1 = 0,
        /// Shortcut between COMPARE[1] event and STOP task
        COMPARE1_STOP: u1 = 0,
        /// Shortcut between COMPARE[2] event and STOP task
        COMPARE2_STOP: u1 = 0,
        /// Shortcut between COMPARE[3] event and STOP task
        COMPARE3_STOP: u1 = 0,
        /// Shortcut between COMPARE[4] event and STOP task
        COMPARE4_STOP: u1 = 0,
        /// Shortcut between COMPARE[5] event and STOP task
        COMPARE5_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timer mode selection
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Timer mode
        MODE: u2 = 0,
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

    /// Configure the number of bits used by the TIMER
    pub const BITMODE = mmio(Address + 0x00000508, 32, packed struct {
        /// Timer bit width
        BITMODE: u2 = 0,
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

    /// Timer prescaler register
    pub const PRESCALER = mmio(Address + 0x00000510, 32, packed struct {
        /// Prescaler value
        PRESCALER: u4 = 0,
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
    /// Description collection[0]: Capture Timer value to CC[0] register
    pub const TASKS_CAPTURE = @intToPtr(*volatile [6]u32, Address + 0x00000040);
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [6]u32, Address + 0x00000140);
    /// Description collection[0]: Capture/Compare register 0
    pub const CC = @intToPtr(*volatile [6]u32, Address + 0x00000540);
};

/// Timer/Counter 1
pub const TIMER1 = extern struct {
    pub const Address: u32 = 0x40009000;

    /// Start Timer
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop Timer
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Increment Timer (Counter mode only)
    pub const TASKS_COUNT = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Clear time
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Deprecated register - Shut down timer
    pub const TASKS_SHUTDOWN = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between COMPARE[0] event and CLEAR task
        COMPARE0_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[1] event and CLEAR task
        COMPARE1_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[2] event and CLEAR task
        COMPARE2_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[3] event and CLEAR task
        COMPARE3_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[4] event and CLEAR task
        COMPARE4_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[5] event and CLEAR task
        COMPARE5_CLEAR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between COMPARE[0] event and STOP task
        COMPARE0_STOP: u1 = 0,
        /// Shortcut between COMPARE[1] event and STOP task
        COMPARE1_STOP: u1 = 0,
        /// Shortcut between COMPARE[2] event and STOP task
        COMPARE2_STOP: u1 = 0,
        /// Shortcut between COMPARE[3] event and STOP task
        COMPARE3_STOP: u1 = 0,
        /// Shortcut between COMPARE[4] event and STOP task
        COMPARE4_STOP: u1 = 0,
        /// Shortcut between COMPARE[5] event and STOP task
        COMPARE5_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timer mode selection
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Timer mode
        MODE: u2 = 0,
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

    /// Configure the number of bits used by the TIMER
    pub const BITMODE = mmio(Address + 0x00000508, 32, packed struct {
        /// Timer bit width
        BITMODE: u2 = 0,
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

    /// Timer prescaler register
    pub const PRESCALER = mmio(Address + 0x00000510, 32, packed struct {
        /// Prescaler value
        PRESCALER: u4 = 0,
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
    /// Description collection[0]: Capture Timer value to CC[0] register
    pub const TASKS_CAPTURE = @intToPtr(*volatile [6]u32, Address + 0x00000040);
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [6]u32, Address + 0x00000140);
    /// Description collection[0]: Capture/Compare register 0
    pub const CC = @intToPtr(*volatile [6]u32, Address + 0x00000540);
};

/// Timer/Counter 2
pub const TIMER2 = extern struct {
    pub const Address: u32 = 0x4000a000;

    /// Start Timer
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop Timer
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Increment Timer (Counter mode only)
    pub const TASKS_COUNT = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Clear time
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Deprecated register - Shut down timer
    pub const TASKS_SHUTDOWN = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between COMPARE[0] event and CLEAR task
        COMPARE0_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[1] event and CLEAR task
        COMPARE1_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[2] event and CLEAR task
        COMPARE2_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[3] event and CLEAR task
        COMPARE3_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[4] event and CLEAR task
        COMPARE4_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[5] event and CLEAR task
        COMPARE5_CLEAR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between COMPARE[0] event and STOP task
        COMPARE0_STOP: u1 = 0,
        /// Shortcut between COMPARE[1] event and STOP task
        COMPARE1_STOP: u1 = 0,
        /// Shortcut between COMPARE[2] event and STOP task
        COMPARE2_STOP: u1 = 0,
        /// Shortcut between COMPARE[3] event and STOP task
        COMPARE3_STOP: u1 = 0,
        /// Shortcut between COMPARE[4] event and STOP task
        COMPARE4_STOP: u1 = 0,
        /// Shortcut between COMPARE[5] event and STOP task
        COMPARE5_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timer mode selection
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Timer mode
        MODE: u2 = 0,
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

    /// Configure the number of bits used by the TIMER
    pub const BITMODE = mmio(Address + 0x00000508, 32, packed struct {
        /// Timer bit width
        BITMODE: u2 = 0,
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

    /// Timer prescaler register
    pub const PRESCALER = mmio(Address + 0x00000510, 32, packed struct {
        /// Prescaler value
        PRESCALER: u4 = 0,
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
    /// Description collection[0]: Capture Timer value to CC[0] register
    pub const TASKS_CAPTURE = @intToPtr(*volatile [6]u32, Address + 0x00000040);
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [6]u32, Address + 0x00000140);
    /// Description collection[0]: Capture/Compare register 0
    pub const CC = @intToPtr(*volatile [6]u32, Address + 0x00000540);
};

/// Real time counter 0
pub const RTC0 = extern struct {
    pub const Address: u32 = 0x4000b000;

    /// Start RTC COUNTER
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop RTC COUNTER
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Clear RTC COUNTER
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Set COUNTER to 0xFFFFF0
    pub const TASKS_TRIGOVRFLW = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Event on COUNTER increment
    pub const EVENTS_TICK = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Event on COUNTER overflow
    pub const EVENTS_OVRFLW = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TICK event
        TICK: u1 = 0,
        /// Write '1' to Enable interrupt for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TICK event
        TICK: u1 = 0,
        /// Write '1' to Disable interrupt for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable or disable event routing
    pub const EVTEN = mmio(Address + 0x00000340, 32, packed struct {
        /// Enable or disable event routing for TICK event
        TICK: u1 = 0,
        /// Enable or disable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Enable or disable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Enable or disable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Enable or disable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Enable or disable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable event routing
    pub const EVTENSET = mmio(Address + 0x00000344, 32, packed struct {
        /// Write '1' to Enable event routing for TICK event
        TICK: u1 = 0,
        /// Write '1' to Enable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Enable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable event routing
    pub const EVTENCLR = mmio(Address + 0x00000348, 32, packed struct {
        /// Write '1' to Disable event routing for TICK event
        TICK: u1 = 0,
        /// Write '1' to Disable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Disable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Current COUNTER value
    pub const COUNTER = mmio(Address + 0x00000504, 32, packed struct {
        /// Counter value
        COUNTER: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// 12 bit prescaler for COUNTER frequency (32768/(PRESCALER+1)).Must be written
    /// when RTC is stopped
    pub const PRESCALER = mmio(Address + 0x00000508, 32, packed struct {
        /// Prescaler value
        PRESCALER: u12 = 0,
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
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [4]u32, Address + 0x00000140);
    /// Description collection[0]: Compare register 0
    pub const CC = @intToPtr(*volatile [4]MMIO(32, packed struct {
        /// Compare value
        COMPARE: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    }), Address + 0x00000540);
};

/// Temperature Sensor
pub const TEMP = extern struct {
    pub const Address: u32 = 0x4000c000;

    /// Start temperature measurement
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop temperature measurement
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Temperature measurement complete, data ready
    pub const EVENTS_DATARDY = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for DATARDY event
        DATARDY: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for DATARDY event
        DATARDY: u1 = 0,
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

    /// Temperature in degC (0.25deg steps)
    pub const TEMP = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Slope of 1st piece wise linear function
    pub const A0 = mmio(Address + 0x00000520, 32, packed struct {
        /// Slope of 1st piece wise linear function
        A0: u12 = 0,
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

    /// Slope of 2nd piece wise linear function
    pub const A1 = mmio(Address + 0x00000524, 32, packed struct {
        /// Slope of 2nd piece wise linear function
        A1: u12 = 0,
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

    /// Slope of 3rd piece wise linear function
    pub const A2 = mmio(Address + 0x00000528, 32, packed struct {
        /// Slope of 3rd piece wise linear function
        A2: u12 = 0,
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

    /// Slope of 4th piece wise linear function
    pub const A3 = mmio(Address + 0x0000052c, 32, packed struct {
        /// Slope of 4th piece wise linear function
        A3: u12 = 0,
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

    /// Slope of 5th piece wise linear function
    pub const A4 = mmio(Address + 0x00000530, 32, packed struct {
        /// Slope of 5th piece wise linear function
        A4: u12 = 0,
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

    /// Slope of 6th piece wise linear function
    pub const A5 = mmio(Address + 0x00000534, 32, packed struct {
        /// Slope of 6th piece wise linear function
        A5: u12 = 0,
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

    /// y-intercept of 1st piece wise linear function
    pub const B0 = mmio(Address + 0x00000540, 32, packed struct {
        /// y-intercept of 1st piece wise linear function
        B0: u14 = 0,
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

    /// y-intercept of 2nd piece wise linear function
    pub const B1 = mmio(Address + 0x00000544, 32, packed struct {
        /// y-intercept of 2nd piece wise linear function
        B1: u14 = 0,
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

    /// y-intercept of 3rd piece wise linear function
    pub const B2 = mmio(Address + 0x00000548, 32, packed struct {
        /// y-intercept of 3rd piece wise linear function
        B2: u14 = 0,
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

    /// y-intercept of 4th piece wise linear function
    pub const B3 = mmio(Address + 0x0000054c, 32, packed struct {
        /// y-intercept of 4th piece wise linear function
        B3: u14 = 0,
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

    /// y-intercept of 5th piece wise linear function
    pub const B4 = mmio(Address + 0x00000550, 32, packed struct {
        /// y-intercept of 5th piece wise linear function
        B4: u14 = 0,
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

    /// y-intercept of 6th piece wise linear function
    pub const B5 = mmio(Address + 0x00000554, 32, packed struct {
        /// y-intercept of 6th piece wise linear function
        B5: u14 = 0,
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

    /// End point of 1st piece wise linear function
    pub const T0 = mmio(Address + 0x00000560, 32, packed struct {
        /// End point of 1st piece wise linear function
        T0: u8 = 0,
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

    /// End point of 2nd piece wise linear function
    pub const T1 = mmio(Address + 0x00000564, 32, packed struct {
        /// End point of 2nd piece wise linear function
        T1: u8 = 0,
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

    /// End point of 3rd piece wise linear function
    pub const T2 = mmio(Address + 0x00000568, 32, packed struct {
        /// End point of 3rd piece wise linear function
        T2: u8 = 0,
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

    /// End point of 4th piece wise linear function
    pub const T3 = mmio(Address + 0x0000056c, 32, packed struct {
        /// End point of 4th piece wise linear function
        T3: u8 = 0,
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

    /// End point of 5th piece wise linear function
    pub const T4 = mmio(Address + 0x00000570, 32, packed struct {
        /// End point of 5th piece wise linear function
        T4: u8 = 0,
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

/// Random Number Generator
pub const RNG = extern struct {
    pub const Address: u32 = 0x4000d000;

    /// Task starting the random number generator
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Task stopping the random number generator
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Event being generated for every new random number written to the VALUE
    /// register
    pub const EVENTS_VALRDY = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between VALRDY event and STOP task
        VALRDY_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for VALRDY event
        VALRDY: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for VALRDY event
        VALRDY: u1 = 0,
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

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000504, 32, packed struct {
        /// Bias correction
        DERCEN: u1 = 0,
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

    /// Output random number
    pub const VALUE = mmio(Address + 0x00000508, 32, packed struct {
        /// Generated random number
        VALUE: u8 = 0,
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

/// AES ECB Mode Encryption
pub const ECB = extern struct {
    pub const Address: u32 = 0x4000e000;

    /// Start ECB block encrypt
    pub const TASKS_STARTECB = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Abort a possible executing ECB operation
    pub const TASKS_STOPECB = @intToPtr(*volatile u32, Address + 0x00000004);

    /// ECB block encrypt complete
    pub const EVENTS_ENDECB = @intToPtr(*volatile u32, Address + 0x00000100);

    /// ECB block encrypt aborted because of a STOPECB task or due to an error
    pub const EVENTS_ERRORECB = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for ENDECB event
        ENDECB: u1 = 0,
        /// Write '1' to Enable interrupt for ERRORECB event
        ERRORECB: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for ENDECB event
        ENDECB: u1 = 0,
        /// Write '1' to Disable interrupt for ERRORECB event
        ERRORECB: u1 = 0,
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

    /// ECB block encrypt memory pointers
    pub const ECBDATAPTR = @intToPtr(*volatile u32, Address + 0x00000504);
};

/// AES CCM Mode Encryption
pub const CCM = extern struct {
    pub const Address: u32 = 0x4000f000;

    /// Start generation of key-stream. This operation will stop by itself when
    /// completed.
    pub const TASKS_KSGEN = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Start encryption/decryption. This operation will stop by itself when
    /// completed.
    pub const TASKS_CRYPT = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Stop encryption/decryption
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Key-stream generation complete
    pub const EVENTS_ENDKSGEN = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Encrypt/decrypt complete
    pub const EVENTS_ENDCRYPT = @intToPtr(*volatile u32, Address + 0x00000104);

    /// CCM error event
    pub const EVENTS_ERROR = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between ENDKSGEN event and CRYPT task
        ENDKSGEN_CRYPT: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for ENDKSGEN event
        ENDKSGEN: u1 = 0,
        /// Write '1' to Enable interrupt for ENDCRYPT event
        ENDCRYPT: u1 = 0,
        /// Write '1' to Enable interrupt for ERROR event
        ERROR: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for ENDKSGEN event
        ENDKSGEN: u1 = 0,
        /// Write '1' to Disable interrupt for ENDCRYPT event
        ENDCRYPT: u1 = 0,
        /// Write '1' to Disable interrupt for ERROR event
        ERROR: u1 = 0,
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

    /// MIC check result
    pub const MICSTATUS = mmio(Address + 0x00000400, 32, packed struct {
        /// The result of the MIC check performed during the previous decryption
        /// operation
        MICSTATUS: u1 = 0,
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

    /// Enable
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable CCM
        ENABLE: u2 = 0,
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

    /// Operation mode
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// The mode of operation to be used
        MODE: u1 = 0,
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
        /// Data rate that the CCM shall run in synch with
        DATARATE: u1 = 0,
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        /// Packet length configuration
        LENGTH: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Pointer to data structure holding AES key and NONCE vector
    pub const CNFPTR = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Input pointer
    pub const INPTR = @intToPtr(*volatile u32, Address + 0x0000050c);

    /// Output pointer
    pub const OUTPTR = @intToPtr(*volatile u32, Address + 0x00000510);

    /// Pointer to data area used for temporary storage
    pub const SCRATCHPTR = @intToPtr(*volatile u32, Address + 0x00000514);
};

/// Accelerated Address Resolver
pub const AAR = extern struct {
    pub const Address: u32 = 0x4000f000;

    /// Start resolving addresses based on IRKs specified in the IRK data structure
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop resolving addresses
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Address resolution procedure complete
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Address resolved
    pub const EVENTS_RESOLVED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Address not resolved
    pub const EVENTS_NOTRESOLVED = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        /// Write '1' to Enable interrupt for RESOLVED event
        RESOLVED: u1 = 0,
        /// Write '1' to Enable interrupt for NOTRESOLVED event
        NOTRESOLVED: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        /// Write '1' to Disable interrupt for RESOLVED event
        RESOLVED: u1 = 0,
        /// Write '1' to Disable interrupt for NOTRESOLVED event
        NOTRESOLVED: u1 = 0,
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

    /// Resolution status
    pub const STATUS = mmio(Address + 0x00000400, 32, packed struct {
        /// The IRK that was used last time an address was resolved
        STATUS: u4 = 0,
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

    /// Enable AAR
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable AAR
        ENABLE: u2 = 0,
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

    /// Number of IRKs
    pub const NIRK = mmio(Address + 0x00000504, 32, packed struct {
        /// Number of Identity root keys available in the IRK data structure
        NIRK: u5 = 0,
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

    /// Pointer to IRK data structure
    pub const IRKPTR = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Pointer to the resolvable address
    pub const ADDRPTR = @intToPtr(*volatile u32, Address + 0x00000510);

    /// Pointer to data area used for temporary storage
    pub const SCRATCHPTR = @intToPtr(*volatile u32, Address + 0x00000514);
};

/// Watchdog Timer
pub const WDT = extern struct {
    pub const Address: u32 = 0x40010000;

    /// Start the watchdog
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Watchdog timeout
    pub const EVENTS_TIMEOUT = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TIMEOUT event
        TIMEOUT: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TIMEOUT event
        TIMEOUT: u1 = 0,
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

    /// Run status
    pub const RUNSTATUS = mmio(Address + 0x00000400, 32, packed struct {
        /// Indicates whether or not the watchdog is running
        RUNSTATUS: u1 = 0,
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

    /// Request status
    pub const REQSTATUS = mmio(Address + 0x00000404, 32, packed struct {
        /// Request status for RR[0] register
        RR0: u1 = 0,
        /// Request status for RR[1] register
        RR1: u1 = 0,
        /// Request status for RR[2] register
        RR2: u1 = 0,
        /// Request status for RR[3] register
        RR3: u1 = 0,
        /// Request status for RR[4] register
        RR4: u1 = 0,
        /// Request status for RR[5] register
        RR5: u1 = 0,
        /// Request status for RR[6] register
        RR6: u1 = 0,
        /// Request status for RR[7] register
        RR7: u1 = 0,
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

    /// Counter reload value
    pub const CRV = @intToPtr(*volatile u32, Address + 0x00000504);

    /// Enable register for reload request registers
    pub const RREN = mmio(Address + 0x00000508, 32, packed struct {
        /// Enable or disable RR[0] register
        RR0: u1 = 0,
        /// Enable or disable RR[1] register
        RR1: u1 = 0,
        /// Enable or disable RR[2] register
        RR2: u1 = 0,
        /// Enable or disable RR[3] register
        RR3: u1 = 0,
        /// Enable or disable RR[4] register
        RR4: u1 = 0,
        /// Enable or disable RR[5] register
        RR5: u1 = 0,
        /// Enable or disable RR[6] register
        RR6: u1 = 0,
        /// Enable or disable RR[7] register
        RR7: u1 = 0,
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

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x0000050c, 32, packed struct {
        /// Configure the watchdog to either be paused, or kept running, while the CPU
        /// is sleeping
        SLEEP: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Configure the watchdog to either be paused, or kept running, while the CPU
        /// is halted by the debugger
        HALT: u1 = 0,
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
    /// Description collection[0]: Reload request 0
    pub const RR = @intToPtr(*volatile [8]u32, Address + 0x00000600);
};

/// Real time counter 1
pub const RTC1 = extern struct {
    pub const Address: u32 = 0x40011000;

    /// Start RTC COUNTER
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop RTC COUNTER
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Clear RTC COUNTER
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Set COUNTER to 0xFFFFF0
    pub const TASKS_TRIGOVRFLW = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Event on COUNTER increment
    pub const EVENTS_TICK = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Event on COUNTER overflow
    pub const EVENTS_OVRFLW = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TICK event
        TICK: u1 = 0,
        /// Write '1' to Enable interrupt for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TICK event
        TICK: u1 = 0,
        /// Write '1' to Disable interrupt for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable or disable event routing
    pub const EVTEN = mmio(Address + 0x00000340, 32, packed struct {
        /// Enable or disable event routing for TICK event
        TICK: u1 = 0,
        /// Enable or disable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Enable or disable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Enable or disable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Enable or disable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Enable or disable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable event routing
    pub const EVTENSET = mmio(Address + 0x00000344, 32, packed struct {
        /// Write '1' to Enable event routing for TICK event
        TICK: u1 = 0,
        /// Write '1' to Enable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Enable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable event routing
    pub const EVTENCLR = mmio(Address + 0x00000348, 32, packed struct {
        /// Write '1' to Disable event routing for TICK event
        TICK: u1 = 0,
        /// Write '1' to Disable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Disable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Current COUNTER value
    pub const COUNTER = mmio(Address + 0x00000504, 32, packed struct {
        /// Counter value
        COUNTER: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// 12 bit prescaler for COUNTER frequency (32768/(PRESCALER+1)).Must be written
    /// when RTC is stopped
    pub const PRESCALER = mmio(Address + 0x00000508, 32, packed struct {
        /// Prescaler value
        PRESCALER: u12 = 0,
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
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [4]u32, Address + 0x00000140);
    /// Description collection[0]: Compare register 0
    pub const CC = @intToPtr(*volatile [4]MMIO(32, packed struct {
        /// Compare value
        COMPARE: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    }), Address + 0x00000540);
};

/// Quadrature Decoder
pub const QDEC = extern struct {
    pub const Address: u32 = 0x40012000;

    /// Task starting the quadrature decoder
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Task stopping the quadrature decoder
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Read and clear ACC and ACCDBL
    pub const TASKS_READCLRACC = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Read and clear ACC
    pub const TASKS_RDCLRACC = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Read and clear ACCDBL
    pub const TASKS_RDCLRDBL = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Event being generated for every new sample value written to the SAMPLE
    /// register
    pub const EVENTS_SAMPLERDY = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Non-null report ready
    pub const EVENTS_REPORTRDY = @intToPtr(*volatile u32, Address + 0x00000104);

    /// ACC or ACCDBL register overflow
    pub const EVENTS_ACCOF = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Double displacement(s) detected
    pub const EVENTS_DBLRDY = @intToPtr(*volatile u32, Address + 0x0000010c);

    /// QDEC has been stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000110);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between REPORTRDY event and READCLRACC task
        REPORTRDY_READCLRACC: u1 = 0,
        /// Shortcut between SAMPLERDY event and STOP task
        SAMPLERDY_STOP: u1 = 0,
        /// Shortcut between REPORTRDY event and RDCLRACC task
        REPORTRDY_RDCLRACC: u1 = 0,
        /// Shortcut between REPORTRDY event and STOP task
        REPORTRDY_STOP: u1 = 0,
        /// Shortcut between DBLRDY event and RDCLRDBL task
        DBLRDY_RDCLRDBL: u1 = 0,
        /// Shortcut between DBLRDY event and STOP task
        DBLRDY_STOP: u1 = 0,
        /// Shortcut between SAMPLERDY event and READCLRACC task
        SAMPLERDY_READCLRACC: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for SAMPLERDY event
        SAMPLERDY: u1 = 0,
        /// Write '1' to Enable interrupt for REPORTRDY event
        REPORTRDY: u1 = 0,
        /// Write '1' to Enable interrupt for ACCOF event
        ACCOF: u1 = 0,
        /// Write '1' to Enable interrupt for DBLRDY event
        DBLRDY: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for SAMPLERDY event
        SAMPLERDY: u1 = 0,
        /// Write '1' to Disable interrupt for REPORTRDY event
        REPORTRDY: u1 = 0,
        /// Write '1' to Disable interrupt for ACCOF event
        ACCOF: u1 = 0,
        /// Write '1' to Disable interrupt for DBLRDY event
        DBLRDY: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
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

    /// Enable the quadrature decoder
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable the quadrature decoder
        ENABLE: u1 = 0,
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

    /// LED output pin polarity
    pub const LEDPOL = mmio(Address + 0x00000504, 32, packed struct {
        /// LED output pin polarity
        LEDPOL: u1 = 0,
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

    /// Sample period
    pub const SAMPLEPER = mmio(Address + 0x00000508, 32, packed struct {
        /// Sample period. The SAMPLE register will be updated for every new sample
        SAMPLEPER: u4 = 0,
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

    /// Motion sample value
    pub const SAMPLE = @intToPtr(*volatile u32, Address + 0x0000050c);

    /// Number of samples to be taken before REPORTRDY and DBLRDY events can be
    /// generated
    pub const REPORTPER = mmio(Address + 0x00000510, 32, packed struct {
        /// Specifies the number of samples to be accumulated in the ACC register before
        /// the REPORTRDY and DBLRDY events can be generated
        REPORTPER: u4 = 0,
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

    /// Register accumulating the valid transitions
    pub const ACC = @intToPtr(*volatile u32, Address + 0x00000514);

    /// Snapshot of the ACC register, updated by the READCLRACC or RDCLRACC task
    pub const ACCREAD = @intToPtr(*volatile u32, Address + 0x00000518);

    /// Enable input debounce filters
    pub const DBFEN = mmio(Address + 0x00000528, 32, packed struct {
        /// Enable input debounce filters
        DBFEN: u1 = 0,
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

    /// Time period the LED is switched ON prior to sampling
    pub const LEDPRE = mmio(Address + 0x00000540, 32, packed struct {
        /// Period in us the LED is switched on prior to sampling
        LEDPRE: u9 = 0,
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

    /// Register accumulating the number of detected double transitions
    pub const ACCDBL = mmio(Address + 0x00000544, 32, packed struct {
        /// Register accumulating the number of detected double or illegal transitions.
        /// ( SAMPLE = 2 ).
        ACCDBL: u4 = 0,
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

    /// Snapshot of the ACCDBL, updated by the READCLRACC or RDCLRDBL task
    pub const ACCDBLREAD = mmio(Address + 0x00000548, 32, packed struct {
        /// Snapshot of the ACCDBL register. This field is updated when the READCLRACC
        /// or RDCLRDBL task is triggered.
        ACCDBLREAD: u4 = 0,
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

    pub const PSEL = struct {

        /// Pin select for LED signal
        pub const LED = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for A signal
        pub const A = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for B signal
        pub const B = mmio(Address + 0x00000008, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };
};

/// Comparator
pub const COMP = extern struct {
    pub const Address: u32 = 0x40013000;

    /// Start comparator
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop comparator
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Sample comparator value
    pub const TASKS_SAMPLE = @intToPtr(*volatile u32, Address + 0x00000008);

    /// COMP is ready and output is valid
    pub const EVENTS_READY = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Downward crossing
    pub const EVENTS_DOWN = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Upward crossing
    pub const EVENTS_UP = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Downward or upward crossing
    pub const EVENTS_CROSS = @intToPtr(*volatile u32, Address + 0x0000010c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between READY event and SAMPLE task
        READY_SAMPLE: u1 = 0,
        /// Shortcut between READY event and STOP task
        READY_STOP: u1 = 0,
        /// Shortcut between DOWN event and STOP task
        DOWN_STOP: u1 = 0,
        /// Shortcut between UP event and STOP task
        UP_STOP: u1 = 0,
        /// Shortcut between CROSS event and STOP task
        CROSS_STOP: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for READY event
        READY: u1 = 0,
        /// Enable or disable interrupt for DOWN event
        DOWN: u1 = 0,
        /// Enable or disable interrupt for UP event
        UP: u1 = 0,
        /// Enable or disable interrupt for CROSS event
        CROSS: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Enable interrupt for DOWN event
        DOWN: u1 = 0,
        /// Write '1' to Enable interrupt for UP event
        UP: u1 = 0,
        /// Write '1' to Enable interrupt for CROSS event
        CROSS: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Disable interrupt for DOWN event
        DOWN: u1 = 0,
        /// Write '1' to Disable interrupt for UP event
        UP: u1 = 0,
        /// Write '1' to Disable interrupt for CROSS event
        CROSS: u1 = 0,
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

    /// Compare result
    pub const RESULT = mmio(Address + 0x00000400, 32, packed struct {
        /// Result of last compare. Decision point SAMPLE task.
        RESULT: u1 = 0,
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

    /// COMP enable
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable COMP
        ENABLE: u2 = 0,
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

    /// Pin select
    pub const PSEL = mmio(Address + 0x00000504, 32, packed struct {
        /// Analog pin select
        PSEL: u3 = 0,
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

    /// Reference source select for single-ended mode
    pub const REFSEL = mmio(Address + 0x00000508, 32, packed struct {
        /// Reference select
        REFSEL: u3 = 0,
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

    /// External reference select
    pub const EXTREFSEL = mmio(Address + 0x0000050c, 32, packed struct {
        /// External analog reference select
        EXTREFSEL: u3 = 0,
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

    /// Threshold configuration for hysteresis unit
    pub const TH = mmio(Address + 0x00000530, 32, packed struct {
        /// VDOWN = (THDOWN+1)/64*VREF
        THDOWN: u6 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// VUP = (THUP+1)/64*VREF
        THUP: u6 = 0,
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

    /// Mode configuration
    pub const MODE = mmio(Address + 0x00000534, 32, packed struct {
        /// Speed and power modes
        SP: u2 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Main operation modes
        MAIN: u1 = 0,
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

    /// Comparator hysteresis enable
    pub const HYST = mmio(Address + 0x00000538, 32, packed struct {
        /// Comparator hysteresis
        HYST: u1 = 0,
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

    /// Current source select on analog input
    pub const ISOURCE = mmio(Address + 0x0000053c, 32, packed struct {
        /// Comparator hysteresis
        ISOURCE: u2 = 0,
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

/// Low Power Comparator
pub const LPCOMP = extern struct {
    pub const Address: u32 = 0x40013000;

    /// Start comparator
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop comparator
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Sample comparator value
    pub const TASKS_SAMPLE = @intToPtr(*volatile u32, Address + 0x00000008);

    /// LPCOMP is ready and output is valid
    pub const EVENTS_READY = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Downward crossing
    pub const EVENTS_DOWN = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Upward crossing
    pub const EVENTS_UP = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Downward or upward crossing
    pub const EVENTS_CROSS = @intToPtr(*volatile u32, Address + 0x0000010c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between READY event and SAMPLE task
        READY_SAMPLE: u1 = 0,
        /// Shortcut between READY event and STOP task
        READY_STOP: u1 = 0,
        /// Shortcut between DOWN event and STOP task
        DOWN_STOP: u1 = 0,
        /// Shortcut between UP event and STOP task
        UP_STOP: u1 = 0,
        /// Shortcut between CROSS event and STOP task
        CROSS_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Enable interrupt for DOWN event
        DOWN: u1 = 0,
        /// Write '1' to Enable interrupt for UP event
        UP: u1 = 0,
        /// Write '1' to Enable interrupt for CROSS event
        CROSS: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for READY event
        READY: u1 = 0,
        /// Write '1' to Disable interrupt for DOWN event
        DOWN: u1 = 0,
        /// Write '1' to Disable interrupt for UP event
        UP: u1 = 0,
        /// Write '1' to Disable interrupt for CROSS event
        CROSS: u1 = 0,
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

    /// Compare result
    pub const RESULT = mmio(Address + 0x00000400, 32, packed struct {
        /// Result of last compare. Decision point SAMPLE task.
        RESULT: u1 = 0,
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

    /// Enable LPCOMP
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable LPCOMP
        ENABLE: u2 = 0,
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

    /// Input pin select
    pub const PSEL = mmio(Address + 0x00000504, 32, packed struct {
        /// Analog pin select
        PSEL: u3 = 0,
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

    /// Reference select
    pub const REFSEL = mmio(Address + 0x00000508, 32, packed struct {
        /// Reference select
        REFSEL: u4 = 0,
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

    /// External reference select
    pub const EXTREFSEL = mmio(Address + 0x0000050c, 32, packed struct {
        /// External analog reference select
        EXTREFSEL: u1 = 0,
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

    /// Analog detect configuration
    pub const ANADETECT = mmio(Address + 0x00000520, 32, packed struct {
        /// Analog detect configuration
        ANADETECT: u2 = 0,
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

    /// Comparator hysteresis enable
    pub const HYST = mmio(Address + 0x00000538, 32, packed struct {
        /// Comparator hysteresis enable
        HYST: u1 = 0,
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

/// Software interrupt 0
pub const SWI0 = extern struct {
    pub const Address: u32 = 0x40014000;

    /// Unused.
    pub const UNUSED = @intToPtr(*volatile u32, Address + 0x00000000);
};

/// Event Generator Unit 0
pub const EGU0 = extern struct {
    pub const Address: u32 = 0x40014000;

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Trigger 0 for triggering the corresponding
    /// TRIGGERED[0] event
    pub const TASKS_TRIGGER = @intToPtr(*volatile [16]u32, Address + 0x00000000);
    /// Description collection[0]: Event number 0 generated by triggering the
    /// corresponding TRIGGER[0] task
    pub const EVENTS_TRIGGERED = @intToPtr(*volatile [16]u32, Address + 0x00000100);
};

/// Software interrupt 1
pub const SWI1 = extern struct {
    pub const Address: u32 = 0x40015000;

    /// Unused.
    pub const UNUSED = @intToPtr(*volatile u32, Address + 0x00000000);
};

/// Event Generator Unit 1
pub const EGU1 = extern struct {
    pub const Address: u32 = 0x40015000;

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Trigger 0 for triggering the corresponding
    /// TRIGGERED[0] event
    pub const TASKS_TRIGGER = @intToPtr(*volatile [16]u32, Address + 0x00000000);
    /// Description collection[0]: Event number 0 generated by triggering the
    /// corresponding TRIGGER[0] task
    pub const EVENTS_TRIGGERED = @intToPtr(*volatile [16]u32, Address + 0x00000100);
};

/// Software interrupt 2
pub const SWI2 = extern struct {
    pub const Address: u32 = 0x40016000;

    /// Unused.
    pub const UNUSED = @intToPtr(*volatile u32, Address + 0x00000000);
};

/// Event Generator Unit 2
pub const EGU2 = extern struct {
    pub const Address: u32 = 0x40016000;

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Trigger 0 for triggering the corresponding
    /// TRIGGERED[0] event
    pub const TASKS_TRIGGER = @intToPtr(*volatile [16]u32, Address + 0x00000000);
    /// Description collection[0]: Event number 0 generated by triggering the
    /// corresponding TRIGGER[0] task
    pub const EVENTS_TRIGGERED = @intToPtr(*volatile [16]u32, Address + 0x00000100);
};

/// Software interrupt 3
pub const SWI3 = extern struct {
    pub const Address: u32 = 0x40017000;

    /// Unused.
    pub const UNUSED = @intToPtr(*volatile u32, Address + 0x00000000);
};

/// Event Generator Unit 3
pub const EGU3 = extern struct {
    pub const Address: u32 = 0x40017000;

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Trigger 0 for triggering the corresponding
    /// TRIGGERED[0] event
    pub const TASKS_TRIGGER = @intToPtr(*volatile [16]u32, Address + 0x00000000);
    /// Description collection[0]: Event number 0 generated by triggering the
    /// corresponding TRIGGER[0] task
    pub const EVENTS_TRIGGERED = @intToPtr(*volatile [16]u32, Address + 0x00000100);
};

/// Software interrupt 4
pub const SWI4 = extern struct {
    pub const Address: u32 = 0x40018000;

    /// Unused.
    pub const UNUSED = @intToPtr(*volatile u32, Address + 0x00000000);
};

/// Event Generator Unit 4
pub const EGU4 = extern struct {
    pub const Address: u32 = 0x40018000;

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Trigger 0 for triggering the corresponding
    /// TRIGGERED[0] event
    pub const TASKS_TRIGGER = @intToPtr(*volatile [16]u32, Address + 0x00000000);
    /// Description collection[0]: Event number 0 generated by triggering the
    /// corresponding TRIGGER[0] task
    pub const EVENTS_TRIGGERED = @intToPtr(*volatile [16]u32, Address + 0x00000100);
};

/// Software interrupt 5
pub const SWI5 = extern struct {
    pub const Address: u32 = 0x40019000;

    /// Unused.
    pub const UNUSED = @intToPtr(*volatile u32, Address + 0x00000000);
};

/// Event Generator Unit 5
pub const EGU5 = extern struct {
    pub const Address: u32 = 0x40019000;

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Enable or disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Enable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TRIGGERED[0] event
        TRIGGERED0: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[1] event
        TRIGGERED1: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[2] event
        TRIGGERED2: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[3] event
        TRIGGERED3: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[4] event
        TRIGGERED4: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[5] event
        TRIGGERED5: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[6] event
        TRIGGERED6: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[7] event
        TRIGGERED7: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[8] event
        TRIGGERED8: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[9] event
        TRIGGERED9: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[10] event
        TRIGGERED10: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[11] event
        TRIGGERED11: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[12] event
        TRIGGERED12: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[13] event
        TRIGGERED13: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[14] event
        TRIGGERED14: u1 = 0,
        /// Write '1' to Disable interrupt for TRIGGERED[15] event
        TRIGGERED15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Trigger 0 for triggering the corresponding
    /// TRIGGERED[0] event
    pub const TASKS_TRIGGER = @intToPtr(*volatile [16]u32, Address + 0x00000000);
    /// Description collection[0]: Event number 0 generated by triggering the
    /// corresponding TRIGGER[0] task
    pub const EVENTS_TRIGGERED = @intToPtr(*volatile [16]u32, Address + 0x00000100);
};

/// Timer/Counter 3
pub const TIMER3 = extern struct {
    pub const Address: u32 = 0x4001a000;

    /// Start Timer
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop Timer
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Increment Timer (Counter mode only)
    pub const TASKS_COUNT = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Clear time
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Deprecated register - Shut down timer
    pub const TASKS_SHUTDOWN = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between COMPARE[0] event and CLEAR task
        COMPARE0_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[1] event and CLEAR task
        COMPARE1_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[2] event and CLEAR task
        COMPARE2_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[3] event and CLEAR task
        COMPARE3_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[4] event and CLEAR task
        COMPARE4_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[5] event and CLEAR task
        COMPARE5_CLEAR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between COMPARE[0] event and STOP task
        COMPARE0_STOP: u1 = 0,
        /// Shortcut between COMPARE[1] event and STOP task
        COMPARE1_STOP: u1 = 0,
        /// Shortcut between COMPARE[2] event and STOP task
        COMPARE2_STOP: u1 = 0,
        /// Shortcut between COMPARE[3] event and STOP task
        COMPARE3_STOP: u1 = 0,
        /// Shortcut between COMPARE[4] event and STOP task
        COMPARE4_STOP: u1 = 0,
        /// Shortcut between COMPARE[5] event and STOP task
        COMPARE5_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timer mode selection
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Timer mode
        MODE: u2 = 0,
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

    /// Configure the number of bits used by the TIMER
    pub const BITMODE = mmio(Address + 0x00000508, 32, packed struct {
        /// Timer bit width
        BITMODE: u2 = 0,
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

    /// Timer prescaler register
    pub const PRESCALER = mmio(Address + 0x00000510, 32, packed struct {
        /// Prescaler value
        PRESCALER: u4 = 0,
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
    /// Description collection[0]: Capture Timer value to CC[0] register
    pub const TASKS_CAPTURE = @intToPtr(*volatile [6]u32, Address + 0x00000040);
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [6]u32, Address + 0x00000140);
    /// Description collection[0]: Capture/Compare register 0
    pub const CC = @intToPtr(*volatile [6]u32, Address + 0x00000540);
};

/// Timer/Counter 4
pub const TIMER4 = extern struct {
    pub const Address: u32 = 0x4001b000;

    /// Start Timer
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop Timer
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Increment Timer (Counter mode only)
    pub const TASKS_COUNT = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Clear time
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Deprecated register - Shut down timer
    pub const TASKS_SHUTDOWN = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between COMPARE[0] event and CLEAR task
        COMPARE0_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[1] event and CLEAR task
        COMPARE1_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[2] event and CLEAR task
        COMPARE2_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[3] event and CLEAR task
        COMPARE3_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[4] event and CLEAR task
        COMPARE4_CLEAR: u1 = 0,
        /// Shortcut between COMPARE[5] event and CLEAR task
        COMPARE5_CLEAR: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between COMPARE[0] event and STOP task
        COMPARE0_STOP: u1 = 0,
        /// Shortcut between COMPARE[1] event and STOP task
        COMPARE1_STOP: u1 = 0,
        /// Shortcut between COMPARE[2] event and STOP task
        COMPARE2_STOP: u1 = 0,
        /// Shortcut between COMPARE[3] event and STOP task
        COMPARE3_STOP: u1 = 0,
        /// Shortcut between COMPARE[4] event and STOP task
        COMPARE4_STOP: u1 = 0,
        /// Shortcut between COMPARE[5] event and STOP task
        COMPARE5_STOP: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[4] event
        COMPARE4: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[5] event
        COMPARE5: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timer mode selection
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Timer mode
        MODE: u2 = 0,
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

    /// Configure the number of bits used by the TIMER
    pub const BITMODE = mmio(Address + 0x00000508, 32, packed struct {
        /// Timer bit width
        BITMODE: u2 = 0,
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

    /// Timer prescaler register
    pub const PRESCALER = mmio(Address + 0x00000510, 32, packed struct {
        /// Prescaler value
        PRESCALER: u4 = 0,
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
    /// Description collection[0]: Capture Timer value to CC[0] register
    pub const TASKS_CAPTURE = @intToPtr(*volatile [6]u32, Address + 0x00000040);
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [6]u32, Address + 0x00000140);
    /// Description collection[0]: Capture/Compare register 0
    pub const CC = @intToPtr(*volatile [6]u32, Address + 0x00000540);
};

/// Pulse Width Modulation Unit 0
pub const PWM0 = extern struct {
    pub const Address: u32 = 0x4001c000;

    /// Stops PWM pulse generation on all channels at the end of current PWM period,
    /// and stops sequence playback
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Steps by one value in the current sequence on all enabled channels if
    /// DECODER.MODE=NextStep. Does not cause PWM generation to start it was not
    /// running.
    pub const TASKS_NEXTSTEP = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Response to STOP task, emitted when PWM pulses are no longer generated
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Emitted at the end of each PWM period
    pub const EVENTS_PWMPERIODEND = @intToPtr(*volatile u32, Address + 0x00000118);

    /// Concatenated sequences have been played the amount of times defined in
    /// LOOP.CNT
    pub const EVENTS_LOOPSDONE = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between SEQEND[0] event and STOP task
        SEQEND0_STOP: u1 = 0,
        /// Shortcut between SEQEND[1] event and STOP task
        SEQEND1_STOP: u1 = 0,
        /// Shortcut between LOOPSDONE event and SEQSTART[0] task
        LOOPSDONE_SEQSTART0: u1 = 0,
        /// Shortcut between LOOPSDONE event and SEQSTART[1] task
        LOOPSDONE_SEQSTART1: u1 = 0,
        /// Shortcut between LOOPSDONE event and STOP task
        LOOPSDONE_STOP: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Enable or disable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Enable or disable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Enable or disable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Enable or disable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Enable or disable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Enable or disable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Enable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Write '1' to Enable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Write '1' to Enable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Write '1' to Enable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Write '1' to Enable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Write '1' to Enable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Disable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Write '1' to Disable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Write '1' to Disable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Write '1' to Disable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Write '1' to Disable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Write '1' to Disable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// PWM module enable register
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable PWM module
        ENABLE: u1 = 0,
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

    /// Selects operating mode of the wave counter
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Selects up or up and down as wave counter mode
        UPDOWN: u1 = 0,
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

    /// Value up to which the pulse generator counter counts
    pub const COUNTERTOP = mmio(Address + 0x00000508, 32, packed struct {
        /// Value up to which the pulse generator counter counts. This register is
        /// ignored when DECODER.MODE=WaveForm and only values from RAM will be used.
        COUNTERTOP: u15 = 0,
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

    /// Configuration for PWM_CLK
    pub const PRESCALER = mmio(Address + 0x0000050c, 32, packed struct {
        /// Pre-scaler of PWM_CLK
        PRESCALER: u3 = 0,
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

    /// Configuration of the decoder
    pub const DECODER = mmio(Address + 0x00000510, 32, packed struct {
        /// How a sequence is read from RAM and spread to the compare register
        LOAD: u2 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Selects source for advancing the active sequence
        MODE: u1 = 0,
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

    /// Amount of playback of a loop
    pub const LOOP = mmio(Address + 0x00000514, 32, packed struct {
        /// Amount of playback of pattern cycles
        CNT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Loads the first PWM value on all enabled channels
    /// from sequence 0, and starts playing that sequence at the rate defined in
    /// SEQ[0]REFRESH and/or DECODER.MODE. Causes PWM generation to start it was not
    /// running.
    pub const TASKS_SEQSTART = @intToPtr(*volatile [2]u32, Address + 0x00000008);
    /// Description collection[0]: First PWM period started on sequence 0
    pub const EVENTS_SEQSTARTED = @intToPtr(*volatile [2]u32, Address + 0x00000108);
    /// Description collection[0]: Emitted at end of every sequence 0, when last
    /// value from RAM has been applied to wave counter
    pub const EVENTS_SEQEND = @intToPtr(*volatile [2]u32, Address + 0x00000110);

    pub const PSEL = struct {
        /// Description collection[0]: Output pin select for PWM channel 0
        pub const OUT = @intToPtr(*volatile [4]MMIO(32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        }), Address + 0x00000000);
    };
};

/// Pulse Density Modulation (Digital Microphone) Interface
pub const PDM = extern struct {
    pub const Address: u32 = 0x4001d000;

    /// Starts continuous PDM transfer
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stops PDM transfer
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// PDM transfer has started
    pub const EVENTS_STARTED = @intToPtr(*volatile u32, Address + 0x00000100);

    /// PDM transfer has finished
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// The PDM has written the last sample specified by SAMPLE.MAXCNT (or the last
    /// sample after a STOP task has been received) to Data RAM
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for STARTED event
        STARTED: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Enable or disable interrupt for END event
        END: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for STARTED event
        STARTED: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for STARTED event
        STARTED: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
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

    /// PDM module enable register
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable PDM module
        ENABLE: u1 = 0,
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

    /// PDM clock generator control
    pub const PDMCLKCTRL = mmio(Address + 0x00000504, 32, packed struct {
        /// PDM_CLK frequency
        FREQ: u32 = 0,
    });

    /// Defines the routing of the connected PDM microphones' signals
    pub const MODE = mmio(Address + 0x00000508, 32, packed struct {
        /// Mono or stereo operation
        OPERATION: u1 = 0,
        /// Defines on which PDM_CLK edge Left (or mono) is sampled
        EDGE: u1 = 0,
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

    /// Left output gain adjustment
    pub const GAINL = mmio(Address + 0x00000518, 32, packed struct {
        /// Left output gain adjustment, in 0.5 dB steps, around the default module gain
        /// (see electrical parameters) 0x00 -20 dB gain adjust 0x01 -19.5 dB gain
        /// adjust (...) 0x27 -0.5 dB gain adjust 0x28 0 dB gain adjust 0x29 +0.5 dB
        /// gain adjust (...) 0x4F +19.5 dB gain adjust 0x50 +20 dB gain adjust
        GAINL: u7 = 0,
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

    /// Right output gain adjustment
    pub const GAINR = mmio(Address + 0x0000051c, 32, packed struct {
        /// Right output gain adjustment, in 0.5 dB steps, around the default module
        /// gain (see electrical parameters)
        GAINR: u8 = 0,
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

    pub const PSEL = struct {

        /// Pin number configuration for PDM CLK signal
        pub const CLK = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin number configuration for PDM DIN signal
        pub const DIN = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };

    pub const SAMPLE = struct {

        /// RAM address pointer to write samples to with EasyDMA
        pub const PTR = mmio(Address + 0x00000000, 32, packed struct {
            /// Address to write PDM samples to over DMA
            SAMPLEPTR: u32 = 0,
        });

        /// Number of samples to allocate memory for in EasyDMA mode
        pub const MAXCNT = mmio(Address + 0x00000004, 32, packed struct {
            /// Length of DMA RAM allocation in number of samples
            BUFFSIZE: u15 = 0,
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
};

/// Non Volatile Memory Controller
pub const NVMC = extern struct {
    pub const Address: u32 = 0x4001e000;

    /// Ready flag
    pub const READY = mmio(Address + 0x00000400, 32, packed struct {
        /// NVMC is ready or busy
        READY: u1 = 0,
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

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000504, 32, packed struct {
        /// Program memory access mode. It is strongly recommended to only activate
        /// erase and write modes when they are actively used. Enabling write or erase
        /// will invalidate the cache and keep it invalidated.
        WEN: u2 = 0,
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

    /// Register for erasing a page in Code area
    pub const ERASEPAGE = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Deprecated register - Register for erasing a page in Code area. Equivalent
    /// to ERASEPAGE.
    pub const ERASEPCR1 = @intToPtr(*volatile u32, Address + 0x00000508);

    /// Register for erasing all non-volatile user memory
    pub const ERASEALL = mmio(Address + 0x0000050c, 32, packed struct {
        /// Erase all non-volatile memory including UICR registers. Note that code erase
        /// has to be enabled by CONFIG.EEN before the UICR can be erased.
        ERASEALL: u1 = 0,
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

    /// Deprecated register - Register for erasing a page in Code area. Equivalent
    /// to ERASEPAGE.
    pub const ERASEPCR0 = @intToPtr(*volatile u32, Address + 0x00000510);

    /// Register for erasing User Information Configuration Registers
    pub const ERASEUICR = mmio(Address + 0x00000514, 32, packed struct {
        /// Register starting erase of all User Information Configuration Registers.
        /// Note that code erase has to be enabled by CONFIG.EEN before the UICR can be
        /// erased.
        ERASEUICR: u1 = 0,
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

    /// I-Code cache configuration register.
    pub const ICACHECNF = mmio(Address + 0x00000540, 32, packed struct {
        /// Cache enable
        CACHEEN: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Cache profiling enable
        CACHEPROFEN: u1 = 0,
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

    /// I-Code cache hit counter.
    pub const IHIT = mmio(Address + 0x00000548, 32, packed struct {
        /// Number of cache hits
        HITS: u32 = 0,
    });

    /// I-Code cache miss counter.
    pub const IMISS = mmio(Address + 0x0000054c, 32, packed struct {
        /// Number of cache misses
        MISSES: u32 = 0,
    });
};

/// Programmable Peripheral Interconnect
pub const PPI = extern struct {
    pub const Address: u32 = 0x4001f000;

    /// Channel enable register
    pub const CHEN = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable channel 0
        CH0: u1 = 0,
        /// Enable or disable channel 1
        CH1: u1 = 0,
        /// Enable or disable channel 2
        CH2: u1 = 0,
        /// Enable or disable channel 3
        CH3: u1 = 0,
        /// Enable or disable channel 4
        CH4: u1 = 0,
        /// Enable or disable channel 5
        CH5: u1 = 0,
        /// Enable or disable channel 6
        CH6: u1 = 0,
        /// Enable or disable channel 7
        CH7: u1 = 0,
        /// Enable or disable channel 8
        CH8: u1 = 0,
        /// Enable or disable channel 9
        CH9: u1 = 0,
        /// Enable or disable channel 10
        CH10: u1 = 0,
        /// Enable or disable channel 11
        CH11: u1 = 0,
        /// Enable or disable channel 12
        CH12: u1 = 0,
        /// Enable or disable channel 13
        CH13: u1 = 0,
        /// Enable or disable channel 14
        CH14: u1 = 0,
        /// Enable or disable channel 15
        CH15: u1 = 0,
        /// Enable or disable channel 16
        CH16: u1 = 0,
        /// Enable or disable channel 17
        CH17: u1 = 0,
        /// Enable or disable channel 18
        CH18: u1 = 0,
        /// Enable or disable channel 19
        CH19: u1 = 0,
        /// Enable or disable channel 20
        CH20: u1 = 0,
        /// Enable or disable channel 21
        CH21: u1 = 0,
        /// Enable or disable channel 22
        CH22: u1 = 0,
        /// Enable or disable channel 23
        CH23: u1 = 0,
        /// Enable or disable channel 24
        CH24: u1 = 0,
        /// Enable or disable channel 25
        CH25: u1 = 0,
        /// Enable or disable channel 26
        CH26: u1 = 0,
        /// Enable or disable channel 27
        CH27: u1 = 0,
        /// Enable or disable channel 28
        CH28: u1 = 0,
        /// Enable or disable channel 29
        CH29: u1 = 0,
        /// Enable or disable channel 30
        CH30: u1 = 0,
        /// Enable or disable channel 31
        CH31: u1 = 0,
    });

    /// Channel enable set register
    pub const CHENSET = mmio(Address + 0x00000504, 32, packed struct {
        /// Channel 0 enable set register. Writing '0' has no effect
        CH0: u1 = 0,
        /// Channel 1 enable set register. Writing '0' has no effect
        CH1: u1 = 0,
        /// Channel 2 enable set register. Writing '0' has no effect
        CH2: u1 = 0,
        /// Channel 3 enable set register. Writing '0' has no effect
        CH3: u1 = 0,
        /// Channel 4 enable set register. Writing '0' has no effect
        CH4: u1 = 0,
        /// Channel 5 enable set register. Writing '0' has no effect
        CH5: u1 = 0,
        /// Channel 6 enable set register. Writing '0' has no effect
        CH6: u1 = 0,
        /// Channel 7 enable set register. Writing '0' has no effect
        CH7: u1 = 0,
        /// Channel 8 enable set register. Writing '0' has no effect
        CH8: u1 = 0,
        /// Channel 9 enable set register. Writing '0' has no effect
        CH9: u1 = 0,
        /// Channel 10 enable set register. Writing '0' has no effect
        CH10: u1 = 0,
        /// Channel 11 enable set register. Writing '0' has no effect
        CH11: u1 = 0,
        /// Channel 12 enable set register. Writing '0' has no effect
        CH12: u1 = 0,
        /// Channel 13 enable set register. Writing '0' has no effect
        CH13: u1 = 0,
        /// Channel 14 enable set register. Writing '0' has no effect
        CH14: u1 = 0,
        /// Channel 15 enable set register. Writing '0' has no effect
        CH15: u1 = 0,
        /// Channel 16 enable set register. Writing '0' has no effect
        CH16: u1 = 0,
        /// Channel 17 enable set register. Writing '0' has no effect
        CH17: u1 = 0,
        /// Channel 18 enable set register. Writing '0' has no effect
        CH18: u1 = 0,
        /// Channel 19 enable set register. Writing '0' has no effect
        CH19: u1 = 0,
        /// Channel 20 enable set register. Writing '0' has no effect
        CH20: u1 = 0,
        /// Channel 21 enable set register. Writing '0' has no effect
        CH21: u1 = 0,
        /// Channel 22 enable set register. Writing '0' has no effect
        CH22: u1 = 0,
        /// Channel 23 enable set register. Writing '0' has no effect
        CH23: u1 = 0,
        /// Channel 24 enable set register. Writing '0' has no effect
        CH24: u1 = 0,
        /// Channel 25 enable set register. Writing '0' has no effect
        CH25: u1 = 0,
        /// Channel 26 enable set register. Writing '0' has no effect
        CH26: u1 = 0,
        /// Channel 27 enable set register. Writing '0' has no effect
        CH27: u1 = 0,
        /// Channel 28 enable set register. Writing '0' has no effect
        CH28: u1 = 0,
        /// Channel 29 enable set register. Writing '0' has no effect
        CH29: u1 = 0,
        /// Channel 30 enable set register. Writing '0' has no effect
        CH30: u1 = 0,
        /// Channel 31 enable set register. Writing '0' has no effect
        CH31: u1 = 0,
    });

    /// Channel enable clear register
    pub const CHENCLR = mmio(Address + 0x00000508, 32, packed struct {
        /// Channel 0 enable clear register. Writing '0' has no effect
        CH0: u1 = 0,
        /// Channel 1 enable clear register. Writing '0' has no effect
        CH1: u1 = 0,
        /// Channel 2 enable clear register. Writing '0' has no effect
        CH2: u1 = 0,
        /// Channel 3 enable clear register. Writing '0' has no effect
        CH3: u1 = 0,
        /// Channel 4 enable clear register. Writing '0' has no effect
        CH4: u1 = 0,
        /// Channel 5 enable clear register. Writing '0' has no effect
        CH5: u1 = 0,
        /// Channel 6 enable clear register. Writing '0' has no effect
        CH6: u1 = 0,
        /// Channel 7 enable clear register. Writing '0' has no effect
        CH7: u1 = 0,
        /// Channel 8 enable clear register. Writing '0' has no effect
        CH8: u1 = 0,
        /// Channel 9 enable clear register. Writing '0' has no effect
        CH9: u1 = 0,
        /// Channel 10 enable clear register. Writing '0' has no effect
        CH10: u1 = 0,
        /// Channel 11 enable clear register. Writing '0' has no effect
        CH11: u1 = 0,
        /// Channel 12 enable clear register. Writing '0' has no effect
        CH12: u1 = 0,
        /// Channel 13 enable clear register. Writing '0' has no effect
        CH13: u1 = 0,
        /// Channel 14 enable clear register. Writing '0' has no effect
        CH14: u1 = 0,
        /// Channel 15 enable clear register. Writing '0' has no effect
        CH15: u1 = 0,
        /// Channel 16 enable clear register. Writing '0' has no effect
        CH16: u1 = 0,
        /// Channel 17 enable clear register. Writing '0' has no effect
        CH17: u1 = 0,
        /// Channel 18 enable clear register. Writing '0' has no effect
        CH18: u1 = 0,
        /// Channel 19 enable clear register. Writing '0' has no effect
        CH19: u1 = 0,
        /// Channel 20 enable clear register. Writing '0' has no effect
        CH20: u1 = 0,
        /// Channel 21 enable clear register. Writing '0' has no effect
        CH21: u1 = 0,
        /// Channel 22 enable clear register. Writing '0' has no effect
        CH22: u1 = 0,
        /// Channel 23 enable clear register. Writing '0' has no effect
        CH23: u1 = 0,
        /// Channel 24 enable clear register. Writing '0' has no effect
        CH24: u1 = 0,
        /// Channel 25 enable clear register. Writing '0' has no effect
        CH25: u1 = 0,
        /// Channel 26 enable clear register. Writing '0' has no effect
        CH26: u1 = 0,
        /// Channel 27 enable clear register. Writing '0' has no effect
        CH27: u1 = 0,
        /// Channel 28 enable clear register. Writing '0' has no effect
        CH28: u1 = 0,
        /// Channel 29 enable clear register. Writing '0' has no effect
        CH29: u1 = 0,
        /// Channel 30 enable clear register. Writing '0' has no effect
        CH30: u1 = 0,
        /// Channel 31 enable clear register. Writing '0' has no effect
        CH31: u1 = 0,
    });
    /// Description collection[0]: Channel group 0
    pub const CHG = @intToPtr(*volatile [6]MMIO(32, packed struct {
        /// Include or exclude channel 0
        CH0: u1 = 0,
        /// Include or exclude channel 1
        CH1: u1 = 0,
        /// Include or exclude channel 2
        CH2: u1 = 0,
        /// Include or exclude channel 3
        CH3: u1 = 0,
        /// Include or exclude channel 4
        CH4: u1 = 0,
        /// Include or exclude channel 5
        CH5: u1 = 0,
        /// Include or exclude channel 6
        CH6: u1 = 0,
        /// Include or exclude channel 7
        CH7: u1 = 0,
        /// Include or exclude channel 8
        CH8: u1 = 0,
        /// Include or exclude channel 9
        CH9: u1 = 0,
        /// Include or exclude channel 10
        CH10: u1 = 0,
        /// Include or exclude channel 11
        CH11: u1 = 0,
        /// Include or exclude channel 12
        CH12: u1 = 0,
        /// Include or exclude channel 13
        CH13: u1 = 0,
        /// Include or exclude channel 14
        CH14: u1 = 0,
        /// Include or exclude channel 15
        CH15: u1 = 0,
        /// Include or exclude channel 16
        CH16: u1 = 0,
        /// Include or exclude channel 17
        CH17: u1 = 0,
        /// Include or exclude channel 18
        CH18: u1 = 0,
        /// Include or exclude channel 19
        CH19: u1 = 0,
        /// Include or exclude channel 20
        CH20: u1 = 0,
        /// Include or exclude channel 21
        CH21: u1 = 0,
        /// Include or exclude channel 22
        CH22: u1 = 0,
        /// Include or exclude channel 23
        CH23: u1 = 0,
        /// Include or exclude channel 24
        CH24: u1 = 0,
        /// Include or exclude channel 25
        CH25: u1 = 0,
        /// Include or exclude channel 26
        CH26: u1 = 0,
        /// Include or exclude channel 27
        CH27: u1 = 0,
        /// Include or exclude channel 28
        CH28: u1 = 0,
        /// Include or exclude channel 29
        CH29: u1 = 0,
        /// Include or exclude channel 30
        CH30: u1 = 0,
        /// Include or exclude channel 31
        CH31: u1 = 0,
    }), Address + 0x00000800);
};

/// Memory Watch Unit
pub const MWU = extern struct {
    pub const Address: u32 = 0x40020000;

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        /// Enable or disable interrupt for REGION[0].WA event
        REGION0WA: u1 = 0,
        /// Enable or disable interrupt for REGION[0].RA event
        REGION0RA: u1 = 0,
        /// Enable or disable interrupt for REGION[1].WA event
        REGION1WA: u1 = 0,
        /// Enable or disable interrupt for REGION[1].RA event
        REGION1RA: u1 = 0,
        /// Enable or disable interrupt for REGION[2].WA event
        REGION2WA: u1 = 0,
        /// Enable or disable interrupt for REGION[2].RA event
        REGION2RA: u1 = 0,
        /// Enable or disable interrupt for REGION[3].WA event
        REGION3WA: u1 = 0,
        /// Enable or disable interrupt for REGION[3].RA event
        REGION3RA: u1 = 0,
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
        /// Enable or disable interrupt for PREGION[0].WA event
        PREGION0WA: u1 = 0,
        /// Enable or disable interrupt for PREGION[0].RA event
        PREGION0RA: u1 = 0,
        /// Enable or disable interrupt for PREGION[1].WA event
        PREGION1WA: u1 = 0,
        /// Enable or disable interrupt for PREGION[1].RA event
        PREGION1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for REGION[0].WA event
        REGION0WA: u1 = 0,
        /// Write '1' to Enable interrupt for REGION[0].RA event
        REGION0RA: u1 = 0,
        /// Write '1' to Enable interrupt for REGION[1].WA event
        REGION1WA: u1 = 0,
        /// Write '1' to Enable interrupt for REGION[1].RA event
        REGION1RA: u1 = 0,
        /// Write '1' to Enable interrupt for REGION[2].WA event
        REGION2WA: u1 = 0,
        /// Write '1' to Enable interrupt for REGION[2].RA event
        REGION2RA: u1 = 0,
        /// Write '1' to Enable interrupt for REGION[3].WA event
        REGION3WA: u1 = 0,
        /// Write '1' to Enable interrupt for REGION[3].RA event
        REGION3RA: u1 = 0,
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
        /// Write '1' to Enable interrupt for PREGION[0].WA event
        PREGION0WA: u1 = 0,
        /// Write '1' to Enable interrupt for PREGION[0].RA event
        PREGION0RA: u1 = 0,
        /// Write '1' to Enable interrupt for PREGION[1].WA event
        PREGION1WA: u1 = 0,
        /// Write '1' to Enable interrupt for PREGION[1].RA event
        PREGION1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for REGION[0].WA event
        REGION0WA: u1 = 0,
        /// Write '1' to Disable interrupt for REGION[0].RA event
        REGION0RA: u1 = 0,
        /// Write '1' to Disable interrupt for REGION[1].WA event
        REGION1WA: u1 = 0,
        /// Write '1' to Disable interrupt for REGION[1].RA event
        REGION1RA: u1 = 0,
        /// Write '1' to Disable interrupt for REGION[2].WA event
        REGION2WA: u1 = 0,
        /// Write '1' to Disable interrupt for REGION[2].RA event
        REGION2RA: u1 = 0,
        /// Write '1' to Disable interrupt for REGION[3].WA event
        REGION3WA: u1 = 0,
        /// Write '1' to Disable interrupt for REGION[3].RA event
        REGION3RA: u1 = 0,
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
        /// Write '1' to Disable interrupt for PREGION[0].WA event
        PREGION0WA: u1 = 0,
        /// Write '1' to Disable interrupt for PREGION[0].RA event
        PREGION0RA: u1 = 0,
        /// Write '1' to Disable interrupt for PREGION[1].WA event
        PREGION1WA: u1 = 0,
        /// Write '1' to Disable interrupt for PREGION[1].RA event
        PREGION1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable or disable non-maskable interrupt
    pub const NMIEN = mmio(Address + 0x00000320, 32, packed struct {
        /// Enable or disable non-maskable interrupt for REGION[0].WA event
        REGION0WA: u1 = 0,
        /// Enable or disable non-maskable interrupt for REGION[0].RA event
        REGION0RA: u1 = 0,
        /// Enable or disable non-maskable interrupt for REGION[1].WA event
        REGION1WA: u1 = 0,
        /// Enable or disable non-maskable interrupt for REGION[1].RA event
        REGION1RA: u1 = 0,
        /// Enable or disable non-maskable interrupt for REGION[2].WA event
        REGION2WA: u1 = 0,
        /// Enable or disable non-maskable interrupt for REGION[2].RA event
        REGION2RA: u1 = 0,
        /// Enable or disable non-maskable interrupt for REGION[3].WA event
        REGION3WA: u1 = 0,
        /// Enable or disable non-maskable interrupt for REGION[3].RA event
        REGION3RA: u1 = 0,
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
        /// Enable or disable non-maskable interrupt for PREGION[0].WA event
        PREGION0WA: u1 = 0,
        /// Enable or disable non-maskable interrupt for PREGION[0].RA event
        PREGION0RA: u1 = 0,
        /// Enable or disable non-maskable interrupt for PREGION[1].WA event
        PREGION1WA: u1 = 0,
        /// Enable or disable non-maskable interrupt for PREGION[1].RA event
        PREGION1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable non-maskable interrupt
    pub const NMIENSET = mmio(Address + 0x00000324, 32, packed struct {
        /// Write '1' to Enable non-maskable interrupt for REGION[0].WA event
        REGION0WA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for REGION[0].RA event
        REGION0RA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for REGION[1].WA event
        REGION1WA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for REGION[1].RA event
        REGION1RA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for REGION[2].WA event
        REGION2WA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for REGION[2].RA event
        REGION2RA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for REGION[3].WA event
        REGION3WA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for REGION[3].RA event
        REGION3RA: u1 = 0,
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
        /// Write '1' to Enable non-maskable interrupt for PREGION[0].WA event
        PREGION0WA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for PREGION[0].RA event
        PREGION0RA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for PREGION[1].WA event
        PREGION1WA: u1 = 0,
        /// Write '1' to Enable non-maskable interrupt for PREGION[1].RA event
        PREGION1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable non-maskable interrupt
    pub const NMIENCLR = mmio(Address + 0x00000328, 32, packed struct {
        /// Write '1' to Disable non-maskable interrupt for REGION[0].WA event
        REGION0WA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for REGION[0].RA event
        REGION0RA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for REGION[1].WA event
        REGION1WA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for REGION[1].RA event
        REGION1RA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for REGION[2].WA event
        REGION2WA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for REGION[2].RA event
        REGION2RA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for REGION[3].WA event
        REGION3WA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for REGION[3].RA event
        REGION3RA: u1 = 0,
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
        /// Write '1' to Disable non-maskable interrupt for PREGION[0].WA event
        PREGION0WA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for PREGION[0].RA event
        PREGION0RA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for PREGION[1].WA event
        PREGION1WA: u1 = 0,
        /// Write '1' to Disable non-maskable interrupt for PREGION[1].RA event
        PREGION1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable/disable regions watch
    pub const REGIONEN = mmio(Address + 0x00000510, 32, packed struct {
        /// Enable/disable write access watch in region[0]
        RGN0WA: u1 = 0,
        /// Enable/disable read access watch in region[0]
        RGN0RA: u1 = 0,
        /// Enable/disable write access watch in region[1]
        RGN1WA: u1 = 0,
        /// Enable/disable read access watch in region[1]
        RGN1RA: u1 = 0,
        /// Enable/disable write access watch in region[2]
        RGN2WA: u1 = 0,
        /// Enable/disable read access watch in region[2]
        RGN2RA: u1 = 0,
        /// Enable/disable write access watch in region[3]
        RGN3WA: u1 = 0,
        /// Enable/disable read access watch in region[3]
        RGN3RA: u1 = 0,
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
        /// Enable/disable write access watch in PREGION[0]
        PRGN0WA: u1 = 0,
        /// Enable/disable read access watch in PREGION[0]
        PRGN0RA: u1 = 0,
        /// Enable/disable write access watch in PREGION[1]
        PRGN1WA: u1 = 0,
        /// Enable/disable read access watch in PREGION[1]
        PRGN1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable regions watch
    pub const REGIONENSET = mmio(Address + 0x00000514, 32, packed struct {
        /// Enable write access watch in region[0]
        RGN0WA: u1 = 0,
        /// Enable read access watch in region[0]
        RGN0RA: u1 = 0,
        /// Enable write access watch in region[1]
        RGN1WA: u1 = 0,
        /// Enable read access watch in region[1]
        RGN1RA: u1 = 0,
        /// Enable write access watch in region[2]
        RGN2WA: u1 = 0,
        /// Enable read access watch in region[2]
        RGN2RA: u1 = 0,
        /// Enable write access watch in region[3]
        RGN3WA: u1 = 0,
        /// Enable read access watch in region[3]
        RGN3RA: u1 = 0,
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
        /// Enable write access watch in PREGION[0]
        PRGN0WA: u1 = 0,
        /// Enable read access watch in PREGION[0]
        PRGN0RA: u1 = 0,
        /// Enable write access watch in PREGION[1]
        PRGN1WA: u1 = 0,
        /// Enable read access watch in PREGION[1]
        PRGN1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable regions watch
    pub const REGIONENCLR = mmio(Address + 0x00000518, 32, packed struct {
        /// Disable write access watch in region[0]
        RGN0WA: u1 = 0,
        /// Disable read access watch in region[0]
        RGN0RA: u1 = 0,
        /// Disable write access watch in region[1]
        RGN1WA: u1 = 0,
        /// Disable read access watch in region[1]
        RGN1RA: u1 = 0,
        /// Disable write access watch in region[2]
        RGN2WA: u1 = 0,
        /// Disable read access watch in region[2]
        RGN2RA: u1 = 0,
        /// Disable write access watch in region[3]
        RGN3WA: u1 = 0,
        /// Disable read access watch in region[3]
        RGN3RA: u1 = 0,
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
        /// Disable write access watch in PREGION[0]
        PRGN0WA: u1 = 0,
        /// Disable read access watch in PREGION[0]
        PRGN0RA: u1 = 0,
        /// Disable write access watch in PREGION[1]
        PRGN1WA: u1 = 0,
        /// Disable read access watch in PREGION[1]
        PRGN1RA: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Pulse Width Modulation Unit 1
pub const PWM1 = extern struct {
    pub const Address: u32 = 0x40021000;

    /// Stops PWM pulse generation on all channels at the end of current PWM period,
    /// and stops sequence playback
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Steps by one value in the current sequence on all enabled channels if
    /// DECODER.MODE=NextStep. Does not cause PWM generation to start it was not
    /// running.
    pub const TASKS_NEXTSTEP = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Response to STOP task, emitted when PWM pulses are no longer generated
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Emitted at the end of each PWM period
    pub const EVENTS_PWMPERIODEND = @intToPtr(*volatile u32, Address + 0x00000118);

    /// Concatenated sequences have been played the amount of times defined in
    /// LOOP.CNT
    pub const EVENTS_LOOPSDONE = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between SEQEND[0] event and STOP task
        SEQEND0_STOP: u1 = 0,
        /// Shortcut between SEQEND[1] event and STOP task
        SEQEND1_STOP: u1 = 0,
        /// Shortcut between LOOPSDONE event and SEQSTART[0] task
        LOOPSDONE_SEQSTART0: u1 = 0,
        /// Shortcut between LOOPSDONE event and SEQSTART[1] task
        LOOPSDONE_SEQSTART1: u1 = 0,
        /// Shortcut between LOOPSDONE event and STOP task
        LOOPSDONE_STOP: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Enable or disable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Enable or disable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Enable or disable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Enable or disable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Enable or disable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Enable or disable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Enable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Write '1' to Enable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Write '1' to Enable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Write '1' to Enable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Write '1' to Enable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Write '1' to Enable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Disable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Write '1' to Disable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Write '1' to Disable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Write '1' to Disable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Write '1' to Disable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Write '1' to Disable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// PWM module enable register
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable PWM module
        ENABLE: u1 = 0,
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

    /// Selects operating mode of the wave counter
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Selects up or up and down as wave counter mode
        UPDOWN: u1 = 0,
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

    /// Value up to which the pulse generator counter counts
    pub const COUNTERTOP = mmio(Address + 0x00000508, 32, packed struct {
        /// Value up to which the pulse generator counter counts. This register is
        /// ignored when DECODER.MODE=WaveForm and only values from RAM will be used.
        COUNTERTOP: u15 = 0,
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

    /// Configuration for PWM_CLK
    pub const PRESCALER = mmio(Address + 0x0000050c, 32, packed struct {
        /// Pre-scaler of PWM_CLK
        PRESCALER: u3 = 0,
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

    /// Configuration of the decoder
    pub const DECODER = mmio(Address + 0x00000510, 32, packed struct {
        /// How a sequence is read from RAM and spread to the compare register
        LOAD: u2 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Selects source for advancing the active sequence
        MODE: u1 = 0,
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

    /// Amount of playback of a loop
    pub const LOOP = mmio(Address + 0x00000514, 32, packed struct {
        /// Amount of playback of pattern cycles
        CNT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Loads the first PWM value on all enabled channels
    /// from sequence 0, and starts playing that sequence at the rate defined in
    /// SEQ[0]REFRESH and/or DECODER.MODE. Causes PWM generation to start it was not
    /// running.
    pub const TASKS_SEQSTART = @intToPtr(*volatile [2]u32, Address + 0x00000008);
    /// Description collection[0]: First PWM period started on sequence 0
    pub const EVENTS_SEQSTARTED = @intToPtr(*volatile [2]u32, Address + 0x00000108);
    /// Description collection[0]: Emitted at end of every sequence 0, when last
    /// value from RAM has been applied to wave counter
    pub const EVENTS_SEQEND = @intToPtr(*volatile [2]u32, Address + 0x00000110);
};

/// Pulse Width Modulation Unit 2
pub const PWM2 = extern struct {
    pub const Address: u32 = 0x40022000;

    /// Stops PWM pulse generation on all channels at the end of current PWM period,
    /// and stops sequence playback
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Steps by one value in the current sequence on all enabled channels if
    /// DECODER.MODE=NextStep. Does not cause PWM generation to start it was not
    /// running.
    pub const TASKS_NEXTSTEP = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Response to STOP task, emitted when PWM pulses are no longer generated
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Emitted at the end of each PWM period
    pub const EVENTS_PWMPERIODEND = @intToPtr(*volatile u32, Address + 0x00000118);

    /// Concatenated sequences have been played the amount of times defined in
    /// LOOP.CNT
    pub const EVENTS_LOOPSDONE = @intToPtr(*volatile u32, Address + 0x0000011c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        /// Shortcut between SEQEND[0] event and STOP task
        SEQEND0_STOP: u1 = 0,
        /// Shortcut between SEQEND[1] event and STOP task
        SEQEND1_STOP: u1 = 0,
        /// Shortcut between LOOPSDONE event and SEQSTART[0] task
        LOOPSDONE_SEQSTART0: u1 = 0,
        /// Shortcut between LOOPSDONE event and SEQSTART[1] task
        LOOPSDONE_SEQSTART1: u1 = 0,
        /// Shortcut between LOOPSDONE event and STOP task
        LOOPSDONE_STOP: u1 = 0,
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

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Enable or disable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Enable or disable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Enable or disable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Enable or disable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Enable or disable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Enable or disable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Enable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Write '1' to Enable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Write '1' to Enable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Write '1' to Enable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Write '1' to Enable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Write '1' to Enable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        /// Write '1' to Disable interrupt for SEQSTARTED[0] event
        SEQSTARTED0: u1 = 0,
        /// Write '1' to Disable interrupt for SEQSTARTED[1] event
        SEQSTARTED1: u1 = 0,
        /// Write '1' to Disable interrupt for SEQEND[0] event
        SEQEND0: u1 = 0,
        /// Write '1' to Disable interrupt for SEQEND[1] event
        SEQEND1: u1 = 0,
        /// Write '1' to Disable interrupt for PWMPERIODEND event
        PWMPERIODEND: u1 = 0,
        /// Write '1' to Disable interrupt for LOOPSDONE event
        LOOPSDONE: u1 = 0,
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

    /// PWM module enable register
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable PWM module
        ENABLE: u1 = 0,
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

    /// Selects operating mode of the wave counter
    pub const MODE = mmio(Address + 0x00000504, 32, packed struct {
        /// Selects up or up and down as wave counter mode
        UPDOWN: u1 = 0,
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

    /// Value up to which the pulse generator counter counts
    pub const COUNTERTOP = mmio(Address + 0x00000508, 32, packed struct {
        /// Value up to which the pulse generator counter counts. This register is
        /// ignored when DECODER.MODE=WaveForm and only values from RAM will be used.
        COUNTERTOP: u15 = 0,
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

    /// Configuration for PWM_CLK
    pub const PRESCALER = mmio(Address + 0x0000050c, 32, packed struct {
        /// Pre-scaler of PWM_CLK
        PRESCALER: u3 = 0,
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

    /// Configuration of the decoder
    pub const DECODER = mmio(Address + 0x00000510, 32, packed struct {
        /// How a sequence is read from RAM and spread to the compare register
        LOAD: u2 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Selects source for advancing the active sequence
        MODE: u1 = 0,
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

    /// Amount of playback of a loop
    pub const LOOP = mmio(Address + 0x00000514, 32, packed struct {
        /// Amount of playback of pattern cycles
        CNT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    /// Description collection[0]: Loads the first PWM value on all enabled channels
    /// from sequence 0, and starts playing that sequence at the rate defined in
    /// SEQ[0]REFRESH and/or DECODER.MODE. Causes PWM generation to start it was not
    /// running.
    pub const TASKS_SEQSTART = @intToPtr(*volatile [2]u32, Address + 0x00000008);
    /// Description collection[0]: First PWM period started on sequence 0
    pub const EVENTS_SEQSTARTED = @intToPtr(*volatile [2]u32, Address + 0x00000108);
    /// Description collection[0]: Emitted at end of every sequence 0, when last
    /// value from RAM has been applied to wave counter
    pub const EVENTS_SEQEND = @intToPtr(*volatile [2]u32, Address + 0x00000110);
};

/// Serial Peripheral Interface Master with EasyDMA 2
pub const SPIM2 = extern struct {
    pub const Address: u32 = 0x40023000;

    /// Start SPI transaction
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000010);

    /// Stop SPI transaction
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000014);

    /// Suspend SPI transaction
    pub const TASKS_SUSPEND = @intToPtr(*volatile u32, Address + 0x0000001c);

    /// Resume SPI transaction
    pub const TASKS_RESUME = @intToPtr(*volatile u32, Address + 0x00000020);

    /// SPI transaction has stopped
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000104);

    /// End of RXD buffer reached
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x00000110);

    /// End of RXD buffer and TXD buffer reached
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000118);

    /// End of TXD buffer reached
    pub const EVENTS_ENDTX = @intToPtr(*volatile u32, Address + 0x00000120);

    /// Transaction started
    pub const EVENTS_STARTED = @intToPtr(*volatile u32, Address + 0x0000014c);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
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
        /// Shortcut between END event and START task
        END_START: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Enable interrupt for ENDTX event
        ENDTX: u1 = 0,
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
        /// Write '1' to Enable interrupt for STARTED event
        STARTED: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        reserved5: u1 = 0,
        /// Write '1' to Disable interrupt for ENDTX event
        ENDTX: u1 = 0,
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
        /// Write '1' to Disable interrupt for STARTED event
        STARTED: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable SPIM
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPIM
        ENABLE: u4 = 0,
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

    /// SPI frequency. Accuracy depends on the HFCLK source selected.
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

    /// Over-read character. Character clocked out in case and over-read of the TXD
    /// buffer.
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character clocked out in case and over-read of the TXD
        /// buffer.
        ORC: u8 = 0,
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

/// SPI Slave 2
pub const SPIS2 = extern struct {
    pub const Address: u32 = 0x40023000;

    /// Acquire SPI semaphore
    pub const TASKS_ACQUIRE = @intToPtr(*volatile u32, Address + 0x00000024);

    /// Release SPI semaphore, enabling the SPI slave to acquire it
    pub const TASKS_RELEASE = @intToPtr(*volatile u32, Address + 0x00000028);

    /// Granted transaction completed
    pub const EVENTS_END = @intToPtr(*volatile u32, Address + 0x00000104);

    /// End of RXD buffer reached
    pub const EVENTS_ENDRX = @intToPtr(*volatile u32, Address + 0x00000110);

    /// Semaphore acquired
    pub const EVENTS_ACQUIRED = @intToPtr(*volatile u32, Address + 0x00000128);

    /// Shortcut register
    pub const SHORTS = mmio(Address + 0x00000200, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Shortcut between END event and ACQUIRE task
        END_ACQUIRE: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for END event
        END: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Enable interrupt for ACQUIRED event
        ACQUIRED: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for END event
        END: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for ENDRX event
        ENDRX: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Write '1' to Disable interrupt for ACQUIRED event
        ACQUIRED: u1 = 0,
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

    /// Semaphore status register
    pub const SEMSTAT = mmio(Address + 0x00000400, 32, packed struct {
        /// Semaphore status
        SEMSTAT: u2 = 0,
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

    /// Status from last transaction
    pub const STATUS = mmio(Address + 0x00000440, 32, packed struct {
        /// TX buffer over-read detected, and prevented
        OVERREAD: u1 = 0,
        /// RX buffer overflow detected, and prevented
        OVERFLOW: u1 = 0,
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

    /// Enable SPI slave
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPI slave
        ENABLE: u4 = 0,
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

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

    /// Default character. Character clocked out in case of an ignored transaction.
    pub const DEF = mmio(Address + 0x0000055c, 32, packed struct {
        /// Default character. Character clocked out in case of an ignored transaction.
        DEF: u8 = 0,
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

    /// Over-read character
    pub const ORC = mmio(Address + 0x000005c0, 32, packed struct {
        /// Over-read character. Character clocked out after an over-read of the
        /// transmit buffer.
        ORC: u8 = 0,
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

/// Serial Peripheral Interface 2
pub const SPI2 = extern struct {
    pub const Address: u32 = 0x40023000;

    /// TXD byte sent and RXD byte received
    pub const EVENTS_READY = @intToPtr(*volatile u32, Address + 0x00000108);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for READY event
        READY: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for READY event
        READY: u1 = 0,
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

    /// Enable SPI
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable or disable SPI
        ENABLE: u4 = 0,
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

    /// RXD register
    pub const RXD = mmio(Address + 0x00000518, 32, packed struct {
        /// RX data received. Double buffered
        RXD: u8 = 0,
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

    /// TXD register
    pub const TXD = mmio(Address + 0x0000051c, 32, packed struct {
        /// TX data to send. Double buffered
        TXD: u8 = 0,
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

    /// SPI frequency
    pub const FREQUENCY = @intToPtr(*volatile u32, Address + 0x00000524);

    /// Configuration register
    pub const CONFIG = mmio(Address + 0x00000554, 32, packed struct {
        /// Bit order
        ORDER: u1 = 0,
        /// Serial clock (SCK) phase
        CPHA: u1 = 0,
        /// Serial clock (SCK) polarity
        CPOL: u1 = 0,
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

/// Real time counter 2
pub const RTC2 = extern struct {
    pub const Address: u32 = 0x40024000;

    /// Start RTC COUNTER
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stop RTC COUNTER
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// Clear RTC COUNTER
    pub const TASKS_CLEAR = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Set COUNTER to 0xFFFFF0
    pub const TASKS_TRIGOVRFLW = @intToPtr(*volatile u32, Address + 0x0000000c);

    /// Event on COUNTER increment
    pub const EVENTS_TICK = @intToPtr(*volatile u32, Address + 0x00000100);

    /// Event on COUNTER overflow
    pub const EVENTS_OVRFLW = @intToPtr(*volatile u32, Address + 0x00000104);

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        /// Write '1' to Enable interrupt for TICK event
        TICK: u1 = 0,
        /// Write '1' to Enable interrupt for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Enable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        /// Write '1' to Disable interrupt for TICK event
        TICK: u1 = 0,
        /// Write '1' to Disable interrupt for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Disable interrupt for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable interrupt for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable or disable event routing
    pub const EVTEN = mmio(Address + 0x00000340, 32, packed struct {
        /// Enable or disable event routing for TICK event
        TICK: u1 = 0,
        /// Enable or disable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Enable or disable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Enable or disable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Enable or disable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Enable or disable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Enable event routing
    pub const EVTENSET = mmio(Address + 0x00000344, 32, packed struct {
        /// Write '1' to Enable event routing for TICK event
        TICK: u1 = 0,
        /// Write '1' to Enable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Enable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Enable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Disable event routing
    pub const EVTENCLR = mmio(Address + 0x00000348, 32, packed struct {
        /// Write '1' to Disable event routing for TICK event
        TICK: u1 = 0,
        /// Write '1' to Disable event routing for OVRFLW event
        OVRFLW: u1 = 0,
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
        /// Write '1' to Disable event routing for COMPARE[0] event
        COMPARE0: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[1] event
        COMPARE1: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[2] event
        COMPARE2: u1 = 0,
        /// Write '1' to Disable event routing for COMPARE[3] event
        COMPARE3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Current COUNTER value
    pub const COUNTER = mmio(Address + 0x00000504, 32, packed struct {
        /// Counter value
        COUNTER: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// 12 bit prescaler for COUNTER frequency (32768/(PRESCALER+1)).Must be written
    /// when RTC is stopped
    pub const PRESCALER = mmio(Address + 0x00000508, 32, packed struct {
        /// Prescaler value
        PRESCALER: u12 = 0,
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
    /// Description collection[0]: Compare event on CC[0] match
    pub const EVENTS_COMPARE = @intToPtr(*volatile [4]u32, Address + 0x00000140);
    /// Description collection[0]: Compare register 0
    pub const CC = @intToPtr(*volatile [4]MMIO(32, packed struct {
        /// Compare value
        COMPARE: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    }), Address + 0x00000540);
};

/// Inter-IC Sound
pub const I2S = extern struct {
    pub const Address: u32 = 0x40025000;

    /// Starts continuous I2S transfer. Also starts MCK generator when this is
    /// enabled.
    pub const TASKS_START = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Stops I2S transfer. Also stops MCK generator. Triggering this task will
    /// cause the {event:STOPPED} event to be generated.
    pub const TASKS_STOP = @intToPtr(*volatile u32, Address + 0x00000004);

    /// The RXD.PTR register has been copied to internal double-buffers. When the
    /// I2S module is started and RX is enabled, this event will be generated for
    /// every RXTXD.MAXCNT words that are received on the SDIN pin.
    pub const EVENTS_RXPTRUPD = @intToPtr(*volatile u32, Address + 0x00000104);

    /// I2S transfer stopped.
    pub const EVENTS_STOPPED = @intToPtr(*volatile u32, Address + 0x00000108);

    /// The TDX.PTR register has been copied to internal double-buffers. When the
    /// I2S module is started and TX is enabled, this event will be generated for
    /// every RXTXD.MAXCNT words that are sent on the SDOUT pin.
    pub const EVENTS_TXPTRUPD = @intToPtr(*volatile u32, Address + 0x00000114);

    /// Enable or disable interrupt
    pub const INTEN = mmio(Address + 0x00000300, 32, packed struct {
        reserved1: u1 = 0,
        /// Enable or disable interrupt for RXPTRUPD event
        RXPTRUPD: u1 = 0,
        /// Enable or disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Enable or disable interrupt for TXPTRUPD event
        TXPTRUPD: u1 = 0,
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

    /// Enable interrupt
    pub const INTENSET = mmio(Address + 0x00000304, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Enable interrupt for RXPTRUPD event
        RXPTRUPD: u1 = 0,
        /// Write '1' to Enable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Enable interrupt for TXPTRUPD event
        TXPTRUPD: u1 = 0,
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

    /// Disable interrupt
    pub const INTENCLR = mmio(Address + 0x00000308, 32, packed struct {
        reserved1: u1 = 0,
        /// Write '1' to Disable interrupt for RXPTRUPD event
        RXPTRUPD: u1 = 0,
        /// Write '1' to Disable interrupt for STOPPED event
        STOPPED: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Write '1' to Disable interrupt for TXPTRUPD event
        TXPTRUPD: u1 = 0,
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

    /// Enable I2S module.
    pub const ENABLE = mmio(Address + 0x00000500, 32, packed struct {
        /// Enable I2S module.
        ENABLE: u1 = 0,
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

    pub const CONFIG = struct {

        /// I2S mode.
        pub const MODE = mmio(Address + 0x00000000, 32, packed struct {
            /// I2S mode.
            MODE: u1 = 0,
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

        /// Reception (RX) enable.
        pub const RXEN = mmio(Address + 0x00000004, 32, packed struct {
            /// Reception (RX) enable.
            RXEN: u1 = 0,
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

        /// Transmission (TX) enable.
        pub const TXEN = mmio(Address + 0x00000008, 32, packed struct {
            /// Transmission (TX) enable.
            TXEN: u1 = 0,
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

        /// Master clock generator enable.
        pub const MCKEN = mmio(Address + 0x0000000c, 32, packed struct {
            /// Master clock generator enable.
            MCKEN: u1 = 0,
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

        /// Master clock generator frequency.
        pub const MCKFREQ = @intToPtr(*volatile u32, Address + 0x00000010);

        /// MCK / LRCK ratio.
        pub const RATIO = mmio(Address + 0x00000014, 32, packed struct {
            /// MCK / LRCK ratio.
            RATIO: u4 = 0,
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

        /// Sample width.
        pub const SWIDTH = mmio(Address + 0x00000018, 32, packed struct {
            /// Sample width.
            SWIDTH: u2 = 0,
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

        /// Alignment of sample within a frame.
        pub const ALIGN = mmio(Address + 0x0000001c, 32, packed struct {
            /// Alignment of sample within a frame.
            ALIGN: u1 = 0,
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

        /// Frame format.
        pub const FORMAT = mmio(Address + 0x00000020, 32, packed struct {
            /// Frame format.
            FORMAT: u1 = 0,
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

        /// Enable channels.
        pub const CHANNELS = mmio(Address + 0x00000024, 32, packed struct {
            /// Enable channels.
            CHANNELS: u2 = 0,
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

    pub const RXD = struct {

        /// Receive buffer RAM start address.
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);
    };

    pub const TXD = struct {

        /// Transmit buffer RAM start address.
        pub const PTR = @intToPtr(*volatile u32, Address + 0x00000000);
    };

    pub const RXTXD = struct {

        /// Size of RXD and TXD buffers.
        pub const MAXCNT = mmio(Address + 0x00000000, 32, packed struct {
            /// Size of RXD and TXD buffers in number of 32 bit words.
            MAXCNT: u14 = 0,
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

    pub const PSEL = struct {

        /// Pin select for MCK signal.
        pub const MCK = mmio(Address + 0x00000000, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for SCK signal.
        pub const SCK = mmio(Address + 0x00000004, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for LRCK signal.
        pub const LRCK = mmio(Address + 0x00000008, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for SDIN signal.
        pub const SDIN = mmio(Address + 0x0000000c, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });

        /// Pin select for SDOUT signal.
        pub const SDOUT = mmio(Address + 0x00000010, 32, packed struct {
            /// Pin number
            PIN: u5 = 0,
            reserved26: u1 = 0,
            reserved25: u1 = 0,
            reserved24: u1 = 0,
            reserved23: u1 = 0,
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
            /// Connection
            CONNECT: u1 = 0,
        });
    };
};

/// FPU
pub const FPU = extern struct {
    pub const Address: u32 = 0x40026000;

    /// Unused.
    pub const UNUSED = @intToPtr(*volatile u32, Address + 0x00000000);
};

/// GPIO Port 1
pub const P0 = extern struct {
    pub const Address: u32 = 0x50000000;

    /// Write GPIO port
    pub const OUT = mmio(Address + 0x00000504, 32, packed struct {
        /// Pin 0
        PIN0: u1 = 0,
        /// Pin 1
        PIN1: u1 = 0,
        /// Pin 2
        PIN2: u1 = 0,
        /// Pin 3
        PIN3: u1 = 0,
        /// Pin 4
        PIN4: u1 = 0,
        /// Pin 5
        PIN5: u1 = 0,
        /// Pin 6
        PIN6: u1 = 0,
        /// Pin 7
        PIN7: u1 = 0,
        /// Pin 8
        PIN8: u1 = 0,
        /// Pin 9
        PIN9: u1 = 0,
        /// Pin 10
        PIN10: u1 = 0,
        /// Pin 11
        PIN11: u1 = 0,
        /// Pin 12
        PIN12: u1 = 0,
        /// Pin 13
        PIN13: u1 = 0,
        /// Pin 14
        PIN14: u1 = 0,
        /// Pin 15
        PIN15: u1 = 0,
        /// Pin 16
        PIN16: u1 = 0,
        /// Pin 17
        PIN17: u1 = 0,
        /// Pin 18
        PIN18: u1 = 0,
        /// Pin 19
        PIN19: u1 = 0,
        /// Pin 20
        PIN20: u1 = 0,
        /// Pin 21
        PIN21: u1 = 0,
        /// Pin 22
        PIN22: u1 = 0,
        /// Pin 23
        PIN23: u1 = 0,
        /// Pin 24
        PIN24: u1 = 0,
        /// Pin 25
        PIN25: u1 = 0,
        /// Pin 26
        PIN26: u1 = 0,
        /// Pin 27
        PIN27: u1 = 0,
        /// Pin 28
        PIN28: u1 = 0,
        /// Pin 29
        PIN29: u1 = 0,
        /// Pin 30
        PIN30: u1 = 0,
        /// Pin 31
        PIN31: u1 = 0,
    });

    /// Set individual bits in GPIO port
    pub const OUTSET = mmio(Address + 0x00000508, 32, packed struct {
        /// Pin 0
        PIN0: u1 = 0,
        /// Pin 1
        PIN1: u1 = 0,
        /// Pin 2
        PIN2: u1 = 0,
        /// Pin 3
        PIN3: u1 = 0,
        /// Pin 4
        PIN4: u1 = 0,
        /// Pin 5
        PIN5: u1 = 0,
        /// Pin 6
        PIN6: u1 = 0,
        /// Pin 7
        PIN7: u1 = 0,
        /// Pin 8
        PIN8: u1 = 0,
        /// Pin 9
        PIN9: u1 = 0,
        /// Pin 10
        PIN10: u1 = 0,
        /// Pin 11
        PIN11: u1 = 0,
        /// Pin 12
        PIN12: u1 = 0,
        /// Pin 13
        PIN13: u1 = 0,
        /// Pin 14
        PIN14: u1 = 0,
        /// Pin 15
        PIN15: u1 = 0,
        /// Pin 16
        PIN16: u1 = 0,
        /// Pin 17
        PIN17: u1 = 0,
        /// Pin 18
        PIN18: u1 = 0,
        /// Pin 19
        PIN19: u1 = 0,
        /// Pin 20
        PIN20: u1 = 0,
        /// Pin 21
        PIN21: u1 = 0,
        /// Pin 22
        PIN22: u1 = 0,
        /// Pin 23
        PIN23: u1 = 0,
        /// Pin 24
        PIN24: u1 = 0,
        /// Pin 25
        PIN25: u1 = 0,
        /// Pin 26
        PIN26: u1 = 0,
        /// Pin 27
        PIN27: u1 = 0,
        /// Pin 28
        PIN28: u1 = 0,
        /// Pin 29
        PIN29: u1 = 0,
        /// Pin 30
        PIN30: u1 = 0,
        /// Pin 31
        PIN31: u1 = 0,
    });

    /// Clear individual bits in GPIO port
    pub const OUTCLR = mmio(Address + 0x0000050c, 32, packed struct {
        /// Pin 0
        PIN0: u1 = 0,
        /// Pin 1
        PIN1: u1 = 0,
        /// Pin 2
        PIN2: u1 = 0,
        /// Pin 3
        PIN3: u1 = 0,
        /// Pin 4
        PIN4: u1 = 0,
        /// Pin 5
        PIN5: u1 = 0,
        /// Pin 6
        PIN6: u1 = 0,
        /// Pin 7
        PIN7: u1 = 0,
        /// Pin 8
        PIN8: u1 = 0,
        /// Pin 9
        PIN9: u1 = 0,
        /// Pin 10
        PIN10: u1 = 0,
        /// Pin 11
        PIN11: u1 = 0,
        /// Pin 12
        PIN12: u1 = 0,
        /// Pin 13
        PIN13: u1 = 0,
        /// Pin 14
        PIN14: u1 = 0,
        /// Pin 15
        PIN15: u1 = 0,
        /// Pin 16
        PIN16: u1 = 0,
        /// Pin 17
        PIN17: u1 = 0,
        /// Pin 18
        PIN18: u1 = 0,
        /// Pin 19
        PIN19: u1 = 0,
        /// Pin 20
        PIN20: u1 = 0,
        /// Pin 21
        PIN21: u1 = 0,
        /// Pin 22
        PIN22: u1 = 0,
        /// Pin 23
        PIN23: u1 = 0,
        /// Pin 24
        PIN24: u1 = 0,
        /// Pin 25
        PIN25: u1 = 0,
        /// Pin 26
        PIN26: u1 = 0,
        /// Pin 27
        PIN27: u1 = 0,
        /// Pin 28
        PIN28: u1 = 0,
        /// Pin 29
        PIN29: u1 = 0,
        /// Pin 30
        PIN30: u1 = 0,
        /// Pin 31
        PIN31: u1 = 0,
    });

    /// Read GPIO port
    pub const IN = mmio(Address + 0x00000510, 32, packed struct {
        /// Pin 0
        PIN0: u1 = 0,
        /// Pin 1
        PIN1: u1 = 0,
        /// Pin 2
        PIN2: u1 = 0,
        /// Pin 3
        PIN3: u1 = 0,
        /// Pin 4
        PIN4: u1 = 0,
        /// Pin 5
        PIN5: u1 = 0,
        /// Pin 6
        PIN6: u1 = 0,
        /// Pin 7
        PIN7: u1 = 0,
        /// Pin 8
        PIN8: u1 = 0,
        /// Pin 9
        PIN9: u1 = 0,
        /// Pin 10
        PIN10: u1 = 0,
        /// Pin 11
        PIN11: u1 = 0,
        /// Pin 12
        PIN12: u1 = 0,
        /// Pin 13
        PIN13: u1 = 0,
        /// Pin 14
        PIN14: u1 = 0,
        /// Pin 15
        PIN15: u1 = 0,
        /// Pin 16
        PIN16: u1 = 0,
        /// Pin 17
        PIN17: u1 = 0,
        /// Pin 18
        PIN18: u1 = 0,
        /// Pin 19
        PIN19: u1 = 0,
        /// Pin 20
        PIN20: u1 = 0,
        /// Pin 21
        PIN21: u1 = 0,
        /// Pin 22
        PIN22: u1 = 0,
        /// Pin 23
        PIN23: u1 = 0,
        /// Pin 24
        PIN24: u1 = 0,
        /// Pin 25
        PIN25: u1 = 0,
        /// Pin 26
        PIN26: u1 = 0,
        /// Pin 27
        PIN27: u1 = 0,
        /// Pin 28
        PIN28: u1 = 0,
        /// Pin 29
        PIN29: u1 = 0,
        /// Pin 30
        PIN30: u1 = 0,
        /// Pin 31
        PIN31: u1 = 0,
    });

    /// Direction of GPIO pins
    pub const DIR = mmio(Address + 0x00000514, 32, packed struct {
        /// Pin 0
        PIN0: u1 = 0,
        /// Pin 1
        PIN1: u1 = 0,
        /// Pin 2
        PIN2: u1 = 0,
        /// Pin 3
        PIN3: u1 = 0,
        /// Pin 4
        PIN4: u1 = 0,
        /// Pin 5
        PIN5: u1 = 0,
        /// Pin 6
        PIN6: u1 = 0,
        /// Pin 7
        PIN7: u1 = 0,
        /// Pin 8
        PIN8: u1 = 0,
        /// Pin 9
        PIN9: u1 = 0,
        /// Pin 10
        PIN10: u1 = 0,
        /// Pin 11
        PIN11: u1 = 0,
        /// Pin 12
        PIN12: u1 = 0,
        /// Pin 13
        PIN13: u1 = 0,
        /// Pin 14
        PIN14: u1 = 0,
        /// Pin 15
        PIN15: u1 = 0,
        /// Pin 16
        PIN16: u1 = 0,
        /// Pin 17
        PIN17: u1 = 0,
        /// Pin 18
        PIN18: u1 = 0,
        /// Pin 19
        PIN19: u1 = 0,
        /// Pin 20
        PIN20: u1 = 0,
        /// Pin 21
        PIN21: u1 = 0,
        /// Pin 22
        PIN22: u1 = 0,
        /// Pin 23
        PIN23: u1 = 0,
        /// Pin 24
        PIN24: u1 = 0,
        /// Pin 25
        PIN25: u1 = 0,
        /// Pin 26
        PIN26: u1 = 0,
        /// Pin 27
        PIN27: u1 = 0,
        /// Pin 28
        PIN28: u1 = 0,
        /// Pin 29
        PIN29: u1 = 0,
        /// Pin 30
        PIN30: u1 = 0,
        /// Pin 31
        PIN31: u1 = 0,
    });

    /// DIR set register
    pub const DIRSET = mmio(Address + 0x00000518, 32, packed struct {
        /// Set as output pin 0
        PIN0: u1 = 0,
        /// Set as output pin 1
        PIN1: u1 = 0,
        /// Set as output pin 2
        PIN2: u1 = 0,
        /// Set as output pin 3
        PIN3: u1 = 0,
        /// Set as output pin 4
        PIN4: u1 = 0,
        /// Set as output pin 5
        PIN5: u1 = 0,
        /// Set as output pin 6
        PIN6: u1 = 0,
        /// Set as output pin 7
        PIN7: u1 = 0,
        /// Set as output pin 8
        PIN8: u1 = 0,
        /// Set as output pin 9
        PIN9: u1 = 0,
        /// Set as output pin 10
        PIN10: u1 = 0,
        /// Set as output pin 11
        PIN11: u1 = 0,
        /// Set as output pin 12
        PIN12: u1 = 0,
        /// Set as output pin 13
        PIN13: u1 = 0,
        /// Set as output pin 14
        PIN14: u1 = 0,
        /// Set as output pin 15
        PIN15: u1 = 0,
        /// Set as output pin 16
        PIN16: u1 = 0,
        /// Set as output pin 17
        PIN17: u1 = 0,
        /// Set as output pin 18
        PIN18: u1 = 0,
        /// Set as output pin 19
        PIN19: u1 = 0,
        /// Set as output pin 20
        PIN20: u1 = 0,
        /// Set as output pin 21
        PIN21: u1 = 0,
        /// Set as output pin 22
        PIN22: u1 = 0,
        /// Set as output pin 23
        PIN23: u1 = 0,
        /// Set as output pin 24
        PIN24: u1 = 0,
        /// Set as output pin 25
        PIN25: u1 = 0,
        /// Set as output pin 26
        PIN26: u1 = 0,
        /// Set as output pin 27
        PIN27: u1 = 0,
        /// Set as output pin 28
        PIN28: u1 = 0,
        /// Set as output pin 29
        PIN29: u1 = 0,
        /// Set as output pin 30
        PIN30: u1 = 0,
        /// Set as output pin 31
        PIN31: u1 = 0,
    });

    /// DIR clear register
    pub const DIRCLR = mmio(Address + 0x0000051c, 32, packed struct {
        /// Set as input pin 0
        PIN0: u1 = 0,
        /// Set as input pin 1
        PIN1: u1 = 0,
        /// Set as input pin 2
        PIN2: u1 = 0,
        /// Set as input pin 3
        PIN3: u1 = 0,
        /// Set as input pin 4
        PIN4: u1 = 0,
        /// Set as input pin 5
        PIN5: u1 = 0,
        /// Set as input pin 6
        PIN6: u1 = 0,
        /// Set as input pin 7
        PIN7: u1 = 0,
        /// Set as input pin 8
        PIN8: u1 = 0,
        /// Set as input pin 9
        PIN9: u1 = 0,
        /// Set as input pin 10
        PIN10: u1 = 0,
        /// Set as input pin 11
        PIN11: u1 = 0,
        /// Set as input pin 12
        PIN12: u1 = 0,
        /// Set as input pin 13
        PIN13: u1 = 0,
        /// Set as input pin 14
        PIN14: u1 = 0,
        /// Set as input pin 15
        PIN15: u1 = 0,
        /// Set as input pin 16
        PIN16: u1 = 0,
        /// Set as input pin 17
        PIN17: u1 = 0,
        /// Set as input pin 18
        PIN18: u1 = 0,
        /// Set as input pin 19
        PIN19: u1 = 0,
        /// Set as input pin 20
        PIN20: u1 = 0,
        /// Set as input pin 21
        PIN21: u1 = 0,
        /// Set as input pin 22
        PIN22: u1 = 0,
        /// Set as input pin 23
        PIN23: u1 = 0,
        /// Set as input pin 24
        PIN24: u1 = 0,
        /// Set as input pin 25
        PIN25: u1 = 0,
        /// Set as input pin 26
        PIN26: u1 = 0,
        /// Set as input pin 27
        PIN27: u1 = 0,
        /// Set as input pin 28
        PIN28: u1 = 0,
        /// Set as input pin 29
        PIN29: u1 = 0,
        /// Set as input pin 30
        PIN30: u1 = 0,
        /// Set as input pin 31
        PIN31: u1 = 0,
    });

    /// Latch register indicating what GPIO pins that have met the criteria set in
    /// the PIN_CNF[n].SENSE registers
    pub const LATCH = mmio(Address + 0x00000520, 32, packed struct {
        /// Status on whether PIN0 has met criteria set in PIN_CNF0.SENSE register.
        /// Write '1' to clear.
        PIN0: u1 = 0,
        /// Status on whether PIN1 has met criteria set in PIN_CNF1.SENSE register.
        /// Write '1' to clear.
        PIN1: u1 = 0,
        /// Status on whether PIN2 has met criteria set in PIN_CNF2.SENSE register.
        /// Write '1' to clear.
        PIN2: u1 = 0,
        /// Status on whether PIN3 has met criteria set in PIN_CNF3.SENSE register.
        /// Write '1' to clear.
        PIN3: u1 = 0,
        /// Status on whether PIN4 has met criteria set in PIN_CNF4.SENSE register.
        /// Write '1' to clear.
        PIN4: u1 = 0,
        /// Status on whether PIN5 has met criteria set in PIN_CNF5.SENSE register.
        /// Write '1' to clear.
        PIN5: u1 = 0,
        /// Status on whether PIN6 has met criteria set in PIN_CNF6.SENSE register.
        /// Write '1' to clear.
        PIN6: u1 = 0,
        /// Status on whether PIN7 has met criteria set in PIN_CNF7.SENSE register.
        /// Write '1' to clear.
        PIN7: u1 = 0,
        /// Status on whether PIN8 has met criteria set in PIN_CNF8.SENSE register.
        /// Write '1' to clear.
        PIN8: u1 = 0,
        /// Status on whether PIN9 has met criteria set in PIN_CNF9.SENSE register.
        /// Write '1' to clear.
        PIN9: u1 = 0,
        /// Status on whether PIN10 has met criteria set in PIN_CNF10.SENSE register.
        /// Write '1' to clear.
        PIN10: u1 = 0,
        /// Status on whether PIN11 has met criteria set in PIN_CNF11.SENSE register.
        /// Write '1' to clear.
        PIN11: u1 = 0,
        /// Status on whether PIN12 has met criteria set in PIN_CNF12.SENSE register.
        /// Write '1' to clear.
        PIN12: u1 = 0,
        /// Status on whether PIN13 has met criteria set in PIN_CNF13.SENSE register.
        /// Write '1' to clear.
        PIN13: u1 = 0,
        /// Status on whether PIN14 has met criteria set in PIN_CNF14.SENSE register.
        /// Write '1' to clear.
        PIN14: u1 = 0,
        /// Status on whether PIN15 has met criteria set in PIN_CNF15.SENSE register.
        /// Write '1' to clear.
        PIN15: u1 = 0,
        /// Status on whether PIN16 has met criteria set in PIN_CNF16.SENSE register.
        /// Write '1' to clear.
        PIN16: u1 = 0,
        /// Status on whether PIN17 has met criteria set in PIN_CNF17.SENSE register.
        /// Write '1' to clear.
        PIN17: u1 = 0,
        /// Status on whether PIN18 has met criteria set in PIN_CNF18.SENSE register.
        /// Write '1' to clear.
        PIN18: u1 = 0,
        /// Status on whether PIN19 has met criteria set in PIN_CNF19.SENSE register.
        /// Write '1' to clear.
        PIN19: u1 = 0,
        /// Status on whether PIN20 has met criteria set in PIN_CNF20.SENSE register.
        /// Write '1' to clear.
        PIN20: u1 = 0,
        /// Status on whether PIN21 has met criteria set in PIN_CNF21.SENSE register.
        /// Write '1' to clear.
        PIN21: u1 = 0,
        /// Status on whether PIN22 has met criteria set in PIN_CNF22.SENSE register.
        /// Write '1' to clear.
        PIN22: u1 = 0,
        /// Status on whether PIN23 has met criteria set in PIN_CNF23.SENSE register.
        /// Write '1' to clear.
        PIN23: u1 = 0,
        /// Status on whether PIN24 has met criteria set in PIN_CNF24.SENSE register.
        /// Write '1' to clear.
        PIN24: u1 = 0,
        /// Status on whether PIN25 has met criteria set in PIN_CNF25.SENSE register.
        /// Write '1' to clear.
        PIN25: u1 = 0,
        /// Status on whether PIN26 has met criteria set in PIN_CNF26.SENSE register.
        /// Write '1' to clear.
        PIN26: u1 = 0,
        /// Status on whether PIN27 has met criteria set in PIN_CNF27.SENSE register.
        /// Write '1' to clear.
        PIN27: u1 = 0,
        /// Status on whether PIN28 has met criteria set in PIN_CNF28.SENSE register.
        /// Write '1' to clear.
        PIN28: u1 = 0,
        /// Status on whether PIN29 has met criteria set in PIN_CNF29.SENSE register.
        /// Write '1' to clear.
        PIN29: u1 = 0,
        /// Status on whether PIN30 has met criteria set in PIN_CNF30.SENSE register.
        /// Write '1' to clear.
        PIN30: u1 = 0,
        /// Status on whether PIN31 has met criteria set in PIN_CNF31.SENSE register.
        /// Write '1' to clear.
        PIN31: u1 = 0,
    });

    /// Select between default DETECT signal behaviour and LDETECT mode
    pub const DETECTMODE = mmio(Address + 0x00000524, 32, packed struct {
        /// Select between default DETECT signal behaviour and LDETECT mode
        DETECTMODE: u1 = 0,
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
    /// Description collection[0]: Configuration of GPIO pins
    pub const PIN_CNF = @intToPtr(*volatile [32]MMIO(32, packed struct {
        /// Pin direction. Same physical register as DIR register
        DIR: u1 = 0,
        /// Connect or disconnect input buffer
        INPUT: u1 = 0,
        /// Pull configuration
        PULL: u2 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Drive configuration
        DRIVE: u3 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Pin sensing mechanism
        SENSE: u2 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    }), Address + 0x00000700);
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

    POWER_CLOCK: InterruptVector = makeUnhandledHandler("POWER_CLOCK"),
    RADIO: InterruptVector = makeUnhandledHandler("RADIO"),
    UARTE0_UART0: InterruptVector = makeUnhandledHandler("UARTE0_UART0"),
    SPIM0_SPIS0_TWIM0_TWIS0_SPI0_TWI0: InterruptVector = makeUnhandledHandler("SPIM0_SPIS0_TWIM0_TWIS0_SPI0_TWI0"),
    SPIM1_SPIS1_TWIM1_TWIS1_SPI1_TWI1: InterruptVector = makeUnhandledHandler("SPIM1_SPIS1_TWIM1_TWIS1_SPI1_TWI1"),
    NFCT: InterruptVector = makeUnhandledHandler("NFCT"),
    GPIOTE: InterruptVector = makeUnhandledHandler("GPIOTE"),
    SAADC: InterruptVector = makeUnhandledHandler("SAADC"),
    TIMER0: InterruptVector = makeUnhandledHandler("TIMER0"),
    TIMER1: InterruptVector = makeUnhandledHandler("TIMER1"),
    TIMER2: InterruptVector = makeUnhandledHandler("TIMER2"),
    RTC0: InterruptVector = makeUnhandledHandler("RTC0"),
    TEMP: InterruptVector = makeUnhandledHandler("TEMP"),
    RNG: InterruptVector = makeUnhandledHandler("RNG"),
    ECB: InterruptVector = makeUnhandledHandler("ECB"),
    CCM_AAR: InterruptVector = makeUnhandledHandler("CCM_AAR"),
    WDT: InterruptVector = makeUnhandledHandler("WDT"),
    RTC1: InterruptVector = makeUnhandledHandler("RTC1"),
    QDEC: InterruptVector = makeUnhandledHandler("QDEC"),
    COMP_LPCOMP: InterruptVector = makeUnhandledHandler("COMP_LPCOMP"),
    SWI0_EGU0: InterruptVector = makeUnhandledHandler("SWI0_EGU0"),
    SWI1_EGU1: InterruptVector = makeUnhandledHandler("SWI1_EGU1"),
    SWI2_EGU2: InterruptVector = makeUnhandledHandler("SWI2_EGU2"),
    SWI3_EGU3: InterruptVector = makeUnhandledHandler("SWI3_EGU3"),
    SWI4_EGU4: InterruptVector = makeUnhandledHandler("SWI4_EGU4"),
    SWI5_EGU5: InterruptVector = makeUnhandledHandler("SWI5_EGU5"),
    TIMER3: InterruptVector = makeUnhandledHandler("TIMER3"),
    TIMER4: InterruptVector = makeUnhandledHandler("TIMER4"),
    PWM0: InterruptVector = makeUnhandledHandler("PWM0"),
    PDM: InterruptVector = makeUnhandledHandler("PDM"),
    reserved2: u32 = 0,
    reserved3: u32 = 0,
    MWU: InterruptVector = makeUnhandledHandler("MWU"),
    PWM1: InterruptVector = makeUnhandledHandler("PWM1"),
    PWM2: InterruptVector = makeUnhandledHandler("PWM2"),
    SPIM2_SPIS2_SPI2: InterruptVector = makeUnhandledHandler("SPIM2_SPIS2_SPI2"),
    RTC2: InterruptVector = makeUnhandledHandler("RTC2"),
    I2S: InterruptVector = makeUnhandledHandler("I2S"),
    FPU: InterruptVector = makeUnhandledHandler("FPU"),
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
