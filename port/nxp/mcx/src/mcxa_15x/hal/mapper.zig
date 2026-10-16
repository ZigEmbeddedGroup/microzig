const Self = @This();
const std = @import("std");
pub const PORTS = struct {
    pub const PORT0 = 0b00000000111111110000000001001111;
    pub const PORT1 = 0b11100000000000001111111111111111;
    pub const PORT2 = 0b00000000101110111011110011111111;
    pub const PORT3 = 0b11111000011111111111111111000111;
    pub const PORT4 = 0b00000000000000000000000011111100;
};

pub const PIN_MAP = packed struct(u8) {
    pin: u5,
    port: u3,
};

pub const PIN = enum(u8) {
    P0_0 = 0b00000000,
    P0_1 = 0b00000001,
    P0_16 = 0b00010000,
    P0_17 = 0b00010001,
    P0_18 = 0b00010010,
    P0_19 = 0b00010011,
    P0_2 = 0b00000010,
    P0_20 = 0b00010100,
    P0_21 = 0b00010101,
    P0_22 = 0b00010110,
    P0_23 = 0b00010111,
    P0_3 = 0b00000011,
    P0_6 = 0b00000110,
    P1_0 = 0b00100000,
    P1_1 = 0b00100001,
    P1_10 = 0b00101010,
    P1_11 = 0b00101011,
    P1_12 = 0b00101100,
    P1_13 = 0b00101101,
    P1_14 = 0b00101110,
    P1_15 = 0b00101111,
    P1_2 = 0b00100010,
    P1_29 = 0b00111101,
    P1_3 = 0b00100011,
    P1_30 = 0b00111110,
    P1_31 = 0b00111111,
    P1_4 = 0b00100100,
    P1_5 = 0b00100101,
    P1_6 = 0b00100110,
    P1_7 = 0b00100111,
    P1_8 = 0b00101000,
    P1_9 = 0b00101001,
    P2_0 = 0b01000000,
    P2_1 = 0b01000001,
    P2_10 = 0b01001010,
    P2_11 = 0b01001011,
    P2_12 = 0b01001100,
    P2_13 = 0b01001101,
    P2_15 = 0b01001111,
    P2_16 = 0b01010000,
    P2_17 = 0b01010001,
    P2_19 = 0b01010011,
    P2_2 = 0b01000010,
    P2_20 = 0b01010100,
    P2_21 = 0b01010101,
    P2_23 = 0b01010111,
    P2_3 = 0b01000011,
    P2_4 = 0b01000100,
    P2_5 = 0b01000101,
    P2_6 = 0b01000110,
    P2_7 = 0b01000111,
    P3_0 = 0b01100000,
    P3_1 = 0b01100001,
    P3_10 = 0b01101010,
    P3_11 = 0b01101011,
    P3_12 = 0b011_01100,
    P3_13 = 0b01101101,
    P3_14 = 0b01101110,
    P3_15 = 0b01101111,
    P3_16 = 0b01110000,
    P3_17 = 0b01110001,
    P3_18 = 0b01110010,
    P3_19 = 0b01110011,
    P3_2 = 0b01100010,
    P3_20 = 0b01110100,
    P3_21 = 0b01110101,
    P3_22 = 0b01110110,
    P3_27 = 0b01111011,
    P3_28 = 0b01111100,
    P3_29 = 0b01111101,
    P3_30 = 0b01111110,
    P3_31 = 0b01111111,
    P3_6 = 0b01100110,
    P3_7 = 0b01100111,
    P3_8 = 0b01101000,
    P3_9 = 0b01101001,
    P4_2 = 0b10000010,
    P4_3 = 0b10000011,
    P4_4 = 0b10000100,
    P4_5 = 0b10000101,
    P4_6 = 0b10000110,
    P4_7 = 0b10000111,

    pub fn mux(comptime pin: PIN) type {
        return @field(Self, @tagName(pin));
    }

    pub inline fn map(self: PIN) PIN_MAP {
        return @bitCast(self);
    }
};

pub const PERIPHERALS = enum(u16) {
    ADC0,
    ADC1,
    AOI0,
    AOI1,
    CAN0,
    CDOG,
    CLKOUT,
    CMC,
    CMP0,
    CMP1,
    CRC0,
    CT,
    CTIMER0,
    CTIMER1,
    CTIMER2,
    CTIMER3,
    CTIMER4,
    DAC0,
    DBGMAILBOX,
    DMA0,
    EDMA_0_TCD0,
    EIM0,
    ERM0,
    FLEXIO0,
    FLEXPWM0,
    FLEXPWM1,
    FMC0,
    FMU0,
    FREQME0,
    GLIKEY0,
    GPIO0,
    GPIO1,
    GPIO2,
    GPIO3,
    GPIO4,
    I3C0,
    LPI2C0,
    LPI2C1,
    LPI2C2,
    LPI2C3,
    LPSPI0,
    LPSPI1,
    LPTMR0,
    LPUART0,
    LPUART1,
    LPUART2,
    LPUART3,
    LPUART4,
    MBC0,
    MRCC0,
    NVIC,
    OPAMP0,
    OSTIMER0,
    PORT0,
    PORT1,
    PORT2,
    PORT3,
    PORT4,
    QDC0,
    QDC1,
    RESET,
    SAU,
    SCB,
    SCG0,
    SCnSCB,
    SPC0,
    SYSCON,
    SysTick,
    TRIG,
    USB0,
    UTICK0,
    VBAT0,
    WAKETIMER0,
    WUU0,
    WWDT0,
};

pub const SIGNALS = enum(u16) {
    ADC0_a0,
    ADC0_a1,
    ADC0_a10,
    ADC0_a11,
    ADC0_a12,
    ADC0_a13,
    ADC0_a14,
    ADC0_a15,
    ADC0_a16,
    ADC0_a17,
    ADC0_a18,
    ADC0_a19,
    ADC0_a2,
    ADC0_a20,
    ADC0_a21,
    ADC0_a22,
    ADC0_a23,
    ADC0_a4,
    ADC0_a5,
    ADC0_a6,
    ADC0_a7,
    ADC0_a8,
    ADC0_a9,
    ADC1_a0,
    ADC1_a1,
    ADC1_a10,
    ADC1_a11,
    ADC1_a12,
    ADC1_a13,
    ADC1_a2,
    ADC1_a20,
    ADC1_a21,
    ADC1_a22,
    ADC1_a3,
    ADC1_a4,
    ADC1_a5,
    ADC1_a6,
    ADC1_a7,
    ADC1_a8,
    ADC1_a9,
    CAN0_rxd,
    CAN0_txd,
    CLKOUT_clkout,
    CMP0_in0,
    CMP0_in1,
    CMP0_in2,
    CMP0_in3,
    CMP0_out,
    CMP1_in0,
    CMP1_in1,
    CMP1_in2,
    CMP1_in3,
    CMP1_out,
    CT_inp0,
    CT_inp1,
    CT_inp10,
    CT_inp11,
    CT_inp12,
    CT_inp13,
    CT_inp14,
    CT_inp15,
    CT_inp16,
    CT_inp17,
    CT_inp18,
    CT_inp19,
    CT_inp2,
    CT_inp3,
    CT_inp4,
    CT_inp5,
    CT_inp6,
    CT_inp7,
    CT_inp8,
    CT_inp9,
    CTIMER0_mat0,
    CTIMER0_mat1,
    CTIMER0_mat2,
    CTIMER0_mat3,
    CTIMER1_mat0,
    CTIMER1_mat1,
    CTIMER1_mat2,
    CTIMER1_mat3,
    CTIMER2_mat0,
    CTIMER2_mat1,
    CTIMER2_mat2,
    CTIMER2_mat3,
    CTIMER3_mat0,
    CTIMER3_mat1,
    CTIMER3_mat2,
    CTIMER3_mat3,
    CTIMER4_mat0,
    CTIMER4_mat1,
    CTIMER4_mat2,
    CTIMER4_mat3,
    DAC0_out,
    FLEXIO0_d0,
    FLEXIO0_d1,
    FLEXIO0_d10,
    FLEXIO0_d11,
    FLEXIO0_d12,
    FLEXIO0_d13,
    FLEXIO0_d14,
    FLEXIO0_d15,
    FLEXIO0_d16,
    FLEXIO0_d17,
    FLEXIO0_d18,
    FLEXIO0_d19,
    FLEXIO0_d2,
    FLEXIO0_d20,
    FLEXIO0_d21,
    FLEXIO0_d22,
    FLEXIO0_d23,
    FLEXIO0_d24,
    FLEXIO0_d25,
    FLEXIO0_d26,
    FLEXIO0_d27,
    FLEXIO0_d28,
    FLEXIO0_d29,
    FLEXIO0_d3,
    FLEXIO0_d30,
    FLEXIO0_d31,
    FLEXIO0_d4,
    FLEXIO0_d5,
    FLEXIO0_d6,
    FLEXIO0_d7,
    FLEXIO0_d8,
    FLEXIO0_d9,
    I3C0_pur,
    I3C0_scl,
    I3C0_sda,
    LPI2C0_hreq,
    LPI2C0_scl,
    LPI2C0_scls,
    LPI2C0_sda,
    LPI2C0_sdas,
    LPI2C1_scl,
    LPI2C1_scls,
    LPI2C1_sda,
    LPI2C1_sdas,
    LPI2C2_hreq,
    LPI2C2_scl,
    LPI2C2_scls,
    LPI2C2_sda,
    LPI2C2_sdas,
    LPI2C3_hreq,
    LPI2C3_scl,
    LPI2C3_scls,
    LPI2C3_sda,
    LPI2C3_sdas,
    LPSPI0_pcs0,
    LPSPI0_pcs1,
    LPSPI0_pcs2,
    LPSPI0_pcs3,
    LPSPI0_sck,
    LPSPI0_sdi,
    LPSPI0_sdo,
    LPSPI1_pcs0,
    LPSPI1_pcs1,
    LPSPI1_pcs2,
    LPSPI1_pcs3,
    LPSPI1_sck,
    LPSPI1_sdi,
    LPSPI1_sdo,
    LPUART0_cts,
    LPUART0_rts,
    LPUART0_rxd,
    LPUART0_txd,
    LPUART1_cts,
    LPUART1_rts,
    LPUART1_rxd,
    LPUART1_txd,
    LPUART2_cts,
    LPUART2_rts,
    LPUART2_rxd,
    LPUART2_txd,
    LPUART3_cts,
    LPUART3_rts,
    LPUART3_rxd,
    LPUART3_txd,
    LPUART4_cts,
    LPUART4_rts,
    LPUART4_rxd,
    LPUART4_txd,
    OPAMP0_inn,
    OPAMP0_inp0,
    OPAMP0_out,
    RESET_btn,
    TRIG_in0,
    TRIG_in1,
    TRIG_in10,
    TRIG_in11,
    TRIG_in2,
    TRIG_in3,
    TRIG_in4,
    TRIG_in5,
    TRIG_in6,
    TRIG_in7,
    TRIG_in8,
    TRIG_in9,
    TRIG_out0,
    TRIG_out1,
    TRIG_out2,
    TRIG_out3,
    TRIG_out4,
    TRIG_out5,
    TRIG_out6,
    TRIG_out7,
    USB0_det,

    pub fn pins(comptime signal: SIGNALS) type {
        var iter = std.mem.splitAny(u8, @tagName(signal), "_");
        const peri = iter.next().?;
        const sig = iter.next().?;

        return @field(@field(Self, peri), sig);
    }
};

pub const ADC0 = struct {
    pub const a0 = struct {
        pub const P2_0 = 0;
    };
    pub const a1 = struct {
        pub const P2_1 = 0;
    };
    pub const a10 = struct {
        pub const P0_20 = 0;
    };
    pub const a11 = struct {
        pub const P0_21 = 0;
    };
    pub const a12 = struct {
        pub const P0_22 = 0;
    };
    pub const a13 = struct {
        pub const P0_23 = 0;
    };
    pub const a14 = struct {
        pub const P0_3 = 0;
    };
    pub const a15 = struct {
        pub const P0_6 = 0;
    };
    pub const a16 = struct {
        pub const P1_0 = 0;
    };
    pub const a17 = struct {
        pub const P1_1 = 0;
    };
    pub const a18 = struct {
        pub const P1_2 = 0;
    };
    pub const a19 = struct {
        pub const P1_3 = 0;
    };
    pub const a2 = struct {
        pub const P2_15 = 0;
    };
    pub const a20 = struct {
        pub const P1_4 = 0;
    };
    pub const a21 = struct {
        pub const P1_5 = 0;
    };
    pub const a22 = struct {
        pub const P1_6 = 0;
    };
    pub const a23 = struct {
        pub const P1_7 = 0;
    };
    pub const a4 = struct {
        pub const P2_2 = 0;
    };
    pub const a5 = struct {
        pub const P2_12 = 0;
    };
    pub const a6 = struct {
        pub const P2_16 = 0;
    };
    pub const a7 = struct {
        pub const P2_7 = 0;
    };
    pub const a8 = struct {
        pub const P0_18 = 0;
    };
    pub const a9 = struct {
        pub const P0_19 = 0;
    };
};

pub const ADC1 = struct {
    pub const a0 = struct {
        pub const P2_4 = 0;
    };
    pub const a1 = struct {
        pub const P2_5 = 0;
    };
    pub const a10 = struct {
        pub const P1_12 = 0;
    };
    pub const a11 = struct {
        pub const P1_13 = 0;
    };
    pub const a12 = struct {
        pub const P1_14 = 0;
    };
    pub const a13 = struct {
        pub const P1_15 = 0;
    };
    pub const a2 = struct {
        pub const P2_19 = 0;
    };
    pub const a20 = struct {
        pub const P3_31 = 0;
    };
    pub const a21 = struct {
        pub const P3_30 = 0;
    };
    pub const a22 = struct {
        pub const P3_29 = 0;
    };
    pub const a3 = struct {
        pub const P2_6 = 0;
    };
    pub const a4 = struct {
        pub const P2_3 = 0;
    };
    pub const a5 = struct {
        pub const P2_13 = 0;
    };
    pub const a6 = struct {
        pub const P2_17 = 0;
    };
    pub const a7 = struct {
        pub const P2_7 = 0;
    };
    pub const a8 = struct {
        pub const P1_10 = 0;
    };
    pub const a9 = struct {
        pub const P1_11 = 0;
    };
};

pub const CAN0 = struct {
    pub const rxd = struct {
        pub const P1_11 = 11;
        pub const P1_12 = 11;
        pub const P2_12 = 11;
        pub const P1_3 = 11;
        pub const P1_7 = 11;
    };
    pub const txd = struct {
        pub const P1_10 = 11;
        pub const P1_13 = 11;
        pub const P2_13 = 11;
        pub const P1_2 = 11;
        pub const P1_6 = 11;
    };
};

pub const CLKOUT = struct {
    pub const clkout = struct {
        pub const P4_2 = 1;
        pub const P3_8 = 12;
        pub const P3_6 = 1;
        pub const P0_6 = 12;
    };
};

pub const CMP0 = struct {
    pub const in0 = struct {
        pub const P2_2 = 0;
    };
    pub const in1 = struct {
        pub const P1_3 = 0;
    };
    pub const in2 = struct {
        pub const P1_4 = 0;
    };
    pub const in3 = struct {
        pub const P1_0 = 0;
    };
    pub const out = struct {
        pub const P0_3 = 8;
        pub const P0_18 = 8;
    };
};

pub const CMP1 = struct {
    pub const in0 = struct {
        pub const P2_3 = 0;
    };
    pub const in1 = struct {
        pub const P0_3 = 0;
    };
    pub const in2 = struct {
        pub const P1_5 = 0;
    };
    pub const in3 = struct {
        pub const P1_1 = 0;
    };
    pub const out = struct {
        pub const P0_6 = 8;
        pub const P0_19 = 8;
    };
};

pub const CT = struct {
    pub const inp0 = struct {
        pub const P0_0 = 4;
        pub const P0_20 = 4;
        pub const P1_2 = 5;
    };
    pub const inp1 = struct {
        pub const P0_1 = 4;
        pub const P0_21 = 4;
        pub const P1_3 = 5;
    };
    pub const inp10 = struct {
        pub const P1_14 = 4;
        pub const P3_22 = 4;
    };
    pub const inp11 = struct {
        pub const P1_15 = 4;
    };
    pub const inp12 = struct {
        pub const P2_2 = 4;
        pub const P3_28 = 4;
    };
    pub const inp13 = struct {
        pub const P2_3 = 4;
        pub const P3_27 = 4;
    };
    pub const inp14 = struct {
        pub const P2_4 = 4;
    };
    pub const inp15 = struct {
        pub const P2_5 = 4;
    };
    pub const inp16 = struct {
        pub const P1_30 = 4;
        pub const P2_0 = 4;
        pub const P3_0 = 4;
    };
    pub const inp17 = struct {
        pub const P1_31 = 4;
        pub const P2_1 = 4;
        pub const P3_1 = 4;
    };
    pub const inp18 = struct {
        pub const P2_6 = 4;
    };
    pub const inp19 = struct {
        pub const P2_7 = 4;
    };
    pub const inp2 = struct {
        pub const P0_6 = 4;
        pub const P0_22 = 4;
    };
    pub const inp3 = struct {
        pub const P3_29 = 4;
        pub const P0_23 = 4;
    };
    pub const inp4 = struct {
        pub const P3_8 = 4;
        pub const P1_0 = 4;
    };
    pub const inp5 = struct {
        pub const P3_9 = 4;
        pub const P1_1 = 4;
    };
    pub const inp6 = struct {
        pub const P4_6 = 4;
        pub const P3_14 = 4;
        pub const P1_6 = 4;
    };
    pub const inp7 = struct {
        pub const P4_7 = 4;
        pub const P3_15 = 4;
        pub const P1_7 = 4;
    };
    pub const inp8 = struct {
        pub const P1_8 = 4;
        pub const P3_16 = 4;
    };
    pub const inp9 = struct {
        pub const P1_9 = 4;
        pub const P3_17 = 4;
    };
};

pub const CTIMER0 = struct {
    pub const mat0 = struct {
        pub const P2_12 = 5;
        pub const P0_2 = 4;
        pub const P0_16 = 4;
        pub const P0_22 = 5;
    };
    pub const mat1 = struct {
        pub const P2_13 = 5;
        pub const P0_3 = 4;
        pub const P0_17 = 4;
        pub const P0_23 = 5;
    };
    pub const mat2 = struct {
        pub const P1_8 = 5;
        pub const P2_15 = 5;
        pub const P2_16 = 5;
        pub const P3_30 = 4;
        pub const P0_18 = 4;
        pub const P1_0 = 5;
    };
    pub const mat3 = struct {
        pub const P1_9 = 5;
        pub const P2_17 = 5;
        pub const P3_31 = 4;
        pub const P0_19 = 4;
        pub const P1_1 = 5;
    };
};

pub const CTIMER1 = struct {
    pub const mat0 = struct {
        pub const P2_4 = 5;
        pub const P3_10 = 4;
        pub const P1_2 = 4;
    };
    pub const mat1 = struct {
        pub const P2_5 = 5;
        pub const P3_11 = 4;
        pub const P1_3 = 4;
    };
    pub const mat2 = struct {
        pub const P2_6 = 5;
        pub const P3_12 = 4;
        pub const P1_4 = 4;
    };
    pub const mat3 = struct {
        pub const P2_7 = 5;
        pub const P3_13 = 4;
        pub const P1_5 = 4;
    };
};

pub const CTIMER2 = struct {
    pub const mat0 = struct {
        pub const P1_10 = 4;
        pub const P2_0 = 5;
        pub const P2_20 = 4;
        pub const P3_18 = 4;
    };
    pub const mat1 = struct {
        pub const P1_11 = 4;
        pub const P2_1 = 5;
        pub const P2_21 = 4;
        pub const P3_19 = 4;
    };
    pub const mat2 = struct {
        pub const P1_12 = 4;
        pub const P2_2 = 5;
        pub const P3_20 = 4;
    };
    pub const mat3 = struct {
        pub const P1_13 = 4;
        pub const P2_3 = 5;
        pub const P2_23 = 4;
        pub const P3_21 = 4;
    };
};

pub const CTIMER3 = struct {
    pub const mat0 = struct {
        pub const P1_14 = 5;
        pub const P2_16 = 4;
    };
    pub const mat1 = struct {
        pub const P1_15 = 5;
        pub const P2_17 = 4;
        pub const P3_27 = 5;
    };
    pub const mat2 = struct {
        pub const P2_10 = 4;
        pub const P3_28 = 5;
    };
    pub const mat3 = struct {
        pub const P2_11 = 4;
        pub const P2_19 = 4;
        pub const P3_29 = 5;
    };
};

pub const CTIMER4 = struct {
    pub const mat0 = struct {
        pub const P4_2 = 4;
        pub const P2_12 = 4;
        pub const P3_2 = 4;
        pub const P1_6 = 5;
    };
    pub const mat1 = struct {
        pub const P4_3 = 4;
        pub const P2_13 = 4;
        pub const P1_7 = 5;
    };
    pub const mat2 = struct {
        pub const P4_4 = 4;
        pub const P3_6 = 4;
    };
    pub const mat3 = struct {
        pub const P4_5 = 4;
        pub const P2_15 = 4;
        pub const P3_7 = 4;
    };
};

pub const DAC0 = struct {
    pub const out = struct {
        pub const P2_2 = 0;
    };
};

pub const FLEXIO0 = struct {
    pub const d0 = struct {
        pub const P0_0 = 6;
        pub const P0_16 = 6;
    };
    pub const d1 = struct {
        pub const P0_1 = 6;
        pub const P0_17 = 6;
    };
    pub const d10 = struct {
        pub const P4_2 = 6;
        pub const P2_2 = 6;
        pub const P3_2 = 6;
        pub const P1_2 = 6;
    };
    pub const d11 = struct {
        pub const P4_3 = 6;
        pub const P2_3 = 6;
        pub const P1_3 = 6;
    };
    pub const d12 = struct {
        pub const P4_4 = 6;
        pub const P2_4 = 6;
        pub const P1_4 = 6;
    };
    pub const d13 = struct {
        pub const P4_5 = 6;
        pub const P2_5 = 6;
        pub const P1_5 = 6;
    };
    pub const d14 = struct {
        pub const P4_6 = 6;
        pub const P2_6 = 6;
        pub const P3_6 = 6;
        pub const P1_6 = 6;
    };
    pub const d15 = struct {
        pub const P4_7 = 6;
        pub const P2_7 = 6;
        pub const P3_7 = 6;
        pub const P1_7 = 6;
    };
    pub const d16 = struct {
        pub const P1_8 = 6;
        pub const P3_8 = 6;
    };
    pub const d17 = struct {
        pub const P1_9 = 6;
        pub const P3_9 = 6;
    };
    pub const d18 = struct {
        pub const P1_10 = 6;
        pub const P2_10 = 6;
        pub const P3_10 = 6;
    };
    pub const d19 = struct {
        pub const P1_11 = 6;
        pub const P2_11 = 6;
        pub const P3_11 = 6;
    };
    pub const d2 = struct {
        pub const P0_2 = 6;
        pub const P0_18 = 6;
    };
    pub const d20 = struct {
        pub const P1_12 = 6;
        pub const P2_12 = 6;
        pub const P3_12 = 6;
    };
    pub const d21 = struct {
        pub const P1_13 = 6;
        pub const P2_13 = 6;
        pub const P3_13 = 6;
    };
    pub const d22 = struct {
        pub const P1_14 = 6;
        pub const P3_14 = 6;
    };
    pub const d23 = struct {
        pub const P1_15 = 6;
        pub const P2_15 = 6;
        pub const P3_15 = 6;
    };
    pub const d24 = struct {
        pub const P2_16 = 6;
        pub const P3_16 = 6;
    };
    pub const d25 = struct {
        pub const P2_17 = 6;
        pub const P3_17 = 6;
    };
    pub const d26 = struct {
        pub const P3_18 = 6;
    };
    pub const d27 = struct {
        pub const P2_19 = 6;
        pub const P3_27 = 6;
        pub const P3_19 = 6;
    };
    pub const d28 = struct {
        pub const P2_20 = 6;
        pub const P3_28 = 6;
        pub const P3_20 = 6;
    };
    pub const d29 = struct {
        pub const P2_21 = 6;
        pub const P3_29 = 6;
        pub const P3_21 = 6;
    };
    pub const d3 = struct {
        pub const P0_3 = 6;
        pub const P0_19 = 6;
    };
    pub const d30 = struct {
        pub const P1_30 = 6;
        pub const P3_30 = 6;
        pub const P3_22 = 6;
    };
    pub const d31 = struct {
        pub const P1_31 = 6;
        pub const P2_23 = 6;
        pub const P3_31 = 6;
    };
    pub const d4 = struct {
        pub const P0_20 = 6;
    };
    pub const d5 = struct {
        pub const P0_21 = 6;
    };
    pub const d6 = struct {
        pub const P0_6 = 6;
        pub const P0_22 = 6;
    };
    pub const d7 = struct {
        pub const P0_23 = 6;
    };
    pub const d8 = struct {
        pub const P2_0 = 6;
        pub const P3_0 = 6;
        pub const P1_0 = 6;
    };
    pub const d9 = struct {
        pub const P2_1 = 6;
        pub const P3_1 = 6;
        pub const P1_1 = 6;
    };
};

pub const I3C0 = struct {
    pub const pur = struct {
        pub const P1_11 = 10;
        pub const P0_2 = 10;
    };
    pub const scl = struct {
        pub const P1_9 = 10;
        pub const P1_31 = 10;
        pub const P0_17 = 10;
    };
    pub const sda = struct {
        pub const P1_8 = 10;
        pub const P1_30 = 10;
        pub const P0_16 = 10;
    };
};

pub const LPI2C0 = struct {
    pub const hreq = struct {
        pub const P0_6 = 2;
    };
    pub const scl = struct {
        pub const P1_31 = 3;
        pub const P0_17 = 2;
    };
    pub const scls = struct {
        pub const P0_18 = 2;
    };
    pub const sda = struct {
        pub const P1_30 = 3;
        pub const P0_16 = 2;
    };
    pub const sdas = struct {
        pub const P0_19 = 2;
    };
};

pub const LPI2C1 = struct {
    pub const scl = struct {
        pub const P1_13 = 2;
        pub const P1_1 = 3;
    };
    pub const scls = struct {
        pub const P1_14 = 2;
        pub const P1_3 = 3;
    };
    pub const sda = struct {
        pub const P1_12 = 2;
        pub const P1_0 = 3;
    };
    pub const sdas = struct {
        pub const P1_15 = 2;
        pub const P1_2 = 3;
    };
};

pub const LPI2C2 = struct {
    pub const hreq = struct {
        pub const P4_6 = 2;
    };
    pub const scl = struct {
        pub const P1_9 = 3;
        pub const P4_3 = 2;
    };
    pub const scls = struct {
        pub const P1_11 = 3;
        pub const P4_5 = 2;
    };
    pub const sda = struct {
        pub const P1_8 = 3;
        pub const P4_4 = 2;
    };
    pub const sdas = struct {
        pub const P1_10 = 3;
        pub const P4_2 = 2;
    };
};

pub const LPI2C3 = struct {
    pub const hreq = struct {
        pub const P3_29 = 2;
    };
    pub const scl = struct {
        pub const P3_27 = 2;
        pub const P3_21 = 2;
    };
    pub const scls = struct {
        pub const P3_30 = 2;
    };
    pub const sda = struct {
        pub const P3_28 = 2;
        pub const P3_20 = 2;
    };
    pub const sdas = struct {
        pub const P3_31 = 2;
    };
};

pub const LPSPI0 = struct {
    pub const pcs0 = struct {
        pub const P0_0 = 3;
        pub const P1_3 = 2;
    };
    pub const pcs1 = struct {
        pub const P0_6 = 3;
        pub const P1_6 = 2;
    };
    pub const pcs2 = struct {
        pub const P0_16 = 3;
        pub const P1_5 = 2;
    };
    pub const pcs3 = struct {
        pub const P0_17 = 3;
        pub const P1_4 = 2;
    };
    pub const sck = struct {
        pub const P0_2 = 3;
        pub const P1_1 = 2;
    };
    pub const sdi = struct {
        pub const P0_1 = 3;
        pub const P1_2 = 2;
    };
    pub const sdo = struct {
        pub const P0_3 = 3;
        pub const P1_0 = 2;
    };
};

pub const LPSPI1 = struct {
    pub const pcs0 = struct {
        pub const P2_17 = 2;
        pub const P3_11 = 2;
    };
    pub const pcs1 = struct {
        pub const P2_6 = 2;
        pub const P3_2 = 2;
    };
    pub const pcs2 = struct {
        pub const P2_20 = 2;
        pub const P3_7 = 2;
    };
    pub const pcs3 = struct {
        pub const P2_21 = 2;
        pub const P3_6 = 2;
    };
    pub const sck = struct {
        pub const P2_12 = 2;
        pub const P3_10 = 2;
    };
    pub const sdi = struct {
        pub const P2_15 = 2;
        pub const P2_16 = 2;
        pub const P3_9 = 2;
    };
    pub const sdo = struct {
        pub const P2_13 = 2;
        pub const P3_8 = 2;
    };
};

pub const LPUART0 = struct {
    pub const cts = struct {
        pub const P2_3 = 2;
        pub const P0_1 = 2;
        pub const P0_23 = 3;
    };
    pub const rts = struct {
        pub const P2_2 = 2;
        pub const P0_0 = 2;
        pub const P0_22 = 3;
    };
    pub const rxd = struct {
        pub const P2_0 = 2;
        pub const P0_2 = 2;
        pub const P0_20 = 3;
    };
    pub const txd = struct {
        pub const P2_1 = 2;
        pub const P0_3 = 2;
        pub const P0_21 = 3;
    };
};

pub const LPUART1 = struct {
    pub const cts = struct {
        pub const P1_11 = 2;
        pub const P2_17 = 3;
        pub const P3_11 = 3;
    };
    pub const rts = struct {
        pub const P1_10 = 2;
        pub const P2_15 = 3;
        pub const P2_16 = 3;
        pub const P3_22 = 3;
        pub const P3_10 = 3;
    };
    pub const rxd = struct {
        pub const P1_8 = 2;
        pub const P2_12 = 3;
        pub const P3_20 = 3;
        pub const P3_8 = 3;
    };
    pub const txd = struct {
        pub const P1_9 = 2;
        pub const P2_13 = 3;
        pub const P3_21 = 3;
        pub const P3_9 = 3;
    };
};

pub const LPUART2 = struct {
    pub const cts = struct {
        pub const P1_15 = 3;
        pub const P2_4 = 3;
        pub const P3_13 = 2;
        pub const P1_7 = 3;
    };
    pub const rts = struct {
        pub const P1_14 = 3;
        pub const P2_5 = 3;
        pub const P3_12 = 2;
        pub const P1_6 = 3;
    };
    pub const rxd = struct {
        pub const P1_12 = 3;
        pub const P2_3 = 3;
        pub const P2_11 = 3;
        pub const P3_14 = 2;
        pub const P1_4 = 3;
    };
    pub const txd = struct {
        pub const P1_13 = 3;
        pub const P2_2 = 3;
        pub const P2_10 = 3;
        pub const P3_15 = 2;
        pub const P1_5 = 3;
    };
};

pub const LPUART3 = struct {
    pub const cts = struct {
        pub const P4_6 = 3;
        pub const P3_14 = 3;
        pub const P3_7 = 3;
    };
    pub const rts = struct {
        pub const P4_7 = 3;
        pub const P3_15 = 3;
        pub const P3_6 = 3;
    };
    pub const rxd = struct {
        pub const P4_2 = 3;
        pub const P3_13 = 3;
        pub const P3_0 = 3;
    };
    pub const txd = struct {
        pub const P4_5 = 3;
        pub const P3_12 = 3;
        pub const P3_1 = 3;
    };
};

pub const LPUART4 = struct {
    pub const cts = struct {
        pub const P2_0 = 3;
        pub const P3_31 = 3;
        pub const P3_17 = 2;
    };
    pub const rts = struct {
        pub const P2_1 = 3;
        pub const P3_30 = 3;
        pub const P3_16 = 2;
    };
    pub const rxd = struct {
        pub const P4_4 = 3;
        pub const P2_6 = 3;
        pub const P3_28 = 3;
        pub const P3_18 = 2;
    };
    pub const txd = struct {
        pub const P4_3 = 3;
        pub const P2_7 = 3;
        pub const P3_27 = 3;
        pub const P3_19 = 2;
    };
};

pub const OPAMP0 = struct {
    pub const inn = struct {
        pub const P2_13 = 0;
    };
    pub const inp0 = struct {
        pub const P2_12 = 0;
    };
    pub const out = struct {
        pub const P2_15 = 0;
    };
};

pub const RESET = struct {
    pub const btn = struct {
        pub const P1_29 = 1;
    };
};

pub const TRIG = struct {
    pub const in0 = struct {
        pub const P3_0 = 1;
        pub const P1_0 = 1;
    };
    pub const in1 = struct {
        pub const P3_1 = 1;
        pub const P1_1 = 1;
    };
    pub const in10 = struct {
        pub const P3_31 = 1;
    };
    pub const in11 = struct {
        pub const P3_28 = 1;
    };
    pub const in2 = struct {
        pub const P3_7 = 1;
        pub const P1_6 = 1;
    };
    pub const in3 = struct {
        pub const P1_13 = 1;
        pub const P3_8 = 1;
    };
    pub const in4 = struct {
        pub const P1_31 = 1;
        pub const P4_6 = 1;
        pub const P2_11 = 1;
        pub const P3_9 = 1;
    };
    pub const in5 = struct {
        pub const P4_7 = 1;
        pub const P2_7 = 1;
        pub const P3_10 = 1;
    };
    pub const in6 = struct {
        pub const P2_0 = 1;
        pub const P2_2 = 1;
        pub const P3_11 = 1;
    };
    pub const in7 = struct {
        pub const P2_1 = 1;
        pub const P2_3 = 1;
    };
    pub const in8 = struct {
        pub const P2_13 = 1;
        pub const P2_20 = 1;
    };
    pub const in9 = struct {
        pub const P2_17 = 1;
        pub const P2_21 = 1;
    };
    pub const out0 = struct {
        pub const P3_20 = 1;
        pub const P1_2 = 1;
    };
    pub const out1 = struct {
        pub const P3_21 = 1;
        pub const P1_3 = 1;
    };
    pub const out2 = struct {
        pub const P1_11 = 1;
        pub const P1_7 = 1;
    };
    pub const out3 = struct {
        pub const P1_30 = 1;
        pub const P4_5 = 1;
    };
    pub const out4 = struct {
        pub const P2_6 = 1;
        pub const P2_15 = 1;
    };
    pub const out5 = struct {
        pub const P2_10 = 1;
        pub const P2_19 = 1;
        pub const P2_23 = 1;
    };
    pub const out6 = struct {
        pub const P3_30 = 1;
    };
    pub const out7 = struct {
        pub const P3_27 = 1;
    };
};

pub const USB0 = struct {
    pub const det = struct {
        pub const P2_12 = 1;
    };
};

pub const P0_0 = enum(u4) {
    FLEXIO0_d0 = 6,
    LPSPI0_pcs0 = 3,
    LPUART0_rts = 2,
    CT_inp0 = 4,
};

pub const P0_1 = enum(u4) {
    FLEXIO0_d1 = 6,
    LPSPI0_sdi = 3,
    LPUART0_cts = 2,
    CT_inp1 = 4,
};

pub const P0_16 = enum(u4) {
    I3C0_sda = 10,
    CTIMER0_mat0 = 4,
    FLEXIO0_d0 = 6,
    LPI2C0_sda = 2,
    LPSPI0_pcs2 = 3,
};

pub const P0_17 = enum(u4) {
    I3C0_scl = 10,
    CTIMER0_mat1 = 4,
    FLEXIO0_d1 = 6,
    LPI2C0_scl = 2,
    LPSPI0_pcs3 = 3,
};

pub const P0_18 = enum(u4) {
    CTIMER0_mat2 = 4,
    FLEXIO0_d2 = 6,
    LPI2C0_scls = 2,
    ADC0_a8 = 0,
    CMP0_out = 8,
};

pub const P0_19 = enum(u4) {
    CTIMER0_mat3 = 4,
    FLEXIO0_d3 = 6,
    LPI2C0_sdas = 2,
    ADC0_a9 = 0,
    CMP1_out = 8,
};

pub const P0_2 = enum(u4) {
    I3C0_pur = 10,
    CTIMER0_mat0 = 4,
    FLEXIO0_d2 = 6,
    LPSPI0_sck = 3,
    LPUART0_rxd = 2,
};

pub const P0_20 = enum(u4) {
    FLEXIO0_d4 = 6,
    LPUART0_rxd = 3,
    ADC0_a10 = 0,
    CT_inp0 = 4,
};

pub const P0_21 = enum(u4) {
    FLEXIO0_d5 = 6,
    LPUART0_txd = 3,
    ADC0_a11 = 0,
    CT_inp1 = 4,
};

pub const P0_22 = enum(u4) {
    CTIMER0_mat0 = 5,
    FLEXIO0_d6 = 6,
    LPUART0_rts = 3,
    ADC0_a12 = 0,
    CT_inp2 = 4,
};

pub const P0_23 = enum(u4) {
    CTIMER0_mat1 = 5,
    FLEXIO0_d7 = 6,
    LPUART0_cts = 3,
    ADC0_a13 = 0,
    CT_inp3 = 4,
};

pub const P0_3 = enum(u4) {
    CTIMER0_mat1 = 4,
    FLEXIO0_d3 = 6,
    LPSPI0_sdo = 3,
    LPUART0_txd = 2,
    ADC0_a14 = 0,
    CMP0_out = 8,
    CMP1_in1 = 0,
};

pub const P0_6 = enum(u4) {
    FLEXIO0_d6 = 6,
    LPI2C0_hreq = 2,
    LPSPI0_pcs1 = 3,
    ADC0_a15 = 0,
    CMP1_out = 8,
    CLKOUT_clkout = 12,
    CT_inp2 = 4,
};

pub const P1_0 = enum(u4) {
    TRIG_in0 = 1,
    CTIMER0_mat2 = 5,
    FLEXIO0_d8 = 6,
    LPI2C1_sda = 3,
    LPSPI0_sdo = 2,
    ADC0_a16 = 0,
    CMP0_in3 = 0,
    CT_inp4 = 4,
};

pub const P1_1 = enum(u4) {
    TRIG_in1 = 1,
    CTIMER0_mat3 = 5,
    FLEXIO0_d9 = 6,
    LPI2C1_scl = 3,
    LPSPI0_sck = 2,
    ADC0_a17 = 0,
    CMP1_in3 = 0,
    CT_inp5 = 4,
};

pub const P1_10 = enum(u4) {
    CTIMER2_mat0 = 4,
    FLEXIO0_d18 = 6,
    LPI2C2_sdas = 3,
    LPUART1_rts = 2,
    ADC1_a8 = 0,
    CAN0_txd = 11,
};

pub const P1_11 = enum(u4) {
    TRIG_out2 = 1,
    I3C0_pur = 10,
    CTIMER2_mat1 = 4,
    FLEXIO0_d19 = 6,
    LPI2C2_scls = 3,
    LPUART1_cts = 2,
    ADC1_a9 = 0,
    CAN0_rxd = 11,
};

pub const P1_12 = enum(u4) {
    CTIMER2_mat2 = 4,
    FLEXIO0_d20 = 6,
    LPI2C1_sda = 2,
    LPUART2_rxd = 3,
    ADC1_a10 = 0,
    CAN0_rxd = 11,
};

pub const P1_13 = enum(u4) {
    TRIG_in3 = 1,
    CTIMER2_mat3 = 4,
    FLEXIO0_d21 = 6,
    LPI2C1_scl = 2,
    LPUART2_txd = 3,
    ADC1_a11 = 0,
    CAN0_txd = 11,
};

pub const P1_14 = enum(u4) {
    CTIMER3_mat0 = 5,
    FLEXIO0_d22 = 6,
    LPI2C1_scls = 2,
    LPUART2_rts = 3,
    ADC1_a12 = 0,
    CT_inp10 = 4,
};

pub const P1_15 = enum(u4) {
    CTIMER3_mat1 = 5,
    FLEXIO0_d23 = 6,
    LPI2C1_sdas = 2,
    LPUART2_cts = 3,
    ADC1_a13 = 0,
    CT_inp11 = 4,
};

pub const P1_2 = enum(u4) {
    TRIG_out0 = 1,
    CTIMER1_mat0 = 4,
    FLEXIO0_d10 = 6,
    LPI2C1_sdas = 3,
    LPSPI0_sdi = 2,
    ADC0_a18 = 0,
    CAN0_txd = 11,
    CT_inp0 = 5,
};

pub const P1_29 = enum(u4) {
    RESET_btn = 1,
};

pub const P1_3 = enum(u4) {
    TRIG_out1 = 1,
    CTIMER1_mat1 = 4,
    FLEXIO0_d11 = 6,
    LPI2C1_scls = 3,
    LPSPI0_pcs0 = 2,
    ADC0_a19 = 0,
    CMP0_in1 = 0,
    CAN0_rxd = 11,
    CT_inp1 = 5,
};

pub const P1_30 = enum(u4) {
    TRIG_out3 = 1,
    I3C0_sda = 10,
    FLEXIO0_d30 = 6,
    LPI2C0_sda = 3,
    CT_inp16 = 4,
};

pub const P1_31 = enum(u4) {
    TRIG_in4 = 1,
    I3C0_scl = 10,
    FLEXIO0_d31 = 6,
    LPI2C0_scl = 3,
    CT_inp17 = 4,
};

pub const P1_4 = enum(u4) {
    CTIMER1_mat2 = 4,
    FLEXIO0_d12 = 6,
    LPSPI0_pcs3 = 2,
    LPUART2_rxd = 3,
    ADC0_a20 = 0,
    CMP0_in2 = 0,
};

pub const P1_5 = enum(u4) {
    CTIMER1_mat3 = 4,
    FLEXIO0_d13 = 6,
    LPSPI0_pcs2 = 2,
    LPUART2_txd = 3,
    ADC0_a21 = 0,
    CMP1_in2 = 0,
};

pub const P1_6 = enum(u4) {
    TRIG_in2 = 1,
    CTIMER4_mat0 = 5,
    FLEXIO0_d14 = 6,
    LPSPI0_pcs1 = 2,
    LPUART2_rts = 3,
    ADC0_a22 = 0,
    CAN0_txd = 11,
    CT_inp6 = 4,
};

pub const P1_7 = enum(u4) {
    TRIG_out2 = 1,
    CTIMER4_mat1 = 5,
    FLEXIO0_d15 = 6,
    LPUART2_cts = 3,
    ADC0_a23 = 0,
    CAN0_rxd = 11,
    CT_inp7 = 4,
};

pub const P1_8 = enum(u4) {
    I3C0_sda = 10,
    CTIMER0_mat2 = 5,
    FLEXIO0_d16 = 6,
    LPI2C2_sda = 3,
    LPUART1_rxd = 2,
    CT_inp8 = 4,
};

pub const P1_9 = enum(u4) {
    I3C0_scl = 10,
    CTIMER0_mat3 = 5,
    FLEXIO0_d17 = 6,
    LPI2C2_scl = 3,
    LPUART1_txd = 2,
    CT_inp9 = 4,
};

pub const P2_0 = enum(u4) {
    TRIG_in6 = 1,
    CTIMER2_mat0 = 5,
    FLEXIO0_d8 = 6,
    LPUART0_rxd = 2,
    LPUART4_cts = 3,
    ADC0_a0 = 0,
    CT_inp16 = 4,
};

pub const P2_1 = enum(u4) {
    TRIG_in7 = 1,
    CTIMER2_mat1 = 5,
    FLEXIO0_d9 = 6,
    LPUART0_txd = 2,
    LPUART4_rts = 3,
    ADC0_a1 = 0,
    CT_inp17 = 4,
};

pub const P2_10 = enum(u4) {
    TRIG_out5 = 1,
    CTIMER3_mat2 = 4,
    FLEXIO0_d18 = 6,
    LPUART2_txd = 3,
};

pub const P2_11 = enum(u4) {
    TRIG_in4 = 1,
    CTIMER3_mat3 = 4,
    FLEXIO0_d19 = 6,
    LPUART2_rxd = 3,
};

pub const P2_12 = enum(u4) {
    CTIMER0_mat0 = 5,
    CTIMER4_mat0 = 4,
    FLEXIO0_d20 = 6,
    LPSPI1_sck = 2,
    LPUART1_rxd = 3,
    USB0_det = 1,
    ADC0_a5 = 0,
    OPAMP0_inp0 = 0,
    CAN0_rxd = 11,
};

pub const P2_13 = enum(u4) {
    TRIG_in8 = 1,
    CTIMER0_mat1 = 5,
    CTIMER4_mat1 = 4,
    FLEXIO0_d21 = 6,
    LPSPI1_sdo = 2,
    LPUART1_txd = 3,
    ADC1_a5 = 0,
    OPAMP0_inn = 0,
    CAN0_txd = 11,
};

pub const P2_15 = enum(u4) {
    TRIG_out4 = 1,
    CTIMER0_mat2 = 5,
    CTIMER4_mat3 = 4,
    FLEXIO0_d23 = 6,
    LPSPI1_sdi = 2,
    LPUART1_rts = 3,
    ADC0_a2 = 0,
    OPAMP0_out = 0,
};

pub const P2_16 = enum(u4) {
    CTIMER0_mat2 = 5,
    CTIMER3_mat0 = 4,
    FLEXIO0_d24 = 6,
    LPSPI1_sdi = 2,
    LPUART1_rts = 3,
    ADC0_a6 = 0,
};

pub const P2_17 = enum(u4) {
    TRIG_in9 = 1,
    CTIMER0_mat3 = 5,
    CTIMER3_mat1 = 4,
    FLEXIO0_d25 = 6,
    LPSPI1_pcs0 = 2,
    LPUART1_cts = 3,
    ADC1_a6 = 0,
};

pub const P2_19 = enum(u4) {
    TRIG_out5 = 1,
    CTIMER3_mat3 = 4,
    FLEXIO0_d27 = 6,
    ADC1_a2 = 0,
};

pub const P2_2 = enum(u4) {
    TRIG_in6 = 1,
    CTIMER2_mat2 = 5,
    FLEXIO0_d10 = 6,
    LPUART0_rts = 2,
    LPUART2_txd = 3,
    ADC0_a4 = 0,
    CMP0_in0 = 0,
    DAC0_out = 0,
    CT_inp12 = 4,
};

pub const P2_20 = enum(u4) {
    TRIG_in8 = 1,
    CTIMER2_mat0 = 4,
    FLEXIO0_d28 = 6,
    LPSPI1_pcs2 = 2,
};

pub const P2_21 = enum(u4) {
    TRIG_in9 = 1,
    CTIMER2_mat1 = 4,
    FLEXIO0_d29 = 6,
    LPSPI1_pcs3 = 2,
};

pub const P2_23 = enum(u4) {
    TRIG_out5 = 1,
    CTIMER2_mat3 = 4,
    FLEXIO0_d31 = 6,
};

pub const P2_3 = enum(u4) {
    TRIG_in7 = 1,
    CTIMER2_mat3 = 5,
    FLEXIO0_d11 = 6,
    LPUART0_cts = 2,
    LPUART2_rxd = 3,
    ADC1_a4 = 0,
    CMP1_in0 = 0,
    CT_inp13 = 4,
};

pub const P2_4 = enum(u4) {
    CTIMER1_mat0 = 5,
    FLEXIO0_d12 = 6,
    LPUART2_cts = 3,
    ADC1_a0 = 0,
    CT_inp14 = 4,
};

pub const P2_5 = enum(u4) {
    CTIMER1_mat1 = 5,
    FLEXIO0_d13 = 6,
    LPUART2_rts = 3,
    ADC1_a1 = 0,
    CT_inp15 = 4,
};

pub const P2_6 = enum(u4) {
    TRIG_out4 = 1,
    CTIMER1_mat2 = 5,
    FLEXIO0_d14 = 6,
    LPSPI1_pcs1 = 2,
    LPUART4_rxd = 3,
    ADC1_a3 = 0,
    CT_inp18 = 4,
};

pub const P2_7 = enum(u4) {
    TRIG_in5 = 1,
    CTIMER1_mat3 = 5,
    FLEXIO0_d15 = 6,
    LPUART4_txd = 3,
    ADC0_a7 = 0,
    ADC1_a7 = 0,
    CT_inp19 = 4,
};

pub const P3_0 = enum(u4) {
    TRIG_in0 = 1,
    FLEXIO0_d8 = 6,
    LPUART3_rxd = 3,
    CT_inp16 = 4,
};

pub const P3_1 = enum(u4) {
    TRIG_in1 = 1,
    FLEXIO0_d9 = 6,
    LPUART3_txd = 3,
    CT_inp17 = 4,
};

pub const P3_10 = enum(u4) {
    TRIG_in5 = 1,
    CTIMER1_mat0 = 4,
    FLEXIO0_d18 = 6,
    LPSPI1_sck = 2,
    LPUART1_rts = 3,
};

pub const P3_11 = enum(u4) {
    TRIG_in6 = 1,
    CTIMER1_mat1 = 4,
    FLEXIO0_d19 = 6,
    LPSPI1_pcs0 = 2,
    LPUART1_cts = 3,
};

pub const P3_12 = enum(u4) {
    CTIMER1_mat2 = 4,
    FLEXIO0_d20 = 6,
    LPUART2_rts = 2,
    LPUART3_txd = 3,
};

pub const P3_13 = enum(u4) {
    CTIMER1_mat3 = 4,
    FLEXIO0_d21 = 6,
    LPUART2_cts = 2,
    LPUART3_rxd = 3,
};

pub const P3_14 = enum(u4) {
    FLEXIO0_d22 = 6,
    LPUART2_rxd = 2,
    LPUART3_cts = 3,
    CT_inp6 = 4,
};

pub const P3_15 = enum(u4) {
    FLEXIO0_d23 = 6,
    LPUART2_txd = 2,
    LPUART3_rts = 3,
    CT_inp7 = 4,
};

pub const P3_16 = enum(u4) {
    FLEXIO0_d24 = 6,
    LPUART4_rts = 2,
    CT_inp8 = 4,
};

pub const P3_17 = enum(u4) {
    FLEXIO0_d25 = 6,
    LPUART4_cts = 2,
    CT_inp9 = 4,
};

pub const P3_18 = enum(u4) {
    CTIMER2_mat0 = 4,
    FLEXIO0_d26 = 6,
    LPUART4_rxd = 2,
};

pub const P3_19 = enum(u4) {
    CTIMER2_mat1 = 4,
    FLEXIO0_d27 = 6,
    LPUART4_txd = 2,
};

pub const P3_2 = enum(u4) {
    CTIMER4_mat0 = 4,
    FLEXIO0_d10 = 6,
    LPSPI1_pcs1 = 2,
};

pub const P3_20 = enum(u4) {
    TRIG_out0 = 1,
    CTIMER2_mat2 = 4,
    FLEXIO0_d28 = 6,
    LPI2C3_sda = 2,
    LPUART1_rxd = 3,
};

pub const P3_21 = enum(u4) {
    TRIG_out1 = 1,
    CTIMER2_mat3 = 4,
    FLEXIO0_d29 = 6,
    LPI2C3_scl = 2,
    LPUART1_txd = 3,
};

pub const P3_22 = enum(u4) {
    FLEXIO0_d30 = 6,
    LPUART1_rts = 3,
    CT_inp10 = 4,
};

pub const P3_27 = enum(u4) {
    TRIG_out7 = 1,
    CTIMER3_mat1 = 5,
    FLEXIO0_d27 = 6,
    LPI2C3_scl = 2,
    LPUART4_txd = 3,
    CT_inp13 = 4,
};

pub const P3_28 = enum(u4) {
    TRIG_in11 = 1,
    CTIMER3_mat2 = 5,
    FLEXIO0_d28 = 6,
    LPI2C3_sda = 2,
    LPUART4_rxd = 3,
    CT_inp12 = 4,
};

pub const P3_29 = enum(u4) {
    CTIMER3_mat3 = 5,
    FLEXIO0_d29 = 6,
    LPI2C3_hreq = 2,
    ADC1_a22 = 0,
    CT_inp3 = 4,
};

pub const P3_30 = enum(u4) {
    TRIG_out6 = 1,
    CTIMER0_mat2 = 4,
    FLEXIO0_d30 = 6,
    LPI2C3_scls = 2,
    LPUART4_rts = 3,
    ADC1_a21 = 0,
};

pub const P3_31 = enum(u4) {
    TRIG_in10 = 1,
    CTIMER0_mat3 = 4,
    FLEXIO0_d31 = 6,
    LPI2C3_sdas = 2,
    LPUART4_cts = 3,
    ADC1_a20 = 0,
};

pub const P3_6 = enum(u4) {
    CTIMER4_mat2 = 4,
    FLEXIO0_d14 = 6,
    LPSPI1_pcs3 = 2,
    LPUART3_rts = 3,
    CLKOUT_clkout = 1,
};

pub const P3_7 = enum(u4) {
    TRIG_in2 = 1,
    CTIMER4_mat3 = 4,
    FLEXIO0_d15 = 6,
    LPSPI1_pcs2 = 2,
    LPUART3_cts = 3,
};

pub const P3_8 = enum(u4) {
    TRIG_in3 = 1,
    FLEXIO0_d16 = 6,
    LPSPI1_sdo = 2,
    LPUART1_rxd = 3,
    CLKOUT_clkout = 12,
    CT_inp4 = 4,
};

pub const P3_9 = enum(u4) {
    TRIG_in4 = 1,
    FLEXIO0_d17 = 6,
    LPSPI1_sdi = 2,
    LPUART1_txd = 3,
    CT_inp5 = 4,
};

pub const P4_2 = enum(u4) {
    CTIMER4_mat0 = 4,
    FLEXIO0_d10 = 6,
    LPI2C2_sdas = 2,
    LPUART3_rxd = 3,
    CLKOUT_clkout = 1,
};

pub const P4_3 = enum(u4) {
    CTIMER4_mat1 = 4,
    FLEXIO0_d11 = 6,
    LPI2C2_scl = 2,
    LPUART4_txd = 3,
};

pub const P4_4 = enum(u4) {
    CTIMER4_mat2 = 4,
    FLEXIO0_d12 = 6,
    LPI2C2_sda = 2,
    LPUART4_rxd = 3,
};

pub const P4_5 = enum(u4) {
    TRIG_out3 = 1,
    CTIMER4_mat3 = 4,
    FLEXIO0_d13 = 6,
    LPI2C2_scls = 2,
    LPUART3_txd = 3,
};

pub const P4_6 = enum(u4) {
    TRIG_in4 = 1,
    FLEXIO0_d14 = 6,
    LPI2C2_hreq = 2,
    LPUART3_cts = 3,
    CT_inp6 = 4,
};

pub const P4_7 = enum(u4) {
    TRIG_in5 = 1,
    FLEXIO0_d15 = 6,
    LPUART3_rts = 3,
    CT_inp7 = 4,
};
