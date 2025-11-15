# issues
- Only supports RP2040
- Sometimes reset stalls when built.  If effected comment out:
    `unreset_block_wait(RESETS_RESET_USBCTRL_BITS);`
   in /.../rp2040_usb.c:rp2040_usb_init as a workaround
# TODO
- How can we move the IRQ functions into ram
- USB Reset hang issue 
- More chips supported