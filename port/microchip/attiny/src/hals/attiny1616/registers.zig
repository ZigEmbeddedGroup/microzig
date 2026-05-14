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

pub inline fn set_bits(address: u16, mask: u8) void {
    write(address, read(address) | mask);
}

pub inline fn clear_bits(address: u16, mask: u8) void {
    write(address, read(address) & ~mask);
}

pub inline fn bit(bit_index: u3) u8 {
    return @as(u8, 1) << bit_index;
}

pub const ccp_signature = 0xD8;

pub const vporta_dir = 0x0000;
pub const vporta_out = 0x0001;
pub const vporta_in = 0x0002;
pub const vporta_intflags = 0x0003;
pub const vportb_dir = 0x0004;
pub const vportb_out = 0x0005;
pub const vportb_in = 0x0006;
pub const vportb_intflags = 0x0007;
pub const vportc_dir = 0x0008;
pub const vportc_out = 0x0009;
pub const vportc_in = 0x000A;
pub const vportc_intflags = 0x000B;

pub const ccp = 0x0034;
pub const rstctrl_rstfr = 0x0040;
pub const rstctrl_swrr = 0x0041;
pub const clkctrl_mclkctrla = 0x0060;
pub const clkctrl_mclkctrlb = 0x0061;
pub const clkctrl_mclkstatus = 0x0063;
pub const vref_ctrla = 0x00A0;
pub const vref_ctrlb = 0x00A1;
pub const wdt_ctrla = 0x0100;
pub const wdt_status = 0x0101;

pub const rtc_pitctrla = 0x0150;
pub const rtc_pitstatus = 0x0151;
pub const rtc_pitintctrl = 0x0152;
pub const rtc_pitintflags = 0x0153;

pub const porta_dir = 0x0400;
pub const porta_out = 0x0404;
pub const porta_in = 0x0408;
pub const porta_intflags = 0x0409;
pub const porta_pinctrl = 0x0410;
pub const portb_dir = 0x0420;
pub const portb_out = 0x0424;
pub const portb_in = 0x0428;
pub const portb_intflags = 0x0429;
pub const portb_pinctrl = 0x0430;
pub const portc_dir = 0x0440;
pub const portc_out = 0x0444;
pub const portc_in = 0x0448;
pub const portc_intflags = 0x0449;
pub const portc_pinctrl = 0x0450;

pub const adc0_ctrla = 0x0600;
pub const adc0_ctrlb = 0x0601;
pub const adc0_ctrlc = 0x0602;
pub const adc0_ctrld = 0x0603;
pub const adc0_sampctrl = 0x0605;
pub const adc0_muxpos = 0x0606;
pub const adc0_command = 0x0608;
pub const adc0_intctrl = 0x060A;
pub const adc0_intflags = 0x060B;
pub const adc0_res = 0x0610;
pub const dac0_data = 0x06A1;

pub const tca0_single_ctrla = 0x0A00;
pub const tca0_single_ctrlb = 0x0A01;
pub const tca0_single_intctrl = 0x0A0A;
pub const tca0_single_intflags = 0x0A0B;
pub const tca0_single_cnt = 0x0A20;
pub const tca0_single_per = 0x0A26;
pub const tca0_single_cmp0 = 0x0A28;
pub const tca0_single_cmp1 = 0x0A2A;
pub const tca0_single_perbuf = 0x0A36;
pub const tca0_single_cmp0buf = 0x0A38;
pub const tca0_single_cmp1buf = 0x0A3A;

pub const nvmctrl_ctrla = 0x1000;
pub const nvmctrl_status = 0x1002;

pub const ccp_ioreg_signature = 0xD8;
pub const ccp_spm_signature = 0x9D;

pub const port_bits = struct {
    pub const pullupen = 3;
};

pub const adc_bits = struct {
    pub const enable = 0;
    pub const freerun = 1;
    pub const runstby = 7;
    pub const start = 0;
    pub const sample_capacitance = 6;
    pub const resrdy = 0;
};

pub const rtc_bits = struct {
    pub const piten = 0;
    pub const pi = 0;
    pub const ctrlbusy = 0;
};

pub const tca_bits = struct {
    pub const enable = 0;
    pub const cmp0en = 4;
    pub const cmp1en = 5;
    pub const ovf = 0;
};

pub const wdt_bits = struct {
    pub const syncbusy = 0;
};

pub const nvm_bits = struct {
    pub const fbusy = 0;
    pub const eebusy = 1;
};
