//!
//! This file implements an I²C slave driver for the RP2 chip family.
//!
//! Useful links:
//!     (Unofficial) I²C Reference: https://www.i2c-bus.org/
//!
//! To use this driver, you must open the I²C slave connection
//! using `I2C_Slave.open()`.  Once the connection is open, and the
//! appropriate ISR is set up, the driver will listen for I²C transactions.
//!
//! If the master requests a read, the driver will call the registered
//! callback with the `mode` set to `.read`.  The  `data` parameter will
//! be a slice into the transfer buffer that the callback function should copy
//! data to.  Since I²C has no means of indicating how much data will be read,
//! the user must add an appropriate amount of data to the buffer.  If more data
//! is requested than will fit in the buffer, the driver will call the callback
//! again with the `mode` set to `.read_more`.
//!
//! If the master requests a write, the driver will call the registered
//! callback with the `mode` set to `.write` and the `data` parameter
//! containing the data sent.  If more data is sent than will fit in the buffer,
//! the driver will return additional data with the `mode` set to
//! `.write_more`.
//!
//! A general call is requested is handled like a write but the `mode`
//! will be `.gen_call` or `.gen_call_more`.
//!
//! The callback operates at interrupt time, so it should not block or
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

pub const CallbackMode = enum { read, read_more, write, write_more, gen_call, gen_call_more };
pub const Callback = *const fn (mode: CallbackMode, data: []u8, param: ?*anyopaque) void;

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
write_mode: CallbackMode = .write,

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
/// * `callback` - The callback to use for handling received data
/// * `param` - The parameter to pass to the callback
pub fn open(self: *Self, addr: u7, transfer_buffer: []u8, callback: Callback, param: ?*anyopaque) void {
    self.transfer_buffer = transfer_buffer;
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

    self.regs.IC_INTR_MASK.write(.{
        .M_RD_REQ = .ENABLED,
        .M_RX_FULL = .ENABLED,
        .M_STOP_DET = .ENABLED,
        .M_RESTART_DET = .ENABLED,
        .M_TX_ABRT = .ENABLED,

        .M_GEN_CALL = .DISABLED,
        .M_START_DET = .DISABLED,
        .M_ACTIVITY = .DISABLED,
        .M_RX_DONE = .DISABLED,
        .M_TX_EMPTY = .DISABLED,
        .M_TX_OVER = .DISABLED,
        .M_RX_OVER = .DISABLED,
        .M_RX_UNDER = .DISABLED,
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
    irq.enable( .I2C1_IRQ );
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

var x : u32 = 0;
var y : u32 = 0;

fn isr_common(self: *Self) void {

    x += 1;
    if (x > 1_000_000) {
        gpio.num(15).toggle(); // red
        x = 0;
    }

    // Save the interrupt status and clear it

    const interruptStatus = self.regs.IC_RAW_INTR_STAT.read();
    _ = self.regs.IC_CLR_INTR.read();



    // if (@as(u32, @bitCast(interruptStatus)) & 0xFFFFFFEF != 0) {
    if (interruptStatus.TX_EMPTY == .ACTIVE) {
        y += 1;
        if (y > 200_000) {
            gpio.num(14).toggle(); // green
            y = 0;
        }
    }

    //  RESTART_DET +
    //  GEN_CALL    -
    //  START_DET   -
    //  STOP_DET    +
    //  ACTIVITY    -
    //  RX_DONE     -
    //  TX_ABRT     +
    //  RD_REQ      +
    //  TX_EMPTY    -
    //  TX_OVER     -
    // RX_FULL     +
    // RX_OVER     -
    // RX_UNDER    -

    // // -- Transmit Abort --

    // if (interruptStatus.TX_ABRT == .ACTIVE) {
    //     // i2c_abort_count_debug += 1;
    //     // i2c_abort_source_debug = self.i2c.get_regs().IC_TX_ABRT_SOURCE.read();
    // }

    // --- We have a RESTART or STOP ---
    // Send any received data we have buffered to the callback and initialize
    // the read and write modes and the transfer buffer.

    if (interruptStatus.RESTART_DET == .ACTIVE or interruptStatus.STOP_DET == .ACTIVE) {
        if (self.data_received) {
            self.callback(self.write_mode, self.transfer_buffer[0..self.transfer_index], self.param);

            self.data_received = false;
        }

        self.read_mode = .read;
        self.write_mode = .write;

        self.transfer_index = 0;
        self.transfer_length = 0;
    }

    // --- We need to transmit data (Read Request) ---
    // Move data from the transfer buffer to the TX FIFO until all data is sent
    // or the TX FIFO is full.  Call the callback as needed to get data from
    // the user.

    if (interruptStatus.RD_REQ == .ACTIVE) {
        // If we don't have any data yet, use the registered
        // callback to get the data we need.

        if (self.transfer_index >= self.transfer_length) {
            self.callback(self.read_mode, self.transfer_buffer, self.param);

            self.transfer_index = 0;
            self.transfer_length = self.transfer_buffer.len;

            self.read_mode = .read_more;
        }

        // Send the data

        while (self.transfer_index < self.transfer_length and self.regs.IC_TXFLR.read().TXFLR < fifo_length) {
            self.regs.IC_DATA_CMD.write_raw(@intCast(self.transfer_buffer[self.transfer_index]));
            self.transfer_index += 1;
        }
    }

    // -- We are receiving data (Write Request) --
    // Move data from the receive FIFO to the transfer buffer until all data is received
    // or the receive FIFO is empty.  Call the callback to send data to the user if the
    // transfer buffer is full.

    if (interruptStatus.RX_FULL == .ACTIVE) {
        // Process any bytes in the receive FIFO

        // Automatically cleared by hardware when fifo is empty.

        while (self.regs.IC_RXFLR.read().RXFLR > 0) {
            // Read a byte and associated flags from the RX FIFO.

            const dataCmd = self.regs.IC_DATA_CMD.read();

            // If it's the first byte in a transfer initialize the
            // transfer index.
            if (dataCmd.FIRST_DATA_BYTE == .ACTIVE) {
                self.transfer_index = 0;
                self.data_received = true;

                if (interruptStatus.GEN_CALL == .ACTIVE) {
                    self.write_mode = .gen_call;
                } else {
                    self.write_mode = .write;
                }
            }

            // If the transfer buffer is full, call the callback to process the data
            if (self.transfer_index >= self.transfer_length) {
                self.callback(self.write_mode, self.transfer_buffer, self.param);
                self.transfer_length = self.transfer_buffer.len;
                if (self.write_mode == .gen_call or self.write_mode == .gen_call_more) {
                    self.write_mode = .gen_call_more;
                } else {
                    self.write_mode = .write_more;
                }
                self.transfer_index = 0;
            }

            // Copy the byte to the transfer buffer
            self.transfer_buffer[self.transfer_index] = dataCmd.DAT;
            self.transfer_index += 1;
        }
    }
}
