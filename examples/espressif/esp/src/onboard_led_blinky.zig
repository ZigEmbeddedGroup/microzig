const std = @import("std");
const microzig = @import("microzig");
const SPI = microzig.chip.peripherals.SPI2;
const RMT = microzig.chip.peripherals.RMT;
const hal = microzig.hal;
const gpio = hal.gpio;
const system = hal.system;
const spi = hal.spi;

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = hal.usb_serial_jtag.logger.logFn,
};

pub fn main() void {
    const mosi_pin = gpio.num(0);
    const miso_pin = gpio.num(1);
    const clk_pin = gpio.num(2);
    const cs_pin = gpio.num(3);

    mosi_pin.connect_peripheral_to_output(.fspid);
    mosi_pin.connect_input_to_peripheral(.fspid);
    miso_pin.connect_peripheral_to_output(.fspiq);
    miso_pin.connect_input_to_peripheral(.fspiq);
    clk_pin.connect_peripheral_to_output(.fspiclk);
    cs_pin.connect_peripheral_to_output(.fspics0);

    const led_pin = gpio.num(8);
    led_pin.connect_peripheral_to_output(.fspid);
    led_pin.connect_input_to_peripheral(.fspid);

    const bus: spi.SPI = .spi2;
    bus.apply(.{
        .clock_config = hal.clock_config,
        .baud_rate = 3_000_000,
        .bit_order = .msb_first,
    });

    const on_data: [12]u8 = comptime blk: {
        const payload: []const u8 = &.{ 10, 10, 10 };

        const patterns: [4]u8 = .{ 0b1000_1000, 0b1000_1110, 0b1110_1000, 0b1110_1110 };
        var output_buffer: [12]u8 = undefined;
        var i: usize = 0;
        for (payload) |byte| {
            var remaining = byte;
            for (0..4) |_| {
                const bits: u2 = @intCast((remaining & 0b1100_0000) >> 6);
                output_buffer[i] = patterns[bits];
                i += 1;
                remaining <<= 2;
            }
        }

        break :blk output_buffer;
    };

    const off_data: [12]u8 = comptime blk: {
        const payload: []const u8 = &.{ 0, 0, 0 };

        const patterns: [4]u8 = .{ 0b1000_1000, 0b1000_1110, 0b1110_1000, 0b1110_1110 };
        var output_buffer: [12]u8 = undefined;
        var i: usize = 0;
        for (payload) |byte| {
            var remaining = byte;
            for (0..4) |_| {
                const bits: u2 = @intCast((remaining & 0b1100_0000) >> 6);
                output_buffer[i] = patterns[bits];
                i += 1;
                remaining <<= 2;
            }
        }

        break :blk output_buffer;
    };

    while (true) {
        std.log.info("on", .{});
        bus.half_duplex_write_blocking(&on_data, .single_two_wires);
        hal.time.sleep_ms(1_000);
        std.log.info("off", .{});
        bus.half_duplex_write_blocking(&off_data, .single_two_wires);
        hal.time.sleep_ms(1_000);
    }

    // std.log.info("{any}", .{buf});

    // system.clocks_enable_set(.{
    //     .spi2 = true,
    // });
    // system.peripheral_reset(.{
    //     .spi2 = true,
    // });
    //
    // const mosi_pin = gpio.num(0);
    // const miso_pin = gpio.num(1);
    // const clk_pin = gpio.num(2);
    // const cs_pin = gpio.num(3);
    //
    // mosi_pin.connect_peripheral_to_output(.fspid);
    // mosi_pin.connect_input_to_peripheral(.fspid);
    // miso_pin.connect_peripheral_to_output(.fspiq);
    // miso_pin.connect_input_to_peripheral(.fspiq);
    // clk_pin.connect_peripheral_to_output(.fspiclk);
    // cs_pin.connect_peripheral_to_output(.fspics0);
    //
    // SPI.USER.write_raw(0);
    //
    // SPI.USER.modify(.{
    //     .DOUTDIN = 1,
    //
    //     .USR_MOSI = 1,
    //     .USR_MISO = 1,
    // });
    //
    // SPI.CLK_GATE.modify(.{
    //     .MST_CLK_ACTIVE = 1,
    //     .MST_CLK_SEL = 1,
    // });
    //
    // SPI.CTRL.modify(.{
    //     .Q_POL = 0,
    //     .D_POL = 0,
    //     .WP_POL = 0,
    // });
    //
    // SPI.SLAVE.write_raw(0);
    //
    // SPI.CLOCK.write(.{
    //     .CLKDIV_PRE = 1,
    //     .CLKCNT_N = 39,
    //     .CLKCNT_L = 39,
    //     .CLKCNT_H = 19,
    //     .CLK_EQU_SYSCLK = 0,
    // });
    //
    // SPI.MS_DLEN.write(.{
    //     .MS_DATA_BITLEN = 2 * 4 * 8 - 1,
    // });
    //
    // const buf: *volatile [16]u32 = @ptrCast(&SPI.W0);
    // for (0..2) |i| {
    //     buf[i] = 0xbad_c0fee;
    // }
    //
    // SPI.DMA_INT_CLR.modify(.{
    //     .TRANS_DONE_INT_CLR = 1,
    // });
    //
    // SPI.DMA_INT_ENA.modify(.{
    //     .TRANS_DONE_INT_ENA = 1,
    // });
    //
    // SPI.DMA_CONF.modify(.{
    //     .RX_AFIFO_RST = 1,
    //     .BUF_AFIFO_RST = 1,
    //     .DMA_AFIFO_RST = 1,
    // });
    //
    // SPI.DMA_CONF.modify(.{
    //     .RX_AFIFO_RST = 0,
    //     .BUF_AFIFO_RST = 0,
    //     .DMA_AFIFO_RST = 0,
    // });
    //
    // SPI.CMD.modify(.{
    //     .UPDATE = 1,
    // });
    //
    // while (SPI.CMD.read().UPDATE == 1) {}
    //
    // SPI.CMD.modify(.{
    //     .USR = 1,
    // });
    //
    // std.log.info("started", .{});
    //
    // while (SPI.DMA_INT_RAW.read().TRANS_DONE_INT_RAW != 1) {}
    //
    // SPI.DMA_INT_CLR.modify(.{
    //     .TRANS_DONE_INT_CLR = 1,
    // });
    //
    // std.log.info("done", .{});
    //
    // std.log.info("{any}", .{SPI.USER.read()});
}

// pub fn main() void {
//     std.log.info("hello world", .{});
//
//     // const RMT_RAM: usize = 0x60016400;
//     const RMT_RAM: [*]volatile RAM_Entry = @ptrFromInt(0x60016400);
//
//     system.clocks_enable_set(.{
//         .rmt = true,
//     });
//     system.peripheral_reset(.{
//         .rmt = true,
//     });
//
//     const led_pin = gpio.num(0);
//     led_pin.reset();
//     led_pin.connect_peripheral_to_output(.rmt0);
//
//     // Self::set_threshold((constants::RMT_CHANNEL_RAM_SIZE * Self::memsize() as usize / 2) as u8);
//     // Self::set_continuous(continuous);
//     // Self::set_generate_repeat_interrupt(repeat);
//     // Self::set_wrap_mode(true);
//     // Self::update();
//     // Self::start_tx();
//     // Self::update();
//
//     // var index: usize = 0;
//     // const data: []const u8 = &.{ 100, 100, 100 };
//     // for (data) |byte| {
//     //     var b = byte;
//     //     for (0..8) |_| {
//     //         const is_one = (b & 0b1000_0000) != 0;
//     //         b <<= 1;
//     //
//     //         const ptr: *volatile RAM_Entry = @ptrFromInt(RMT_RAM + index * @sizeOf(u32));
//     //         ptr.* = if (is_one) .{
//     //             .first = .{
//     //                 .period = 3,
//     //                 .level = 1,
//     //             },
//     //             .second = .{
//     //                 .period = 7,
//     //                 .level = 0,
//     //             },
//     //         } else .{
//     //             .first = .{
//     //                 .period = 5,
//     //                 .level = 1,
//     //             },
//     //             .second = .{
//     //                 .period = 6,
//     //                 .level = 0,
//     //             },
//     //         };
//     //
//     //         std.log.info("write {}", .{index});
//     //
//     //         index += 1;
//     //     }
//     // }
//     //
//     // @as(*volatile RAM_Entry, @ptrFromInt(RMT_RAM + index * @sizeOf(u32))).* = .{
//     //     .first = .{
//     //         .period = 0,
//     //         .level = 0,
//     //     },
//     //     .second = .{
//     //         .period = 0,
//     //         .level = 0,
//     //     },
//     // };
//
//     RMT.SYS_CONF.modify(.{
//         .CLK_EN = 1,
//     });
//     RMT.SYS_CONF.modify(.{
//         .APB_FIFO_MASK = 1,
//         .MEM_FORCE_PD = 0,
//         .MEM_FORCE_PU = 0,
//         .SCLK_DIV_NUM = 1,
//         .SCLK_SEL = 1,
//         .SCLK_ACTIVE = 1,
//     });
//
//     RMT.CH0_TX_CONF0.modify(.{
//         .CONF_UPDATE = 1,
//     });
//
//     RMT.REF_CNT_RST.modify(.{
//         .CH0 = 1,
//     });
//
//     RMT.CH0_TX_CONF0.modify(.{
//         .MEM_RD_RST = 1,
//         .APB_MEM_RST = 1,
//     });
//
//     RMT.CH0_TX_CONF0.modify(.{
//         .MEM_RD_RST = 0,
//         .APB_MEM_RST = 0,
//     });
//
//     RMT.CH0_TX_CONF0.modify(.{
//         .IDLE_OUT_LV = 0,
//         .IDLE_OUT_EN = 1,
//         .MEM_SIZE = 1,
//         .DIV_CNT = 1,
//         .CARRIER_EN = 0,
//     });
//
//     // RMT.CH0_TX_LIM.modify(.{
//     //     .TX_LIM = @as(u9, @intCast(index * 2)),
//     // });
//
//     RMT_RAM[0] = .{
//         .first = .{
//             .period = 1,
//             .level = 1,
//         },
//         .second = .{
//             .period = 1,
//             .level = 0,
//         },
//     };
//     RMT_RAM[1] = .{
//         .first = .{
//             .period = 5,
//             .level = 1,
//         },
//         .second = .{
//             .period = 0,
//             .level = 0,
//         },
//     };
//     // RMT_RAM[2] = .{
//     //     .first = .{
//     //         .period = 0,
//     //         .level = 0,
//     //     },
//     //     .second = .{
//     //         .period = 0,
//     //         .level = 0,
//     //     },
//     // };
//
//     RMT.CH0_TX_CONF0.modify(.{
//         .CONF_UPDATE = 1,
//     });
//
//     RMT.CH0_TX_CONF0.modify(.{
//         .TX_START = 1,
//     });
//
//     std.log.info("{?}", .{RMT.CH0_TX_CONF0.read()});
//     while (true) {
//         const status = RMT.INT_RAW.read();
//
//         std.log.info("{} {}", .{ status.CH0_TX_END_INT_RAW, status.CH0_TX_ERR_INT_RAW });
//         std.log.info("{?}", .{RMT.CH0STATUS.read()});
//         hal.time.sleep_ms(1000);
//     }
// }
//
// const PulseCode = packed struct {
//     period: u15,
//     level: u1,
// };
//
// const RAM_Entry = extern struct {
//     first: PulseCode,
//     second: PulseCode,
// };
