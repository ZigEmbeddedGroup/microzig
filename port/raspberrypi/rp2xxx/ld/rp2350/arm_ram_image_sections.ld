SECTIONS
{
  /DISCARD/ :
  {
    *(.entry)
  }

  .flash_start :
  {
    KEEP(*(microzig_flash_start))
  } > ram0

  .bootmeta :
  {
    __bootmeta_start__ = .;
    KEEP(*(.bootmeta))
    __bootmeta_end__ = .;
  } > ram0

  .text :
  {
     *(.text*)
     KEEP(*(.ram_text))
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
