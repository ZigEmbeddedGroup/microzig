//! This module is meant to be used to define linking apis

pub const MemoryRegion = struct {
    kind: Kind,
    offset: u64,
    length: u64,

    pub const Kind = union(enum) {
        flash,
        ram,
        custom: RegionSpec,
    };

    pub const RegionSpec = struct {
        name: []const u8,
        executable: bool,
        readable: bool,
        writeable: bool,
    };
};
