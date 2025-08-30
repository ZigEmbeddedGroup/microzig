# Zig Intel Hex parser

A loader for the [Intel Hex](https://en.wikipedia.org/wiki/Intel_HEX) format used in embedded
development.

## Features
- Supports all 6 record types
- Raw record parser (`parseRaw`)
- User-friendly preprocessor (`parseData`)
- Pedantic and lax parsing

## Example

```zig
fn processData(x: void, offset: u32, data: []const u8) !void {
    std.debug.warn("read slice @ 0x{x}: {x}\n", .{ offset, data });
}

pub fn main() !void {
    var file = try std.fs.cwd().openFile("data/example.ihex", .{ .read = true, .write = false });
    defer file.close();

    const entry_point = try ihex.parseData(file.reader(), ihex.ParseMode{ .pedantic = true }, {}, error{}, processData);
    if (entry_point) |ep| {
        std.debug.warn("entry point: 0x{x}\n", .{ep});
    }
}
```
