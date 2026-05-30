pub const c = @import("lwip").c;

pub fn c_err(res: c.err_t) Error!void {
    return switch (res) {
        c.ERR_OK => {},
        c.ERR_MEM => error.OutOfMemory,
        c.ERR_BUF => error.BufferError,
        c.ERR_TIMEOUT => error.Timeout,
        c.ERR_RTE => error.Routing,
        c.ERR_INPROGRESS => error.InProgress,
        c.ERR_VAL => error.IllegalValue,
        c.ERR_WOULDBLOCK => error.WouldBlock,
        c.ERR_USE => error.AddressInUse,
        c.ERR_ALREADY => error.AlreadyConnecting,
        c.ERR_ISCONN => error.AlreadyConnected,
        c.ERR_CONN => error.NotConnected,
        c.ERR_IF => error.LowlevelInterfaceError,
        c.ERR_ABRT => error.ConnectionAborted,
        c.ERR_RST => error.ConnectionReset,
        c.ERR_CLSD => error.ConnectionClosed,
        c.ERR_ARG => error.IllegalArgument,
        else => @panic("unexpected character"),
    };
}

pub const Error = error{
    /// Out of memory error.
    OutOfMemory,
    /// Buffer error.
    BufferError,
    /// Timeout.
    Timeout,
    /// Routing problem.
    Routing,
    /// Operation in progress
    InProgress,
    /// Illegal value.
    IllegalValue,
    /// Operation would block.
    WouldBlock,
    /// Address in use.
    AddressInUse,
    /// Already connecting.
    AlreadyConnecting,
    /// Conn already established.
    AlreadyConnected,
    /// Not connected.
    NotConnected,
    /// Low-level netif error
    LowlevelInterfaceError,
    /// Connection aborted.
    ConnectionAborted,
    /// Connection reset.
    ConnectionReset,
    /// Connection closed.
    ConnectionClosed,
    /// Illegal argument.
    IllegalArgument,
};
