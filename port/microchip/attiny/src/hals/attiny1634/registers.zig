pub inline fn mem8(address: u16) *volatile u8 {
    return @ptrFromInt(address);
}

pub inline fn mem16(address: u16) *volatile u16 {
    return @ptrFromInt(address);
}

pub inline fn read(address: u16) u8 {
    return mem8(address).*;
}

pub inline fn write(address: u16, value: u8) void {
    mem8(address).* = value;
}

pub inline fn setBits(address: u16, mask: u8) void {
    mem8(address).* |= mask;
}

pub inline fn clearBits(address: u16, mask: u8) void {
    mem8(address).* &= ~mask;
}

pub inline fn bit(n: u3) u8 {
    return @as(u8, 1) << n;
}

pub const ADCL = 0x00;
pub const ADCH = 0x01;
pub const ADCSRB = 0x02;
pub const ADCSRA = 0x03;
pub const ADMUX = 0x04;
pub const PINC = 0x07;
pub const DDRC = 0x08;
pub const PORTC = 0x09;
pub const PUEC = 0x0A;
pub const PINB = 0x0B;
pub const DDRB = 0x0C;
pub const PORTB = 0x0D;
pub const PUEB = 0x0E;
pub const PINA = 0x0F;
pub const DDRA = 0x10;
pub const PORTA = 0x11;
pub const PUEA = 0x12;
pub const OCR0B = 0x17;
pub const OCR0A = 0x18;
pub const TCNT0 = 0x19;
pub const TCCR0B = 0x1A;
pub const TCCR0A = 0x1B;
pub const EECR = 0x1C;
pub const EEDR = 0x1D;
pub const EEARL = 0x1E;
pub const EEARH = 0x1F;
pub const PCMSK0 = 0x27;
pub const PCMSK1 = 0x28;
pub const PCMSK2 = 0x29;
pub const CCP = 0x2F;
pub const WDTCSR = 0x30;
pub const CLKPR = 0x33;
pub const MCUSR = 0x35;
pub const MCUCR = 0x36;
pub const TIFR = 0x39;
pub const TIMSK = 0x3A;
pub const GIMSK = 0x3C;
pub const ICR1 = 0x68;
pub const OCR1B = 0x6A;
pub const OCR1A = 0x6C;
pub const TCNT1 = 0x6E;
pub const TCCR1C = 0x70;
pub const TCCR1B = 0x71;
pub const TCCR1A = 0x72;

pub const eeprom_bits = struct {
    pub const eempe = 2;
    pub const eepe = 1;
    pub const eere = 0;
};

pub const watchdog_bits = struct {
    pub const wdp0 = 0;
    pub const wdp1 = 1;
    pub const wdp2 = 2;
    pub const wde = 3;
    pub const wdp3 = 5;
    pub const wdie = 6;
    pub const wdif = 7;
};
