/* TODO: put `rodata` in rom and `microzig_time_critical` in ram */
SECTIONS
{
  .text :
  {
    KEEP(*(microzig_flash_start))
    *(.text*)
    KEEP(*(microzig_time_critical))
  } > flash0

  .data :
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    *(.rodata*)
    microzig_data_end = .;
  } > ram0 AT> flash0

  .bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.bss*)
    *(.sbss*)
    microzig_bss_end = .;
  } > ram0

  .flash_end :
  {
    PROVIDE(microzig_flash_end = .);
  } > flash0

  microzig_data_load_start = LOADADDR(.data);
  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
