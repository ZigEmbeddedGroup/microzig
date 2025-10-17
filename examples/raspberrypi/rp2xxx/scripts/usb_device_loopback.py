#!/usr/bin/env python3

#
# Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
#
# SPDX-License-Identifier: BSD-3-Clause
#

# sudo pip3 install pyusb

import usb.core
import usb.util
import time

try:
    # find our device
    # use list_devices.py for idVendor and idProduct values
    dev = usb.core.find(idVendor=0x0000, idProduct=0x0001)

    # was it found?
    if dev is None:
        raise ValueError('Device not found. Verify that device is attached, then check vendor and product settings.')

    print("Device found!")

    # Detach kernel driver BEFORE setting configuration
    detached_interfaces = []
    for interface in [0, 1]:
        if dev.is_kernel_driver_active(interface):
            try:
                dev.detach_kernel_driver(interface)
                detached_interfaces.append(interface)
                print(f"Kernel driver detached from interface {interface}")
            except:
                pass

    # Set configuration
    try:
        dev.set_configuration()
        print("Configuration set")
    except usb.core.USBError as e:
        print(f"Configuration already set or error: {e}")

    # get an endpoint instance
    cfg = dev.get_active_configuration()
    intf = cfg[(1, 0)]  # Interface 1, Alt 0

    outep = usb.util.find_descriptor(
        intf,
        custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress) == usb.util.ENDPOINT_OUT)

    inep = usb.util.find_descriptor(
        intf,
        custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress) == usb.util.ENDPOINT_IN)

    assert inep is not None, "IN endpoint not found"
    assert outep is not None, "OUT endpoint not found"

    print(f"OUT endpoint: 0x{outep.bEndpointAddress:02x}")
    print(f"IN endpoint: 0x{inep.bEndpointAddress:02x}")

    # Clear any stale data from the IN endpoint
    try:
        while True:
            inep.read(64, timeout=100)  # Short timeout to flush buffer
    except usb.core.USBTimeoutError:
        pass  # Good, buffer is empty now

    test_string = "Hello World!"
    print(f"\nSending: {test_string}")

    bytes_written = outep.write(test_string, timeout=1000)
    print(f"Wrote {bytes_written} bytes")
    
    time.sleep(0.1)  # Give device a moment to process
    
    from_device = inep.read(64, timeout=2000)
    print(f"Received {len(from_device)} bytes")
    print("Device Says: {}".format(''.join([chr(x) for x in from_device])))

except usb.core.USBTimeoutError:
    print("\nTimeout! The device isn't responding.")
except usb.core.USBError as e:
    print(f"USB Error: {e}")
finally:
    # Proper cleanup
    print("\nCleaning up...")
    try:
        # Release interfaces
        usb.util.release_interface(dev, 1)
        usb.util.release_interface(dev, 0)
        
        # Reattach kernel driver if we detached it
        for interface in detached_interfaces:
            try:
                dev.attach_kernel_driver(interface)
                print(f"Kernel driver reattached to interface {interface}")
            except:
                pass
        
        # Dispose of the device object
        usb.util.dispose_resources(dev)
    except:
        pass
    
    print("Done!")
