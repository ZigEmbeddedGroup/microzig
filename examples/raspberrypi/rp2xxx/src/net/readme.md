# Examples for the pico 2w and lwip network

Currently tested only on pico 2w, should also work on pico w.

## secrets.zig

Enter your ssid, wifi password and wifi security type into `secrets.zig` file. All examples will used those credentials to connect to the WiFi. There is the option to use DHCP or fixed IP address.

`tcp_client` example also uses `host_ip` when connecting to the host, enter your desktop host IP address there.

## pong.zig

This only sets up cyw43 (pico WiFi chip), joins the WiFi network, and initializes lwip stack.   
When connected it will display its IP address in the log:

```
================ STARTING NEW LOGGER ================
debug (main): mac address: 2ccf67f3b7ea
debug (main): wifi joined
debug (lwip): netif status callback is_link_up: false, is_up: true, ready: false, ip: 0.0.0.0
debug (lwip): netif status callback is_link_up: true, is_up: true, ready: true, ip: 192.168.190.206
```

Than you can ping that address from the your host computer and see responses.

## scan.zig

Scans for WiFi networks and reports each found network. If open network is found it connects to that network. Reports WiFi chip join state.

```
================ STARTING NEW LOGGER ================
[0.930822] debug (main): scaning wifi networks
[0.945470] debug (main):   found ssid: SUN2000-NS235G001306, channel: 1, open: false, ap mac 3820283fbffa
[1.095437] debug (main):   found ssid: my-net-1            , channel: 6, open: false, ap mac 18e829c4ec78
[1.115025] debug (main):   found ssid: my-net-2            , channel: 6, open: true , ap mac 1ae829c4ec78
[1.185040] debug (main):   found ssid: my-net-2            , channel: 6, open: true , ap mac 7283c23179d7
[1.214764] debug (main):   found ssid: my-net-1            , channel: 6, open: false, ap mac 7683c23179d7
[1.625584] debug (main):   found ssid: NVRE82242483        , channel: 13, open: false, ap mac e0baad364a3d
[1.665162] debug (main): joining to: my-net-2
[2.543121] debug (main): join state .joined
[5.017620] debug (lwip): netif status callback is_link_up: true, is_up: true, ready: true, ip: 192.168.207.170
[20.673675] debug (lwip): netif status callback is_link_up: false, is_up: true, ready: false, ip: 192.168.207.170
[20.683811] debug (main): join state changed .disjoined
[30.386339] debug (lwip): netif status callback is_link_up: true, is_up: true, ready: true, ip: 192.168.207.170
[30.396295] debug (main): join state changed .joined
```
Here I turned off my-net-2 access point, and bring it back after few seconds.

## udp.zig

Listens for UDP packets on port 9999. Each received packet is echoed to the source IP address and port 9999.

Get pico IP address from log, if you are using DHCP:
```
debug (lwip): netif status callback is_link_up: true, is_up: true, ready: true, ip: 192.168.190.206
```

Then on host computer send something to that IP and port 9999:
```sh
echo "hello from host" | ncat -u 192.168.190.50 9999

ncat -u 192.168.190.50 9999 < LICENSE
```

To receive echoed packets start listening on the host: 
```sh
ncat -ulp 9999
```

Then send something to the pico again.


## tcp_server.zig

Listens for TCP connections on the port 9998 and logs received data.

Once you find pico IP in the log you can send something to that IP, for example to send file content:

```sh
ncat 192.168.190.206 9998 < build.zig
```

Examples allocates space for two connections when both are active it will not receive any new connections.


## tcp_client.zig

Connects to the host computer, sends TCP payload of various sizes. From time to time closes connection and reconnects. Receives TCP data and logs it. 

Host computer should listen on the port 9998 for TCP connections. This examples uses `host_ip` from secrets. 

On the host listen for TCP connections on port 9998:
```sh
ncat  -lkv -p 9998
```

To echo same packet back to the pico:
```sh
ncat -lkv -p 9998 --exec /bin/cat
```

This example will send various TCP payload sizes. When the payload is too big for the TCP send buffer out of memory error will be raised on send.
