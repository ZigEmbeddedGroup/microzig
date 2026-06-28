# Nordic nrf5x

HALs and register definitions for nrf5x devices

## SoftDevice examples

- `pca10040_softdevice_preflashed_blinky`:
  app-only build for a target with SoftDevice-shifted flash/RAM. Use this when
  SoftDevice is already flashed on the chip.
- `nrf52840_mdk_softdevice_merged_blinky`:
  emits both app artifacts and a merged Intel HEX that includes the app image
  and `s140` SoftDevice image.
- `nrf52840_dongle_softdevice_merged_blinky`:
  same merged approach for the nRF52840 Dongle with `s140`.

Build one SoftDevice example:

```sh
zig build -Dexample=nrf52840_mdk_softdevice_merged_blinky
```

## Renode supports:

- nrf52840 development kit
