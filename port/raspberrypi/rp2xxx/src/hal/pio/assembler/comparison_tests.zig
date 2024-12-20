const std = @import("std");
const assembler = @import("../assembler.zig");
const tokenizer = @import("tokenizer.zig");
const CPU = @import("../../cpu.zig").CPU;

const c = @cImport({
    @cDefine("PICO_NO_HARDWARE", "1");
    @cInclude("stdint.h");
    @cInclude("comparison_tests/addition.pio.h");
    @cInclude("comparison_tests/apa102.pio.h");
    @cInclude("comparison_tests/blink.pio.h");
    @cInclude("comparison_tests/clocked_input.pio.h");
    @cInclude("comparison_tests/differential_manchester.pio.h");
    @cInclude("comparison_tests/hello.pio.h");
    @cInclude("comparison_tests/hub75.pio.h");
    @cInclude("comparison_tests/i2c.pio.h");
    @cInclude("comparison_tests/irq.pio.h");
    @cInclude("comparison_tests/manchester_encoding.pio.h");
    @cInclude("comparison_tests/movrx.pio.h");
    @cInclude("comparison_tests/nec_carrier_burst.pio.h");
    @cInclude("comparison_tests/nec_carrier_control.pio.h");
    @cInclude("comparison_tests/nec_receive.pio.h");
    @cInclude("comparison_tests/pio_serialiser.pio.h");
    @cInclude("comparison_tests/pwm.pio.h");
    @cInclude("comparison_tests/quadrature_encoder.pio.h");
    @cInclude("comparison_tests/resistor_dac.pio.h");
    @cInclude("comparison_tests/spi.pio.h");
    @cInclude("comparison_tests/squarewave.pio.h");
    @cInclude("comparison_tests/squarewave_fast.pio.h");
    @cInclude("comparison_tests/squarewave_wrap.pio.h");
    @cInclude("comparison_tests/st7789_lcd.pio.h");
    @cInclude("comparison_tests/uart_rx.pio.h");
    @cInclude("comparison_tests/uart_tx.pio.h");
    @cInclude("comparison_tests/ws2812.pio.h");
});

fn pio_comparison(comptime source: []const u8) !void {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |cpu| {
        try pio_comparison_cpu(cpu, source);
    }
}

fn pio_comparison_cpu(comptime cpu: CPU, comptime source: []const u8) !void {
    comptime var diags: ?assembler.Diagnostics = null;
    const output = try comptime assembler.assemble_impl(cpu, source, &diags, .{});
    try std.testing.expect(output.programs.len > 0);

    inline for (output.programs) |program| {
        const expected_insns = @field(c, program.name ++ "_program_instructions");
        for (program.instructions, expected_insns) |actual, expected| {
            std.log.debug("expected: 0x{x}", .{expected});
            std.log.debug("  actual: 0x{x}", .{actual});
            std.log.debug("", .{});
        }

        for (program.instructions, expected_insns) |actual, expected|
            try std.testing.expectEqual(expected, actual);
    }
}

test "pio.comparison.addition" {
    @setEvalBranchQuota(4000);
    try pio_comparison(@embedFile("comparison_tests/addition.pio"));
}

test "pio.comparison.apa102" {
    @setEvalBranchQuota(11000);
    try pio_comparison(@embedFile("comparison_tests/apa102.pio"));
}

test "pio.comparison.blink" {
    @setEvalBranchQuota(4000);
    try pio_comparison(@embedFile("comparison_tests/blink.pio"));
}

test "pio.comparison.clocked_input" {
    @setEvalBranchQuota(5000);
    try pio_comparison(@embedFile("comparison_tests/clocked_input.pio"));
}

test "pio.comparison.differential_manchester" {
    @setEvalBranchQuota(14000);
    try pio_comparison(@embedFile("comparison_tests/differential_manchester.pio"));
}

test "pio.comparison.hello" {
    @setEvalBranchQuota(3000);
    try pio_comparison(@embedFile("comparison_tests/hello.pio"));
}

test "pio.comparison.hub75" {
    @setEvalBranchQuota(17000);
    try pio_comparison(@embedFile("comparison_tests/hub75.pio"));
}

test "pio.comparison.i2c" {
    @setEvalBranchQuota(17000);
    try pio_comparison(@embedFile("comparison_tests/i2c.pio"));
}

test "pio.comparison.irq" {
    @setEvalBranchQuota(22000);
    try pio_comparison_cpu(.RP2350, @embedFile("comparison_tests/irq.pio"));
}

test "pio.comparison.manchester_encoding" {
    @setEvalBranchQuota(11000);
    try pio_comparison(@embedFile("comparison_tests/manchester_encoding.pio"));
}

test "pio.comparison.movrx" {
    @setEvalBranchQuota(11000);
    try pio_comparison_cpu(.RP2350, @embedFile("comparison_tests/movrx.pio"));
}

test "pio.comparison.nec_carrier_burst" {
    @setEvalBranchQuota(6000);
    try pio_comparison(@embedFile("comparison_tests/nec_carrier_burst.pio"));
}

test "pio.comparison.nec_carrier_control" {
    @setEvalBranchQuota(9000);
    try pio_comparison(@embedFile("comparison_tests/nec_carrier_control.pio"));
}

test "pio.comparison.nec_receive" {
    @setEvalBranchQuota(11000);
    try pio_comparison(@embedFile("comparison_tests/nec_receive.pio"));
}

test "pio.comparison.pio_serialiser" {
    @setEvalBranchQuota(3000);
    try pio_comparison(@embedFile("comparison_tests/pio_serialiser.pio"));
}

test "pio.comparison.pwm" {
    @setEvalBranchQuota(4000);
    try pio_comparison(@embedFile("comparison_tests/pwm.pio"));
}

test "pio.comparison.quadrature_encoder" {
    @setEvalBranchQuota(17000);
    try pio_comparison(@embedFile("comparison_tests/quadrature_encoder.pio"));
}

test "pio.comparison.resistor_dac" {
    @setEvalBranchQuota(3000);
    try pio_comparison(@embedFile("comparison_tests/resistor_dac.pio"));
}

test "pio.comparison.spi" {
    @setEvalBranchQuota(22000);
    try pio_comparison(@embedFile("comparison_tests/spi.pio"));
}

test "pio.comparison.squarewave" {
    @setEvalBranchQuota(2000);
    try pio_comparison(@embedFile("comparison_tests/squarewave.pio"));
}

test "pio.comparison.squarewave_fast" {
    @setEvalBranchQuota(2000);
    try pio_comparison(@embedFile("comparison_tests/squarewave_fast.pio"));
}

test "pio.comparison.squarewave_wrap" {
    @setEvalBranchQuota(3000);
    try pio_comparison(@embedFile("comparison_tests/squarewave_wrap.pio"));
}

test "pio.comparison.st7789_lcd" {
    @setEvalBranchQuota(5000);
    try pio_comparison(@embedFile("comparison_tests/st7789_lcd.pio"));
}

test "pio.comparison.uart_rx" {
    @setEvalBranchQuota(11000);
    try pio_comparison(@embedFile("comparison_tests/uart_rx.pio"));
}

test "pio.comparison.uart_tx" {
    @setEvalBranchQuota(6000);
    try pio_comparison(@embedFile("comparison_tests/uart_tx.pio"));
}

test "pio.comparison.ws2812" {
    @setEvalBranchQuota(11000);
    try pio_comparison(@embedFile("comparison_tests/ws2812.pio"));
}
