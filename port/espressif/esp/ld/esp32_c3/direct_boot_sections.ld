SECTIONS
{
  .text ORIGIN(IROM) : AT(0)
  {
    _irom_start = .;
    KEEP(*(microzig_flash_start))
    *(.text*)

    . = ALIGN(8);
  } > IROM

  _irom_size = . - _irom_start;

  _drom_start = ORIGIN(DROM) + _irom_size;
  .rodata _drom_start : AT(_irom_size)
  {
    *(.rodata*)
    *(.srodata*)

    /* wifi rodata */
    *(.rodata_wlog_*.*)
  } > DROM

  _drom_size = . - _drom_start;

  .ram_text ORIGIN(IRAM) : AT(_irom_size + _drom_size)
  {
    . = ALIGN(16);
    microzig_ram_text_start = .;
    KEEP(*(.ram_text))
    KEEP(*(.ram_vectors))

    . = ALIGN(16);
    /* wifi rwtext */
    *(.wifi0iram  .wifi0iram.*)
    *(.wifirxiram  .wifirxiram.*)
    *(.wifislprxiram  .wifislprxiram.*)
    *(.wifislpiram  .wifislpiram.*)
    *(.phyiram  .phyiram.*)
    *(.iram1  .iram1.*)
    *(.wifiextrairam.* )
    *(.coexiram.* )

    . = ALIGN(16);
    microzig_ram_text_end = .;
  } > IRAM

  . = ALIGN(16);
  _iram_size = . - microzig_ram_text_start;

  _dram_start = ORIGIN(DRAM) + _iram_size;
  .data _dram_start : AT(_irom_size + _drom_size + _iram_size)
  {
    . = ALIGN(16);
    /* put microzig_data_start right before .ram_text */
    microzig_data_start = . - _iram_size;
    *(.sdata*)
    *(.data*)

    /* wifi data */
    *(.dram1*)

    . = ALIGN(16);
    microzig_data_end = .;
  } > DRAM

  .bss (NOLOAD) :
  {
    . = ALIGN(16);
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    . = ALIGN(16);
    microzig_bss_end = .;
  } > DRAM

  .heap (NOLOAD) :
  {
    microzig_heap_start = .;
    . = ORIGIN(DRAM) + LENGTH(DRAM);
    microzig_heap_end   = .;
  } > DRAM

  microzig_data_load_start = ORIGIN(DROM) + _irom_size + _drom_size;
  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);

  /DISCARD/ :
  {
    *(.eh_frame_hdr)
    *(.eh_frame)
  }
}
