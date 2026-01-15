pub const c = @cImport({
    @cInclude("lwip/init.h");
    @cInclude("lwip/tcpip.h");
    @cInclude("lwip/netifapi.h");
    @cInclude("lwip/netif.h");
    @cInclude("lwip/dhcp.h");
    @cInclude("lwip/tcp.h");
    @cInclude("lwip/udp.h");
    @cInclude("lwip/etharp.h");
    @cInclude("lwip/ethip6.h");
    @cInclude("lwip/timeouts.h");
});

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
