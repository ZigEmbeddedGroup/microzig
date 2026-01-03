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
    *(.srodata*)

    . = ALIGN(ALIGNOF(.flash.rodata.wifi));
  } > DROM

  .flash.rodata.wifi : ALIGN(0x10)
  {
    *(.rodata_wlog_*.*)
  } > DROM

  .ram.text :
  {
    KEEP(*(.ram_text))
    KEEP(*(.ram_vectors))

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
  } > IRAM

  .ram.text.wifi :
  {
    *( .wifi0iram  .wifi0iram.*)
    *( .wifirxiram  .wifirxiram.*)
    *( .wifislprxiram  .wifislprxiram.*)
    *( .wifislpiram  .wifislpiram.*)
    *( .phyiram  .phyiram.*)
    *( .iram1  .iram1.*)
    *( .wifiextrairam.* )
    *( .coexiram.* )
  } > IRAM

  .ram_data_dummy (NOLOAD) :
  {
    . = ALIGN(ALIGNOF(.ram.text)) + SIZEOF(.ram.text);
    . = ALIGN(ALIGNOF(.ram.text.wifi)) + SIZEOF(.ram.text.wifi);
  } > DRAM

  .data :
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    microzig_data_end = .;
  } > DRAM

  .data.wifi :
  {
    *(.dram1*)
  } > DRAM

  .bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    microzig_bss_end = .;
  } > DRAM

  .tbss (NOLOAD) :
  {
    *(.tbss*)
  }

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
