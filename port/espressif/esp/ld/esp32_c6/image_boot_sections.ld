/**
 * The esp32c6 shares one address space between the instruction and the data view of both the
 * flash and the sram: IROM and DROM both start at 0x42000000, IRAM and DRAM both at 0x40800000.
 *
 * The esp32c3 script offsets one view against the other with dummy sections, which would overlap
 * here. Instead everything is placed through a single region so that its location counter walks
 * over the sections in order.
 *
 * The rodata comes first so that the app descriptor, which the bootloader and espflash expect at
 * the very start of the first mapped segment, ends up there. The text is then pushed onto the
 * next mmu page so that it is mapped as a segment of its own.
 */
SECTIONS
{
  .flash_rodata_offset (NOLOAD) :
  {
    /* Skip 0x20 bytes for the esp image format mapping header. */
    . += 0x20;
  } > IROM

  /* Keep section name used by esp-idf. This would be the first thing in the image */
  .flash.appdesc : ALIGN(0x10)
  {
    KEEP(*(.app_desc))

    /* Prevent gap between .app_desc and .rodata */
    . = ALIGN(ALIGNOF(.flash.rodata));
  } > IROM

  .flash.rodata : ALIGN(0x10)
  {
    *(.rodata*)
    *(.srodata*)

    . = ALIGN(ALIGNOF(.flash.rodata.wifi));
  } > IROM

  .flash.rodata.wifi : ALIGN(0x10)
  {
    *(.rodata_wlog_*.*)
  } > IROM

  /* Align to the mmu page size and skip another mapping header, this time for the text segment.
   * Anything the linker placed on its own in between, .eh_frame for example, stays part of the
   * rodata segment. */
  .flash_text_offset (NOLOAD) : ALIGN(0x10000)
  {
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

  .ram.text :
  {
    . = ALIGN(16);
    KEEP(*(.ram_text))
    KEEP(*(.ram_vectors))

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
  } > IRAM

  .ram.text.wifi :
  {
    . = ALIGN(16);
    *( .wifi0iram  .wifi0iram.*)
    *( .wifirxiram  .wifirxiram.*)
    *( .wifislprxiram  .wifislprxiram.*)
    *( .wifislpiram  .wifislpiram.*)
    *( .phyiram  .phyiram.*)
    *( .iram1  .iram1.*)
    *( .wifiextrairam.* )
    *( .coexiram.* )
  } > IRAM

  .data :
  {
    . = ALIGN(16);
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    . = ALIGN(16);
    microzig_data_end = .;
  } > IRAM

  .data.wifi :
  {
    . = ALIGN(16);
    *(.dram1*)
  } > IRAM

  .bss (NOLOAD) :
  {
    . = ALIGN(16);
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    . = ALIGN(16);
    microzig_bss_end = .;
  } > IRAM

  .heap (NOLOAD) :
  {
    microzig_heap_start = .;
    . = ORIGIN(IRAM) + LENGTH(IRAM);
    microzig_heap_end   = .;
  } > IRAM

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
