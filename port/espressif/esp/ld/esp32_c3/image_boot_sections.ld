SECTIONS
{
  .flash_rodata_offset (NOLOAD) :
  {
    /* Skip 0x20 bytes for the esp image format mapping header. */
    . += 0x20;
  } > DROM

  /* Keep name used by esp-idf. This would be the first thing in the image */
  .flash.appdesc : ALIGN(0x10)
  {
    KEEP(*(.app_desc))

    /* Prevent gap between .app_desc and .rodata */
    . = ALIGN(ALIGNOF(.flash.rodata));
  } > DROM

  .flash.rodata : ALIGN(0x10)
  {
    *(.rodata*)
  } > DROM

  /* Dummy section to offset the text section after the rodata section */
  .flash_text_dummy (NOLOAD) :
  {
    . = ALIGN(ALIGNOF(.flash_rodata_offset)) + SIZEOF(.flash_rodata_offset);
    . = ALIGN(ALIGNOF(.flash.appdesc)) + SIZEOF(.flash.appdesc);
    . = ALIGN(ALIGNOF(.flash.rodata)) + SIZEOF(.flash.rodata);

    /* Add alignment of MMU page size + 0x20 bytes for the mapping header. */
    . = ALIGN(0x10000) + 0x20;
  } > IROM

  .flash.text :
  {
    KEEP(*(microzig_flash_start))
    *(.text*)

    /**
     * CPU will try to prefetch up to 16 bytes of of instructions.
     * This means that any configuration (e.g. MMU, PMS) must allow
     * safe access to up to 16 bytes after the last real instruction, add
     * dummy bytes to ensure this
     */
    . += 16;
  } > IROM

  .ram.text :
  {
    KEEP(*(.ram_text))

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
  } > IRAM

  .ram_data_dummy (NOLOAD) :
  {
    . = ALIGN(ALIGNOF(.ram.text)) + SIZEOF(.ram_text);
  } > DRAM

  .data :
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    microzig_data_end = .;
  } > DRAM

  .bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    microzig_bss_end = .;
  } > DRAM

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
