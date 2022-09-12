const std = @import("std");

/// The version information for this library. This is hardcoded for now but
/// in the future we will parse this from configure.ac.
pub const Version = struct {
    pub const major = "2";
    pub const minor = "9";
    pub const micro = "12";

    pub fn number() []const u8 {
        comptime {
            return major ++ "0" ++ minor ++ "0" ++ micro;
        }
    }

    pub fn string() []const u8 {
        comptime {
            return "\"" ++ number() ++ "\"";
        }
    }

    pub fn dottedString() []const u8 {
        comptime {
            return "\"" ++ major ++ "." ++ minor ++ "." ++ micro ++ "\"";
        }
    }
};

/// This is the type returned by create.
pub const Library = struct {
    step: *std.build.LibExeObjStep,

    /// statically link this library into the given step
    pub fn link(self: Library, other: *std.build.LibExeObjStep) void {
        self.addIncludeDirs(other);
        other.linkLibrary(self.step);
    }

    /// only add the include dirs to the given step. This is useful if building
    /// a static library that you don't want to fully link in the code of this
    /// library.
    pub fn addIncludeDirs(self: Library, other: *std.build.LibExeObjStep) void {
        _ = self;
        other.addIncludeDir(include_dir);
        other.addIncludeDir(override_include_dir);
    }
};

/// Compile-time options for the library. These mostly correspond to
/// options exposed by the native build system used by the library.
pub const Options = struct {
    // These options are all defined in libxml2's configure.c and correspond
    // to `--with-X` options for `./configure`. Their defaults are properly set.
    c14n: bool = true,
    catalog: bool = true,
    debug: bool = true,
    docb: bool = true, // docbook
    ftp: bool = true,
    history: bool = true,
    html: bool = true,
    iconv: bool = true,
    icu: bool = false,
    iso8859x: bool = true,
    mem_debug: bool = false,
    minimum: bool = true,
    output: bool = true,
    pattern: bool = true,
    push: bool = true,
    reader: bool = true,
    regexp: bool = true,
    run_debug: bool = false,
    sax1: bool = true,
    schemas: bool = true,
    schematron: bool = true,
    thread: bool = true,
    thread_alloc: bool = false,
    tree: bool = true,
    valid: bool = true,
    writer: bool = true,
    xinclude: bool = true,
    xpath: bool = true,
    xptr: bool = true,
    modules: bool = true,
    lzma: bool = true,
    zlib: bool = true,
};

/// Create this library. This is the primary API users of build.zig should
/// use to link this library to their application. On the resulting Library,
/// call the link function and given your own application step.
pub fn create(
    b: *std.build.Builder,
    target: std.zig.CrossTarget,
    mode: std.builtin.Mode,
    opts: Options,
) !Library {
    const ret = b.addStaticLibrary("xml2", null);
    ret.setTarget(target);
    ret.setBuildMode(mode);

    var flags = std.ArrayList([]const u8).init(b.allocator);
    defer flags.deinit();

    try flags.appendSlice(&.{
        // Version info, hardcoded
        comptime "-DLIBXML_VERSION=" ++ Version.number(),
        comptime "-DLIBXML_VERSION_STRING=" ++ Version.string(),
        "-DLIBXML_VERSION_EXTRA=\"\"",
        comptime "-DLIBXML_DOTTED_VERSION=" ++ Version.dottedString(),

        // These might now always be true (particularly Windows) but for
        // now we just set them all. We should do some detection later.
        "-DSEND_ARG2_CAST=",
        "-DGETHOSTBYNAME_ARG_CAST=",
        "-DGETHOSTBYNAME_ARG_CAST_CONST=",

        // Always on
        "-DLIBXML_STATIC=1",
        "-DLIBXML_AUTOMATA_ENABLED=1",
        "-DWITHOUT_TRIO=1",
    });

    if (!target.isWindows()) {
        try flags.appendSlice(&.{
            "-DHAVE_ARPA_INET_H=1",
            "-DHAVE_ARPA_NAMESER_H=1",
            "-DHAVE_DL_H=1",
            "-DHAVE_NETDB_H=1",
            "-DHAVE_NETINET_IN_H=1",
            "-DHAVE_PTHREAD_H=1",
            "-DHAVE_SHLLOAD=1",
            "-DHAVE_SYS_DIR_H=1",
            "-DHAVE_SYS_MMAN_H=1",
            "-DHAVE_SYS_NDIR_H=1",
            "-DHAVE_SYS_SELECT_H=1",
            "-DHAVE_SYS_SOCKET_H=1",
            "-DHAVE_SYS_TIMEB_H=1",
            "-DHAVE_SYS_TIME_H=1",
            "-DHAVE_SYS_TYPES_H=1",
        });
    }

    // Option-specific changes
    if (opts.history) {
        try flags.appendSlice(&.{
            "-DHAVE_LIBHISTORY=1",
            "-DHAVE_LIBREADLINE=1",
        });
    }
    if (opts.mem_debug) {
        try flags.append("-DDEBUG_MEMORY_LOCATION=1");
    }
    if (opts.regexp) {
        try flags.append("-DLIBXML_UNICODE_ENABLED=1");
    }
    if (opts.run_debug) {
        try flags.append("-DLIBXML_DEBUG_RUNTIME=1");
    }
    if (opts.thread) {
        try flags.append("-DHAVE_LIBPTHREAD=1");
    }

    // Enable our `./configure` options. For bool-type fields we translate
    // it to the `LIBXML_{field}_ENABLED` C define where field is uppercased.
    inline for (std.meta.fields(@TypeOf(opts))) |field| {
        if (field.field_type == bool and @field(opts, field.name)) {
            var nameBuf: [32]u8 = undefined;
            const name = std.ascii.upperString(&nameBuf, field.name);
            const define = try std.fmt.allocPrint(b.allocator, "-DLIBXML_{s}_ENABLED=1", .{name});
            try flags.append(define);
        }
    }

    // C files
    ret.addCSourceFiles(srcs, flags.items);
    if (opts.sax1) {
        ret.addCSourceFile(comptime root() ++ "libxml2/DOCBparser.c", flags.items);
    }

    ret.addIncludeDir(include_dir);
    ret.addIncludeDir(override_include_dir);
    if (target.isWindows()) {
        ret.addIncludeDir(win32_include_dir);
        ret.linkSystemLibrary("ws2_32");
    } else {
        ret.addIncludeDir(posix_include_dir);
    }
    ret.linkLibC();

    return Library{ .step = ret };
}

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse unreachable) ++ "/";
}

/// Directories with our includes.
const include_dir = root() ++ "libxml2/include";
const override_include_dir = root() ++ "override/include";
const posix_include_dir = root() ++ "override/config/posix";
const win32_include_dir = root() ++ "override/config/win32";

const srcs = &.{
    root() ++ "libxml2/buf.c",
    root() ++ "libxml2/c14n.c",
    root() ++ "libxml2/catalog.c",
    root() ++ "libxml2/chvalid.c",
    root() ++ "libxml2/debugXML.c",
    root() ++ "libxml2/dict.c",
    root() ++ "libxml2/encoding.c",
    root() ++ "libxml2/entities.c",
    root() ++ "libxml2/error.c",
    root() ++ "libxml2/globals.c",
    root() ++ "libxml2/hash.c",
    root() ++ "libxml2/HTMLparser.c",
    root() ++ "libxml2/HTMLtree.c",
    root() ++ "libxml2/legacy.c",
    root() ++ "libxml2/list.c",
    root() ++ "libxml2/nanoftp.c",
    root() ++ "libxml2/nanohttp.c",
    root() ++ "libxml2/parser.c",
    root() ++ "libxml2/parserInternals.c",
    root() ++ "libxml2/pattern.c",
    root() ++ "libxml2/relaxng.c",
    root() ++ "libxml2/SAX.c",
    root() ++ "libxml2/SAX2.c",
    root() ++ "libxml2/schematron.c",
    root() ++ "libxml2/threads.c",
    root() ++ "libxml2/tree.c",
    root() ++ "libxml2/uri.c",
    root() ++ "libxml2/valid.c",
    root() ++ "libxml2/xinclude.c",
    root() ++ "libxml2/xlink.c",
    root() ++ "libxml2/xmlIO.c",
    root() ++ "libxml2/xmlmemory.c",
    root() ++ "libxml2/xmlmodule.c",
    root() ++ "libxml2/xmlreader.c",
    root() ++ "libxml2/xmlregexp.c",
    root() ++ "libxml2/xmlsave.c",
    root() ++ "libxml2/xmlschemas.c",
    root() ++ "libxml2/xmlschemastypes.c",
    root() ++ "libxml2/xmlstring.c",
    root() ++ "libxml2/xmlunicode.c",
    root() ++ "libxml2/xmlwriter.c",
    root() ++ "libxml2/xpath.c",
    root() ++ "libxml2/xpointer.c",
    root() ++ "libxml2/xzlib.c",
};
