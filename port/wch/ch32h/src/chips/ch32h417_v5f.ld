SECTIONS
{
  .flash_start :
  {
    KEEP(*(microzig_flash_start))
  } > FLASH

  .init :
  {
    KEEP(*(.init))
    . = ALIGN(4);
  } > FLASH

  .cache : ALIGN(4)
  {
    _cache_beg = .;
    KEEP(*(.cache))
    KEEP(*(.cache.*))
    . = ALIGN(4);
    _cache_end = .;
  } > FLASH

  .text : ALIGN(4)
  {
    microzig_text_start = .;
    *(.text*)
    *(.ram_text*)
    . = ALIGN(4);
    microzig_text_end = .;
  } > ITCM AT> FLASH
  microzig_text_load_start = LOADADDR(.text);

  .data : ALIGN(4)
  {
    . = ALIGN(4);
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    *(.srodata*)
    *(.rodata*)
    . = ALIGN(4);
    microzig_data_end = .;
  } > DTCM AT> FLASH
  microzig_data_load_start = LOADADDR(.data);

  .bss (NOLOAD) :
  {
    . = ALIGN(4);
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    *(.gnu.linkonce.b.*)
    . = ALIGN(4);
    microzig_bss_end = .;
  } > DTCM

  .heap (NOLOAD) :
  {
    microzig_heap_start = .;
    . = ORIGIN(DTCM) + LENGTH(DTCM);
    microzig_heap_end = .;
  } > DTCM

  .flash_end :
  {
    microzig_flash_end = .;
  } > FLASH

  /DISCARD/ :
  {
    *(.eh_frame*)
  }

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
