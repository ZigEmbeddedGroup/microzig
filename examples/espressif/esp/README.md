# Examples for the Port `espressif-esp`

- [Blinky](src/blinky.zig) on [ESP32-C3-32S-Kit](https://www.waveshare.com/wiki/ESP-C3-32S-Kit)
  Showcases how to do a simple RGB cycling.

## How to flash the image onto the device

- esp image

```sh
esptool --chip esp32c3 -b 460800 --before default_reset --after hard_reset write_flash \
        0x0 bootloader.bin 0x8000 partition_table.bin 0x10000 zig-out/firmware/esp32_c3_blinky.bin
```
NOTE: you have to provide a [bootloader](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c3/api-guides/bootloader.html) and a [partition table](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c3/api-guides/partition-tables.html).

- direct boot image

```sh
esptool.py --chip esp32c3 -b 460800 --before default_reset --after hard_reset write_flash 0x0 zig-out/firmware/esp32_c3_direct_boot_blinky.bin
```
