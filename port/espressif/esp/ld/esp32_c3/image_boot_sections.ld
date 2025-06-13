SECTIONS
{
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

  .drom.dummy (NOLOAD) :
  {
    . = ORIGIN(DROM) + SIZEOF(.text);

    /* Add alignment of MMU page size + 0x20 bytes for the mapping header. */
    . = ALIGN(0x10000) + 0x20;
  } > DROM

  .drom.rodata :
  {
    KEEP(*(.app_desc))
    *(.rodata*)
  } > DROM

  .rwtext :
  {
    KEEP(*(microzig_time_critical))

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
  } > IRAM

  .dram.dummy (NOLOAD) :
  {
    . = ORIGIN(DRAM) + SIZEOF(.rwtext);
  } > DRAM

  .dram.data :
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    microzig_data_end = .;
  } > DRAM

  .dram.bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    microzig_bss_end = .;
  } > DRAM

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
