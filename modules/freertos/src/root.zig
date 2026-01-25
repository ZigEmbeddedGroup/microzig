const std = @import("std");

pub const c = @cImport({
    @cInclude("FreeRTOS.h");
    @cInclude("task.h");
});

pub const OS = struct {
    pub const MINIMAL_STACK_SIZE: usize = c.configMINIMAL_STACK_SIZE;
    pub const MAX_PRIORITIES: usize = c.configMAX_PRIORITIES;

    pub fn vTaskStartScheduler() noreturn {
        c.vTaskStartScheduler();
        unreachable;
    }

    pub fn vTaskDelay(ticks: c.TickType_t) void {
        c.vTaskDelay(ticks);
    }

    pub fn xTaskCreate(
        task_function: c.TaskFunction_t,
        name: [*:0]const u8,
        stack_depth: u16,
        parameters: ?*anyopaque,
        priority: u32,
        task_handle: ?*c.TaskHandle_t,
    ) c.BaseType_t {
        return c.xTaskCreate(
            task_function,
            name,
            stack_depth,
            parameters,
            priority,
            task_handle,
        );
    }
};

// Those 3 exported interrupt functions are used when PICO_NO_RAM_VECTOR_TABLE is 1
// This doesn't work because Microzig but also Pico SDK? dont set VTOR to 0x10000100 for RP2040 at boot
// even if proper configuration is set:
// pub const microzig_options = microzig.Options{
//    .overwrite_hal_interrupts = true,
//    .interrupts = .{
//      .PendSV = .{ .naked = freertos.isr_pendsv },
//      .SysTick = .{ .c = freertos.isr_systick },
//      .SVCall = .{ .c = freertos.isr_svcall }
//    },
//    .cpu = .{
//        .ram_vector_table = false,
//    },
//};
// probably related to: https://github.com/raspberrypi/pico-sdk/issues/6
// In most scenarious we are not interested in no ram vector case anyway
pub extern fn isr_pendsv() callconv(.naked) void;
pub extern fn isr_svcall() callconv(.c) void;
pub extern fn isr_systick() callconv(.c) void;
