const std = @import("std");
const koino = @import("koino");

const markdown_options = koino.Options{
    .extensions = .{
        .table = true,
        .autolink = true,
        .strikethrough = true,
    },
};

/// verifies and parses a file name in the format
/// "YYYY-MM-DD - " [.*] ".md"
/// 
fn isValidArticleFileName(path: []const u8) ?Date {
    if (path.len < 16)
        return null;
    if (!std.mem.endsWith(u8, path, ".md"))
        return null;
    if (path[4] != '-' or path[7] != '-' or !std.mem.eql(u8, path[10..13], " - "))
        return null;
    return Date{
        .year = std.fmt.parseInt(u16, path[0..4], 10) catch return null,
        .month = std.fmt.parseInt(u8, path[5..7], 10) catch return null,
        .day = std.fmt.parseInt(u8, path[8..10], 10) catch return null,
    };
}

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = &gpa.allocator;

    var website = Website{
        .allocator = allocator,
        .arena = std.heap.ArenaAllocator.init(allocator),
        .articles = std.ArrayList(Article).init(allocator),
    };
    defer website.deinit();

    // gather step
    {
        var root_dir = try std.fs.cwd().openDir("website", .{});
        defer root_dir.close();

        // gather articles
        {
            var dir = try root_dir.openDir("articles", .{ .iterate = true });
            defer dir.close();

            var iter = dir.iterate();
            while (try iter.next()) |entry| {
                if (entry.kind != .File) {
                    std.log.err("Illegal folder in directory website/articles: {s}", .{entry.name});
                    continue;
                }

                const date = isValidArticleFileName(entry.name) orelse {
                    std.log.err("Illegal file name in directory website/articles: {s}", .{entry.name});
                    continue;
                };

                var article = Article{
                    .title = "Not yet generated",
                    .src_file = undefined,
                    .date = date,
                };

                article.src_file = try std.fs.path.join(&website.arena.allocator, &[_][]const u8{
                    "website",
                    "articles",
                    entry.name,
                });

                try website.addArticle(article);
            }
        }
    }

    try website.prepareRendering();

    // final rendering
    {
        var root_dir = try std.fs.cwd().makeOpenPath("render", .{});
        defer root_dir.close();

        try website.renderIndexFile("website/index.md", root_dir, "index.htm");

        try website.renderArticleIndex(root_dir, "articles.htm");

        var art_dir = try root_dir.makeOpenPath("articles", .{});
        defer art_dir.close();

        try website.renderArticles(art_dir);
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

const Date = struct {
    const Self = @This();

    day: u8,
    month: u8,
    year: u16,

    fn toInteger(self: Self) u32 {
        return @as(u32, self.day) + 33 * @as(u32, self.month) + (33 * 13) * @as(u32, self.year);
    }

    pub fn lessThan(lhs: Self, rhs: Self) bool {
        return lhs.toInteger() < rhs.toInteger();
    }

    pub fn eql(a: Self, b: Self) bool {
        return std.meta.eql(a, b);
    }

    pub fn format(self: Self, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        try writer.print("{d:0>4}-{d:0>2}-{d:0>2}", .{
            self.year, self.month, self.day,
        });
    }
};

const Article = struct {
    date: Date,
    src_file: []const u8,
    title: []const u8,
};

const Website = struct {
    const Self = @This();

    is_prepared: bool = false,
    allocator: *std.mem.Allocator,
    arena: std.heap.ArenaAllocator,
    articles: std.ArrayList(Article),

    fn deinit(self: *Self) void {
        self.articles.deinit();
        self.arena.deinit();
        self.* = undefined;
    }

    fn addArticle(self: *Self, article: Article) !void {
        self.is_prepared = false;
        try self.articles.append(Article{
            .date = article.date,
            .src_file = try self.arena.allocator.dupe(u8, article.src_file),
            .title = try self.arena.allocator.dupe(u8, article.title),
        });
    }

    fn prepareRendering(self: *Self) !void {
        std.sort.sort(Article, self.articles.items, self.*, sortArticlesDesc);

        for (self.articles.items) |*article| {
            var doc = blk: {
                var p = try koino.parser.Parser.init(self.allocator, markdown_options);
                defer p.deinit();

                const markdown = try std.fs.cwd().readFileAlloc(self.allocator, article.src_file, 10_000_000);
                defer self.allocator.free(markdown);

                try p.feed(markdown);

                break :blk try p.finish();
            };
            defer doc.deinit();

            std.debug.assert(doc.data.value == .Document);

            var iter = doc.first_child;
            var heading_or_null: ?*koino.nodes.AstNode = while (iter) |item| : (iter = item.next) {
                if (item.data.value == .Heading) {
                    if (item.data.value.Heading.level == 1) {
                        break item;
                    }
                }
            } else null;

            if (heading_or_null) |heading| {
                const string = try koino.html.print(&self.arena.allocator, markdown_options, heading);

                std.debug.assert(std.mem.startsWith(u8, string, "<h1>"));
                std.debug.assert(std.mem.endsWith(u8, string, "</h1>\n"));

                article.title = string[4 .. string.len - 6];
            }
        }

        self.is_prepared = true;
    }

    fn sortArticlesDesc(self: Self, lhs: Article, rhs: Article) bool {
        if (lhs.date.lessThan(rhs.date))
            return false;
        if (rhs.date.lessThan(lhs.date))
            return true;
        return (std.mem.order(u8, lhs.title, rhs.title) == .gt);
    }

    fn removeExtension(src_name: []const u8) []const u8 {
        const ext = std.fs.path.extension(src_name);
        return src_name[0 .. src_name.len - ext.len];
    }

    fn changeExtension(self: *Self, src_name: []const u8, new_ext: []const u8) ![]const u8 {
        return std.mem.join(&self.arena.allocator, "", &[_][]const u8{
            removeExtension(src_name),
            new_ext,
        });
    }

    fn urlEscape(self: *Self, text: []const u8) ![]u8 {
        const legal_character = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~";

        var len: usize = 0;
        for (text) |c| {
            len += if (std.mem.indexOfScalar(u8, legal_character, c) == null)
                @as(usize, 3)
            else
                @as(usize, 1);
        }

        const buf = try self.arena.allocator.alloc(u8, len);
        var offset: usize = 0;
        for (text) |c| {
            if (std.mem.indexOfScalar(u8, legal_character, c) == null) {
                const hexdigits = "0123456789ABCDEF";
                buf[offset + 0] = '%';
                buf[offset + 1] = hexdigits[(c >> 4) & 0xF];
                buf[offset + 2] = hexdigits[(c >> 0) & 0xF];
                offset += 3;
            } else {
                buf[offset] = c;
                offset += 1;
            }
        }

        return buf;
    }

    fn renderArticles(self: *Self, dst_dir: std.fs.Dir) !void {
        std.debug.assert(self.is_prepared);
        for (self.articles.items) |art| {
            try self.renderMarkdownFile(
                art.src_file,
                dst_dir,
                try self.changeExtension(std.fs.path.basename(art.src_file), ".htm"),
            );
        }
    }

    /// Renders the root file and replaces `<!-- ARTICLES -->` with the first 10 articles,
    /// in descending order
    fn renderIndexFile(self: *Self, src_path: []const u8, dst_dir: std.fs.Dir, file_name: []const u8) !void {
        std.debug.assert(self.is_prepared);

        var src_code = try std.fs.cwd().readFileAlloc(self.allocator, src_path, 10_000_000);
        defer self.allocator.free(src_code);

        var array_buffer = std.ArrayList(u8).init(self.allocator);
        defer array_buffer.deinit();

        const offset = std.mem.indexOf(u8, src_code, "<!-- ARTICLES -->") orelse return error.MissingArticlesMarker;

        var writer = array_buffer.writer();

        try writer.writeAll(src_code[0..offset]);

        for (self.articles.items[0..std.math.min(self.articles.items.len, 10)]) |art| {
            try writer.print("- [{} - {s}](articles/{s}.htm)\n", .{
                art.date,
                art.title,
                try self.urlEscape(removeExtension(std.fs.path.basename(art.src_file))),
            });
        }

        try writer.writeAll(src_code[offset + 17 ..]);

        try self.renderMarkdown(array_buffer.items, dst_dir, file_name);
    }

    /// Renders the root file and replaces `<!-- ARTICLES -->` with the first 10 articles,
    /// in descending order
    fn renderArticleIndex(self: *Self, dst_dir: std.fs.Dir, file_name: []const u8) !void {
        std.debug.assert(self.is_prepared);

        var array_buffer = std.ArrayList(u8).init(self.allocator);
        defer array_buffer.deinit();

        var writer = array_buffer.writer();

        try writer.writeAll("# Articles\n");
        try writer.writeAll("\n");

        for (self.articles.items[0..std.math.min(self.articles.items.len, 10)]) |art| {
            try writer.print("- [{} - {s}](articles/{s}.htm)\n", .{
                art.date,
                art.title,
                try self.urlEscape(removeExtension(std.fs.path.basename(art.src_file))),
            });
        }

        try self.renderMarkdown(array_buffer.items, dst_dir, file_name);
    }

    /// Render a given markdown file into `dst_path`.
    fn renderMarkdownFile(self: Self, src_path: []const u8, dst_dir: std.fs.Dir, dst_path: []const u8) !void {
        std.debug.assert(self.is_prepared);

        var markdown_input = try std.fs.cwd().readFileAlloc(self.allocator, src_path, 10_000_000);
        defer self.allocator.free(markdown_input);

        try self.renderMarkdown(markdown_input, dst_dir, dst_path);
    }

    /// Render the given markdown source into `dst_path`.
    fn renderMarkdown(self: Self, source: []const u8, dst_dir: std.fs.Dir, dst_path: []const u8) !void {
        std.debug.assert(self.is_prepared);

        var rendered_markdown = try markdownToHtml(self.allocator, markdown_options, source);
        defer self.allocator.free(rendered_markdown);

        try self.renderHtml(rendered_markdown, dst_dir, dst_path);
    }

    /// Render the markdown body into `dst_path`.
    fn renderHtml(self: Self, source: []const u8, dst_dir: std.fs.Dir, dst_path: []const u8) !void {
        std.debug.assert(self.is_prepared);

        var output_file = try dst_dir.createFile(dst_path, .{});
        defer output_file.close();

        var writer = output_file.writer();

        try self.renderHeader(writer);
        try writer.writeAll(source);
        try self.renderFooter(writer);
    }

    fn renderHeader(self: Self, writer: anytype) !void {
        std.debug.assert(self.is_prepared);
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
    }

    fn renderFooter(self: Self, writer: anytype) !void {
        std.debug.assert(self.is_prepared);
        try writer.writeAll(
            \\</body>
            \\</html>
            \\
        );
    }
};
