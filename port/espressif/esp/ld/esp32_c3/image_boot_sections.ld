SECTIONS
{
  .irom.text :
  {
    microzig_text_start = .;

    KEEP(*(microzig_flash_start))
    *(.text*)

    microzig_text_end = .;

    /**
     * CPU will try to prefetch up to 16 bytes of of instructions.
     * This means that any configuration (e.g. MMU, PMS) must allow
     * safe access to up to 16 bytes after the last real instruction, add
     * dummy bytes to ensure this
     */
    . += 16;
  } > flash0

  .drom.dummy (NOLOAD) :
  {
    . = ORIGIN(data_flash) + (microzig_text_end - microzig_text_start);

    /* Add alignment of MMU page size + 0x20 bytes for the mapping header. */
    . = ALIGN(0x10000) + 0x20;
  } > data_flash

  .drom.rodata :
  {
    microzig_rodata_start = .;

    KEEP(*(.app_desc))
    *(.rodata*)

    microzig_rodata_end = .;
  } > data_flash

  .iram.text :
  {
    microzig_iram_text_start = .;

    KEEP(*(microzig_time_critical))

    microzig_iram_text_end = .;

    /* TODO: in the case of memory protection there should be some alignment
     * and offset done here (NOLOAD) */
  } > instruction_ram

  .dram.dummy (NOLOAD) :
  {
    . = ORIGIN(ram0) + (microzig_iram_text_end - microzig_iram_text_start);
  } > ram0

  .dram.data :
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    microzig_data_end = .;
  } > ram0

  .dram.bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.bss*)
    *(.sbss*)
    microzig_bss_end = .;
  } > ram0

  PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
