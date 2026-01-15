/// Physical/data-link layer interface for the network module.
///
/// The type erased pointer to the data-link layer implementation.
ptr: *anyopaque,

vtable: struct {
    /// Receive data packet from the data link layer.
    ///
    /// Network module allocates and passes buffer to the recv function. If there
    /// is no data waiting in the driver null is returned.
    ///
    /// If non null tuple is returned it contains start position of the Ethernet
    /// header in that buffer and length of the data packet.
    ///
    /// Start position can be greater than zero if there is data link layer
    /// specific header in the buffer after getting data from the driver.
    recv: *const fn (*anyopaque, []u8) anyerror!?struct { usize, usize },

    /// Send data packet to the data link layer.
    send: *const fn (*anyopaque, []u8) Error!void,
},

pub const Error = error{
    /// Packet can't fit into link output buffer
    OutOfMemory,
    /// Link is disconnected
    LinkDown,
    /// All other errors
    InternalError,
};
