#!/usr/bin/env python3
import usb.core

# Find ALL USB devices
devices = usb.core.find(find_all=True)

print("Connected USB devices:")
print("-" * 60)
for dev in devices:
    print(f"Vendor ID:  0x{dev.idVendor:04x}")
    print(f"Product ID: 0x{dev.idProduct:04x}")
    try:
        print(f"Manufacturer: {dev.manufacturer}")
        print(f"Product: {dev.product}")
    except usb.core.USBError as e:
        print("(Could not read device strings: {e})")
    except ValueError:
        print("(Device has no string descriptors)")
    print("-" * 60)
