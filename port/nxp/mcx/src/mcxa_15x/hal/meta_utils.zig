const std = @import("std");
const mapper = @import("mapper.zig");

pub fn check_mux(comptime pin: mapper.PIN, comptime sig: mapper.SIGNALS) usize {
    const sig_pins = sig.pins();
    const pins_mux = pin.mux();

    if (@hasDecl(sig_pins, @tagName(pin))) {
        return @field(sig_pins, @tagName(pin));
    } else {
        @compileError(std.fmt.comptimePrint(
            \\Pin "{0s}" does not have a mux for "{1s}":
            \\available Pins for "{1s}" are:
            \\{2s}
            \\
            \\available Mux for Pin "{0s}" are:
            \\{3s}
            \\
        , .{
            @tagName(pin),
            @tagName(sig),
            list_peri_recursive(@typeInfo(sig_pins).@"struct".decl_names),
            list_peri_recursive(@typeInfo(pins_mux).@"enum".field_names),
        }));
    }
}

fn list_peri_recursive(comptime names: []const []const u8) []const u8 {
    for (names, 1..) |n, i| {
        return " - " ++ n ++ "\n" ++ list_peri_recursive(names[i..]);
    }
    return "";
}

test {
    const val = comptime check_mux(.P0_0, .LPUART0_rts);
    @compileLog(val);
}
