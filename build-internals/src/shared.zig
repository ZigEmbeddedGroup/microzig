/// A descriptor for memory regions in a microcontroller.
pub const MemoryRegion = struct {
    /// The type of the memory region for generating a proper linker script.
    kind: Kind,
    offset: u64,
    length: u64,

    pub const Kind = union(enum) {
        /// This is a (normally) immutable memory region where the code is stored.
        flash,

        /// This is a mutable memory region for data storage.
        ram,

        /// This is a memory region that maps MMIO devices.
        io,

        /// This is a memory region that exists, but is reserved and must not be used.
        reserved,

        /// This is a memory region used for internal linking tasks required by the board support package.
        private: PrivateRegion,
    };

    pub const PrivateRegion = struct {
        /// The name of the memory region. Will not have an automatic numeric counter and must be unique.
        name: []const u8,

        /// Is the memory region executable?
        executable: bool,

        /// Is the memory region readable?
        readable: bool,

        /// Is the memory region writable?
        writeable: bool,
    };
};
