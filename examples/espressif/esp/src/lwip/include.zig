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
