pub const xosc_freq = 12_000_000;

pub const has_qfn_80 = true;  // Uses QFN-80 chip with extra I/O pins

// ### TODO ### Add automatic default pin configuration for board pins

const microzig = @import("microzig");
const hal = microzig.hal;
const pins = hal.pins;

pub const pin_config = pins.GlobalConfiguration{
    .GPIO12 = .{
        .name = "hstx_d2p",
    },

    .GPIO13 = .{
        .name = "hstx_d2n",
    },

    .GPIO14 = .{
        .name = "hstx_ckp",
    },

    .GPIO15 = .{
        .name = "hstx_ckn",
    },

    .GPIO16 = .{
        .name = "hstx_d1p",
    },

    .GPIO17 = .{
        .name = "hstx_d1n",
    },

    .GPIO18 = .{
        .name = "hstx_d0p",
    },

    .GPIO19 = .{
        .name = "hstx_d0n",
    },

    .GPIO20 = .{
        .name = "sda",
        .function = .I2C0,
    },

    .GPIO21 = .{
        .name = "scl",
        .function = .I2C0,
    },

    .GPIO23 = .{
        .name = "red_led",
        .function = .SIO,
        .direction = .out,
    },

    .GPIO24 = .{
        .name = "boot_button",
        .function = .SIO,
        .direction = .in,
    },

    .GPIO25 = .{
        .name = "neo_pixel",
        .function = .SIO,
        .direction = .out,
    },

    .GPIO26 = .{
        .name = "hstx_d26",
    },

    .GPIO27 = .{
        .name = "hstx_d27",
    },

    .GPIO28 = .{
        .name = "miso",
        .function = .SPI0,
    },

    .GPIO29 = .{
        .name = "usb_host_power",
        .function = .SIO,
        .direction = .out,
    },

    .GPIO30 = .{
        .name = "mosi",
        .function = .SPI0,
    },

    .GPIO31 = .{
        .name = "sck",
        .function = .SPI0,
    },

    .GPIO32 = .{
        .name = "usb_host_data_plus",
    },

    .GPIO33 = .{
        .name = "usb_host_data_minus",
    },

    .GPIO34 = .{
        .name = "sd_sck",
        .function = .SPI1,
        .direction = .out,
    },

    .GPIO35 = .{
        .name = "sd_miso",
        .function = .SPI1,
        .direction = .in,
    },

    .GPIO36 = .{
        .name = "sd_mosi",
        .function = .SPI1,
        .direction = .out,
    },

    .GPIO37 = .{
        .name = "sd_data1",
        .direction = .out,
    },

    .GPIO38 = .{
        .name = "sd_data2",
        .direction = .out,
    },

    .GPIO39 = .{
        .name = "sd_cs",
        .function = .SPI1,
        .direction = .out,
    },

    .GPIO40 = .{
        .name = "sd_cd",
    },

    .GPIO41 = .{
        .name = "a0",
    },

    .GPIO42 = .{
        .name = "a1",
    },

    .GPIO43 = .{
        .name = "a2",
    },

    .GPIO44 = .{
        .name = "a3",
    },

    .GPIO45 = .{
        .name = "a4",
    },

    .GPIO46 = .{
        .name = "a5",
    },

    .GPIO47 = .{
        .name = "QMI_CS1",
        .function = .PIO2,
    },
};