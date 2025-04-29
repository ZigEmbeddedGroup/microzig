const std = @import("std");

const c = @import("wifi-driver-c");
const microzig = @import("microzig");
const TrapFrame = microzig.cpu.TrapFrame;
const time = microzig.drivers.time;
const peripherals = microzig.chip.peripherals;
const SYSTEM = peripherals.SYSTEM;
const RTC_CNTL = peripherals.RTC_CNTL;
const APB_CTRL = peripherals.APB_CTRL;
const hal = microzig.hal;
const systimer = hal.systimer;

const log = std.log.scoped(.esp_wifi); // what should be the scope?
var wifi_allocator: std.mem.Allocator = undefined;

// based on the rust crate esp-wifi: https://github.com/esp-rs/esp-hal/blob/main/esp-wifi

pub const Error = error{
    OutOfMemory,
    InternalWifiError,
};

pub fn init(allocator: std.mem.Allocator) Error!void {
    wifi_allocator = allocator;

    // TODO: check that clock frequency is higher or equal to 80mhz

    enable_wifi_power_domain_and_init_clocks();
    // phy_mem_init(); // only sets some global variable on esp32c3

    microzig.cpu.interrupt.disable_interrupts();

    setup_interrupts();
    setup_timer_periodic_alarm();
    try allocate_main_task(allocator);
    // allocate timer task

    // enable yield software interrupt
    microzig.cpu.interrupt.enable(.interrupt3);

    microzig.cpu.interrupt.enable_interrupts();

    // This would populate the main task's context.
    // NOTE: we could probably remove this and wait for the first preemption interrupt
    yield_task();

    // NOTE: should be configurable
    try c_result(c.esp_wifi_internal_set_log_level(c.WIFI_LOG_VERBOSE));
}

pub const wifi_controller = struct {
    pub fn init() Error!void {
        init_config.wpa_crypto_funcs = c.g_wifi_default_wpa_crypto_funcs;

        // coex init

        try c_result(c.esp_wifi_init_internal(&init_config));
    }

    // I pupulated this with the defaults from rust. Some of it should be configurable.
    var init_config: c.wifi_init_config_t = .{
        .osi_funcs = &osi_functions_table,
        // .wpa_crypto_funcs = c.g_wifi_default_wpa_crypto_funcs,
        .static_rx_buf_num = 10,
        .dynamic_rx_buf_num = 32,
        .tx_buf_type = c.CONFIG_ESP_WIFI_TX_BUFFER_TYPE,
        .static_tx_buf_num = 0,
        .dynamic_tx_buf_num = 32,
        .rx_mgmt_buf_type = c.CONFIG_ESP_WIFI_DYNAMIC_RX_MGMT_BUF,
        .rx_mgmt_buf_num = c.CONFIG_ESP_WIFI_RX_MGMT_BUF_NUM_DEF,
        .cache_tx_buf_num = c.WIFI_CACHE_TX_BUFFER_NUM,
        .csi_enable = 0, // TODO: WiFi channel state information enable flag.
        .ampdu_rx_enable = 1,
        .ampdu_tx_enable = 1,
        .amsdu_tx_enable = 0,
        .nvs_enable = 0,
        .nano_enable = 0,
        .rx_ba_win = 6,
        .wifi_task_core_id = 0,
        .beacon_max_len = c.WIFI_SOFTAP_BEACON_MAX_LEN,
        .mgmt_sbuf_num = c.WIFI_MGMT_SBUF_NUM,
        .feature_caps = wifi_feature_caps,
        .sta_disconnected_pm = false,
        .espnow_max_encrypt_num = c.CONFIG_ESP_WIFI_ESPNOW_MAX_ENCRYPT_NUM,
        .tx_hetb_queue_num = 3,
        .dump_hesigb_enable = false,
        .magic = c.WIFI_INIT_CONFIG_MAGIC,
    };

    var osi_functions_table: c.wifi_osi_funcs_t = .{
        ._version = c.ESP_WIFI_OS_ADAPTER_VERSION,
        ._env_is_chip = osi_functions.env_is_chip,
        ._set_intr = osi_functions.set_intr,
        ._clear_intr = osi_functions.clear_intr,
        ._set_isr = osi_functions.set_isr,
        ._ints_on = osi_functions.ints_on,
        ._ints_off = osi_functions.ints_off,
        ._is_from_isr = osi_functions.is_from_isr,
        ._spin_lock_create = osi_functions.spin_lock_create,
        ._spin_lock_delete = osi_functions.spin_lock_delete,
        ._wifi_int_disable = osi_functions.wifi_int_disable,
        ._wifi_int_restore = osi_functions.wifi_int_restore,
        ._task_yield_from_isr = osi_functions.task_yield_from_isr,
        ._semphr_create = osi_functions.semphr_create,
        ._semphr_delete = osi_functions.semphr_delete,
        ._semphr_take = osi_functions.semphr_take,
        ._semphr_give = osi_functions.semphr_give,
        ._wifi_thread_semphr_get = osi_functions.wifi_thread_semphr_get,
        ._mutex_create = osi_functions.mutex_create,
        ._recursive_mutex_create = osi_functions.recursive_mutex_create,
        ._mutex_delete = osi_functions.mutex_delete,
        ._mutex_lock = osi_functions.mutex_lock,
        ._mutex_unlock = osi_functions.mutex_unlock,
        ._queue_create = osi_functions.queue_create,
        ._queue_delete = osi_functions.queue_delete,
        ._queue_send = osi_functions.queue_send,
        ._queue_send_from_isr = osi_functions.queue_send_from_isr,
        ._queue_send_to_back = osi_functions.queue_send_to_back,
        ._queue_send_to_front = osi_functions.queue_send_to_front,
        ._queue_recv = osi_functions.queue_recv,
        ._queue_msg_waiting = osi_functions.queue_msg_waiting,
        ._event_group_create = osi_functions.event_group_create,
        ._event_group_delete = osi_functions.event_group_delete,
        ._event_group_set_bits = osi_functions.event_group_set_bits,
        ._event_group_clear_bits = osi_functions.event_group_clear_bits,
        ._event_group_wait_bits = osi_functions.event_group_wait_bits,
        ._task_create_pinned_to_core = osi_functions.task_create_pinned_to_core,
        ._task_create = osi_functions.task_create,
        ._task_delete = osi_functions.task_delete,
        ._task_delay = osi_functions.task_delay,
        ._task_ms_to_tick = osi_functions.task_ms_to_tick,
        ._task_get_current_task = osi_functions.task_get_current_task,
        ._task_get_max_priority = osi_functions.task_get_max_priority,
        ._malloc = osi_functions.malloc,
        ._free = osi_functions.free,
        ._event_post = osi_functions.event_post,
        ._get_free_heap_size = osi_functions.get_free_heap_size,
        ._rand = osi_functions.rand,
        ._dport_access_stall_other_cpu_start_wrap = osi_functions.dport_access_stall_other_cpu_start_wrap,
        ._dport_access_stall_other_cpu_end_wrap = osi_functions.dport_access_stall_other_cpu_end_wrap,
        ._wifi_apb80m_request = osi_functions.wifi_apb80m_request,
        ._wifi_apb80m_release = osi_functions.wifi_apb80m_release,
        ._phy_disable = osi_functions.phy_disable,
        ._phy_enable = osi_functions.phy_enable,
        ._phy_update_country_info = osi_functions.phy_update_country_info,
        ._read_mac = osi_functions.read_mac,
        ._timer_arm = osi_functions.timer_arm,
        ._timer_disarm = osi_functions.timer_disarm,
        ._timer_done = osi_functions.timer_done,
        ._timer_setfn = osi_functions.timer_setfn,
        ._timer_arm_us = osi_functions.timer_arm_us,
        ._wifi_reset_mac = osi_functions.wifi_reset_mac,
        ._wifi_clock_enable = osi_functions.wifi_clock_enable,
        ._wifi_clock_disable = osi_functions.wifi_clock_disable,
        ._wifi_rtc_enable_iso = osi_functions.wifi_rtc_enable_iso,
        ._wifi_rtc_disable_iso = osi_functions.wifi_rtc_disable_iso,
        ._esp_timer_get_time = osi_functions.esp_timer_get_time,
        ._nvs_set_i8 = osi_functions.nvs_set_i8,
        ._nvs_get_i8 = osi_functions.nvs_get_i8,
        ._nvs_set_u8 = osi_functions.nvs_set_u8,
        ._nvs_get_u8 = osi_functions.nvs_get_u8,
        ._nvs_set_u16 = osi_functions.nvs_set_u16,
        ._nvs_get_u16 = osi_functions.nvs_get_u16,
        ._nvs_open = osi_functions.nvs_open,
        ._nvs_close = osi_functions.nvs_close,
        ._nvs_commit = osi_functions.nvs_commit,
        ._nvs_set_blob = osi_functions.nvs_set_blob,
        ._nvs_get_blob = osi_functions.nvs_get_blob,
        ._nvs_erase_key = osi_functions.nvs_erase_key,
        ._get_random = osi_functions.get_random,
        ._get_time = osi_functions.get_time,
        ._random = osi_functions.random,
        ._slowclk_cal_get = osi_functions.slowclk_cal_get,
        ._log_write = osi_functions.log_write,
        ._log_writev = osi_functions.log_writev,
        ._log_timestamp = osi_functions.log_timestamp,
        ._malloc_internal = osi_functions.malloc_internal,
        ._realloc_internal = osi_functions.realloc_internal,
        ._calloc_internal = osi_functions.calloc_internal,
        ._zalloc_internal = osi_functions.zalloc_internal,
        ._wifi_malloc = osi_functions.wifi_malloc,
        ._wifi_realloc = osi_functions.wifi_realloc,
        ._wifi_calloc = osi_functions.wifi_calloc,
        ._wifi_zalloc = osi_functions.wifi_zalloc,
        ._wifi_create_queue = osi_functions.wifi_create_queue,
        ._wifi_delete_queue = osi_functions.wifi_delete_queue,
        ._coex_init = osi_functions.coex_init,
        ._coex_deinit = osi_functions.coex_deinit,
        ._coex_enable = osi_functions.coex_enable,
        ._coex_disable = osi_functions.coex_disable,
        ._coex_status_get = osi_functions.coex_status_get,
        ._coex_condition_set = osi_functions.coex_condition_set,
        ._coex_wifi_request = osi_functions.coex_wifi_request,
        ._coex_wifi_release = osi_functions.coex_wifi_release,
        ._coex_wifi_channel_set = osi_functions.coex_wifi_channel_set,
        ._coex_event_duration_get = osi_functions.coex_event_duration_get,
        ._coex_pti_get = osi_functions.coex_pti_get,
        ._coex_schm_status_bit_clear = osi_functions.coex_schm_status_bit_clear,
        ._coex_schm_status_bit_set = osi_functions.coex_schm_status_bit_set,
        ._coex_schm_interval_set = osi_functions.coex_schm_interval_set,
        ._coex_schm_interval_get = osi_functions.coex_schm_interval_get,
        ._coex_schm_curr_period_get = osi_functions.coex_schm_curr_period_get,
        ._coex_schm_curr_phase_get = osi_functions.coex_schm_curr_phase_get,
        ._coex_schm_process_restart = osi_functions.coex_schm_process_restart,
        ._coex_schm_register_cb = osi_functions.coex_schm_register_cb,
        ._coex_register_start_cb = osi_functions.coex_register_start_cb,
        ._coex_schm_flexible_period_set = osi_functions.coex_schm_flexible_period_set,
        ._coex_schm_flexible_period_get = osi_functions.coex_schm_flexible_period_get,
        ._magic = c.ESP_WIFI_OS_ADAPTER_MAGIC,
    };

    const wifi_enable_wpa3_sae: u64 = 1 << 0;
    const wifi_enable_enterprise: u64 = 1 << 7;
    // const wifi_ftm_initiator: u64 = 1 << 2;
    // const wifi_ftm_responder: u64 = 1 << 3;
    // const wifi_enable_gcmp: u64 = 1 << 4;
    // const wifi_enable_gmac: u64 = 1 << 5;
    // const wifi_enable_11r: u64 = 1 << 6;

    const wifi_feature_caps: u64 = wifi_enable_wpa3_sae | wifi_enable_enterprise;
};

fn enable_wifi_power_domain_and_init_clocks() void {
    const system_wifibb_rst: u32 = 1 << 0;
    const system_fe_rst: u32 = 1 << 1;
    const system_wifimac_rst: u32 = 1 << 2;
    const system_btbb_rst: u32 = 1 << 3; // bluetooth baseband
    const system_btmac_rst: u32 = 1 << 4; // deprecated
    const system_rw_btmac_rst: u32 = 1 << 9; // bluetooth mac
    const system_rw_btmac_reg_rst: u32 = 1 << 11; // bluetooth mac registers
    const system_btbb_reg_rst: u32 = 1 << 13; // bluetooth baseband registers

    const modem_reset_field_when_pu: u32 = system_wifibb_rst |
        system_fe_rst |
        system_wifimac_rst |
        system_btbb_rst |
        system_btmac_rst |
        system_rw_btmac_rst |
        system_rw_btmac_reg_rst |
        system_btbb_reg_rst;

    RTC_CNTL.DIG_PWC.modify(.{
        .WIFI_FORCE_PD = 0,
        .BT_FORCE_PD = 0,
    });

    APB_CTRL.WIFI_RST_EN.write(.{ .WIFI_RST = APB_CTRL.WIFI_RST_EN.read().WIFI_RST | modem_reset_field_when_pu });
    APB_CTRL.WIFI_RST_EN.write(.{ .WIFI_RST = APB_CTRL.WIFI_RST_EN.read().WIFI_RST & ~modem_reset_field_when_pu });

    RTC_CNTL.DIG_ISO.modify(.{
        .WIFI_FORCE_ISO = 0,
        .BT_FORCE_ISO = 0,
    });

    const system_wifi_clk_i2c_clk_en: u32 = 1 << 5;
    const system_wifi_clk_unused_bit12: u32 = 1 << 12;
    const wifi_bt_sdio_clk: u32 = system_wifi_clk_i2c_clk_en | system_wifi_clk_unused_bit12;
    const system_wifi_clk_en: u32 = 0x00FB9FCF;

    APB_CTRL.WIFI_CLK_EN.write(.{ .WIFI_CLK_EN = APB_CTRL.WIFI_CLK_EN.read().WIFI_CLK_EN & ~wifi_bt_sdio_clk | system_wifi_clk_en });
}

fn setup_interrupts() void {
    // TODO: should be configurable

    microzig.cpu.interrupt.map(.wifi_mac, .interrupt1);
    microzig.cpu.interrupt.map(.wifi_pwr, .interrupt1);
    microzig.cpu.interrupt.map(.systimer_target0, .interrupt2);
    microzig.cpu.interrupt.map(.from_cpu_intr0, .interrupt3);

    const interrupts: []const microzig.cpu.Interrupt = &.{
        .interrupt1,
        .interrupt2,
        .interrupt3,
    };
    for (interrupts) |int| {
        microzig.cpu.interrupt.set_type(int, .level);
        microzig.cpu.interrupt.set_priority(int, .lowest);
    }
}

const timer_alarm: systimer.Alarm = .alarm0;
const preemt_interval: time.Duration = .from_ms(10);

fn setup_timer_periodic_alarm() void {
    // unit0 is already enabled as it is used by `hal.time`.
    timer_alarm.set_unit(.unit0);

    // sets the period to one second.
    timer_alarm.set_period(@intCast(preemt_interval.to_us() * systimer.ticks_per_us()));

    // to enable period mode you have to first clear the mode bit.
    timer_alarm.set_mode(.target);
    timer_alarm.set_mode(.period);

    timer_alarm.set_interrupt_enabled(true);
    timer_alarm.set_enabled(true);

    microzig.cpu.interrupt.enable(.interrupt3);
}

const Task = struct {
    trap_frame: TrapFrame,
    stack: []const u8,
    semaphore: u32 = 0,
    next: *Task,
};

var current_task: *Task = undefined;

fn allocate_main_task(allocator: std.mem.Allocator) !void {
    const task: *Task = try allocator.create(Task);
    task.* = .{
        .trap_frame = undefined,
        .stack = &.{},
        .next = task, // loop back to this task
    };
    current_task = task;
}

fn switch_task(trap_frame: *TrapFrame) void {
    copy_context(&current_task.trap_frame, trap_frame);

    // check if we need to delete the any task

    current_task = current_task.next;

    copy_context(trap_frame, &current_task.trap_frame);
}

fn copy_context(dst: *TrapFrame, src: *const TrapFrame) void {
    // don't restore csrs
    const size = @offsetOf(TrapFrame, "mstatus");
    @memcpy(std.mem.asBytes(dst)[0..size], std.mem.asBytes(src)[0..size]);
}

fn yield_task() void {
    SYSTEM.CPU_INTR_FROM_CPU_0.write(.{
        .CPU_INTR_FROM_CPU_0 = 1,
    });
}

var wifi_interrupt_handler: struct {
    f: *const fn (?*anyopaque) callconv(.c) void,
    arg: ?*anyopaque,
} = undefined;

pub const interrupt_handlers = struct {
    pub fn wifi_xxx(_: *TrapFrame) callconv(.c) void {
        log.debug("interrupt WIFI_xxx {} {?}", .{
            wifi_interrupt_handler.f,
            wifi_interrupt_handler.arg,
        });

        wifi_interrupt_handler.f(wifi_interrupt_handler.arg);
    }

    pub fn timer(trap_frame: *TrapFrame) callconv(.c) void {
        timer_alarm.clear_interrupt();

        switch_task(trap_frame);
    }

    pub fn software(trap_frame: *TrapFrame) callconv(.c) void {
        SYSTEM.CPU_INTR_FROM_CPU_0.write(.{
            .CPU_INTR_FROM_CPU_0 = 0,
        });

        switch_task(trap_frame);
    }
};

const osi_functions = struct {
    pub fn env_is_chip() callconv(.c) bool {
        return true;
    }

    pub fn set_intr(cpu_no: i32, intr_source: u32, intr_num: u32, intr_prio: i32) callconv(.c) void {
        // TODO: maybe assert here argument values contain the values bellow

        log.debug("set_intr {} {} {} {}", .{ cpu_no, intr_source, intr_num, intr_prio });

        // esp32c3
        // these are already set up
        // possible calls:
        // INFO - set_intr 0 2 1 1 (WIFI_PWR)
        // INFO - set_intr 0 0 1 1 (WIFI_MAC)
    }

    pub fn clear_intr(intr_source: u32, intr_num: u32) callconv(.c) void {
        log.debug("clear_intr {} {}", .{ intr_source, intr_num });
    }

    pub fn set_isr(
        n: i32,
        f: ?*anyopaque,
        arg: ?*anyopaque,
    ) callconv(.c) void {
        log.debug("set_isr {} {?} {?}", .{ n, f, arg });

        switch (n) {
            0, 1 => {
                const cs = microzig.interrupt.enter_critical_section();
                defer cs.leave();

                wifi_interrupt_handler = .{
                    .f = @alignCast(@ptrCast(f)),
                    .arg = arg,
                };
            },
            else => @panic("invalid interrupt number"),
        }

        microzig.cpu.interrupt.enable(.interrupt1);
    }

    // NOTE: temp until I see what bits are set.
    pub fn ints_on(mask: u32) callconv(.c) void {
        std.debug.panic("ints_on {}", .{mask});
    }

    pub fn ints_off(mask: u32) callconv(.c) void {
        std.debug.panic("ints_off {}", .{mask});
    }

    pub fn is_from_isr() callconv(.c) bool {
        return true;
    }

    var FAKE_SPINLOCK: u8 = 1;
    pub fn spin_lock_create() callconv(.c) ?*anyopaque {
        log.debug("spin_lock_create", .{});
        return &FAKE_SPINLOCK;
    }

    pub fn spin_lock_delete(_: ?*anyopaque) callconv(.c) void {
        log.debug("spin_lock_delete", .{});
    }

    // NOTE: critical section for now. If we decide to run the code on multiple cpus (on other chips) we
    // should change this.
    pub fn wifi_int_disable(_: ?*anyopaque) callconv(.c) u32 {
        log.debug("wifi_int_disable", .{});

        const ints_enabled = microzig.cpu.interrupt.globally_enabled();
        if (ints_enabled) {
            microzig.cpu.interrupt.disable_interrupts();
        }
        return @intFromBool(ints_enabled);
    }

    pub fn wifi_int_restore(_: ?*anyopaque, state: u32) callconv(.c) void {
        log.debug("wifi_int_restore", .{});

        // NOTE: is this required?
        microzig.cpu.fence();

        // check if interrupts were enabled before.
        if (state != 0) {
            microzig.cpu.interrupt.enable_interrupts();
        }
    }

    pub fn task_yield_from_isr() callconv(.c) void {
        log.debug("task_yield_from_isr", .{});

        yield_task();
    }

    pub fn semphr_create(max_value: u32, init_value: u32) callconv(.c) ?*anyopaque {
        log.debug("semphr_create {} {}", .{ max_value, init_value });

        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        const ptr = wifi_allocator.create(u32) catch {
            log.warn("failed to allocate semaphore", .{});
            return null;
        };
        ptr.* = init_value;

        return ptr;
    }

    pub fn semphr_delete(ptr: ?*anyopaque) callconv(.c) void {
        log.debug("semphr_delete {?}", .{ptr});

        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();
        wifi_allocator.destroy(@as(*u32, @alignCast(@ptrCast(ptr))));
    }

    pub fn semphr_take(ptr: ?*anyopaque, tick: u32) callconv(.c) i32 {
        log.debug("semphr_take {?} {}", .{ ptr, tick });

        const forever = tick == c.OSI_FUNCS_TIME_BLOCKING;
        const timeout = tick;
        const start = hal.time.get_time_since_boot();

        const sem: *u32 = @alignCast(@ptrCast(ptr));

        while (true) {
            const res: bool = blk: {
                const cs = microzig.interrupt.enter_critical_section();
                defer cs.leave();

                microzig.cpu.fence();

                const cnt = sem.*;
                if (cnt > 0) {
                    sem.* = cnt - 1;
                    break :blk true;
                } else {
                    break :blk false;
                }
            };

            if (res) {
                return 1;
            }

            if (!forever and hal.time.get_time_since_boot().diff(start).to_us() > timeout) {
                break;
            }

            yield_task();
        }

        return 0;
    }

    pub fn semphr_give(ptr: ?*anyopaque) callconv(.c) i32 {
        log.debug("semphr_give {?}", .{ptr});

        const sem: *u32 = @alignCast(@ptrCast(ptr));

        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        const cnt = sem.*;
        sem.* = cnt + 1;
        return 1;
    }

    pub fn wifi_thread_semphr_get() callconv(.c) ?*anyopaque {
        return @ptrCast(&current_task.semaphore);
    }

    pub fn mutex_create() callconv(.c) void {
        @panic("mutex_create: not implemented");
    }

    pub fn recursive_mutex_create() callconv(.c) void {
        @panic("mutex_create: not implemented");
    }

    pub fn mutex_delete() callconv(.c) void {}

    pub fn mutex_lock() callconv(.c) void {}

    pub fn mutex_unlock() callconv(.c) void {}

    pub fn queue_create() callconv(.c) void {}

    pub fn queue_delete() callconv(.c) void {}

    pub fn queue_send() callconv(.c) void {}

    pub fn queue_send_from_isr() callconv(.c) void {}

    pub fn queue_send_to_back() callconv(.c) void {}

    pub fn queue_send_to_front() callconv(.c) void {}

    pub fn queue_recv() callconv(.c) void {}

    pub fn queue_msg_waiting() callconv(.c) void {}

    pub fn event_group_create() callconv(.c) void {}

    pub fn event_group_delete() callconv(.c) void {}

    pub fn event_group_set_bits() callconv(.c) void {}

    pub fn event_group_clear_bits() callconv(.c) void {}

    pub fn event_group_wait_bits() callconv(.c) void {}

    pub fn task_create_pinned_to_core() callconv(.c) void {}

    pub fn task_create() callconv(.c) void {}

    pub fn task_delete() callconv(.c) void {}

    pub fn task_delay() callconv(.c) void {}

    pub fn task_ms_to_tick() callconv(.c) void {}

    pub fn task_get_current_task() callconv(.c) void {}

    pub fn task_get_max_priority() callconv(.c) void {}

    pub fn malloc() callconv(.c) void {}

    pub fn free() callconv(.c) void {}

    pub fn event_post() callconv(.c) void {}

    pub fn get_free_heap_size() callconv(.c) void {}

    pub fn rand() callconv(.c) void {}

    pub fn dport_access_stall_other_cpu_start_wrap() callconv(.c) void {}

    pub fn dport_access_stall_other_cpu_end_wrap() callconv(.c) void {}

    pub fn wifi_apb80m_request() callconv(.c) void {}

    pub fn wifi_apb80m_release() callconv(.c) void {}

    pub fn phy_disable() callconv(.c) void {}

    pub fn phy_enable() callconv(.c) void {}

    pub fn phy_update_country_info() callconv(.c) void {}

    pub fn read_mac() callconv(.c) void {}

    pub fn timer_arm() callconv(.c) void {}

    pub fn timer_disarm() callconv(.c) void {}

    pub fn timer_done() callconv(.c) void {}

    pub fn timer_setfn() callconv(.c) void {}

    pub fn timer_arm_us() callconv(.c) void {}

    pub fn wifi_reset_mac() callconv(.c) void {}

    pub fn wifi_clock_enable() callconv(.c) void {}

    pub fn wifi_clock_disable() callconv(.c) void {}

    pub fn wifi_rtc_enable_iso() callconv(.c) void {}

    pub fn wifi_rtc_disable_iso() callconv(.c) void {}

    pub fn esp_timer_get_time() callconv(.c) void {}

    pub fn nvs_set_i8() callconv(.c) void {}

    pub fn nvs_get_i8() callconv(.c) void {}

    pub fn nvs_set_u8() callconv(.c) void {}

    pub fn nvs_get_u8() callconv(.c) void {}

    pub fn nvs_set_u16() callconv(.c) void {}

    pub fn nvs_get_u16() callconv(.c) void {}

    pub fn nvs_open() callconv(.c) void {}

    pub fn nvs_close() callconv(.c) void {}

    pub fn nvs_commit() callconv(.c) void {}

    pub fn nvs_set_blob() callconv(.c) void {}

    pub fn nvs_get_blob() callconv(.c) void {}

    pub fn nvs_erase_key() callconv(.c) void {}

    pub fn get_random() callconv(.c) void {}

    pub fn get_time() callconv(.c) void {}

    pub fn random() callconv(.c) void {}

    pub fn slowclk_cal_get() callconv(.c) void {}

    pub fn log_write() callconv(.c) void {}

    pub fn log_writev() callconv(.c) void {}

    pub fn log_timestamp() callconv(.c) void {}

    pub fn malloc_internal() callconv(.c) void {}

    pub fn realloc_internal() callconv(.c) void {}

    pub fn calloc_internal() callconv(.c) void {}

    pub fn zalloc_internal() callconv(.c) void {}

    pub fn wifi_malloc() callconv(.c) void {}

    pub fn wifi_realloc() callconv(.c) void {}

    pub fn wifi_calloc() callconv(.c) void {}

    pub fn wifi_zalloc() callconv(.c) void {}

    pub fn wifi_create_queue() callconv(.c) void {}

    pub fn wifi_delete_queue() callconv(.c) void {}

    pub fn coex_init() callconv(.c) void {}

    pub fn coex_deinit() callconv(.c) void {}

    pub fn coex_enable() callconv(.c) void {}

    pub fn coex_disable() callconv(.c) void {}

    pub fn coex_status_get() callconv(.c) void {}

    pub fn coex_condition_set() callconv(.c) void {}

    pub fn coex_wifi_request() callconv(.c) void {}

    pub fn coex_wifi_release() callconv(.c) void {}

    pub fn coex_wifi_channel_set() callconv(.c) void {}

    pub fn coex_event_duration_get() callconv(.c) void {}

    pub fn coex_pti_get() callconv(.c) void {}

    pub fn coex_schm_status_bit_clear() callconv(.c) void {}

    pub fn coex_schm_status_bit_set() callconv(.c) void {}

    pub fn coex_schm_interval_set() callconv(.c) void {}

    pub fn coex_schm_interval_get() callconv(.c) void {}

    pub fn coex_schm_curr_period_get() callconv(.c) void {}

    pub fn coex_schm_curr_phase_get() callconv(.c) void {}

    pub fn coex_schm_process_restart() callconv(.c) void {}

    pub fn coex_schm_register_cb() callconv(.c) void {}

    pub fn coex_register_start_cb() callconv(.c) void {}

    pub fn coex_schm_flexible_period_set() callconv(.c) void {}

    pub fn coex_schm_flexible_period_get() callconv(.c) void {}
};

fn c_result(err_code: i32) Error!void {
    const InternalWifiError = enum(i32) {
        /// Out of memory
        esp_err_no_mem = 0x101,

        /// Invalid argument
        esp_err_invalid_arg = 0x102,

        /// Wi_fi driver was not installed by esp_wifi_init
        esp_err_wifi_not_init = 0x3001,

        /// Wi_fi driver was not started by esp_wifi_start
        esp_err_wifi_not_started = 0x3002,

        /// Wi_fi driver was not stopped by esp_wifi_stop
        esp_err_wifi_not_stopped = 0x3003,

        /// Wi_fi interface error
        esp_err_wifi_if = 0x3004,

        /// Wi_fi mode error
        esp_err_wifi_mode = 0x3005,

        /// Wi_fi internal state error
        esp_err_wifi_state = 0x3006,

        /// Wi_fi internal control block of station or soft-AP error
        esp_err_wifi_conn = 0x3007,

        /// Wi_fi internal NVS module error
        esp_err_wifi_nvs = 0x3008,

        /// MAC address is invalid
        esp_err_wifi_mac = 0x3009,

        /// SSID is invalid
        esp_err_wifi_ssid = 0x300A,

        /// Password is invalid
        esp_err_wifi_password = 0x300B,

        /// Timeout error
        esp_err_wifi_timeout = 0x300C,

        /// Wi_fi is in sleep state(RF closed) and wakeup fail
        esp_err_wifi_wake_fail = 0x300D,

        /// The caller would block
        esp_err_wifi_would_block = 0x300E,

        /// Station still in disconnect status
        esp_err_wifi_not_connect = 0x300F,

        /// Failed to post the event to Wi_fi task
        esp_err_wifi_post = 0x3012,

        /// Invalid Wi_fi state when init/deinit is called
        esp_err_wifi_init_state = 0x3013,

        /// Returned when Wi_fi is stopping
        esp_err_wifi_stop_state = 0x3014,

        /// The Wi_fi connection is not associated
        esp_err_wifi_not_assoc = 0x3015,

        /// The Wi_fi TX is disallowed
        esp_err_wifi_tx_disallow = 0x3016,
    };

    if (err_code != c.ESP_OK) {
        const err: InternalWifiError = @enumFromInt(err_code);
        log.err("Internal wifi error occurred: {s}", .{@tagName(err)});
        return error.InternalWifiError;
    }
}
