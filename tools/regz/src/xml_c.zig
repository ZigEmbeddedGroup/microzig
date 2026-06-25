// Only used when compiling with zig 0.16
pub const c = @cImport({
    @cDefine("LIBXML_TREE_ENABLED", {});
    @cDefine("LIBXML_SCHEMAS_ENABLED", {});
    @cDefine("LIBXML_READER_ENABLED", {});
    @cInclude("libxml/xmlreader.h");
});
