const Patch = @import("microzig/build-internals").Patch;

pub const patches: []const Patch = &.{
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 0, .name = "PORT0" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 1, .name = "PORT1" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 2, .name = "PORT2" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 3, .name = "PORT3" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 6, .name = "UART0" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 7, .name = "UART1" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 8, .name = "LPUART" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 10, .name = "SPI" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 12, .name = "I2C" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 14, .name = "TIM0" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 15, .name = "TIM1" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 16, .name = "TIM2" } },
    .{ .add_interrupt = .{ .device_name = "HDSC_HC32L110", .idx = 17, .name = "LPTIM" } },
};
