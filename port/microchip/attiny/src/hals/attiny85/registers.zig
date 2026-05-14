pub inline fn io(comptime address: u6) *volatile u8 {
    return @ptrFromInt(address);
}

pub inline fn read(comptime address: u6) u8 {
    return io(address).*;
}

pub inline fn write(comptime address: u6, value: u8) void {
    io(address).* = value;
}

pub inline fn setBits(comptime address: u6, mask: u8) void {
    io(address).* |= mask;
}

pub inline fn clearBits(comptime address: u6, mask: u8) void {
    io(address).* &= ~mask;
}

pub inline fn bit(comptime n: u3) u8 {
    return @as(u8, 1) << n;
}

pub const ADCSRB = 0x03;
pub const ADCL = 0x04;
pub const ADCH = 0x05;
pub const ADCSRA = 0x06;
pub const ADMUX = 0x07;
pub const DIDR0 = 0x14;
pub const PCMSK = 0x15;
pub const PINB = 0x16;
pub const DDRB = 0x17;
pub const PORTB = 0x18;
pub const EECR = 0x1C;
pub const EEDR = 0x1D;
pub const EEARL = 0x1E;
pub const EEARH = 0x1F;
pub const WDTCR = 0x21;
pub const CLKPR = 0x26;
pub const OCR0B = 0x28;
pub const OCR0A = 0x29;
pub const TCCR0A = 0x2A;
pub const OCR1B = 0x2B;
pub const GTCCR = 0x2C;
pub const OCR1C = 0x2D;
pub const OCR1A = 0x2E;
pub const TCNT1 = 0x2F;
pub const TCCR1 = 0x30;
pub const TCNT0 = 0x32;
pub const TCCR0B = 0x33;
pub const MCUSR = 0x34;
pub const MCUCR = 0x35;
pub const TIFR = 0x38;
pub const TIMSK = 0x39;
pub const GIFR = 0x3A;
pub const GIMSK = 0x3B;

pub const adc_bits = struct {
    pub const aden = 7;
    pub const adsc = 6;
    pub const adate = 5;
    pub const adif = 4;
    pub const adie = 3;
};

pub const eeprom_bits = struct {
    pub const eepm1 = 5;
    pub const eepm0 = 4;
    pub const eerie = 3;
    pub const eempe = 2;
    pub const eepe = 1;
    pub const eere = 0;
};

pub const watchdog_bits = struct {
    pub const wdie = 6;
    pub const wdp3 = 5;
    pub const wdce = 4;
    pub const wde = 3;
    pub const wdp2 = 2;
    pub const wdp1 = 1;
    pub const wdp0 = 0;
};

pub const sleep_bits = struct {
    pub const bods = 7;
    pub const bodse = 2;
    pub const se = 5;
    pub const sm1 = 4;
    pub const sm0 = 3;
};
