ENTRY(resetHandler)

PROVIDE(__stack_top = ALIGN(ORIGIN(RAM) + LENGTH(RAM) - 8 ,8));

SECTIONS
{

  .boot2 ORIGIN(FLASH) :
  {
    KEEP(*(.boot2));
    . = ALIGN(256);
  } >FLASH

  .isr_vector :
  {
    . = ALIGN(4);
    LONG(__stack_top);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } > FLASH

  .text :
  {
    . = ALIGN(4);
    *(.text*)
    *(.rodata*)
  } > FLASH
  
  .ARM :
  {
      __exidx_start = .;
      *(.ARM.exidx*)
      __exidx_end = .;
  } > FLASH

  .bss : {
    . = ALIGN(4);
    _bss_ram_start = .;
    *(.bss*)
    _bss_ram_stop = .;
    . = ALIGN(4);
  } >RAM

  _data_rom_start = LOADADDR(.data);
  .data : {
    . = ALIGN(4);
    _data_ram_start = .;
    *(.data*)
    _data_ram_stop = .;
    . = ALIGN(4);
  } >RAM AT> FLASH
}
