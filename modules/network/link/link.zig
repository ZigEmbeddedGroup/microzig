/// Physical/data-link layer interface for the network module.
///
/// The type erased pointer to the data-link layer implementation.
ptr: *anyopaque,

vtable: struct {
    /// Receive data packet from the data link layer.
    ///
    /// Network module allocates and passes buffer to the recv function. If there
    /// is no data waiting in the driver zero len is returned in the response.
    ///
    /// Head and len definies part of the buffer where paket data is stored.
    /// Head position can be greater than zero if there is data link layer
    /// specific header in the buffer after getting data from the driver.
    ///
    /// Each read also returns current link state; up or down.
    recv: *const fn (*anyopaque, []u8) anyerror!RecvResponse,

    /// Send data packet to the data link layer.
    send: *const fn (*anyopaque, []u8) Error!void,
},

pub const RecvResponse = struct {
    pub const LinkState = enum {
        up,
        down,
    };

    head: usize = 0,
    len: usize = 0,
    link_state: LinkState = .up,
    next_packet_available: ?bool = null,
};

pub const Error = error{
    /// Packet can't fit into link output buffer
    OutOfMemory,
    /// Link is disconnected
    LinkDown,
    /// All other errors
    InternalError,
};
