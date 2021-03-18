const root = @import("root");

extern var _data_rom_start: [*]u8;
extern var _data_ram_stop: [*]u8;
extern var _data_ram_start: [*]u8;

export fn resetHandler() callconv(.C) void {
    const data_size = @ptrToInt(_data_ram_stop) - @ptrToInt(_data_ram_stop);
    for (_data_rom_start[0..data_size]) |b, i| _data_ram_start[i] = b;

    XOSC.init();

    //TODO: init clocks

    root.main();
}

pub fn handler(foo: anytype) fn () callconv(.C) void {
    return struct {
        pub fn handler() callconv(.C) void {
            @breakpoint();
        }
    }.handler;
}

export fn dummyHandler() callconv(.C) void {}

// TODO: move that to specific SoC file
const INTERRUPTS_COUNT = 17;

pub export const _BOOT2: [256]u8 linksection(".boot2") = @embedFile("./boot2.bin")[0..256].*;

export const isr_vector linksection(".isr_vector") = comptime isr_init: {
    var result: [INTERRUPTS_COUNT]?fn () callconv(.C) void = [_]?fn () callconv(.C) void{
        resetHandler,
        handler(.nmi), // nmi
        handler(.hardfault), // hardfault
        handler(.mem), // memmanager
        handler(.nus), // nus fault
        handler(.usage), // usage fault
        handler(.r1),
        handler(.r2),
        handler(.r3),
        handler(.r4),
        handler(.svc), // SVC
        handler(.r5), // DebugMon
        handler(.r6),
        handler(.pendsv),
        handler(.systick),
        handler(.irq0),
        handler(.irq1),
    };

    if (@hasDecl(root, "initInterrupts")) {
        root.initInterrupts(&result);
    }

    break :isr_init result;
};

const XOSC = struct {
    pub fn init() void {
        if (!mmio.XOSC.STATUS.get().STABLE) {
            // stolen from xosc.c
            mmio.XOSC.STARTUP.set(.{ .DELAY = (12000 + 128) / 256 }); // 12MHz
            mmio.XOSC.CTRL.set(.{
                .FREQ_RANGE = 2720, // 1_15MHZ
                .ENABLE = 4011, // ENABLE
            });
            while (!mmio.XOSC.STATUS.get().STABLE)
                delay(1);
        }
    }
};
