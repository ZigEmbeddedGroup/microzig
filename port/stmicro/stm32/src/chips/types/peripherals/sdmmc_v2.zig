const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// SDMMC
pub const SDMMC = extern struct {
    /// SDMMC power control register
    /// offset: 0x00
    POWER: mmio.Mmio(packed struct(u32) {
        /// SDMMC state control bits. These bits can only be written when the SDMMC is not in the power-on state (PWRCTRL?11). These bits are used to define the functional state of the SDMMC signals: Any further write will be ignored, PWRCTRL value will keep 11.
        PWRCTRL: u2,
        /// Voltage switch sequence start. This bit is used to start the timing critical section of the voltage switch sequence:
        VSWITCH: u1,
        /// Voltage switch procedure enable. This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0). This bit is used to stop the SDMMC_CK after the voltage switch command response:
        VSWITCHEN: u1,
        /// Data and command direction signals polarity selection. This bit can only be written when the SDMMC is in the power-off state (PWRCTRL = 00).
        DIRPOL: u1,
        padding: u27 = 0,
    }),
    /// The SDMMC_CLKCR register controls the SDMMC_CK output clock, the SDMMC_RX_CLK receive clock, and the bus width.
    /// offset: 0x04
    CLKCR: mmio.Mmio(packed struct(u32) {
        /// Clock divide factor This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0). This field defines the divide factor between the input clock (SDMMCCLK) and the output clock (SDMMC_CK): SDMMC_CK frequency = SDMMCCLK / [2 * CLKDIV]. 0xx: etc.. xxx: etc..
        CLKDIV: u10,
        reserved12: u2 = 0,
        /// Power saving configuration bit This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0) For power saving, the SDMMC_CK clock output can be disabled when the bus is idle by setting PWRSAV:
        PWRSAV: u1,
        reserved14: u1 = 0,
        /// Wide bus mode enable bit This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0)
        WIDBUS: u2,
        /// SDMMC_CK dephasing selection bit for data and Command. This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0). When clock division = 1 (CLKDIV = 0), this bit has no effect. Data and Command change on SDMMC_CK falling edge. When clock division &gt;1 (CLKDIV &gt; 0) &amp; DDR = 0: - SDMMC_CK edge occurs on SDMMCCLK rising edge. When clock division >1 (CLKDIV > 0) & DDR = 1: - Data changed on the SDMMCCLK falling edge succeeding a SDMMC_CK edge. - SDMMC_CK edge occurs on SDMMCCLK rising edge. - Data changed on the SDMMC_CK falling edge succeeding a SDMMC_CK edge. - SDMMC_CK edge occurs on SDMMCCLK rising edge.
        NEGEDGE: u1,
        /// Hardware flow control enable This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0) When Hardware flow control is enabled, the meaning of the TXFIFOE and RXFIFOF flags change, please see SDMMC status register definition in Section56.8.11.
        HWFC_EN: u1,
        /// Data rate signaling selection This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0) DDR rate shall only be selected with 4-bit or 8-bit wide bus mode. (WIDBUS &gt; 00). DDR = 1 has no effect when WIDBUS = 00 (1-bit wide bus). DDR rate shall only be selected with clock division &gt;1. (CLKDIV &gt; 0)
        DDR: u1,
        /// Bus speed mode selection between DS, HS, SDR12, SDR25 and SDR50, DDR50, SDR104. This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0)
        BUSSPEED: u1,
        /// Receive clock selection. These bits can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0)
        SELCLKRX: u2,
        padding: u10 = 0,
    }),
    /// The SDMMC_ARGR register contains a 32-bit command argument, which is sent to a card as part of a command message.
    /// offset: 0x08
    ARGR: mmio.Mmio(packed struct(u32) {
        /// Command argument. These bits can only be written by firmware when CPSM is disabled (CPSMEN = 0). Command argument sent to a card as part of a command message. If a command contains an argument, it must be loaded into this register before writing a command to the command register.
        CMDARG: u32,
    }),
    /// The SDMMC_CMDR register contains the command index and command type bits. The command index is sent to a card as part of a command message. The command type bits control the command path state machine (CPSM).
    /// offset: 0x0c
    CMDR: mmio.Mmio(packed struct(u32) {
        /// Command index. This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0). The command index is sent to the card as part of a command message.
        CMDINDEX: u6,
        /// The CPSM treats the command as a data transfer command, stops the interrupt period, and signals DataEnable to the DPSM This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0). If this bit is set, the CPSM issues an end of interrupt period and issues DataEnable signal to the DPSM when the command is sent.
        CMDTRANS: u1,
        /// The CPSM treats the command as a Stop Transmission command and signals Abort to the DPSM. This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0). If this bit is set, the CPSM issues the Abort signal to the DPSM when the command is sent.
        CMDSTOP: u1,
        /// Wait for response bits. This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0). They are used to configure whether the CPSM is to wait for a response, and if yes, which kind of response.
        WAITRESP: u2,
        /// CPSM waits for interrupt request. If this bit is set, the CPSM disables command timeout and waits for an card interrupt request (Response). If this bit is cleared in the CPSM Wait state, will cause the abort of the interrupt mode.
        WAITINT: u1,
        /// CPSM Waits for end of data transfer (CmdPend internal signal) from DPSM. This bit when set, the CPSM waits for the end of data transfer trigger before it starts sending a command. WAITPEND is only taken into account when DTMODE = MMC stream data transfer, WIDBUS = 1-bit wide bus mode, DPSMACT = 1 and DTDIR = from host to card.
        WAITPEND: u1,
        /// Command path state machine (CPSM) Enable bit This bit is written 1 by firmware, and cleared by hardware when the CPSM enters the Idle state. If this bit is set, the CPSM is enabled. When DTEN = 1, no command will be transfered nor boot procedure will be started. CPSMEN is cleared to 0.
        CPSMEN: u1,
        /// Hold new data block transmission and reception in the DPSM. If this bit is set, the DPSM will not move from the Wait_S state to the Send state or from the Wait_R state to the Receive state.
        DTHOLD: u1,
        /// Select the boot mode procedure to be used. This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0)
        BOOTMODE: u1,
        /// Enable boot mode procedure.
        BOOTEN: u1,
        /// The CPSM treats the command as a Suspend or Resume command and signals interrupt period start/end. This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0). CMDSUSPEND = 1 and CMDTRANS = 0 Suspend command, start interrupt period when response bit BS=0. CMDSUSPEND = 1 and CMDTRANS = 1 Resume command with data, end interrupt period when response bit DF=1.
        CMDSUSPEND: u1,
        padding: u15 = 0,
    }),
    /// SDMMC command response register
    /// offset: 0x10
    RESPCMDR: mmio.Mmio(packed struct(u32) {
        /// Response command index
        RESPCMD: u6,
        padding: u26 = 0,
    }),
    /// The SDMMC_RESP1/2/3/4R registers contain the status of a card, which is part of the received response.
    /// offset: 0x14
    RESPR: [4]mmio.Mmio(packed struct(u32) {
        /// see Table 432
        CARDSTATUS: u32,
    }),
    /// The SDMMC_DTIMER register contains the data timeout period, in card bus clock periods. A counter loads the value from the SDMMC_DTIMER register, and starts decrementing when the data path state machine (DPSM) enters the Wait_R or Busy state. If the timer reaches 0 while the DPSM is in either of these states, the timeout status flag is set.
    /// offset: 0x24
    DTIMER: mmio.Mmio(packed struct(u32) {
        /// Data and R1b busy timeout period This bit can only be written when the CPSM and DPSM are not active (CPSMACT = 0 and DPSMACT = 0). Data and R1b busy timeout period expressed in card bus clock periods.
        DATATIME: u32,
    }),
    /// The SDMMC_DLENR register contains the number of data bytes to be transferred. The value is loaded into the data counter when data transfer starts.
    /// offset: 0x28
    DLENR: mmio.Mmio(packed struct(u32) {
        /// Data length value This register can only be written by firmware when DPSM is inactive (DPSMACT = 0). Number of data bytes to be transferred. When DDR = 1 DATALENGTH is truncated to a multiple of 2. (The last odd byte is not transfered) When DATALENGTH = 0 no data will be transfered, when requested by a CPSMEN and CMDTRANS = 1 also no command will be transfered. DTEN and CPSMEN are cleared to 0.
        DATALENGTH: u25,
        padding: u7 = 0,
    }),
    /// The SDMMC_DCTRL register control the data path state machine (DPSM).
    /// offset: 0x2c
    DCTRL: mmio.Mmio(packed struct(u32) {
        /// Data transfer enable bit This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0). This bit is cleared by Hardware when data transfer completes. This bit shall only be used to transfer data when no associated data transfer command is used, i.e. shall not be used with SD or eMMC cards.
        DTEN: u1,
        /// Data transfer direction selection This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0).
        DTDIR: u1,
        /// Data transfer mode selection. This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0).
        DTMODE: u2,
        /// Data block size This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0). Define the data block length when the block data transfer mode is selected: When DATALENGTH is not a multiple of DBLOCKSIZE, the transfered data is truncated at a multiple of DBLOCKSIZE. (Any remain data will not be transfered.) When DDR = 1, DBLOCKSIZE = 0000 shall not be used. (No data will be transfered)
        DBLOCKSIZE: u4,
        /// Read wait start. If this bit is set, read wait operation starts.
        RWSTART: u1,
        /// Read wait stop This bit is written by firmware and auto cleared by hardware when the DPSM moves from the READ_WAIT state to the WAIT_R or IDLE state.
        RWSTOP: u1,
        /// Read wait mode. This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0).
        RWMOD: u1,
        /// SD I/O interrupt enable functions This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0). If this bit is set, the DPSM enables the SD I/O card specific interrupt operation.
        SDIOEN: u1,
        /// Enable the reception of the boot acknowledgment. This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0).
        BOOTACKEN: u1,
        /// FIFO reset, will flush any remaining data. This bit can only be written by firmware when IDMAEN= 0 and DPSM is active (DPSMACT = 1). This bit will only take effect when a transfer error or transfer hold occurs.
        FIFORST: u1,
        padding: u18 = 0,
    }),
    /// The SDMMC_DCNTR register loads the value from the data length register (see SDMMC_DLENR) when the DPSM moves from the Idle state to the Wait_R or Wait_S state. As data is transferred, the counter decrements the value until it reaches 0. The DPSM then moves to the Idle state and when there has been no error, the data status end flag (DATAEND) is set.
    /// offset: 0x30
    DCNTR: mmio.Mmio(packed struct(u32) {
        /// Data count value When read, the number of remaining data bytes to be transferred is returned. Write has no effect.
        DATACOUNT: u25,
        padding: u7 = 0,
    }),
    /// The SDMMC_STAR register is a read-only register. It contains two types of flag:Static flags (bits [29,21,11:0]): these bits remain asserted until they are cleared by writing to the SDMMC interrupt Clear register (see SDMMC_ICR)Dynamic flags (bits [20:12]): these bits change state depending on the state of the underlying logic (for example, FIFO full and empty flags are asserted and de-asserted as data while written to the FIFO)
    /// offset: 0x34
    STAR: mmio.Mmio(packed struct(u32) {
        /// Command response received (CRC check failed). Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        CCRCFAIL: u1,
        /// Data block sent/received (CRC check failed). Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        DCRCFAIL: u1,
        /// Command response timeout. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR. The Command Timeout period has a fixed value of 64 SDMMC_CK clock periods.
        CTIMEOUT: u1,
        /// Data timeout. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        DTIMEOUT: u1,
        /// Transmit FIFO underrun error or IDMA read transfer error. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        TXUNDERR: u1,
        /// Received FIFO overrun error or IDMA write transfer error. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        RXOVERR: u1,
        /// Command response received (CRC check passed, or no CRC). Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        CMDREND: u1,
        /// Command sent (no response required). Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        CMDSENT: u1,
        /// Data transfer ended correctly. (data counter, DATACOUNT is zero and no errors occur). Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        DATAEND: u1,
        /// Data transfer Hold. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        DHOLD: u1,
        /// Data block sent/received. (CRC check passed) and DPSM moves to the READWAIT state. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        DBCKEND: u1,
        /// Data transfer aborted by CMD12. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        DABORT: u1,
        /// Data path state machine active, i.e. not in Idle state. This is a hardware status flag only, does not generate an interrupt.
        DPSMACT: u1,
        /// Command path state machine active, i.e. not in Idle state. This is a hardware status flag only, does not generate an interrupt.
        CPSMACT: u1,
        /// Transmit FIFO half empty At least half the number of words can be written into the FIFO. This bit is cleared when the FIFO becomes half+1 full.
        TXFIFOHE: u1,
        /// Receive FIFO half full There are at least half the number of words in the FIFO. This bit is cleared when the FIFO becomes half+1 empty.
        RXFIFOHF: u1,
        /// Transmit FIFO full This is a hardware status flag only, does not generate an interrupt. This bit is cleared when one FIFO location becomes empty.
        TXFIFOF: u1,
        /// Receive FIFO full This bit is cleared when one FIFO location becomes empty.
        RXFIFOF: u1,
        /// Transmit FIFO empty This bit is cleared when one FIFO location becomes full.
        TXFIFOE: u1,
        /// Receive FIFO empty This is a hardware status flag only, does not generate an interrupt. This bit is cleared when one FIFO location becomes full.
        RXFIFOE: u1,
        /// Inverted value of SDMMC_D0 line (Busy), sampled at the end of a CMD response and a second time 2 SDMMC_CK cycles after the CMD response. This bit is reset to not busy when the SDMMCD0 line changes from busy to not busy. This bit does not signal busy due to data transfer. This is a hardware status flag only, it does not generate an interrupt.
        BUSYD0: u1,
        /// end of SDMMC_D0 Busy following a CMD response detected. This indicates only end of busy following a CMD response. This bit does not signal busy due to data transfer. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        BUSYD0END: u1,
        /// SDIO interrupt received. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        SDIOIT: u1,
        /// Boot acknowledgment received (boot acknowledgment check fail). Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        ACKFAIL: u1,
        /// Boot acknowledgment timeout. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        ACKTIMEOUT: u1,
        /// Voltage switch critical timing section completion. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        VSWEND: u1,
        /// SDMMC_CK stopped in Voltage switch procedure. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        CKSTOP: u1,
        /// IDMA transfer error. Interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        IDMATE: u1,
        /// IDMA buffer transfer complete. interrupt flag is cleared by writing corresponding interrupt clear bit in SDMMC_ICR.
        IDMABTC: u1,
        padding: u3 = 0,
    }),
    /// The SDMMC_ICR register is a write-only register. Writing a bit with 1 clears the corresponding bit in the SDMMC_STAR status register.
    /// offset: 0x38
    ICR: mmio.Mmio(packed struct(u32) {
        /// CCRCFAIL flag clear bit Set by software to clear the CCRCFAIL flag.
        CCRCFAILC: u1,
        /// DCRCFAIL flag clear bit Set by software to clear the DCRCFAIL flag.
        DCRCFAILC: u1,
        /// CTIMEOUT flag clear bit Set by software to clear the CTIMEOUT flag.
        CTIMEOUTC: u1,
        /// DTIMEOUT flag clear bit Set by software to clear the DTIMEOUT flag.
        DTIMEOUTC: u1,
        /// TXUNDERR flag clear bit Set by software to clear TXUNDERR flag.
        TXUNDERRC: u1,
        /// RXOVERR flag clear bit Set by software to clear the RXOVERR flag.
        RXOVERRC: u1,
        /// CMDREND flag clear bit Set by software to clear the CMDREND flag.
        CMDRENDC: u1,
        /// CMDSENT flag clear bit Set by software to clear the CMDSENT flag.
        CMDSENTC: u1,
        /// DATAEND flag clear bit Set by software to clear the DATAEND flag.
        DATAENDC: u1,
        /// DHOLD flag clear bit Set by software to clear the DHOLD flag.
        DHOLDC: u1,
        /// DBCKEND flag clear bit Set by software to clear the DBCKEND flag.
        DBCKENDC: u1,
        /// DABORT flag clear bit Set by software to clear the DABORT flag.
        DABORTC: u1,
        reserved21: u9 = 0,
        /// BUSYD0END flag clear bit Set by software to clear the BUSYD0END flag.
        BUSYD0ENDC: u1,
        /// SDIOIT flag clear bit Set by software to clear the SDIOIT flag.
        SDIOITC: u1,
        /// ACKFAIL flag clear bit Set by software to clear the ACKFAIL flag.
        ACKFAILC: u1,
        /// ACKTIMEOUT flag clear bit Set by software to clear the ACKTIMEOUT flag.
        ACKTIMEOUTC: u1,
        /// VSWEND flag clear bit Set by software to clear the VSWEND flag.
        VSWENDC: u1,
        /// CKSTOP flag clear bit Set by software to clear the CKSTOP flag.
        CKSTOPC: u1,
        /// IDMA transfer error clear bit Set by software to clear the IDMATE flag.
        IDMATEC: u1,
        /// IDMA buffer transfer complete clear bit Set by software to clear the IDMABTC flag.
        IDMABTCC: u1,
        padding: u3 = 0,
    }),
    /// The interrupt mask register determines which status flags generate an interrupt request by setting the corresponding bit to 1.
    /// offset: 0x3c
    MASKR: mmio.Mmio(packed struct(u32) {
        /// Command CRC fail interrupt enable Set and cleared by software to enable/disable interrupt caused by command CRC failure.
        CCRCFAILIE: u1,
        /// Data CRC fail interrupt enable Set and cleared by software to enable/disable interrupt caused by data CRC failure.
        DCRCFAILIE: u1,
        /// Command timeout interrupt enable Set and cleared by software to enable/disable interrupt caused by command timeout.
        CTIMEOUTIE: u1,
        /// Data timeout interrupt enable Set and cleared by software to enable/disable interrupt caused by data timeout.
        DTIMEOUTIE: u1,
        /// Tx FIFO underrun error interrupt enable Set and cleared by software to enable/disable interrupt caused by Tx FIFO underrun error.
        TXUNDERRIE: u1,
        /// Rx FIFO overrun error interrupt enable Set and cleared by software to enable/disable interrupt caused by Rx FIFO overrun error.
        RXOVERRIE: u1,
        /// Command response received interrupt enable Set and cleared by software to enable/disable interrupt caused by receiving command response.
        CMDRENDIE: u1,
        /// Command sent interrupt enable Set and cleared by software to enable/disable interrupt caused by sending command.
        CMDSENTIE: u1,
        /// Data end interrupt enable Set and cleared by software to enable/disable interrupt caused by data end.
        DATAENDIE: u1,
        /// Data hold interrupt enable Set and cleared by software to enable/disable the interrupt generated when sending new data is hold in the DPSM Wait_S state.
        DHOLDIE: u1,
        /// Data block end interrupt enable Set and cleared by software to enable/disable interrupt caused by data block end.
        DBCKENDIE: u1,
        /// Data transfer aborted interrupt enable Set and cleared by software to enable/disable interrupt caused by a data transfer being aborted.
        DABORTIE: u1,
        reserved14: u2 = 0,
        /// Tx FIFO half empty interrupt enable Set and cleared by software to enable/disable interrupt caused by Tx FIFO half empty.
        TXFIFOHEIE: u1,
        /// Rx FIFO half full interrupt enable Set and cleared by software to enable/disable interrupt caused by Rx FIFO half full.
        RXFIFOHFIE: u1,
        reserved17: u1 = 0,
        /// Rx FIFO full interrupt enable Set and cleared by software to enable/disable interrupt caused by Rx FIFO full.
        RXFIFOFIE: u1,
        /// Tx FIFO empty interrupt enable Set and cleared by software to enable/disable interrupt caused by Tx FIFO empty.
        TXFIFOEIE: u1,
        reserved21: u2 = 0,
        /// BUSYD0END interrupt enable Set and cleared by software to enable/disable the interrupt generated when SDMMC_D0 signal changes from busy to NOT busy following a CMD response.
        BUSYD0ENDIE: u1,
        /// SDIO mode interrupt received interrupt enable Set and cleared by software to enable/disable the interrupt generated when receiving the SDIO mode interrupt.
        SDIOITIE: u1,
        /// Acknowledgment Fail interrupt enable Set and cleared by software to enable/disable interrupt caused by acknowledgment Fail.
        ACKFAILIE: u1,
        /// Acknowledgment timeout interrupt enable Set and cleared by software to enable/disable interrupt caused by acknowledgment timeout.
        ACKTIMEOUTIE: u1,
        /// Voltage switch critical timing section completion interrupt enable Set and cleared by software to enable/disable the interrupt generated when voltage switch critical timing section completion.
        VSWENDIE: u1,
        /// Voltage Switch clock stopped interrupt enable Set and cleared by software to enable/disable interrupt caused by Voltage Switch clock stopped.
        CKSTOPIE: u1,
        reserved28: u1 = 0,
        /// IDMA buffer transfer complete interrupt enable Set and cleared by software to enable/disable the interrupt generated when the IDMA has transferred all data belonging to a memory buffer.
        IDMABTCIE: u1,
        padding: u3 = 0,
    }),
    /// The SDMMC_ACKTIMER register contains the acknowledgment timeout period, in SDMMC_CK bus clock periods. A counter loads the value from the SDMMC_ACKTIMER register, and starts decrementing when the data path state machine (DPSM) enters the Wait_Ack state. If the timer reaches 0 while the DPSM is in this states, the acknowledgment timeout status flag is set.
    /// offset: 0x40
    ACKTIMER: mmio.Mmio(packed struct(u32) {
        /// Boot acknowledgment timeout period This bit can only be written by firmware when CPSM is disabled (CPSMEN = 0). Boot acknowledgment timeout period expressed in card bus clock periods.
        ACKTIME: u25,
        padding: u7 = 0,
    }),
    /// offset: 0x44
    reserved68: [12]u8,
    /// The receive and transmit FIFOs can be read or written as 32-bit wide registers. The FIFOs contain 32 entries on 32 sequential addresses. This allows the CPU to use its load and store multiple operands to read from/write to the FIFO.
    /// offset: 0x50
    IDMACTRLR: mmio.Mmio(packed struct(u32) {
        /// IDMA enable This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0).
        IDMAEN: u1,
        /// Buffer mode selection. This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0).
        IDMABMODE: u1,
        /// Double buffer mode active buffer indication This bit can only be written by firmware when DPSM is inactive (DPSMACT = 0). When IDMA is enabled this bit is toggled by hardware.
        IDMABACT: u1,
        padding: u29 = 0,
    }),
    /// The SDMMC_IDMABSIZER register contains the buffers size when in double buffer configuration.
    /// offset: 0x54
    IDMABSIZER: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// Number of transfers per buffer. This 8-bit value shall be multiplied by 8 to get the size of the buffer in 32-bit words and by 32 to get the size of the buffer in bytes. Example: IDMABNDT = 0x01: buffer size = 8 words = 32 bytes. These bits can only be written by firmware when DPSM is inactive (DPSMACT = 0).
        IDMABNDT: u8,
        padding: u19 = 0,
    }),
    /// The SDMMC_IDMABASE0R register contains the memory buffer base address in single buffer configuration and the buffer 0 base address in double buffer configuration.
    /// offset: 0x58
    IDMABASE0R: mmio.Mmio(packed struct(u32) {
        /// Buffer 0 memory base address bits [31:2], shall be word aligned (bit [1:0] are always 0 and read only). This register can be written by firmware when DPSM is inactive (DPSMACT = 0), and can dynamically be written by firmware when DPSM active (DPSMACT = 1) and memory buffer 0 is inactive (IDMABACT = 1).
        IDMABASE0: u32,
    }),
    /// The SDMMC_IDMABASE1R register contains the double buffer configuration second buffer memory base address.
    /// offset: 0x5c
    IDMABASE1R: mmio.Mmio(packed struct(u32) {
        /// Buffer 1 memory base address, shall be word aligned (bit [1:0] are always 0 and read only). This register can be written by firmware when DPSM is inactive (DPSMACT = 0), and can dynamically be written by firmware when DPSM active (DPSMACT = 1) and memory buffer 1 is inactive (IDMABACT = 0).
        IDMABASE1: u32,
    }),
    /// offset: 0x60
    reserved96: [32]u8,
    /// The receive and transmit FIFOs can be only read or written as word (32-bit) wide registers. The FIFOs contain 16 entries on sequential addresses. This allows the CPU to use its load and store multiple operands to read from/write to the FIFO.When accessing SDMMC_FIFOR with half word or byte access an AHB bus fault is generated.
    /// offset: 0x80
    FIFOR: mmio.Mmio(packed struct(u32) {
        /// Receive and transmit FIFO data This register can only be read or written by firmware when the DPSM is active (DPSMACT=1). The FIFO data occupies 16 entries of 32-bit words.
        FIFODATA: u32,
    }),
    /// offset: 0x84
    reserved132: [880]u8,
    /// SDMMC IP version register
    /// offset: 0x3f4
    VER: mmio.Mmio(packed struct(u32) {
        /// IP minor revision number.
        MINREV: u4,
        /// IP major revision number.
        MAJREV: u4,
        padding: u24 = 0,
    }),
    /// SDMMC IP identification register
    /// offset: 0x3f8
    ID: mmio.Mmio(packed struct(u32) {
        /// SDMMC IP identification.
        IP_ID: u32,
    }),
};
