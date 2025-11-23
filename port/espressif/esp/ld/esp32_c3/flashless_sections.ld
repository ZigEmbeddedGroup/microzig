SECTIONS
{
  .ram_text ORIGIN(IRAM) : AT(0)
  {
    microzig_ram_text_start = .;

    KEEP(*(microzig_ram_start))
    *(.text*)
    KEEP(*(.ram_text))

    *(.rwtext*)

    /* wifi rwtext */
    *(.wifi0iram  .wifi0iram.*)
    *(.wifirxiram  .wifirxiram.*)
    *(.wifislprxiram  .wifislprxiram.*)
    *(.wifislpiram  .wifislpiram.*)
    *(.phyiram  .phyiram.*)
    *(.iram1  .iram1.*)
    *(.wifiextrairam.* )
    *(.coexiram.* )
  } > IRAM

  . = ALIGN(8);
  _iram_size = . - microzig_ram_text_start;

  _dram_start = ORIGIN(DRAM) + _iram_size;
  .data _dram_start : AT(_iram_size)
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)

    /* wifi rodata */
    *(.rodata_wlog_*.*)

    /* wifi data */
    *(.dram1 .dram1.*)

    *(.rodata*)
    *(.srodata*)
  } > DRAM

  .bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.bss*)
    *(.sbss*)
    microzig_bss_end = .;
  } > DRAM

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
