#!/usr/bin/env python3

# Install python3 HID package https://pypi.org/project/hid/
import hid

# default is TinyUSB (0xcafe), Adafruit (0x239a), RaspberryPi (0x2e8a), Espressif (0x303a) VID
USB_VID = (0xcafe, 0x239a, 0x2e8a, 0x303a)

print("VID list: " + ", ".join('%02x' % v for v in USB_VID))

for vid in  USB_VID:
    for dict in hid.enumerate(vid):
        print(dict)
        dev = hid.Device(dict['vendor_id'], dict['product_id'])
        if dev:
            while True:
                inp = input("Send text to HID Device : ").encode('utf-8')
                dev.write(inp)

                x = 0
                l = len(inp)
                r = b""
                while (x < l):
                    str_in = dev.read(64)
                    r += str_in
                    x += 64

                print("Received from HID Device:\n", r)
                print("hex:\n", r.hex())
