# WiFi firmware blobs

Firmware sources:

[Source 1 - Infineon](https://github.com/Infineon/wifi-host-driver/tree/master/WHD/COMPONENT_WIFI5/resources/firmware/COMPONENT_43439)

[Source 2 - Embassy](https://github.com/embassy-rs/embassy/tree/main/cyw43-firmware)

[Source 3 - georgerobotics](https://github.com/georgerobotics/cyw43-driver/tree/main/firmware)

Licensed under the [Infineon Permissive Binary License](./LICENSE-permissive-binary-license-1.0.txt)

## Changelog

* 2025-04-23: Firmware 7.95.88 (cf1d613 CY) obtained from Infineon GitHub repo
* 2025-04-23: Firmware 7.95.61 (abcd531 CY) obtained from Embassy GitHub repo

## Notes
* Firmware version is determined by chip logs after boot sequence. For example:

  [1.035957] debug (cyw43_chip): 000000.055 wl0: Broadcom BCM43439 802.11 Wireless Controller 7.95.61 (abcd531 CY)

* The Pico SDK and Embassy use a slightly older version of the CYW-43439 firmware. For development purposes, please use the older version to match the Embassy driver code, which is used as a reference.