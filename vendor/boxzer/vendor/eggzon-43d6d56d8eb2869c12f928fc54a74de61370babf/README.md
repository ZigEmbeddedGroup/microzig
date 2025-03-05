# 🥚-Zon

```zig
var doc = try parseString(std.testing.allocator,
    \\.{
    \\    .name = "egg-zon",
    \\    .version = "0.1.0",
    \\
    \\    .dependencies = .{
    \\        .@"parser-toolkit" = .{
    \\            .url = "https://github.com/MasterQ32/parser-toolkit/archive/6238b7c6893582fb56f39676a090b1af1226fe1a.tar.gz",
    \\            .hash = "1220cf55c10add71a9cd2591dbe118ffa9a9198e21069e440fae1f6e3eef6f274733",
    \\        },
    \\    },
    \\}
);
defer doc.deinit();

const name = doc.root.object.get("name").?.string;
```
