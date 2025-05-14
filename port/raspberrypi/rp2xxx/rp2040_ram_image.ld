/*
 * Target CPU:  ARM Cortex-M0+
 * Target Chip: RP2040
 */

ENTRY(_entry_point);

MEMORY
{
  entry  (rwx) : ORIGIN = 0x20000000, LENGTH = 0x00000100
  ram0   (rwx) : ORIGIN = 0x20000100, LENGTH = 0x0003ff00
}

SECTIONS
{
  .entry :
  {
     KEEP(*(.entry))
  } > entry

  .text :
  {
     KEEP(*(.isr_vector))
     *(.text*)
     *(.rodata*)
  } > ram0

  .ARM.extab : {
      *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > ram0

  .ARM.exidx : {
      *(.ARM.exidx* .gnu.linkonce.armexidx.*)
  } > ram0

  .data :
  {
     microzig_data_start = .;
     KEEP(*(.time_critical*))
     *(.data*)
     microzig_data_end = .;
  } > ram0

  .bss :
  {
      microzig_bss_start = .;
      *(.bss*)
      microzig_bss_end = .;
  } > ram0

  .ram_vectors (NOLOAD) :
  {
    KEEP(*(ram_vectors))
  } > ram0

  /* Would not be used */
  microzig_data_load_start = LOADADDR(.data);
}
