//!
//! This file implements an I²C slave driver for the RP2 chip family.
//!
//! Useful links:
//!     (Unofficial) I²C Reference: https://www.i2c-bus.org/
//!
//! To use this driver, you must open the I²C slave connection
//! using `I2C_Slave.open()` with the following parameters:
//!
//! * `addr` - The I²C slave address to listen to
//! * `transfer_buffer` - A buffer to use to transfer data
//! * `callback` - The callback to use for handling requests
//! * `param` - The parameter to pass to the callback
//!
//! The transfer buffer SHOULD be sized to hold the maximum amount of data
//! that will be transferred in a single transaction, but it is not required
//! to be.
//!
//! Once the connection is open, and the appropriate ISR is set up,
//! the driver will listen for I²C transactions.
//!
//! ## Master Read / Slave Write
//!
//! If the master requests a read, the driver will call the registered
//! callback with the `mode` set to `.read`.  The  `data` parameter will
//! be a slice that the callback function should copy data to. Since I²C has no
//! means of indicating how much data will be read, this slice's
//! length will the length of the transfer buffer passed to `I2C_Slave.open()`).
//! The user MUST add at least one byte to the buffer, and return the number of
//! bytes added.  If more data is provided that actually needed, the extra data
//! will be ignored.  If insufficient data is provided, the driver will call the
//! callback again with the `mode` set to `.read_more` until all needed data is
//! supplied.
//!
//! ## Master Write / Slave Read
//!
//! If the master requests a write, the driver will call the registered
//! callback with the `mode` set to `.write` and the `data` parameter
//! containing a slice with the data sent.  If more data is sent by the master
//! than will fit in the buffer, the driver will make one or more calls to the
//! callback with the `mode` set to `.write_part` before making the final call
//! with the `mode` set to `.write`.
//!
//! The user SHOULD return the number of bytes consumed, but at present this
//! return value is ignored.
//!
//! A general call request is handled like a write but the `mode`
//! will be `.gen_call` or `.gen_call_part`.
//!
//! ## Notes
//!
//! The callback operates at interrupt time, so it SHOULD not block or
//! perform any time-consuming operations.
//!
//! The callback will be called with the `param` parameter passed to
//! `I2C_Slave.open()`.

const std = @import("std");
const microzig = @import("microzig");
const irq = @import("irq.zig");

const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const I2C0 = peripherals.I2C0;
const I2C1 = peripherals.I2C1;
const I2cRegs = microzig.chip.types.peripherals.I2C0;

const fifo_length = 16;

const gpio = @import("gpio.zig");

pub const CallbackMode = enum { read, read_more, write, write_part, gen_call, gen_call_part };
pub const Callback = *const fn (mode: CallbackMode, data: []u8, param: ?*anyopaque) usize;

const Self = @This();

var i2cs: [2]Self = .{ .{ .regs = I2C0 }, .{ .regs = I2C1 } };

pub const i2c0 = &i2cs[0];
pub const i2c1 = &i2cs[1];

regs: *volatile I2cRegs = undefined,
callback: Callback = undefined,
param: ?*anyopaque = null,
transfer_buffer: []u8 = undefined,
transfer_index: usize = 0,
transfer_length: usize = 0,
data_received: bool = false,
read_mode: CallbackMode = .read,
gen_call: bool = false,

pub fn isr0() callconv(.c) void {
    i2cs[0].isr_common();
}

pub fn isr1() callconv(.c) void {
    i2cs[1].isr_common();
}

/// Opens the I²C slave connection
///
/// ## Parameters
///
/// * `addr` - The I²C slave address to use
/// * `transfer_buffer` - A buffer to use to transfer data
/// * `callback` - The callback to use for handling requests
/// * `param` - The parameter to pass to the callback
pub fn open(self: *Self, addr: u7, transfer_buffer: []u8, callback: Callback, param: ?*anyopaque) void {
    self.transfer_buffer = transfer_buffer;
    self.transfer_length = 0;
    self.callback = callback;
    self.param = param;

    self.disable();

    self.regs.IC_SAR.write(.{ .IC_SAR = addr, .padding = 0 });

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
        .padding = 0,
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
        .padding = 0,
    });

    // ### TODO ### Set up the ISR at runtime
    // Ideally, MicroZig would have a way to set up the ISR at runtime,
    // and we could make a call like:
    //    `irq.set_handler( self.i2c, if (i2c == 0) isr0 else isr1);`

    // For now, you'll have to set up the ISR manually in your main program.
    // by adding something like the following to your main program:
    //
    // pub const microzig_options = microzig.Options
    //   {
    //     .interrupts = .{ .I2C0_IRQ = i2c_slave.isr0, .I2C1_IRQ = i2c_slave.isr1 },
    //   } ;

    self.enable();
    irq.enable(.I2C1_IRQ);
}

/// Close the I²C slave driver
///
/// ## Parameters
///
/// * `self` - The I²C slave driver to close
///
pub fn close(self: *Self) void {
    self.disable();
}

//------------------------------------------------------------------------------

inline fn disable(self: *Self) void {
    self.regs.IC_ENABLE.write(.{
        .ENABLE = .DISABLED,
        .ABORT = .DISABLE,
        .TX_CMD_BLOCK = .NOT_BLOCKED,
        .padding = 0,
    });
}

//------------------------------------------------------------------------------

inline fn enable(self: *Self) void {
    self.regs.IC_ENABLE.write(.{
        .ENABLE = .ENABLED,
        .ABORT = .DISABLE,
        .TX_CMD_BLOCK = .NOT_BLOCKED,
        .padding = 0,
    });
}

//------------------------------------------------------------------------------

pub fn set_slave_address(self: *Self, addr: u7) void {
    self.disable();
    self.regs.IC_SAR.write(.{ .IC_SAR = @enumFromInt(addr), .padding = 0 });
    self.enable();
}

//------------------------------------------------------------------------------
/// Common ISR for the I2C0 and I2C1 slave driver
///
/// ## Parameters
///
/// * `self` - The I2C0 or I2C1 slave driver to use
///
fn isr_common(self: *Self) void {

    // Save the interrupt status and clear it

    const interruptStatus = self.regs.IC_RAW_INTR_STAT.read();
    _ = self.regs.IC_CLR_INTR.read();

    // --- We need to transmit data (Read Request) ---
    // Move data from the transfer buffer to the TX FIFO until all data is sent
    // or the TX FIFO is full.  Call the callback as needed to get data from
    // the user.

    if (interruptStatus.RD_REQ == .ACTIVE) {
        // If we don't have any data in the transfer buffer, use the registered
        // callback to get some.

        if (self.transfer_index >= self.transfer_length) {
            self.transfer_index = 0;
            self.transfer_length = self.callback(self.read_mode, self.transfer_buffer, self.param);

            if (self.transfer_length == 0) @panic("I2C read callback returned 0");
            if (self.transfer_length > self.transfer_buffer.len) @panic("I2C read callback returned too much data");

            self.read_mode = .read_more;
        }

        // Send the data

        while (self.transfer_index < self.transfer_length and self.regs.IC_STATUS.read().TFNF == .NOT_FULL) {
            self.regs.IC_DATA_CMD.write_raw(@intCast(self.transfer_buffer[self.transfer_index]));
            self.transfer_index += 1;
        }
    }

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
                _ = self.callback(if (self.gen_call) .gen_call_part else .write_part, self.transfer_buffer, self.param);
                self.transfer_index = 0;
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
            _ = self.callback(if (self.gen_call) .gen_call else .write, self.transfer_buffer[0..self.transfer_index], self.param);

            self.data_received = false;
        }

        self.read_mode = .read;
        self.gen_call = false;

        self.transfer_index = 0;
        self.transfer_length = 0;
    }
}
