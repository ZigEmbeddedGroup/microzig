pub const xosc_freq = 12_000_000;

pub const has_rp2350b = true; // Uses RP2350B chip with extra I/O pins

// ### TODO ### Add automatic default pin configuration for board pins

const microzig = @import("microzig");
const hal = microzig.hal;
const pins = hal.pins;

pub const pin_config = pins.GlobalConfiguration{
    // .GPIO12 = .{
    //     .name = "hstx_d2p",
    //     .function = .HSTX,
    // },
    //
    // .GPIO13 = .{
    //     .name = "hstx_d2n",
    //     .function = .HSTX,
    // },
    //
    // .GPIO14 = .{
    //     .name = "hstx_ckp",
    //     .function = .HSTX,
    // },
    //
    // .GPIO15 = .{
    //     .name = "hstx_ckn",
    //     .function = .HSTX,
    // },
    //
    // .GPIO16 = .{
    //     .name = "hstx_d1p",
    //     .function = .HSTX,
    // },
    //
    // .GPIO17 = .{
    //     .name = "hstx_d1n",
    //     .function = .HSTX,
    // },
    //
    // .GPIO18 = .{
    //     .name = "hstx_d0p",
    //     .function = .HSTX,
    // },
    //
    // .GPIO19 = .{
    //     .name = "hstx_d0n",
    //     .function = .HSTX,
    // },
    //
    // .GPIO20 = .{
    //     .name = "sda",
    //     .function = .I2C0_SDA,
    // },
    //
    // .GPIO21 = .{
    //     .name = "scl",
    //     .function = .I2C0_SCL,
    // },

    .GPIO23 = .{
        .name = "led",
        .function = .SIO,
        .direction = .out,
    },

    // .GPIO24 = .{
    //     .name = "boot_button",
    //     .function = .SIO,
    //     .direction = .in,
    // },
    //
    // .GPIO25 = .{
    //     .name = "neo_pixel",
    //     .function = .SIO,
    //     .direction = .out,
    // },
    //
    // .GPIO26 = .{
    //     .name = "hstx_d26",
    //     .function = .SIO,
    // },
    //
    // .GPIO27 = .{
    //     .name = "hstx_d27",
    //     .function = .SIO,
    // },
    //
    // .GPIO28 = .{
    //     .name = "miso",
    //     .function = .SPI1_RX,
    // },
    //
    // .GPIO29 = .{
    //     .name = "usb_host_power",
    //     .function = .SIO,
    //     .direction = .out,
    // },
    //
    // .GPIO30 = .{
    //     .name = "sck",
    //     .function = .SPI1_SCK,
    // },
    //
    // .GPIO31 = .{
    //     .name = "mosi",
    //     .function = .SPI1_TX,
    // },
    //
    // .GPIO32 = .{
    //     .name = "usb_host_data_plus",
    // },
    //
    // .GPIO33 = .{
    //     .name = "usb_host_data_minus",
    // },
    //
    // .GPIO34 = .{
    //     .name = "sd_sck",
    //     .function = .SPI0_SCK,
    //     .direction = .out,
    // },
    //
    // .GPIO35 = .{
    //     .name = "sd_mosi",
    //     .function = .SPI0_TX,
    //     .direction = .out,
    // },
    //
    // .GPIO36 = .{
    //     .name = "sd_miso",
    //     .function = .SPI0_RX,
    //     .direction = .in,
    // },
    //
    // .GPIO37 = .{
    //     .name = "sd_data1",
    //     .direction = .out,
    // },
    //
    // .GPIO38 = .{
    //     .name = "sd_data2",
    //     .direction = .out,
    // },
    //
    // .GPIO39 = .{
    //     .name = "sd_cs",
    //     .function = .SIO,
    //     .direction = .out,
    // },
    //
    // .GPIO40 = .{
    //     .name = "sd_cd",
    // },
    //
    // .GPIO41 = .{
    //     .name = "A0",
    //     .function = .ADC1,
    // },
    //
    // .GPIO42 = .{
    //     .name = "A1",
    //     .function = .ADC2,
    // },
    //
    // .GPIO43 = .{
    //     .name = "A2",
    //     .function = .ADC3,
    // },
    //
    // .GPIO44 = .{
    //     .name = "A3",
    //     .function = .ADC4,
    // },
    //
    // .GPIO45 = .{
    //     .name = "A4",
    //     .function = .ADC5,
    // },
    //
    // .GPIO46 = .{
    //     .name = "A5",
    //     .function = .ADC6,
    // },
    //
    // .GPIO47 = .{
    //     .name = "QMI_CS1",
    //     .function = .PIO2,
    //     .direction = .out,
    // },
};
