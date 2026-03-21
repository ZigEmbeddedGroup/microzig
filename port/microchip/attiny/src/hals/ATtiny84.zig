const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const cpu = microzig.cpu;

pub const gpio = struct {
    pub const Port = enum(u1) {
        a = 0,
        b = 1,

        pub const Regs = extern struct {
            /// Port Input Pins
            PIN: u8,
            /// Port Data Direction Register
            DDR: u8,
            /// Port Data Register
            PORT: u8,
        };

        // IO addresses (data address - 0x20) for SBI/CBI instructions.
        // PINB=0x16, DDRB=0x17, PORTB=0x18
        // PINA=0x19, DDRA=0x1A, PORTA=0x1B
        pub inline fn get_regs(port: Port) *volatile Regs {
            return switch (port) {
                .b => @ptrFromInt(0x16),
                .a => @ptrFromInt(0x19),
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

    pub const Pin = packed struct(u4) {
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
