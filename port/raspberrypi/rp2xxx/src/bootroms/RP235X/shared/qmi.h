/**
 * Copyright (c) 2024 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
// =============================================================================
// Register block : QMI (Quad SPI Memory Interface)
// Version        : 1
// Bus type       : apb
// Description    : QSPI Memory Interface
//                  RP2350 uses QMI instead of SSI for flash access
// =============================================================================
#ifndef HARDWARE_REGS_QMI_DEFINED
#define HARDWARE_REGS_QMI_DEFINED

// =============================================================================
// Register    : QMI_DIRECT_CSR
// Description : Control and status for direct serial mode
#define QMI_DIRECT_CSR_OFFSET _u(0x00000000)
#define QMI_DIRECT_CSR_BITS   _u(0x00ffffff)
#define QMI_DIRECT_CSR_RESET  _u(0x00000000)

// Field       : QMI_DIRECT_CSR_CLKDIV
// Description : Clock divisor for direct mode
#define QMI_DIRECT_CSR_CLKDIV_RESET  _u(0x00)
#define QMI_DIRECT_CSR_CLKDIV_BITS   _u(0x0000ff00)
#define QMI_DIRECT_CSR_CLKDIV_MSB    _u(15)
#define QMI_DIRECT_CSR_CLKDIV_LSB    _u(8)
#define QMI_DIRECT_CSR_CLKDIV_ACCESS "RW"

// Field       : QMI_DIRECT_CSR_RXDELAY
// Description : Delay RX sampling by this many system clocks
#define QMI_DIRECT_CSR_RXDELAY_RESET  _u(0x0)
#define QMI_DIRECT_CSR_RXDELAY_BITS   _u(0x00000030)
#define QMI_DIRECT_CSR_RXDELAY_MSB    _u(5)
#define QMI_DIRECT_CSR_RXDELAY_LSB    _u(4)
#define QMI_DIRECT_CSR_RXDELAY_ACCESS "RW"

// Field       : QMI_DIRECT_CSR_ASSERT_CS1N
// Description : Assert CS1 (not CS0)
#define QMI_DIRECT_CSR_ASSERT_CS1N_RESET  _u(0x0)
#define QMI_DIRECT_CSR_ASSERT_CS1N_BITS   _u(0x00000002)
#define QMI_DIRECT_CSR_ASSERT_CS1N_MSB    _u(1)
#define QMI_DIRECT_CSR_ASSERT_CS1N_LSB    _u(1)
#define QMI_DIRECT_CSR_ASSERT_CS1N_ACCESS "RW"

// Field       : QMI_DIRECT_CSR_EN
// Description : Enable direct mode
#define QMI_DIRECT_CSR_EN_RESET  _u(0x0)
#define QMI_DIRECT_CSR_EN_BITS   _u(0x00000001)
#define QMI_DIRECT_CSR_EN_MSB    _u(0)
#define QMI_DIRECT_CSR_EN_LSB    _u(0)
#define QMI_DIRECT_CSR_EN_ACCESS "RW"

// =============================================================================
// Register    : QMI_DIRECT_TX
// Description : Direct mode TX data
#define QMI_DIRECT_TX_OFFSET _u(0x00000004)
#define QMI_DIRECT_TX_BITS   _u(0xffffffff)
#define QMI_DIRECT_TX_RESET  _u(0x00000000)

// Field       : QMI_DIRECT_TX_OE
// Description : Output enable (active high)
#define QMI_DIRECT_TX_OE_RESET  _u(0x0)
#define QMI_DIRECT_TX_OE_BITS   _u(0x00010000)
#define QMI_DIRECT_TX_OE_MSB    _u(16)
#define QMI_DIRECT_TX_OE_LSB    _u(16)
#define QMI_DIRECT_TX_OE_ACCESS "RW"

// Field       : QMI_DIRECT_TX_IWIDTH
// Description : Instruction/address width
//               0x0 -> 1-bit
//               0x1 -> 2-bit (dual)
//               0x2 -> 4-bit (quad)
#define QMI_DIRECT_TX_IWIDTH_RESET  _u(0x0)
#define QMI_DIRECT_TX_IWIDTH_BITS   _u(0x00003000)
#define QMI_DIRECT_TX_IWIDTH_MSB    _u(13)
#define QMI_DIRECT_TX_IWIDTH_LSB    _u(12)
#define QMI_DIRECT_TX_IWIDTH_ACCESS "RW"

// Field       : QMI_DIRECT_TX_DWIDTH
// Description : Data width
//               0x0 -> 1-bit
//               0x1 -> 2-bit (dual)
//               0x2 -> 4-bit (quad)
#define QMI_DIRECT_TX_DWIDTH_RESET  _u(0x0)
#define QMI_DIRECT_TX_DWIDTH_BITS   _u(0x00000c00)
#define QMI_DIRECT_TX_DWIDTH_MSB    _u(11)
#define QMI_DIRECT_TX_DWIDTH_LSB    _u(10)
#define QMI_DIRECT_TX_DWIDTH_ACCESS "RW"

// Field       : QMI_DIRECT_TX_NOPUSH
// Description : Do not push data into RX FIFO
#define QMI_DIRECT_TX_NOPUSH_RESET  _u(0x0)
#define QMI_DIRECT_TX_NOPUSH_BITS   _u(0x00000100)
#define QMI_DIRECT_TX_NOPUSH_MSB    _u(8)
#define QMI_DIRECT_TX_NOPUSH_LSB    _u(8)
#define QMI_DIRECT_TX_NOPUSH_ACCESS "RW"

// Field       : QMI_DIRECT_TX_DATA
// Description : Data to transmit
#define QMI_DIRECT_TX_DATA_RESET  _u(0x00)
#define QMI_DIRECT_TX_DATA_BITS   _u(0x000000ff)
#define QMI_DIRECT_TX_DATA_MSB    _u(7)
#define QMI_DIRECT_TX_DATA_LSB    _u(0)
#define QMI_DIRECT_TX_DATA_ACCESS "WF"

// =============================================================================
// Register    : QMI_DIRECT_RX
// Description : Direct mode RX data
#define QMI_DIRECT_RX_OFFSET _u(0x00000008)
#define QMI_DIRECT_RX_BITS   _u(0x000000ff)
#define QMI_DIRECT_RX_RESET  _u(0x00000000)

// Field       : QMI_DIRECT_RX_DATA
// Description : Received data
#define QMI_DIRECT_RX_DATA_RESET  _u(0x00)
#define QMI_DIRECT_RX_DATA_BITS   _u(0x000000ff)
#define QMI_DIRECT_RX_DATA_MSB    _u(7)
#define QMI_DIRECT_RX_DATA_LSB    _u(0)
#define QMI_DIRECT_RX_DATA_ACCESS "RF"

// =============================================================================
// Register    : QMI_M0_TIMING
// Description : Memory window 0 timing
#define QMI_M0_TIMING_OFFSET _u(0x0000000c)
#define QMI_M0_TIMING_BITS   _u(0xffffffff)
#define QMI_M0_TIMING_RESET  _u(0x40000000)

// Field       : QMI_M0_TIMING_COOLDOWN
// Description : Cooldown cycles after CS deassert
#define QMI_M0_TIMING_COOLDOWN_RESET  _u(0x02)
#define QMI_M0_TIMING_COOLDOWN_BITS   _u(0x000000c0)
#define QMI_M0_TIMING_COOLDOWN_MSB    _u(7)
#define QMI_M0_TIMING_COOLDOWN_LSB    _u(6)
#define QMI_M0_TIMING_COOLDOWN_ACCESS "RW"

// Field       : QMI_M0_TIMING_PAGEBREAK
// Description : Page break cycles
#define QMI_M0_TIMING_PAGEBREAK_RESET  _u(0x00)
#define QMI_M0_TIMING_PAGEBREAK_BITS   _u(0x00000030)
#define QMI_M0_TIMING_PAGEBREAK_MSB    _u(5)
#define QMI_M0_TIMING_PAGEBREAK_LSB    _u(4)
#define QMI_M0_TIMING_PAGEBREAK_ACCESS "RW"

// Field       : QMI_M0_TIMING_SELECT_SETUP
// Description : CS setup time
#define QMI_M0_TIMING_SELECT_SETUP_RESET  _u(0x1)
#define QMI_M0_TIMING_SELECT_SETUP_BITS   _u(0x0000000c)
#define QMI_M0_TIMING_SELECT_SETUP_MSB    _u(3)
#define QMI_M0_TIMING_SELECT_SETUP_LSB    _u(2)
#define QMI_M0_TIMING_SELECT_SETUP_ACCESS "RW"

// Field       : QMI_M0_TIMING_SELECT_HOLD
// Description : CS hold time
#define QMI_M0_TIMING_SELECT_HOLD_RESET  _u(0x1)
#define QMI_M0_TIMING_SELECT_HOLD_BITS   _u(0x00000003)
#define QMI_M0_TIMING_SELECT_HOLD_MSB    _u(1)
#define QMI_M0_TIMING_SELECT_HOLD_LSB    _u(0)
#define QMI_M0_TIMING_SELECT_HOLD_ACCESS "RW"

// =============================================================================
// Register    : QMI_M0_RFMT
// Description : Memory window 0 read format
#define QMI_M0_RFMT_OFFSET _u(0x00000010)
#define QMI_M0_RFMT_BITS   _u(0xffffffff)
#define QMI_M0_RFMT_RESET  _u(0x00000000)

// Field       : QMI_M0_RFMT_DTR
// Description : Enable DTR (double transfer rate)
#define QMI_M0_RFMT_DTR_RESET  _u(0x0)
#define QMI_M0_RFMT_DTR_BITS   _u(0x10000000)
#define QMI_M0_RFMT_DTR_MSB    _u(28)
#define QMI_M0_RFMT_DTR_LSB    _u(28)
#define QMI_M0_RFMT_DTR_ACCESS "RW"

// Field       : QMI_M0_RFMT_DUMMY_LEN
// Description : Number of dummy cycles
#define QMI_M0_RFMT_DUMMY_LEN_RESET  _u(0x00)
#define QMI_M0_RFMT_DUMMY_LEN_BITS   _u(0x00070000)
#define QMI_M0_RFMT_DUMMY_LEN_MSB    _u(18)
#define QMI_M0_RFMT_DUMMY_LEN_LSB    _u(16)
#define QMI_M0_RFMT_DUMMY_LEN_ACCESS "RW"

// Field       : QMI_M0_RFMT_SUFFIX_LEN
// Description : Suffix length in bits
#define QMI_M0_RFMT_SUFFIX_LEN_RESET  _u(0x0)
#define QMI_M0_RFMT_SUFFIX_LEN_BITS   _u(0x00003000)
#define QMI_M0_RFMT_SUFFIX_LEN_MSB    _u(13)
#define QMI_M0_RFMT_SUFFIX_LEN_LSB    _u(12)
#define QMI_M0_RFMT_SUFFIX_LEN_ACCESS "RW"

// Field       : QMI_M0_RFMT_PREFIX_LEN
// Description : Prefix length (command + mode) in bits
#define QMI_M0_RFMT_PREFIX_LEN_RESET  _u(0x0)
#define QMI_M0_RFMT_PREFIX_LEN_BITS   _u(0x00000100)
#define QMI_M0_RFMT_PREFIX_LEN_MSB    _u(8)
#define QMI_M0_RFMT_PREFIX_LEN_LSB    _u(8)
#define QMI_M0_RFMT_PREFIX_LEN_ACCESS "RW"

// Field       : QMI_M0_RFMT_DATA_WIDTH
// Description : Data width
//               0x0 -> 1-bit
//               0x1 -> 2-bit (dual)
//               0x2 -> 4-bit (quad)
#define QMI_M0_RFMT_DATA_WIDTH_RESET  _u(0x0)
#define QMI_M0_RFMT_DATA_WIDTH_BITS   _u(0x00000030)
#define QMI_M0_RFMT_DATA_WIDTH_MSB    _u(5)
#define QMI_M0_RFMT_DATA_WIDTH_LSB    _u(4)
#define QMI_M0_RFMT_DATA_WIDTH_ACCESS "RW"

// Field       : QMI_M0_RFMT_ADDR_WIDTH
// Description : Address width
//               0x0 -> 1-bit
//               0x1 -> 2-bit (dual)
//               0x2 -> 4-bit (quad)
#define QMI_M0_RFMT_ADDR_WIDTH_RESET  _u(0x0)
#define QMI_M0_RFMT_ADDR_WIDTH_BITS   _u(0x0000000c)
#define QMI_M0_RFMT_ADDR_WIDTH_MSB    _u(3)
#define QMI_M0_RFMT_ADDR_WIDTH_LSB    _u(2)
#define QMI_M0_RFMT_ADDR_WIDTH_ACCESS "RW"

// Field       : QMI_M0_RFMT_INSTR_WIDTH
// Description : Instruction width
//               0x0 -> 1-bit
//               0x1 -> 2-bit (dual)
//               0x2 -> 4-bit (quad)
#define QMI_M0_RFMT_INSTR_WIDTH_RESET  _u(0x0)
#define QMI_M0_RFMT_INSTR_WIDTH_BITS   _u(0x00000003)
#define QMI_M0_RFMT_INSTR_WIDTH_MSB    _u(1)
#define QMI_M0_RFMT_INSTR_WIDTH_LSB    _u(0)
#define QMI_M0_RFMT_INSTR_WIDTH_ACCESS "RW"

// =============================================================================
// Register    : QMI_M0_RCMD
// Description : Memory window 0 read command
#define QMI_M0_RCMD_OFFSET _u(0x00000014)
#define QMI_M0_RCMD_BITS   _u(0x0000ffff)
#define QMI_M0_RCMD_RESET  _u(0x00000000)

// Field       : QMI_M0_RCMD_SUFFIX
// Description : Command suffix (mode bits)
#define QMI_M0_RCMD_SUFFIX_RESET  _u(0x00)
#define QMI_M0_RCMD_SUFFIX_BITS   _u(0x0000ff00)
#define QMI_M0_RCMD_SUFFIX_MSB    _u(15)
#define QMI_M0_RCMD_SUFFIX_LSB    _u(8)
#define QMI_M0_RCMD_SUFFIX_ACCESS "RW"

// Field       : QMI_M0_RCMD_PREFIX
// Description : Command prefix (instruction byte)
#define QMI_M0_RCMD_PREFIX_RESET  _u(0x00)
#define QMI_M0_RCMD_PREFIX_BITS   _u(0x000000ff)
#define QMI_M0_RCMD_PREFIX_MSB    _u(7)
#define QMI_M0_RCMD_PREFIX_LSB    _u(0)
#define QMI_M0_RCMD_PREFIX_ACCESS "RW"

#endif // HARDWARE_REGS_QMI_DEFINED
