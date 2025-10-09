const std = @import("std");
const microzig = @import("microzig");

const PPB = microzig.chip.peripherals.PPB;
const hal = microzig.hal;

const time = hal.time;

const uart = hal.uart.instance.num(0);

var RandomGen = std.Random.DefaultPrng.init(0);
const rand = RandomGen.random();

const alloc_count: usize = 200;
const replace_count: usize = 10_000;

// -----------------------------------------------------------------------------
//  Local Constants
// -----------------------------------------------------------------------------

// --- GPIO pins --------------------------------

const pin_config = hal.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
    .GPIO1 = .{
        .name = "gpio1",
        .function = .UART0_RX,
    },
};

const pins = pin_config.pins();

// ---- UART Configuration --------------------------------

const baud_rate = 115200;

// ---- MicroZig Options --------------------------------

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    //.logFn      = hal.uart.logFn,
    .logFn = hal.uart.log_threadsafe,
};

pub fn main() !void {

    // --- Set up GPIO -------------------------------

    pin_config.apply();

    // --- Set up UART -------------------------------

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = hal.clock_config,
    });

    // --- Set up Logger -----------------------------

    hal.uart.init_logger(uart);

    time.sleep_ms(1000);

    std.log.info("Hello, World!", .{});

    if (microzig.hal.compatibility.arch == .riscv) {
        std.log.debug("core: {any} 0x{x:08}", .{ microzig.cpu.csr.mtvec, microzig.cpu.csr.mtvec.read_raw() });
    }

    // --- Set up the Allocator ----------------------

    // Create an Allocator type suitable for the target.
    const Allocator = microzig.Allocator;

    // Create an instance of that type.
    var heap_allocator = Allocator.init_with_heap(1024);

    // Get an std.mem.Allocator from the heap allocator.
    const allocator = heap_allocator.allocator();

    // --- Test the Allocator -----------------------

    // Get the initial free heap size.
    const init_free_heap: usize = heap_allocator.free_heap();
    std.log.debug("Free heap at start: {d}", .{init_free_heap});

    // Create an array of allocations and fill it with random sized allocations.

    var allocs: [alloc_count][]u8 = undefined;

    for (&allocs) |*a| {
        const size = rand.intRangeAtMost(usize, 1, 256);
        a.* = try allocator.alloc(u8, size);
    }

    // Replace random selections from `allocs` with new allocations.
    // We'll time this to see how fast it is.

    const start_time = time.get_time_since_boot();

    var idx: usize = undefined;

    for (0..10_000) |_| {
        idx = rand.intRangeAtMost(usize, 0, alloc_count - 1);

        allocator.free(allocs[idx]);

        allocs[idx] = try allocator.alloc(u8, rand.intRangeAtMost(usize, 1, 256));
    }

    const end_time = time.get_time_since_boot();

    const total_time = end_time.diff(start_time).to_us();
    std.log.info("It took {d} µs to replace {d} allocations.", .{ total_time, replace_count });
    const per_alloc = @as(f32, @floatFromInt(total_time)) / @as(f32, @floatFromInt(replace_count));
    std.log.info("  Each replace took {d} µs on average.", .{per_alloc});

    // Run the grow test.

    // Do a few allocations with a larger alignment to make sure that works.

    for (0..100) |_| {
        idx = rand.intRangeAtMost(usize, 0, alloc_count - 1);

        allocator.free(allocs[idx]);

        allocs[idx] = try allocator.alignedAlloc(u8, .@"32", rand.intRangeAtMost(usize, 1, 256));

        // For Zig 0.15.0
        // allocs[idx] = try allocator.alignedAlloc(u8, .@"32", rand.intRangeAtMost(usize, 1, 256));
    }

    // Do an integrity check.

    if (!heap_allocator.dbg_integrity_check()) {
        std.log.err("Integrity check failed\n", .{});
        heap_allocator.dbg_log_chunk_list();
        heap_allocator.dbg_log_free_chains();
    }

    // Free the allocations.

    for (&allocs) |*a| {
        allocator.free(a.*);
    }

    // Test the ability to grow an allocation.   The buffer at this point
    // should consist of a single unused chunk.  We will allocate two
    // big chunks and try to grow them.  The first should fail as the second
    // chunk is in the way.

    const big_size = 512;

    const big_1 = try allocator.alloc(u8, big_size);
    const big_2 = try allocator.alloc(u8, big_size);

    heap_allocator.dbg_log_chunk_list();

    if (allocator.resize(big_1, big_size * 2)) {
        std.log.debug("resize of big_1 succeeded where it should have failed\n", .{});
    }

    if (!allocator.resize(big_2, big_size * 2)) {
        std.log.debug("resize of big_2 failed where it should have succeeded\n", .{});
    }

    allocator.free(big_1);
    allocator.free(big_2);

    // Get the final free heap size -- should be the same as the initial size

    const final_free_heap: usize = heap_allocator.free_heap();
    std.log.debug("Free heap at end: {d}", .{final_free_heap});
}
