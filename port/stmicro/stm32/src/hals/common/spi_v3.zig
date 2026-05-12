//implementação do SPI v3
//TODO LIST:
// - batter slave support
// - CRC
// - SPI frame < 8bits

const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const enums = @import("enums.zig");
pub const Instances = enums.SPI_Type;

const Digital_IO = microzig.drivers.base.Digital_IO;
pub const spi_v3 = microzig.chip.types.peripherals.spi_v3;
pub const SPI_Peripheral = spi_v3.SPI;
pub const FTHLV = spi_v3.FTHLV;
pub const MBR = spi_v3.MBR;
pub const UDRCFG = spi_v3.UDRCFG;
pub const UDRDET = spi_v3.UDRDET;
pub const COMM = spi_v3.COMM;
pub const SP = spi_v3.SP;
pub const MASTER = spi_v3.MASTER;
pub const LSBFIRST = spi_v3.LSBFIRST;
pub const CPHA = spi_v3.CPHA;
pub const CPOL = spi_v3.CPOL;
pub const SSIOP = spi_v3.SSIOP;
pub const SSOM = spi_v3.SSOM;
pub const HDDIR = spi_v3.HDDIR;

/// Software management of CS signal input
pub const SSM = enum(u1) {
    /// SS pin (SPI CS) is used as an input to detect multiple SPI masters.
    internal = 0,

    /// User controls the input signal via software.
    external = 1,
};

pub const CS_Pin = union(enum) {
    /// CS is controlled internally by the hardware.
    internal: SSOM,

    /// CS is controlled internally by the HAL.
    soft_internal: *Digital_IO,

    /// CS is controlled externally by the user.
    external: void,
};

pub const UnderrunBehavior = union(enum) {
    send_pattern: u32,
    repeat_last_receive: void,
    repeat_last_transmit: void,
};

//SPI master only configs
pub const SPI_Master = struct {
    chip_select: CS_Pin,

    /// Defines which level represents an active CS signal.
    chip_select_polarity: SSIOP = .ActiveLow,

    /// When non-null, enables multi-master mode.
    /// NOTE: when CS is controlled internally by the hardware,
    /// multi-master can only be achieved via software.
    multi_master_support: ?SSM = null,

    ///When SPI master has to be disabled temporary for a specific configuration reason (e.g. CRC
    ///reset, CPHA or HDDIR change) setting this bit prevents any glitches on the associated
    ///outputs configured at alternate function mode by keeping them forced at state corresponding the current SPI configuration
    lock_gpios: bool = false,

    /// defines the delay (in SPI clocks) between frames
    inter_data_dalay: u4 = 0,

    /// defines the delay (in SPI clocks) between the first frame and CS activation
    cs_delay: u4 = 0,

    /// SPI flow is suspended temporary on RxFIFO full condition.
    automatic_rx_suspend: bool = false,
};

//SPI slave only configs
pub const SPI_Slave = struct {
    underrun_detection: UDRDET = .StartOfFrame,
    underrun_behavior: UnderrunBehavior = .{ .send_pattern = 0 },
};

pub const SPI_Mode = union(enum) {
    slave: SPI_Slave,
    master: SPI_Master,
};

pub const SPI_Interrupts = struct {
    /// RXP Interrupt Enable
    rxp: bool = false,
    /// TXP interrupt enable
    txp: bool = false,
    /// DXP interrupt enabled
    dxp: bool = false,
    /// EOT, SUSP and TXC interrupt enable
    eot_susp_txc: bool = false,
    /// TXTFIE interrupt enable
    txtf: bool = false,
    /// UDR interrupt enable
    underrun: bool = false,
    /// OVR interrupt enable
    overrun: bool = false,
    /// CRC Interrupt enable
    crc_error: bool = false,
    /// TIFRE interrupt enable
    tifre: bool = false,
    /// Mode Fault interrupt enable
    mode_fault: bool = false,
    /// Additional number of transactions reload interrupt enable
    additional_transactions_reload: bool = false,
};

pub const SPI_Config = struct {
    spi_mode: SPI_Mode,
    baud_rate_div: MBR = .Div2, //SPI Master or Slave in TI mode only

    //commum SPI configs
    cpol: CPOL = .IdleLow,
    cpha: CPHA = .FirstEdge,
    frame_format: LSBFIRST = .MSBFirst,
    comm_mode: COMM = .FullDuplex,
    data_size: u5 = 7, //8bits

    //hardware SPI configs
    io_swap: bool = false,
    fifo_threshold_level: FTHLV = .OneFrame,
    protocol: SP = .Motorola,

    //DMA and Interrupts
    enable_tx_dma: bool = false,
    enable_rx_dma: bool = false,
    interrupts: SPI_Interrupts = .{},
};

pub const SPI_ConfigError = error{
    Invalid_DSIZE,
    Invalid_Multimaster,
} || Digital_IO.SetDirError || Digital_IO.SetBiasError;

pub const SPI_TransferError = error{
    InvalidMode,
    Suspended,
    InvalidTransactionLength,

    ///this error only occurs when mixing Blocking and Non-Blocking operations,
    ///it happens when CTSIZE (current transaction size) reaches 0 but a
    ///blocking operation is still has data to send/receive.
    IncompleteTransaction,

    ///Check `get_error_flags()` for more details
    TransactionError,
} || Digital_IO.WriteError;

pub const SPI_ErrorStatus = packed struct(u5) {
    overrun: bool,
    underrun: bool,
    mode_fault: bool,
    crc_error: bool,
    tiref: bool,
};

pub const SPI = struct {
    instance: Instances,
    spi: *volatile SPI_Peripheral,
    nss: CS_Pin = .external,

    fn check_config(config: *const SPI_Config) SPI_ConfigError!void {
        if (config.data_size < 0b11) return SPI_ConfigError.Invalid_DSIZE;

        if (config.spi_mode == .master) {
            const master_conf = config.spi_mode.master;
            switch (master_conf.chip_select) {
                .internal => {
                    if (master_conf.multi_master_support) |ssm| {
                        if (ssm == .internal) return SPI_ConfigError.Invalid_Multimaster;
                    }
                },
                else => {},
            }
        }
    }

    pub fn apply(self: *SPI, config: SPI_Config) SPI_ConfigError!void {
        try check_config(&config);

        self.spi.CR1.raw = 0; //force reset SPI
        defer self.spi.CR1.modify_one("SPE", 1);

        self.spi.CFG1.modify(.{
            .DSIZE = config.data_size,
            .FTHLV = config.fifo_threshold_level,
            .RXDMAEN = @intFromBool(config.enable_rx_dma),
            .TXDMAEN = @intFromBool(config.enable_tx_dma),
            .MBR = config.baud_rate_div,
        });

        self.spi.CFG2.modify(.{
            .COMM = config.comm_mode,
            .SP = config.protocol,
            .LSBFIRST = config.frame_format,
            .CPHA = config.cpha,
            .CPOL = config.cpol,
            .IOSWP = @intFromBool(config.io_swap),
        });

        switch (config.spi_mode) {
            .slave => |conf| self.slave_config(conf),
            .master => |conf| try self.master_config(conf),
        }

        self.spi.IER.modify(.{
            .RXPIE = @intFromBool(config.interrupts.rxp),
            .TXPIE = @intFromBool(config.interrupts.txp),
            .DXPIE = @intFromBool(config.interrupts.dxp),
            .EOTIE = @intFromBool(config.interrupts.eot_susp_txc),
            .TXTFIE = @intFromBool(config.interrupts.txtf),
            .UDRIE = @intFromBool(config.interrupts.underrun),
            .OVRIE = @intFromBool(config.interrupts.overrun),
            .CRCEIE = @intFromBool(config.interrupts.crc_error),
            .TIFREIE = @intFromBool(config.interrupts.tifre),
            .MODFIE = @intFromBool(config.interrupts.mode_fault),
            .TSERFIE = @intFromBool(config.interrupts.additional_transactions_reload),
        });
    }

    fn slave_config(self: *const SPI, config: SPI_Slave) void {
        const bhvr = @intFromEnum(config.underrun_behavior);
        self.spi.CFG1.modify(.{
            .UDRDET = config.underrun_detection,
            .UDRCFG = @as(UDRCFG, @enumFromInt(bhvr)),
        });

        switch (config.underrun_behavior) {
            .send_pattern => |ptrn| {
                self.spi.UDRDR.raw = ptrn;
            },
            else => {},
        }
        self.spi.CFG2.modify_one("MASTER", MASTER.Slave);
    }

    fn master_config(self: *SPI, config: SPI_Master) SPI_ConfigError!void {
        self.spi.CR1.modify_one("MASRX", @intFromBool(config.automatic_rx_suspend));
        self.nss = config.chip_select;

        switch (config.chip_select) {
            .internal => |ssom| {
                self.spi.CFG2.modify(.{
                    .SSOM = ssom,
                    .SSOE = 1,
                });
            },
            .external => {
                self.spi.CFG2.modify(.{
                    .SSOE = 0,
                });
            },
            .soft_internal => |pin| {
                try pin.set_direction(.output);
                try pin.set_bias(.low);

                self.spi.CFG2.modify(.{
                    .SSOE = 0,
                });
            },
        }

        if (config.multi_master_support) |ssm| {
            self.spi.CR1.modify_one("SSI", 1);
            self.spi.CFG2.modify_one("SSM", @as(u1, @intFromEnum(ssm)));
        } else {
            self.spi.CFG2.modify_one("SSOE", 1);
            self.spi.CFG2.modify_one("SSM", 0);
        }

        self.spi.CFG2.modify(.{
            .MIDI = config.inter_data_dalay,
            .MSSI = config.cs_delay,
            .AFCNTR = @intFromBool(config.lock_gpios),
            .MASTER = MASTER.Master,
            .SSIOP = config.chip_select_polarity,
        });
    }

    fn set_chip_select(self: *const SPI, active: bool) SPI_TransferError!void {
        switch (self.nss) {
            .soft_internal => |pin| {
                try pin.write(if (active) .low else .high);
            },
            else => {},
        }
    }

    pub inline fn disable_spi(self: *const SPI) void {
        self.spi.CR1.modify_one("SPE", 0);
    }

    pub inline fn enable_spi(self: *const SPI) void {
        self.spi.CR1.modify_one("SPE", 1);
    }

    pub inline fn check_end_of_transfer(self: *const SPI) bool {
        return self.spi.SR.read().EOT == 1;
    }

    pub inline fn clear_end_of_transfer_flag(self: *const SPI) void {
        self.spi.IFCR.modify_one("EOTC", 1);
    }

    pub inline fn check_rx(self: *const SPI) bool {
        return self.spi.SR.read().RXP == 1;
    }

    pub inline fn check_tx(self: *const SPI) bool {
        return self.spi.SR.read().TXP == 1;
    }

    pub inline fn flush_rx_FIFO(self: *const SPI) void {
        while (self.check_rx()) {
            std.mem.doNotOptimizeAway(self.spi.RXDR8);
        }
    }

    pub inline fn start_transaction(self: *const SPI) void {
        self.spi.CR1.modify_one("CSTART", 1);
    }

    pub inline fn check_transfer_filled(self: *const SPI) bool {
        return self.spi.SR.read().TXTF == 1;
    }

    pub inline fn clear_filled_flag(self: *const SPI) void {
        self.spi.IFCR.modify_one("TXTFC", 1);
    }

    pub inline fn suspend_transaction(self: *const SPI) void {
        self.spi.CR1.modify_one("CSUSP", 1);
    }

    pub inline fn check_transaction_suspended(self: *const SPI) bool {
        return self.spi.SR.read().SUSP == 1;
    }

    // Suspends the current SPI transaction and blocks until the suspension is confirmed.
    pub fn suspend_blocking(self: *const SPI) void {
        self.suspend_transaction();
        while (!self.check_transaction_suspended()) {}
    }

    pub fn get_error_flags(self: *const SPI) SPI_ErrorStatus {
        return SPI_ErrorStatus{
            .overrun = self.spi.SR.read().OVR == 1,
            .underrun = self.spi.SR.read().UDR == 1,
            .mode_fault = self.spi.SR.read().MODF == 1,
            .crc_error = self.spi.SR.read().CRCE == 1,
            .tiref = self.spi.SR.read().TIFRE == 1,
        };
    }

    pub fn clear_error_flags(self: *const SPI) void {
        self.spi.IFCR.modify(.{
            .OVRC = 1,
            .UDRC = 1,
            .MODFC = 1,
            .CRCEC = 1,
            .TIFREC = 1,
        });
    }

    pub fn clear_all_flags(self: *const SPI) void {
        self.spi.IFCR.raw = 0xFFFFFFFF;
    }

    pub fn set_transaction_length(self: *const SPI, length: u16, reload: u16) void {
        self.disable_spi();
        defer self.enable_spi();

        self.spi.CR2.modify(.{
            .TSIZE = length,
            .TSER = reload,
        });
    }

    inline fn check_for_error(self: *const SPI) SPI_TransferError!void {
        if (@as(u5, @bitCast(self.get_error_flags())) != 0) {
            return SPI_TransferError.TransactionError;
        }
        if (self.check_transaction_suspended()) return SPI_TransferError.Suspended;
    }

    ///Blocking write operation.
    ///
    ///This function only supports `FullDuplex`, `HalfDuplex` and `Transmitter-Only` modes.
    ///If used in HalfDuplex mode, the `HDDIR` bit is set to Transmitter.
    ///If used in `Receiver-Only` mode, returns an InvalidMode error.
    ///
    ///NOTE: for correct use of Output Management in Internal CS mode,
    ///the maximum transaction length is set to 16bits (65535). (max TSIZE value)
    ///
    ///NOTE: this function requires that the SPI peripheral is already configured and
    ///in a valid state for a transaction.
    pub fn write_blocking(self: *const SPI, data: []const u8) SPI_TransferError!void {
        const mode = self.spi.CFG2.read().COMM;

        if (data.len == 0 or data.len > 65535) return SPI_TransferError.InvalidTransactionLength;

        //check current mode
        if (mode == .HalfDuplex) {
            self.spi.CR1.modify_one("HDDIR", HDDIR.Transmitter);
        } else if (mode == .Receiver) return SPI_TransferError.InvalidMode;

        //set transaction length, CS and start transaction
        self.set_transaction_length(@truncate(data.len), 0);
        try self.set_chip_select(true);
        defer self.set_chip_select(false) catch {};
        self.start_transaction();

        defer self.clear_filled_flag();
        defer self.clear_end_of_transfer_flag();

        for (data, 0..) |byte, idx| {
            if (mode == .FullDuplex) self.flush_rx_FIFO();
            try self.check_for_error();

            if (self.check_transfer_filled() and idx != data.len - 1) {
                return SPI_TransferError.IncompleteTransaction;
            }

            while (!self.check_tx()) {}
            self.spi.TXDR8 = byte;
        }

        while (!self.check_end_of_transfer()) {
            if (mode == .FullDuplex) self.flush_rx_FIFO();
            try self.check_for_error();
        }
    }

    ///Blocking read operation.
    ///
    ///This function only supports `FullDuplex`, `HalfDuplex` and `Receiver-Only` modes.
    ///If used in HalfDuplex mode, the `HDDIR` bit is set to Receiver.
    ///If used in `Transmitter-Only` mode, returns an InvalidMode error.
    ///
    ///NOTE: for correct use of Output Management in Internal CS mode,
    ///the maximum transaction length is set to 16bits (65535). (max TSIZE value)
    ///
    ///NOTE: this function requires that the SPI peripheral is already configured and
    ///in a valid state for a transaction.
    pub fn read_blocking(self: *const SPI, buffer: []u8) SPI_TransferError!void {
        const mode = self.spi.CFG2.read().COMM;

        if (buffer.len == 0 or buffer.len > 65535) return SPI_TransferError.InvalidTransactionLength;

        //check current mode
        if (mode == .HalfDuplex) {
            self.spi.CR1.modify_one("HDDIR", HDDIR.Receiver);
        } else if (mode == .Transmitter) return SPI_TransferError.InvalidMode;

        //set transaction length, CS and start transaction
        self.set_transaction_length(@truncate(buffer.len), 0);
        try self.set_chip_select(true);
        defer self.set_chip_select(false) catch {};

        self.start_transaction();

        defer self.clear_end_of_transfer_flag();

        for (buffer) |*byte| {
            if (mode == .FullDuplex) {
                while (!self.check_tx()) {}
                self.spi.TXDR8 = 0xFF; //send dummy byte
            }

            try self.check_for_error();

            while (!self.check_rx()) {}
            byte.* = self.spi.RXDR8;
        }

        while (!self.check_end_of_transfer()) {
            if (mode == .FullDuplex) {
                while (!self.check_tx()) {}
                self.spi.TXDR8 = 0xFF; //send dummy byte
            }
            try self.check_for_error();
        }
    }

    ///Blocking transceive operation.
    ///Full-Duplex mode only.
    ///both data and buffer must have the same length.
    pub fn transceive_blocking(self: *const SPI, data: []const u8, buffer: []u8) SPI_TransferError!void {
        const mode = self.spi.CFG2.read().COMM;

        if (data.len != buffer.len) return SPI_TransferError.InvalidTransactionLength;
        if (data.len == 0 or data.len > 65535) return SPI_TransferError.InvalidTransactionLength;

        //check current mode
        if (mode != .FullDuplex) {
            return SPI_TransferError.InvalidMode;
        }

        //set transaction length, CS and start transaction
        self.set_transaction_length(@truncate(data.len), 0);
        try self.set_chip_select(true);
        defer self.set_chip_select(false) catch {};
        self.start_transaction();

        defer self.clear_end_of_transfer_flag();
        defer self.clear_filled_flag();

        for (data, 0..) |byte, idx| {
            try self.check_for_error();

            if (self.check_transfer_filled() and idx != data.len - 1) {
                return SPI_TransferError.IncompleteTransaction;
            }

            while (!self.check_tx()) {}
            self.spi.TXDR8 = byte;

            while (!self.check_rx()) {}
            buffer[idx] = self.spi.RXDR8;
        }

        while (!self.check_end_of_transfer()) {
            try self.check_for_error();
        }
    }

    pub fn init(comptime spi_inst: Instances) SPI {
        hal.rcc.enable_clock(enums.to_peripheral(spi_inst));
        return .{ .spi = enums.get_regs(SPI_Peripheral, spi_inst), .instance = spi_inst };
    }
};
