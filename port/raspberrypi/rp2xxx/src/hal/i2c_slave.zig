//!
//! This file implements an I2C slave driver for the RP2 chip family.
//!
//! Useful links:
//!     (Unofficial) I2C Reference: https://www.i2c-bus.org/
//!
//! To use this driver, you must open the I2C slave connection
//! using `I2C_Slave.open()` with the following parameters:
//!
//! * `addr` - The I2C slave address to listen to
//! * `transfer_buffer` - A buffer to use to transfer data
//! * `rx_callback` - The callback to use for handling data received from i2c
//! * `tx_callback` - The callback to use for providing data sent to i2c
//! * `param` - An optional parameter to pass to the callback
//!
//! The transfer buffer SHOULD be sized to hold the maximum amount of data
//! that will be transferred in a single transaction, but it is not required
//! to be.
//!
//! Once the connection is open, and the appropriate ISR is set up,
//! the driver will listen for I2C transactions.
//!
//! ## Master Write / Slave Read
//!
//! When we get data from the master we add it to the transfer buffer.  If the
//! buffer becomes full and we have more data to add, we call the rx_callback
//! with the `last` parameter set to `false`.
//!
//! When we have processed all the data from the master, and the master issues
//! a STOP or RESTART condition, we call the rx_callback with the `last`
//! parameter set to `true`.
//!
//! In either case, the `first` parameter will be set `true` for the initial
//! callback for a transaction, and the `gen_call` parameter will be set to
//! `true` for a general call and `false` if the transaction was addressed to us.
//!
//! ## Master Read / Slave Write
//!
//! If the master requests data from us we call the tx_callback with the `first`
//! parameter set to `true`.  The user should add data to `data` and return the
//! number of bytes added.
//!
//! If the master requests more data, we call the tx_callback with the `first`
//! parameter set to `false`.  The user can return 0 if no more data is available.
//!

const std = @import("std");
const microzig = @import("microzig");
const irq = microzig.hal.irq;
const i2c = microzig.hal.i2c;

const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const I2C0 = peripherals.I2C0;
const I2C1 = peripherals.I2C1;
const I2cRegs = microzig.chip.types.peripherals.I2C0;

const fifo_length = 16;

const gpio = @import("gpio.zig");

pub const RXCallback = *const fn (data: []const u8, first: bool, last: bool, gen_call: bool, param: ?*anyopaque) void;
pub const TXCallback = *const fn (data: []u8, first: bool, param: ?*anyopaque) usize;

const Self = @This();

var i2cs: [2]Self = .{ .{ .regs = I2C0 }, .{ .regs = I2C1 } };

pub const i2c0 = &i2cs[0];
pub const i2c1 = &i2cs[1];

regs: *volatile I2cRegs = undefined,
rxCallback: RXCallback = undefined,
txCallback: TXCallback = undefined,
param: ?*anyopaque = null,
transfer_buffer: []u8 = undefined,
transfer_index: usize = 0,
transfer_length: usize = 0,
data_received: bool = false,
first_call: bool = true,
gen_call: bool = false,
tx_end: bool = false,

pub fn isr0() callconv(.c) void {
    i2cs[0].isr_common();
}

pub fn isr1() callconv(.c) void {
    i2cs[1].isr_common();
}

/// Opens the I2C slave connection
///
/// ## Parameters
///
/// * `addr` - The I2C slave address to use
/// * `transfer_buffer` - A buffer to use to transfer data
/// * `rxCallback` - The callback to use for handling data received from i2c
/// * `txCallback` - The callback to use for providing data sent to i2c
/// * `param` - An optional parameter to pass to the callback
pub fn open(self: *Self, addr: i2c.Address, transfer_buffer: []u8, rxCallback: RXCallback, txCallback: TXCallback, param: ?*anyopaque) void {
    self.transfer_buffer = transfer_buffer;
    self.transfer_length = 0;
    self.txCallback = txCallback;
    self.rxCallback = rxCallback;
    self.param = param;

    self.disable();

    self.regs.IC_SAR.write(.{ .IC_SAR = @intFromEnum(addr) });

    self.regs.IC_CON.write(.{
        .MASTER_MODE = .DISABLED,
        .IC_SLAVE_DISABLE = .SLAVE_ENABLED,
        .SPEED = .FAST,
        .RX_FIFO_FULL_HLD_CTRL = .ENABLED,
        .IC_RESTART_EN = .DISABLED,
        .TX_EMPTY_CTRL = .DISABLED,
        .IC_10BITADDR_SLAVE = .ADDR_7BITS,
        .IC_10BITADDR_MASTER = .ADDR_7BITS,
        .STOP_DET_IFADDRESSED = .DISABLED,
        .STOP_DET_IF_MASTER_ACTIVE = 0,
    });

    // Be careful when setting the mask.  Due to vagrancies of the RP2040.svd file
    // the values are the opposite of what you might expect.  When setting the mask:
    //  .ENABLED    is 0 (masked)   which means the interrupt is disabled, and
    //  .DISABLED   is 1 (unmasked) which means the interrupt is enabled.

    self.regs.IC_INTR_MASK.write(.{
        .M_RD_REQ = .DISABLED,
        .M_RX_FULL = .DISABLED,
        .M_STOP_DET = .DISABLED,
        .M_RESTART_DET = .DISABLED,
        .M_TX_ABRT = .DISABLED,

        .M_GEN_CALL = .ENABLED,
        .M_START_DET = .ENABLED,
        .M_ACTIVITY = .ENABLED,
        .M_RX_DONE = .ENABLED,
        .M_TX_EMPTY = .ENABLED,
        .M_TX_OVER = .ENABLED,
        .M_RX_OVER = .ENABLED,
        .M_RX_UNDER = .ENABLED,
    });

    self.enable();

    if (self.regs == I2C0) {
        if (irq.can_set_handler()) {
            _ = irq.set_handler(.I2C0_IRQ, .{ .c = isr0 });
        }
        irq.enable(.I2C0_IRQ);
    } else {
        if (irq.can_set_handler()) {
            _ = irq.set_handler(.I2C1_IRQ, .{ .c = isr1 });
        }
        irq.enable(.I2C1_IRQ);
    }
}

/// Close the I2C slave driver
///
/// ## Parameters
///
/// * `self` - The I2C slave driver to close
///
pub fn close(self: *Self) void {
    self.disable();
}

/// Disable the I2C slave
inline fn disable(self: *Self) void {
    self.regs.IC_ENABLE.write(.{
        .ENABLE = .DISABLED,
        .ABORT = .DISABLE,
        .TX_CMD_BLOCK = .NOT_BLOCKED,
    });
}

/// Enable the I2C slave
inline fn enable(self: *Self) void {
    self.regs.IC_ENABLE.write(.{
        .ENABLE = .ENABLED,
        .ABORT = .DISABLE,
        .TX_CMD_BLOCK = .NOT_BLOCKED,
    });
}

/// Set the I2C slave address
///
/// ## Parameters
///
/// * `self` - The I2C0 or I2C1 slave driver to use
/// * `addr` - The I2C slave address to use
///
pub fn set_slave_address(self: *Self, addr: u7) void {
    self.disable();
    self.regs.IC_SAR.write(.{ .IC_SAR = @enumFromInt(addr) });
    self.enable();
}

/// Common ISR for the I2C0 and I2C1 slave driver
///
/// ## Parameters
///
/// * `self` - The I2C0 or I2C1 slave driver to use
///
fn isr_common(self: *Self) void {

    // Save the interrupt status and clear it

    const interruptStatus = self.regs.IC_RAW_INTR_STAT.read();

    // -- Clear Abort --
    // IC_CLR_INTR does not do this correctly.

    if (interruptStatus.TX_ABRT == .ACTIVE) {
        self.regs.IC_CLR_TX_ABRT.raw = 0;
    }

    _ = self.regs.IC_CLR_INTR.read();

    // -- General Call --

    if (interruptStatus.GEN_CALL == .ACTIVE) self.gen_call = true;

    // -- We are receiving data (Write Request) --
    // Move data from the receive FIFO to the transfer buffer until all data is received
    // or the receive FIFO is empty.  Call the callback to send data to the user if the
    // transfer buffer is full.

    if (interruptStatus.RX_FULL == .ACTIVE) {
        // Process any bytes in the receive FIFO
        // Automatically cleared by hardware when fifo is empty.

        while (self.regs.IC_STATUS.read().RFNE == .NOT_EMPTY) {
            // Read a byte and associated flags from the RX FIFO.

            const dataCmd = self.regs.IC_DATA_CMD.read();

            if (interruptStatus.GEN_CALL == .ACTIVE) self.gen_call = true;

            // If the transfer buffer is full, call the callback to process the partial data

            if (self.transfer_index >= self.transfer_buffer.len) {
                self.rxCallback(self.transfer_buffer[0..self.transfer_index], self.first_call, false, self.gen_call, self.param);
                self.transfer_index = 0;
                self.first_call = false;
            }

            // Copy the byte to the transfer buffer

            self.transfer_buffer[self.transfer_index] = dataCmd.DAT;
            self.transfer_index += 1;
            self.data_received = true;
        }
    }

    // --- We have a RESTART or STOP ---
    // Send any received data we have buffered to the callback and initialize
    // the read and write modes and the transfer buffer.

    if (interruptStatus.RESTART_DET == .ACTIVE or interruptStatus.STOP_DET == .ACTIVE) {
        if (self.data_received) {
            self.rxCallback(self.transfer_buffer[0..self.transfer_index], self.first_call, true, self.gen_call, self.param);

            self.data_received = false;
        }

        self.first_call = true;
        self.gen_call = false;
        self.tx_end = false;

        self.transfer_index = 0;
        self.transfer_length = 0;
    }

    // --- We need to transmit data (Read Request) ---
    // Move data from the transfer buffer to the TX FIFO until all data is sent
    // or the TX FIFO is full.  Call the callback as needed to get data from
    // the user.

    if (interruptStatus.RD_REQ == .ACTIVE) {
        // If we don't have any data in the transfer buffer, use the registered
        // callback to get some.

        if (!self.tx_end and self.transfer_index >= self.transfer_length) {
            self.transfer_index = 0;
            self.transfer_length = self.txCallback(self.transfer_buffer, self.first_call, self.param);

            if (self.transfer_length > self.transfer_buffer.len) @panic("I2C read callback returned too much data");

            if (self.transfer_length == 0) self.tx_end = true;

            self.first_call = false;
        }

        if (self.tx_end) {
            // If we have no more data, fill the TX FIFO with zeros

            while (self.regs.IC_STATUS.read().TFNF == .NOT_FULL) {
                self.regs.IC_DATA_CMD.write_raw(0);
            }
        } else {
            // Fill the TX FIFO with data from the transfer buffer

            while (self.transfer_index < self.transfer_length and self.regs.IC_STATUS.read().TFNF == .NOT_FULL) {
                self.regs.IC_DATA_CMD.write_raw(@intCast(self.transfer_buffer[self.transfer_index]));
                self.transfer_index += 1;
            }
        }
    }
}
