const mdf = @import("../framework.zig");
pub const lcd_delayus_callback = fn (delay: u32) void;

pub const Lcd_commands = enum(u8) {
    lcd_clear = 0x01,
    lcd_reset = 0x02,
    lcd_shift_cursor_left = 0x10,
    lcd_shift_cursor_right = 0x14,
    lcd_shift_display_left = 0x18,
    lcd_shift_display_right = 0x1C,
};

//lcd "function set" enums
const Function_set = enum(u8) {
    lcd_line = 0x8,
    lcd_bus = 0x10,
    lcd_char = 0x4,
};

pub const Lines = enum(u8) { one, two };
pub const Bussize = enum(u8) { bus4bits, bus8bits };
pub const Charsize = enum(u8) { char5x8, char5x10 };

//lcd "entry mode" enums
const Entry_mode = enum(u8) { lcd_shift_mode = 0x1, lcd_shift_dir = 0x2 };
pub const State = enum(u8) {
    off,
    on,
};

pub const ShiftDirection = enum(u8) {
    dec,
    inc,
};

//lcd "display control" enums
const Display_control = enum(u8) { lcd_blink = 0x01, lcd_cursor = 0x02, lcd_display = 0x04 };

pub const Config = struct {
    lines: Lines = .two,
    bus: Bussize = .bus4bits,
    char_size: Charsize = .char5x8,
    shift_direction: ShiftDirection = .inc,
    display_shift: State = .off,
    cursor: State = .off,
    cursor_blink: State = .off,
    display: State = .on,
};
pub const HD44780 = struct {
    //internal config vars
    function_set: u8,
    entry_mode: u8,
    display_control: u8,
    enable_set: u8,
    full_bus: bool,

    //internal_callbacks
    internal_delay: *const lcd_delayus_callback,
    io_interface: mdf.base.Datagram_Device,

    //LCD functions

    //create a new LCD without set configs
    //TODO:  8bits - 11 pin parallel interface
    fn interface(Self: *HD44780, config: u8, data: u8) void {
        const pkg: [1]u8 = .{(config & 0b00000111) | (data & 0xF0) | 0x08};
        Self.io_interface.write(&pkg) catch return; //TODO: return Error
    }

    fn send8bits(Self: *HD44780, data: u8, rs_state: u1) void {
        Self.interface(rs_state, data);
        Self.interface(rs_state | Self.enable_set, data);
        Self.internal_delay(1);
        Self.interface(rs_state, data);
    }

    fn send4bits(Self: *HD44780, data: u8, rs_state: u1) void {
        const high_nibble: u8 = data & 0xF0;
        const low_nibble: u8 = data << 4;
        Self.send8bits(high_nibble, rs_state);
        Self.internal_delay(1);
        Self.send8bits(low_nibble, rs_state);
    }

    //Low level sendfunction
    pub fn send(Self: *HD44780, data: u8, rs_state: u1) *HD44780 {
        if (Self.full_bus) {
            Self.send8bits(data, rs_state);
        } else {
            Self.send4bits(data, rs_state);
        }

        if (rs_state == 0) {
            Self.internal_delay(40);
        } else {
            Self.internal_delay(2);
        }
        return Self;
    }
    //config functions
    pub fn set_bus_size(Self: *HD44780, size: Bussize) *HD44780 {
        if (size == Bussize.bus4bits) {
            Self.function_set &= ~@intFromEnum(Function_set.lcd_bus);
            Self.full_bus = false;
        } else {
            Self.function_set |= @intFromEnum(Function_set.lcd_bus);
            Self.full_bus = true;
        }
        return Self;
    }

    pub fn set_char_size(Self: *HD44780, charsize: Charsize) *HD44780 {
        if (charsize == Charsize.char5x8) {
            Self.function_set &= ~@intFromEnum(Function_set.lcd_char);
        } else {
            Self.function_set |= @intFromEnum(Function_set.lcd_char);
        }
        return Self;
    }

    //========== commands functions ==========

    //TODO: change left/right to dec/inc

    //low level command function
    pub inline fn command(Self: *HD44780, cmd: Lcd_commands) void {
        _ = Self.send(@intFromEnum(cmd), 0);
    }

    pub fn screen_clear(Self: *HD44780) *HD44780 {
        Self.command(Lcd_commands.lcd_clear);
        Self.internal_delay(1600); //clear and reset need to delay >1.6ms
        return Self;
    }

    pub fn reset_cursor(Self: *HD44780) *HD44780 {
        Self.command(Lcd_commands.lcd_reset);
        Self.internal_delay(1600); //clear and reset need to delay >1.6ms
        return Self;
    }

    pub fn shift_cursor_left(Self: *HD44780) *HD44780 {
        Self.command(Lcd_commands.lcd_shift_cursor_left);
        return Self;
    }

    pub fn shift_cursor_right(Self: *HD44780) *HD44780 {
        Self.command(Lcd_commands.lcd_shift_cursor_right);
        return Self;
    }

    pub fn shift_display_left(Self: *HD44780) *HD44780 {
        Self.command(Lcd_commands.lcd_shift_display_left);
        return Self;
    }

    pub fn shift_display_right(Self: *HD44780) *HD44780 {
        Self.command(Lcd_commands.lcd_shift_display_right);
        return Self;
    }

    //control functions

    pub fn shift_control(Self: *HD44780, st: State) *HD44780 {
        switch (st) {
            .on => Self.entry_mode |= Entry_mode.lcd_shift_mode,
            .off => Self.entry_mode &= ~Entry_mode.lcd_shift_mode,
        }
        _ = Self.send(Self.entry_mode, 0);
        return Self;
    }

    pub fn shift_mode(Self: *HD44780, mode: ShiftDirection) *HD44780 {
        switch (mode) {
            .inc => Self.entry_mode |= Entry_mode.lcd_shift_dir,
            .dec => Self.entry_mode &= ~Entry_mode.lcd_shift_dir,
        }
        _ = Self.send(Self.entry_mode, 0);
        return Self;
    }

    pub fn display_set(Self: *HD44780, st: State) *HD44780 {
        switch (st) {
            .on => Self.display_control |= Display_control.lcd_display,
            .off => Self.display_control &= ~Display_control.lcd_display,
        }
        _ = Self.send(Self.display_control, 0);
        return Self;
    }

    pub fn cursor_control(Self: *HD44780, st: State) *HD44780 {
        switch (st) {
            .on => Self.display_control |= Display_control.lcd_cursor,
            .off => Self.display_control &= ~Display_control.lcd_cursor,
        }
        _ = Self.send(Self.display_control, 0);
        return Self;
    }

    pub fn cursor_blink_control(Self: *HD44780, st: State) *HD44780 {
        switch (st) {
            .on => Self.display_control |= Display_control.lcd_blink,
            .off => Self.display_control &= ~Display_control.lcd_blink,
        }
        _ = Self.send(Self.display_control, 0);
        return Self;
    }

    pub fn select_all(Self: *HD44780) *HD44780 {
        Self.enable_set = 0b1100;
        return Self;
    }
    pub inline fn select_lcd(Self: *HD44780, en: u1) *HD44780 {
        Self.enable_set = 1 << en;
        return Self;
    }

    pub fn set_cursor(Self: *HD44780, line: u8, col: u8) *HD44780 {
        const addrs = [_]u8{ 0x80, 0xC0 };
        if ((line < 2) and (col < 40)) {
            _ = Self.send(addrs[line] | col, 0);
        }
    }

    pub fn create_custom_char(Self: *HD44780, new_char: [8]u8, mem_addr: u8) *HD44780 {
        const mem_aux = ((mem_addr & 0b111) << 3) | 0x40;
        _ = Self.send(mem_aux, 0);
        for (new_char) |line| {
            _ = Self.send(line, 1);
        }
        return Self;
    }

    pub fn write(Self: *HD44780, text: []const u8) *HD44780 {
        for (text) |char| {
            _ = Self.send(char, 1);
        }
        return Self;
    }

    pub fn init_device(Self: *HD44780, skip_init_time: bool) *HD44780 {
        if (!skip_init_time) {
            Self.internal_delay(55000); //wait time = power on time + init time (datasheet: power up time = >40ms | begin time = >15ms)
        }
        _ = Self.select_all();
        Self.send8bits(0x30, 0);
        Self.internal_delay(4100);
        Self.send8bits(0x30, 0);
        Self.internal_delay(100);
        Self.send8bits(0x30, 0);
        Self.internal_delay(100);
        Self.send8bits(0x20, 0);
        _ = Self.send(Self.function_set, 0);
        _ = Self.screen_clear().reset_cursor();
        _ = Self.send(Self.entry_mode, 0);
        _ = Self.send(Self.display_control, 0);
        return Self;
    }

    pub fn init(io_device: mdf.base.Datagram_Device, delay_callback: *const lcd_delayus_callback, config: Config) HD44780 {
        const function_set = (1 << 5) + (@intFromEnum(config.bus) << 4) + (@intFromEnum(config.lines) << 3) + @intFromEnum(config.char_size) << 2;
        const entry_mode = (1 << 2) + (@intFromEnum(config.shift_direction) << 1) + @intFromEnum(config.display_shift);
        const display_control = (1 << 3) + (@intFromEnum(config.display) << 2) + (@intFromEnum(config.cursor) << 1) + @intFromEnum(config.cursor_blink);
        const bus = !(config.bus == .bus4bits);
        const lcd = HD44780{
            .function_set = function_set,
            .entry_mode = entry_mode,
            .display_control = display_control,
            .enable_set = 0b1100,
            .full_bus = bus,
            .internal_delay = delay_callback,
            .io_interface = io_device,
        };
        return lcd;
    }
};
