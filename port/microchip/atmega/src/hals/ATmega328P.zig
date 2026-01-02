const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const cpu = microzig.cpu;

pub const gpio = struct {
    pub const Port = enum(u2) {
        b = 1,
        c = 2,
        d = 3,

        pub const Regs = extern struct {
            /// Port Input Pins
            PIN: u8,
            /// Port Data Direction Register
            DDR: u8,
            /// Port Data Register
            PORT: u8,
        };

        // These addresses are IO addresses. These are used instead of the data
        // addresses so that we can use SBI and CBI instructiosn
        pub inline fn get_regs(port: Port) *volatile Regs {
            return switch (port) {
                .b => @ptrFromInt(0x3),
                .c => @ptrFromInt(0x6),
                .d => @ptrFromInt(0x9),
            };
        }
    };

    pub fn pin(port: Port, num: u3) Pin {
        return Pin{
            .port = port,
            .num = num,
        };
    }

    pub const Direction = enum {
        input,
        output,
    };

    pub const Pin = packed struct(u5) {
        port: Port,
        num: u3,

        pub inline fn set_direction(p: Pin, dir: Direction) void {
            const dir_addr: *volatile u8 = &p.port.get_regs().DDR;
            switch (dir) {
                .input => cpu.cbi(@intFromPtr(dir_addr), p.num),
                .output => cpu.sbi(@intFromPtr(dir_addr), p.num),
            }
        }

        pub inline fn read(p: Pin) u1 {
            const pin_addr: *volatile u8 = &p.port.get_regs().PIN;
            return @truncate(pin_addr.* >> p.num & 0x01);
        }

        pub inline fn put(p: Pin, value: u1) void {
            const port_addr: *volatile u8 = &p.port.get_regs().PORT;
            switch (value) {
                1 => cpu.sbi(@intFromPtr(port_addr), p.num),
                0 => cpu.cbi(@intFromPtr(port_addr), p.num),
            }
        }

        pub inline fn toggle(p: Pin) void {
            const pin_addr: *volatile u8 = &p.port.get_regs().PIN;
            cpu.sbi(@intFromPtr(pin_addr), p.num);
        }
    };
};
