SECTIONS
{
  .flash_start :
  {
    KEEP(*(microzig_flash_start))
  } > flash0

  .text :
  {
    *(.text*)
    *(.srodata*)
    *(.rodata*)
  } > flash0

  .data :
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    KEEP(*(.ram_text))
    microzig_data_end = .;
  } > ram0 AT> flash0

  .bss (NOLOAD):
  {
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    microzig_bss_end = .;
  } > ram0

  .heap (NOLOAD) :
  {
      microzig_heap_start = .;
      . = ORIGIN(ram0) + LENGTH(ram0);
      microzig_heap_end   = .;
  } > ram0

  .isr_vector :
  {
    KEEP(*(.isr_vector*))
  } > isr_vector

  .flash_end :
  {
    microzig_flash_end = .;
  } > flash0

  microzig_data_load_start = LOADADDR(.data);
}
