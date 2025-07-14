SECTIONS
{
  .rodata.skip (NOLOAD) :
  {
    /* Skip 0x20 bytes for the esp image format mapping header. */
    . += 0x20;
  } > DROM

  .rodata : ALIGN(4)
  {
    . = ALIGN(4);
    KEEP(*(.app_desc))
    *(.rodata*)
    *(.srodata*)
    . = ALIGN(4);
  } > DROM

  .rodata.wifi : ALIGN(4)
  {
    . = ALIGN(4);
    *(.rodata_wlog_*.*)
    . = ALIGN(4);
  } > DROM

  .text.dummy (NOLOAD) : ALIGN(4)
  {
    . = ALIGN(ALIGNOF(.rodata));
    . = ALIGN(ALIGNOF(.rodata.wifi));

    . = . + SIZEOF(.rodata.skip);
    . = . + SIZEOF(.rodata);
    . = . + SIZEOF(.rodata.wifi);

    . = ALIGN(0x10000) + 0x20;
  } > IROM

  .text :
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

  .ram_text : ALIGN(4)
  {
    . = ALIGN(4);
    KEEP(*(.ram_text))
    . = ALIGN(4);

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
  } > IRAM

  .ram_text.wifi : ALIGN(4)
  {
    . = ALIGN(4);
    *( .wifi0iram  .wifi0iram.*)
    *( .wifirxiram  .wifirxiram.*)
    *( .wifislprxiram  .wifislprxiram.*)
    *( .wifislpiram  .wifislpiram.*)
    *( .phyiram  .phyiram.*)
    *( .iram1  .iram1.*)
    *( .wifiextrairam.* )
    *( .coexiram.* )
    . = ALIGN(4);
  } > IRAM

  .data.dummy (NOLOAD) : ALIGN(4)
  {
    . = . + SIZEOF(.ram_text) + SIZEOF(.ram_text.wifi);
  } > DRAM

  .data : ALIGN(4)
  {
    microzig_data_start = .;
    . = ALIGN (4);

    *(.sdata*)
    *(.data*)

    microzig_data_end = .;
    . = ALIGN (4);
  } > DRAM

  .data.wifi : ALIGN(4)
  {
    . = ALIGN (4);
    *(.dram1*)
    . = ALIGN (4);
  }

  .bss (NOLOAD) : ALIGN (4)
  {
    microzig_bss_start = .;
    . = ALIGN (4);

    *(.sbss*)
    *(.bss*)

    microzig_bss_end = .;
    . = ALIGN (4);
  } > DRAM

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
