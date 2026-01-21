SECTIONS
{
  .flash_text_offset (NOLOAD) :
  {
    /* Skip 0x20 bytes for the esp image format mapping header. */
    . += 0x20;
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

  /* Dummy section to offset the rodata section after the text section */
  .flash_rodata_dummy (NOLOAD) :
  {
    . = ALIGN(ALIGNOF(.flash_text_offset)) + SIZEOF(.flash_text_offset);
    . = ALIGN(ALIGNOF(.flash.text)) + SIZEOF(.flash.text);

    /* Add alignment of MMU page size + 0x20 bytes for the mapping header. */
    . = ALIGN(0x10000) + 0x20;
  } > DROM

  /* Keep section name used by esp-idf. This would be the first thing in the image */
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

  .ram.text :
  {
    KEEP(*(.ram_text))

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
  } > IRAM

  .ram_data_dummy (NOLOAD) :
  {
    . = ALIGN(ALIGNOF(.ram.text)) + SIZEOF(.ram.text);
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

  /DISCARD/ :
  {
    *(.eh_frame_hdr)
    *(.eh_frame)
  }
}
