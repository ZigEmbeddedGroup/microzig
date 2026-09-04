/**
 * The Raspberry Pi firmware reads kernel8.img off the boot partition, copies it to 0x80000 and
 * jumps to its first byte, so this is a plain ram image with the entry point at the front.
 */
ENTRY(_start)

SECTIONS
{
  .text :
  {
    KEEP(*(microzig_ram_start))
    *(.text*)
    . = ALIGN(16);
  } > RAM

  .rodata : ALIGN(16)
  {
    *(.rodata*)
    *(.srodata*)
  } > RAM

  .data : ALIGN(16)
  {
    microzig_data_start = .;
    *(.data*)
    *(.sdata*)
    /* Place the global offset table here explicitly. Left as an orphan the linker puts it past
       the heap, at the very end of the region, and the flat image then spans all of ram. */
    *(.got)
    *(.got.plt)
    . = ALIGN(16);
    microzig_data_end = .;
  } > RAM

  .bss (NOLOAD) : ALIGN(16)
  {
    microzig_bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(COMMON)
    . = ALIGN(16);
    microzig_bss_end = .;
  } > RAM

  /* The stack grows down from the end of the region. `_start` points sp at
     __microzig_end_of_stack, keep the heap clear of it. */
  __microzig_stack_size = 0x10000;
  __microzig_end_of_stack = ORIGIN(RAM) + LENGTH(RAM);

  .heap (NOLOAD) : ALIGN(16)
  {
    microzig_heap_start = .;
    . = ORIGIN(RAM) + LENGTH(RAM) - __microzig_stack_size;
    microzig_heap_end = .;
  } > RAM

  /DISCARD/ :
  {
    *(.comment)
    *(.note*)
  }
}
