const std = @import("std");
const koino = @import("koino");

const markdown_options = koino.Options{
    .extensions = .{
        .table = true,
        .autolink = true,
        .strikethrough = true,
    },
    .render = .{
        .header_anchors = true,
        .anchor_icon = "§ ",
    },
};

/// verifies and parses a file name in the format
/// "YYYY-MM-DD - " [.*] ".md"
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

    const allocator = gpa.allocator();

    var website = Website{
        .allocator = allocator,
        .arena = std.heap.ArenaAllocator.init(allocator),
        .articles = std.ArrayList(Article).init(allocator),
        .tutorials = std.ArrayList(Tutorial).init(allocator),
        .images = std.ArrayList([]const u8).init(allocator),
    };
    defer website.deinit();

    // gather step
    {
        var root_dir = try std.fs.cwd().openDir("website", .{});
        defer root_dir.close();

        // Tutorials are maintained manually right now
        try website.addTutorial(Tutorial{
            .src_file = "website/tutorials/01-embedded-basics.md",
        });
        try website.addTutorial(Tutorial{
            .src_file = "website/tutorials/02-embedded-programming.md",
        });
        // try website.addTutorial(Tutorial{
        //     .src_file = "website/tutorials/03-lpc1768.md",
        // });
        // try website.addTutorial(Tutorial{
        //     .src_file = "website/tutorials/03-nrf52.md",
        // });
        // try website.addTutorial(Tutorial{
        //     .src_file = "website/tutorials/03-avr.md",
        // });
        // try website.addTutorial(Tutorial{
        //     .src_file = "website/tutorials/03-pi-pico.md",
        // });
        // try website.addTutorial(Tutorial{
        //     .src_file = "website/tutorials/03-stm32.md",
        // });
        // try website.addTutorial(Tutorial{
        //     .src_file = "website/tutorials/04-chose-device.md",
        // });
        // try website.addTutorial(Tutorial{
        //     .src_file = "website/tutorials/05-hal.md",
        // });

        // img articles
        {
            var dir = try root_dir.openDir("img", .{ .iterate = true });
            defer dir.close();

            var iter = dir.iterate();

            while (try iter.next()) |entry| {
                if (entry.kind != .File) {
                    std.log.err("Illegal folder in directory website/img: {s}", .{entry.name});
                    continue;
                }

                const path = try std.fs.path.join(website.arena.allocator(), &[_][]const u8{
                    "website",
                    "img",
                    entry.name,
                });

                try website.addImage(path);
            }
        }

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
                    if (!std.mem.eql(u8, entry.name, ".keep"))
                        std.log.err("Illegal file name in directory website/articles: {s}", .{entry.name});
                    continue;
                };

                var article = Article{
                    .title = "Not yet generated",
                    .src_file = undefined,
                    .date = date,
                };

                article.src_file = try std.fs.path.join(website.arena.allocator(), &[_][]const u8{
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

        try website.renderMarkdownFile("website/index.md", root_dir, "index.htm");

        try website.renderArticleIndex(root_dir, "articles.htm");

        var art_dir = try root_dir.makeOpenPath("articles", .{});
        defer art_dir.close();

        var tut_dir = try root_dir.makeOpenPath("tutorials", .{});
        defer tut_dir.close();

        var img_dir = try root_dir.makeOpenPath("img", .{});
        defer img_dir.close();

        try website.renderArticles(art_dir);

        try website.renderTutorials(tut_dir);

        try website.renderAtomFeed(root_dir, "feed.atom");

        try website.renderImages(img_dir);
    }
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
        _ = fmt;
        _ = options;
        try writer.print("{d:0>4}-{d:0>2}-{d:0>2}", .{
            self.year, self.month, self.day,
        });
    }
};

const Article = struct {
    date: Date,
    src_file: []const u8,
    title: []const u8 = "<undetermined>",
};

const Tutorial = struct {
    src_file: []const u8,
    title: []const u8 = "<undetermined>",
};

const Website = struct {
    const Self = @This();

    is_prepared: bool = false,
    allocator: std.mem.Allocator,
    arena: std.heap.ArenaAllocator,
    articles: std.ArrayList(Article),
    tutorials: std.ArrayList(Tutorial),
    images: std.ArrayList([]const u8),

    fn deinit(self: *Self) void {
        self.tutorials.deinit();
        self.articles.deinit();
        self.images.deinit();
        self.arena.deinit();
        self.* = undefined;
    }

    fn addArticle(self: *Self, article: Article) !void {
        self.is_prepared = false;
        try self.articles.append(Article{
            .date = article.date,
            .src_file = try self.arena.allocator().dupe(u8, article.src_file),
            .title = try self.arena.allocator().dupe(u8, article.title),
        });
    }

    fn addTutorial(self: *Self, tutorial: Tutorial) !void {
        self.is_prepared = false;
        try self.tutorials.append(Tutorial{
            .src_file = try self.arena.allocator().dupe(u8, tutorial.src_file),
            .title = try self.arena.allocator().dupe(u8, tutorial.title),
        });
    }

    fn addImage(self: *Self, path: []const u8) !void {
        self.is_prepared = false;
        try self.images.append(try self.arena.allocator().dupe(u8, path));
    }

    fn findTitle(self: *Self, file: []const u8) !?[]const u8 {
        var doc = blk: {
            var p = try koino.parser.Parser.init(self.allocator, markdown_options);
            defer p.deinit();

            const markdown = try std.fs.cwd().readFileAlloc(self.allocator, file, 10_000_000);
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
            var list = std.ArrayList(u8).init(self.arena.allocator());
            defer list.deinit();

            var options = markdown_options;
            options.render.header_anchors = false;

            try koino.html.print(list.writer(), self.arena.allocator(), options, heading);

            const string = list.toOwnedSlice();

            std.debug.assert(std.mem.startsWith(u8, string, "<h1>"));
            std.debug.assert(std.mem.endsWith(u8, string, "</h1>\n"));

            return string[4 .. string.len - 6];
        } else {
            return null;
        }
    }

    fn prepareRendering(self: *Self) !void {
        std.sort.sort(Article, self.articles.items, self.*, sortArticlesDesc);

        for (self.articles.items) |*article| {
            if (try self.findTitle(article.src_file)) |title| {
                article.title = title;
            }
        }

        for (self.tutorials.items) |*tutorial| {
            std.debug.print("{s}\n", .{tutorial.src_file});
            if (try self.findTitle(tutorial.src_file)) |title| {
                tutorial.title = title;
            }
        }

        self.is_prepared = true;
    }

    fn sortArticlesDesc(self: Self, lhs: Article, rhs: Article) bool {
        _ = self;
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
        return std.mem.join(self.arena.allocator(), "", &[_][]const u8{
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

        const buf = try self.arena.allocator().alloc(u8, len);
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

    fn renderTutorials(self: *Self, dst_dir: std.fs.Dir) !void {
        std.debug.assert(self.is_prepared);
        for (self.tutorials.items) |tut| {
            try self.renderMarkdownFile(
                tut.src_file,
                dst_dir,
                try self.changeExtension(std.fs.path.basename(tut.src_file), ".htm"),
            );
        }
    }

    /// Renders a list of all possible articles
    fn renderArticleIndex(self: *Self, dst_dir: std.fs.Dir, file_name: []const u8) !void {
        std.debug.assert(self.is_prepared);

        try self.renderMarkdown(
            \\# Articles
            \\
            \\<!-- ARTICLES -->
        , dst_dir, file_name);
    }

    /// Render a given markdown file into `dst_path`.
    fn renderMarkdownFile(self: *Self, src_path: []const u8, dst_dir: std.fs.Dir, dst_path: []const u8) !void {
        std.debug.assert(self.is_prepared);

        var markdown_input = try std.fs.cwd().readFileAlloc(self.allocator, src_path, 10_000_000);
        defer self.allocator.free(markdown_input);

        try self.renderMarkdown(markdown_input, dst_dir, dst_path);
    }

    /// Render the given markdown source into `dst_path`.
    /// supported features here are:
    /// - `<!-- TOC -->` (renders a table of contents with all items that come *after* said TOC
    /// - `<!-- ARTICLES10 -->` Renders the 10 latest articles
    /// - `<!-- ARTICLES -->` Renders all articles
    fn renderMarkdown(self: *Self, source: []const u8, dst_dir: std.fs.Dir, dst_path: []const u8) !void {
        std.debug.assert(self.is_prepared);

        var doc: *koino.nodes.AstNode = blk: {
            var p = try koino.parser.Parser.init(self.arena.allocator(), markdown_options);
            try p.feed(source);
            defer p.deinit();
            break :blk try p.finish();
        };
        defer doc.deinit();

        std.debug.assert(doc.data.value == .Document);

        var output_file = try dst_dir.createFile(dst_path, .{});
        defer output_file.close();

        var writer = output_file.writer();

        try self.renderHeader(writer);
        {
            var renderer = koino.html.makeHtmlFormatter(writer, self.arena.allocator(), markdown_options);
            defer renderer.deinit();

            var iter = doc.first_child;
            while (iter) |item| : (iter = item.next) {
                if (item.data.value == .HtmlBlock) {
                    const raw_string = item.data.value.HtmlBlock.literal.items;

                    const string = std.mem.trim(u8, raw_string, " \t\r\n");

                    if (std.mem.eql(u8, string, "<!-- TOC -->")) {
                        var min_heading_level: ?u8 = null;
                        var current_heading_level: u8 = undefined;

                        var heading_options = markdown_options;
                        heading_options.render.header_anchors = false;

                        try writer.writeAll("<ul>");

                        var it = item.next;
                        while (it) |child| : (it = child.next) {
                            if (child.data.value == .Heading) {
                                var heading = child.data.value.Heading;

                                if (min_heading_level == null) {
                                    min_heading_level = heading.level;
                                    current_heading_level = heading.level;
                                }

                                if (heading.level < min_heading_level.?)
                                    continue;

                                while (current_heading_level > heading.level) {
                                    try writer.writeAll("</ul>");
                                    current_heading_level -= 1;
                                }
                                while (current_heading_level < heading.level) {
                                    try writer.writeAll("<ul>");
                                    current_heading_level += 1;
                                }

                                try writer.writeAll("<li><a href=\"#");
                                try writer.writeAll(try renderer.getNodeAnchor(child));
                                try writer.writeAll("\">");

                                {
                                    var i = child.first_child;
                                    while (i) |c| : (i = c.next) {
                                        try koino.html.print(
                                            writer,
                                            self.arena.allocator(),
                                            heading_options,
                                            c,
                                        );
                                    }
                                }
                                try writer.writeAll("</a>");

                                while (current_heading_level > heading.level) {
                                    try writer.writeAll("</ul>");
                                    current_heading_level -= 1;
                                }

                                try writer.writeAll("</li>");
                            }
                        }

                        if (min_heading_level) |mhl| {
                            while (current_heading_level > mhl) {
                                try writer.writeAll("</ul>");
                                current_heading_level -= 1;
                            }
                        }

                        try writer.writeAll("</ul>");
                    } else if (std.mem.eql(u8, string, "<!-- ARTICLES -->")) {
                        for (self.articles.items[0..std.math.min(self.articles.items.len, 10)]) |art| {
                            try writer.print(
                                \\<li><a href="articles/{s}.htm">{} - {s}</a></li>
                                \\
                            , .{
                                try self.urlEscape(removeExtension(std.fs.path.basename(art.src_file))),
                                art.date,
                                art.title,
                            });
                        }
                    } else if (std.mem.eql(u8, string, "<!-- ARTICLES -->")) {
                        try writer.writeAll("<ul>\n");
                        for (self.articles.items[0..std.math.min(self.articles.items.len, 10)]) |art| {
                            try writer.print(
                                \\<li><a href="articles/{s}.htm">{} - {s}</a></li>
                                \\
                            , .{
                                try self.urlEscape(removeExtension(std.fs.path.basename(art.src_file))),
                                art.date,
                                art.title,
                            });
                        }
                        try writer.writeAll("</ul>\n");
                    } else {
                        std.log.err("Unhandled HTML inline: {s}", .{string});
                    }
                } else {
                    try renderer.format(item, false);
                }
            }
        }
        try self.renderFooter(writer);
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
            //  Limit the text width of the body to roughly 40 characters
            \\  body {
            \\    max-width: 40em;
            \\    margin-left: auto;
            \\    margin-right: auto;
            \\    font-family: sans;
            \\  }
            \\
            \\  @media screen and (max-width: 600px) {
            \\    body {
            \\      padding: 2em;
            \\    }
            \\  }
            // Align top-level headings
            \\  h1 {
            \\    text-align: center;
            \\  }
            \\
            // Make images in headings and links exactly 1 character high.
            \\  h1 img, h2 img, h3 img, h3 img, h4 img, h5 img, h6 img, a img {
            \\    width: 1em;
            \\    height: 1em;
            \\    vertical-align: middle;
            \\  }
            \\
            // center images in a paragraph and display them as a block
            \\  p > img {
            \\    display: block;
            \\    max-width: 100%;
            \\    margin-left: auto;
            \\    margin-right: auto;
            \\  }
            \\ 
            // Make nice top-level codeblocks
            \\  body > pre {
            \\    background-color: #EEE;
            \\    padding: 0.5em;
            \\  }
            \\
            // Make nice top-level blockquotes
            \\  body > blockquote {
            \\    border-left: 3pt solid cornflowerblue;
            \\    padding-left: 0.5em;
            \\    margin-left: 0.5em;
            \\ }
            \\
            // Make links in headings invisible
            \\  h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {
            \\    text-decoration: none;
            \\    font-weight: lighter;
            \\    color: unset;
            \\    opacity: 10%;
            \\    margin-left: -1.5em;
            \\    padding-left: 0.5em;
            \\  }
            \\  h1:hover a, h2:hover a, h3:hover a, h4:hover a, h5:hover a, h6:hover a {
            \\    opacity: 50%;
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

    fn renderAtomFeed(self: *Self, dir: std.fs.Dir, file_name: []const u8) !void {
        var feed_file = try dir.createFile(file_name, .{});
        defer feed_file.close();

        var feed_writer = feed_file.writer();

        try feed_writer.writeAll(
            \\<?xml version="1.0" encoding="utf-8"?>
            \\<feed xmlns="http://www.w3.org/2005/Atom">
            \\  <author>
            \\    <name>Zig Embedded Group</name>
            \\  </author>
            \\  <title>Zig Embedded Group</title>
            \\  <id>https://zeg.random-projects.net/</id>
            \\
        );

        var last_update = Date{ .year = 0, .month = 0, .day = 0 };
        var article_count: usize = 0;
        for (self.articles.items) |article| {
            if (last_update.lessThan(article.date)) {
                last_update = article.date;
                article_count = 0;
            } else {
                article_count += 1;
            }
        }

        try feed_writer.print("  <updated>{d:0>4}-{d:0>2}-{d:0>2}T{d:0>2}:00:00Z</updated>\n", .{
            last_update.year,
            last_update.month,
            last_update.day,
            article_count, // this is fake, but is just here for creating a incremental version for multiple articles a day
        });

        for (self.articles.items) |article| {
            const uri_name = try self.urlEscape(removeExtension(article.src_file));
            try feed_writer.print(
                \\  <entry>
                \\    <title>{s}</title>
                \\    <link href="https://zeg.random-projects.net/articles/{s}.htm" />
                \\    <id>zeg.random-projects.net/articles/{s}.htm</id>
                \\    <updated>{d:0>4}-{d:0>2}-{d:0>2}T00:00:00Z</updated>
                \\  </entry>
                \\
            , .{
                article.title,
                uri_name,
                uri_name,
                article.date.year,
                article.date.month,
                article.date.day,
            });
        }

        try feed_writer.writeAll("</feed>");
    }

    fn renderImages(self: Self, target_dir: std.fs.Dir) !void {
        for (self.images.items) |img| {
            try std.fs.Dir.copyFile(
                std.fs.cwd(),
                img,
                target_dir,
                std.fs.path.basename(img),
                .{},
            );
        }
    }

    // fn renderArticle(self: *Website, article: Article, dst_dir: std.fs.Dir, dst_name: []const u8) !void {
    //     var formatter = HtmlFormatter.init(allocator, options);
    //     defer formatter.deinit();

    //     try formatter.format(root, false);

    //     return formatter.buffer.toOwnedSlice();
    // }
};
