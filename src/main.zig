const std = @import("std");
const koino = @import("koino");

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = &gpa.allocator;

    var root_dir = try std.fs.walkPath(allocator, "website");
    defer root_dir.deinit();

    const markdown_options = koino.Options{
        .extensions = .{
            .table = true,
            .autolink = true,
            .strikethrough = true,
        },
    };

    while (try root_dir.next()) |entry| {
        switch (entry.kind) {
            // we create the directories by forcing them
            .Directory => {},

            .File => {
                const ext = std.fs.path.extension(entry.path);
                if (std.mem.eql(u8, ext, ".md")) {
                    std.log.info("render {s}", .{entry.path});

                    const out_name = try std.mem.concat(allocator, u8, &[_][]const u8{
                        entry.path[8 .. entry.path.len - 3],
                        ".htm",
                    });
                    defer allocator.free(out_name);

                    var out_path = try std.fs.path.join(allocator, &[_][]const u8{
                        "render", out_name,
                    });
                    defer allocator.free(out_path);

                    if (std.fs.path.dirname(out_path)) |dir| {
                        std.debug.print("{s}\n", .{dir});
                        try std.fs.cwd().makePath(dir);
                    }

                    var markdown_input = try std.fs.cwd().readFileAlloc(allocator, entry.path, 10_000_000);
                    defer allocator.free(markdown_input);

                    var rendered_markdown = try markdownToHtml(allocator, markdown_options, markdown_input);
                    defer gpa.allocator.free(rendered_markdown);

                    var output_file = try std.fs.cwd().createFile(out_path, .{});
                    defer output_file.close();

                    var writer = output_file.writer();

                    try writer.writeAll(
                        \\<!DOCTYPE html>
                        \\<html lang="en">
                        \\
                        \\<head>
                        \\  <meta charset="utf-8">
                        \\  <meta name="viewport" content="width=device-width, initial-scale=1">
                        \\  <title>ZEG</title>
                        \\<style>
                        \\  body {
                        \\    max-width: 40em;
                        \\    margin-left: auto;
                        \\    margin-right: auto;
                        \\    font-family: sans;
                        \\  }
                        \\  h1 {
                        \\    text-align: center;
                        \\  }
                        \\</style>
                        \\</head>
                        \\<body>
                    );

                    try writer.writeAll(rendered_markdown);

                    try writer.writeAll(
                        \\</body>
                        \\</html>
                        \\
                    );
                }
            },

            else => std.debug.panic("Unsupported file type {s} in directory!", .{@tagName(entry.kind)}),
        }
    }
}

fn markdownToHtmlInternal(resultAllocator: *std.mem.Allocator, internalAllocator: *std.mem.Allocator, options: koino.Options, markdown: []const u8) ![]u8 {
    var p = try koino.parser.Parser.init(internalAllocator, options);
    try p.feed(markdown);

    var doc = try p.finish();
    p.deinit();

    defer doc.deinit();

    return try koino.html.print(resultAllocator, p.options, doc);
}

pub fn markdownToHtml(allocator: *std.mem.Allocator, options: koino.Options, markdown: []const u8) ![]u8 {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    return markdownToHtmlInternal(allocator, &arena.allocator, options, markdown);
}
