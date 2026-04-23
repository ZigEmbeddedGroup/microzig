# Nordic nrf5x

HALs and register definitions for nrf5x devices

## SoftDevice integration

The nRF5x port now exposes SoftDevice-aware targets under `mb.ports.nrf5x.softdevice`.

Available profiles:

- `s132` for nRF52832
- `s140` for nRF52833, nRF52840

SoftDevice binaries are sourced from the official Nordic nRF5 SDK v17.1.0
package via Zig package manager.

Example target names:

- `mb.ports.nrf5x.softdevice.boards.nordic.pca10040_s132`
- `mb.ports.nrf5x.softdevice.boards.nordic.nrf52840_dongle_s140`
- `mb.ports.nrf5x.softdevice.boards.nordic.nrf52840_mdk_s140`
- `mb.ports.nrf5x.softdevice.boards.bbc.microbit_v2_s140`

You can merge app HEX + SoftDevice HEX with:

- `mb.ports.nrf5x.merge_hex(app_hex, softdevice_hex, "output.hex")`

## Renode supports:

- nrf52840 development kit
