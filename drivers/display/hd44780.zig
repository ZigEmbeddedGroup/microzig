const mdf = @import("../framework.zig");
pub const delayus_callback = fn (delay: u32) void;

pub const LcdCommands = enum(u8) {
    clear = 0x01,
    reset = 0x02,
    shift_cursor_left = 0x10,
    shift_cursor_right = 0x14,
    shift_display_left = 0x18,
    shift_display_right = 0x1C,
};

//lcd "function set" enums
const FunctionSet = enum(u8) {
    line = 0x8,
    bus = 0x10,
    char = 0x4,
};

pub const Lines = enum { one, two };
pub const BusSize = enum { four, eight };
pub const CharSize = enum { @"5x8", @"5x10" };

//lcd "entry mode" enums
const EntryMode = enum(u8) { shift_mode = 0x1, shift_dir = 0x2 };
pub const State = enum {
    off,
    on,
};

pub const ShiftDirection = enum {
    dec,
    inc,
};

//lcd "display control" enums
const DisplayControl = enum(u8) {
    blink = 0x01,
    cursor = 0x02,
    display = 0x04,
};

pub const DeviceConfig = struct {
    lines: Lines = .two,
    bus: BusSize = .four,
    char_size: CharSize = .@"5x8",
    shift_direction: ShiftDirection = .inc,
    display_shift: State = .off,
    cursor: State = .off,
    cursor_blink: State = .off,
    display: State = .on,
    skip_begin_delay: bool = false,
};

pub const HD44780_Config = struct {
    Datagram_Device: type = mdf.base.Datagram_Device,
};

pub fn HD44780(comptime config: HD44780_Config) type {
    return struct {
        const Self = @This();
        //internal_callbacks
        internal_delay: *const delayus_callback,
        io_interface: config.Datagram_Device,

        //internal Deviceconfig vars
        function_set: u6 = 0,
        entry_mode: u3 = 0,
        display_control: u4 = 0,
        enable_set: u8 = 0b1100,
        full_bus: bool = false,

        //LCD functions
        //TODO:  remove this, implement a driver for PCF8574 i2C I/O expander
        fn interface(lcd: *Self, lcd_config: u8, data: u8) !void {
            const pkg: [1]u8 = .{(lcd_config & 0b00000111) | (data & 0xF0) | 0x08};
            try lcd.io_interface.write(&pkg);
        }

        fn send8bits(lcd: *Self, data: u8, rs_state: u1) !void {
            try lcd.interface(rs_state, data);
            try lcd.interface(rs_state | lcd.enable_set, data);
            lcd.internal_delay(1);
            try lcd.interface(rs_state, data);
        }

        fn send4bits(lcd: *Self, data: u8, rs_state: u1) !void {
            const high_nibble: u8 = data & 0xF0;
            const low_nibble: u8 = data << 4;
            try lcd.send8bits(high_nibble, rs_state);
            lcd.internal_delay(1);
            try lcd.send8bits(low_nibble, rs_state);
        }

        //Low level sendfunction
        pub fn send(lcd: *Self, data: u8, rs_state: u1) !void {
            if (lcd.full_bus) {
                try lcd.send8bits(data, rs_state);
            } else {
                try lcd.send4bits(data, rs_state);
            }

            if (rs_state == 0) {
                lcd.internal_delay(40);
            } else {
                lcd.internal_delay(2);
            }
        }

        //========== commands functions ==========

        //TODO: change left/right to dec/inc

        //low level command function
        pub inline fn command(lcd: *Self, cmd: LcdCommands) !void {
            try lcd.send(@intFromEnum(cmd), 0);
        }

        pub fn screen_clear(lcd: *Self) !void {
            try lcd.command(LcdCommands.clear);
            lcd.internal_delay(1600); //clear and reset need to delay >1.6ms
        }

        pub fn reset_cursor(lcd: *Self) !void {
            try lcd.command(LcdCommands.reset);
            lcd.internal_delay(1600); //clear and reset need to delay >1.6ms
        }

        pub fn shift_cursor_left(lcd: *Self) !void {
            try lcd.command(LcdCommands.shift_cursor_left);
        }

        pub fn shift_cursor_right(lcd: *Self) !void {
            try lcd.command(LcdCommands.shift_cursor_right);
        }

        pub fn shift_display_left(lcd: *Self) !void {
            try lcd.command(LcdCommands.shift_display_left);
        }

        pub fn shift_display_right(lcd: *Self) !void {
            try lcd.command(LcdCommands.shift_display_right);
        }

        //control functions

        pub fn shift_control(lcd: *Self, st: State) !void {
            switch (st) {
                .on => lcd.entryMode |= EntryMode.shift_mode,
                .off => lcd.entryMode &= ~EntryMode.shift_mode,
            }
            try lcd.send(lcd.entryMode, 0);
        }

        pub fn shift_mode(lcd: *Self, mode: ShiftDirection) !void {
            switch (mode) {
                .inc => lcd.entryMode |= EntryMode.shift_dir,
                .dec => lcd.entryMode &= ~EntryMode.shift_dir,
            }
            try lcd.send(lcd.entryMode, 0);
        }

        pub fn display_set(lcd: *Self, st: State) !void {
            switch (st) {
                .on => lcd.displayControl |= DisplayControl.display,
                .off => lcd.displayControl &= ~DisplayControl.display,
            }
            try lcd.send(lcd.displayControl, 0);
        }

        pub fn cursor_control(lcd: *Self, st: State) !void {
            switch (st) {
                .on => lcd.displayControl |= DisplayControl.cursor,
                .off => lcd.displayControl &= ~DisplayControl.cursor,
            }
            try lcd.send(lcd.displayControl, 0);
        }

        pub fn cursor_blink_control(lcd: *Self, st: State) !void {
            switch (st) {
                .on => lcd.displayControl |= DisplayControl.blink,
                .off => lcd.displayControl &= ~DisplayControl.blink,
            }
            try lcd.send(lcd.displayControl, 0);
        }

        pub fn select_all(lcd: *Self) void {
            lcd.enable_set = 0b1100;
        }
        pub inline fn select_lcd(lcd: *Self, en: u1) !void {
            lcd.enable_set = 1 << en;
        }

        pub fn set_cursor(lcd: *Self, line: u8, col: u8) !void {
            const addrs = [_]u8{ 0x80, 0xC0 };
            if ((line < 2) and (col < 40)) {
                try lcd.send(addrs[line] | col, 0);
            }
        }

        pub fn create_custom_char(lcd: *Self, new_char: [8]u8, mem_addr: u3) !void {
            const mem_aux = (@as(u8, mem_addr) << 3) | 0x40;
            try lcd.send(mem_aux, 0);
            for (new_char) |line| {
                try lcd.send(line, 1);
            }
        }

        pub fn write(lcd: *Self, text: []const u8) !void {
            for (text) |char| {
                try lcd.send(char, 1);
            }
        }

        pub fn init_device(lcd: *Self, device_config: DeviceConfig) !void {
            lcd.function_set = (1 << 5) + (@as(u6, @intFromEnum(device_config.bus)) << 4) + (@as(u6, @intFromEnum(device_config.lines)) << 3) + (@as(u6, @intFromEnum(device_config.char_size)) << 2);
            lcd.entry_mode = (1 << 2) + (@as(u3, @intFromEnum(device_config.shift_direction)) << 1) + @intFromEnum(device_config.display_shift);
            lcd.display_control = (1 << 3) + (@as(u4, @intFromEnum(device_config.display)) << 2) + (@as(u4, @intFromEnum(device_config.cursor)) << 1) + @intFromEnum(device_config.cursor_blink);
            lcd.full_bus = !(device_config.bus == .four);
            if (!device_config.skip_begin_delay) {
                lcd.internal_delay(55000); //wait time = power on time + init time (datasheet: power up time = >40ms | begin time = >15ms)
            }
            try lcd.send8bits(0x30, 0);
            lcd.internal_delay(4100);
            try lcd.send8bits(0x30, 0);
            lcd.internal_delay(100);
            try lcd.send8bits(0x30, 0);
            lcd.internal_delay(100);
            try lcd.send8bits(0x20, 0);
            try lcd.send(lcd.function_set, 0);
            try lcd.screen_clear();
            try lcd.reset_cursor();
            try lcd.send(lcd.entry_mode, 0);
            try lcd.send(lcd.display_control, 0);
        }

        pub fn init(io_device: config.Datagram_Device, delay_callback: *const delayus_callback) Self {
            return .{
                .internal_delay = delay_callback,
                .io_interface = io_device,
            };
        }
    };
}
