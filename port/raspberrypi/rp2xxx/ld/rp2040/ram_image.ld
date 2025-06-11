/*
 * Target CPU:  ARM Cortex-M0+
 * Target Chip: RP2040
 */

MEMORY
{
  entry  (rwx) : ORIGIN = 0x20000000, LENGTH = 0x00000100
  ram0   (rwx) : ORIGIN = 0x20000100, LENGTH = 0x0003ff00
}

SECTIONS
{
  .entry :
  {
     KEEP(*(.entry))
  } > entry

  .text :
  {
     KEEP(*(microzig_flash_start))
     *(.text*)
     *(.rodata*)
  } > ram0

  .ARM.extab : {
      *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > ram0

  .ARM.exidx : {
      *(.ARM.exidx* .gnu.linkonce.armexidx.*)
  } > ram0

  .data :
  {
     *(.data*)
  } > ram0

  .bss :
  {
      *(.bss*)
  } > ram0

  /* Unused, but set as extern in startup_logic */
  microzig_data_start = .;
  microzig_data_end = .;
  microzig_bss_start = .;
  microzig_bss_end = .;
  microzig_data_load_start = .;
}
