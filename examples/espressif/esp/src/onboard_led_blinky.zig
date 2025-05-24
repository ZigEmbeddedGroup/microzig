const std = @import("std");
const microzig = @import("microzig");
const RMT = microzig.chip.peripherals.RMT;
const hal = microzig.hal;
const gpio = hal.gpio;
const system = hal.system;

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = hal.usb_serial_jtag.logger.logFn,
};

const PulseCode = packed struct {
    period: u15,
    level: u1,
};

const RAM_Entry = extern struct {
    first: PulseCode,
    second: PulseCode,
};

const RMT_RAM: usize = 0x60016400;
// const RMT_RAM: *volatile u32 = @ptrFromInt(0x60016400);

pub fn main() void {
    system.clocks_enable_set(.{
        .rmt = true,
    });
    system.peripheral_reset(.{
        .rmt = true,
    });

    const led_pin = gpio.num(8);
    led_pin.set_open_drain_output(true);
    led_pin.set_input_enable(true);
    led_pin.set_pulldown(true);
    led_pin.connect_peripheral_to_output(.rmt0);

    RMT.SYS_CONF.modify(.{
        .APB_FIFO_MASK = 1,
        .SCLK_DIV_NUM = 0,
        .SCLK_SEL = 1,
        .SCLK_ACTIVE = 1,
        .CLK_EN = 0,
    });

    // Self::set_threshold((constants::RMT_CHANNEL_RAM_SIZE * Self::memsize() as usize / 2) as u8);
    // Self::set_continuous(continuous);
    // Self::set_generate_repeat_interrupt(repeat);
    // Self::set_wrap_mode(true);
    // Self::update();
    // Self::start_tx();
    // Self::update();

    var index: usize = 0;
    const data: []const u8 = &.{ 100, 100, 100 };
    for (data) |byte| {
        var b = byte;
        for (0..8) |_| {
            const is_one = (b & 0b1000_0000) != 0;
            b <<= 1;

            const ptr: *volatile RAM_Entry = @ptrFromInt(RMT_RAM + index * @sizeOf(u32));
            ptr.* = if (is_one) .{
                .first = .{
                    .period = 3,
                    .level = 1,
                },
                .second = .{
                    .period = 7,
                    .level = 0,
                },
            } else .{
                .first = .{
                    .period = 5,
                    .level = 1,
                },
                .second = .{
                    .period = 6,
                    .level = 0,
                },
            };

            std.log.info("write {}", .{index});

            index += 1;
        }
    }

    @as(*volatile RAM_Entry, @ptrFromInt(RMT_RAM + index * @sizeOf(u32))).* = .{
        .first = .{
            .period = 0,
            .level = 0,
        },
        .second = .{
            .period = 0,
            .level = 0,
        },
    };

    RMT.CH0_TX_CONF0.modify(.{
        // .MEM_RD_RST = 1,
        .IDLE_OUT_LV = 0,
        .IDLE_OUT_EN = 1,
        .MEM_SIZE = 2,
        .DIV_CNT = 10,
        .CARRIER_EN = 0,
        // .TX_CONTI_MODE = 0,
    });

    RMT.CH0_TX_LIM.modify(.{
        .TX_LIM = @as(u9, @intCast(index * 2)),
    });

    RMT.CH0_TX_CONF0.modify(.{
        .CONF_UPDATE = 1,
    });

    // RMT_RAM[0] = .{
    //     .first = .{
    //         .period = 1,
    //         .level = 0,
    //     },
    //     .second = .{
    //         .period = 1,
    //         .level = 1,
    //     },
    // };
    // RMT_RAM[1] = .{
    //     .first = .{
    //         .period = 1,
    //         .level = 0,
    //     },
    //     .second = .{
    //         .period = 1,
    //         .level = 1,
    //     },
    // };

    RMT.REF_CNT_RST.modify(.{
        .CH0 = 1,
    });

    RMT.CH0_TX_CONF0.modify(.{
        .CONF_UPDATE = 1,
    });

    RMT.CH0_TX_CONF0.modify(.{
        .TX_START = 1,
    });

    RMT.CH0_TX_CONF0.modify(.{
        .CONF_UPDATE = 1,
    });

    std.log.info("{?}", .{RMT.CH0_TX_CONF0.read()});
    while (true) {
        const status = RMT.INT_RAW.read();

        std.log.info("{} {}", .{ status.CH0_TX_END_INT_RAW, status.CH0_TX_ERR_INT_RAW });
        std.log.info("{?}", .{RMT.CH0STATUS.read()});
        hal.time.sleep_ms(1000);
    }
}
