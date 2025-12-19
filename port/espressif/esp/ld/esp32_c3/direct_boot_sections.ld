SECTIONS
{
  .text ORIGIN(IROM) : AT(0)
  {
    _irom_start = .;
    KEEP(*(microzig_flash_start))
    *(.text*)
  } > IROM

  . = ALIGN(8);

  _irom_size = . - _irom_start;

  _drom_start = ORIGIN(DROM) + _irom_size;
  .rodata _drom_start : AT(_irom_size)
  {
    *(.rodata*)
  } > DROM

  _drom_size = . - _drom_start;

  .ram_text ORIGIN(IRAM) : AT(_irom_size + _drom_size)
  {
    microzig_ram_text_start = .;
    KEEP(*(.ram_text))
    microzig_ram_text_end = .;
  } > IRAM

  . = ALIGN(4);
  _iram_size = . - microzig_ram_text_start;

  _dram_start = ORIGIN(DRAM) + _iram_size;
  .data _dram_start : AT(_irom_size + _drom_size + _iram_size)
  {
    /* put microzig_data_start right before .ram_text */
    microzig_data_start = . - _iram_size;
    *(.sdata*)
    *(.data*)
    microzig_data_end = .;
  } > DRAM

  .bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.bss*)
    *(.sbss*)
    microzig_bss_end = .;
  } > DRAM

  microzig_data_load_start = ORIGIN(DROM) + _irom_size + _drom_size;
  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
