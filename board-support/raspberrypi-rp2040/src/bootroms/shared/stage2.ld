/*
 * Target CPU:  ARM Cortex-M0+
 * Target Chip: RP2040
 */

ENTRY(_stage2_boot);

MEMORY
{
  flash0 (rx!w) : ORIGIN = 0x10000000, LENGTH = 0x00200000
  ram0   (rwx) : ORIGIN = 0x20000000, LENGTH = 0x00040000
}

SECTIONS
{
  .text : {
    KEEP (*(.text))
    *(.rodata*)
  } > flash0

  .ARM.exidx : {
      *(.ARM.exidx* .gnu.linkonce.armexidx.*)
  } >flash0


  .data :
  {
     *(.data*)
      *(.bss*)
  } > ram0 /* AT> flash0 */
}
