MEMORY
{
  flash (rx!w) : ORIGIN = 0x00000000, LENGTH = 512k
  ram0  (rw!x) : ORIGIN = 0x10000000, LENGTH = 32k
  ram1  (rw!x) : ORIGIN = 0x2007C000, LENGTH = 32k
}
SECTIONS
{
    . = 0;
    /* Code-Speicher im Flash ***********/
    .text :
    {
        __code_start__ = .;

        LONG( ORIGIN(ram1) + LENGTH(ram1) ) 
        KEEP(*( .isr_vector ));

        *(.text)
        *(.text.*)

        . = ALIGN(4);
        __code_end__ = .;

        *(.gnu.linkonce.t.*)
        *(.glue_7)
        *(.glue_7t)
        *(.gcc_except_table)
        *(.gnu.linkonce.r.*)

    } >flash

    . = ALIGN(4);

    /* contains unwinding information */
    .ARM.exidx : {
        . = ALIGN(4);
        __exidx_start = .;
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
        __exidx_end = .;
        . = ALIGN(4);
    } >flash

    . = ALIGN(4);

    /* Konstanten im Flash ****************/
    .rodata . :
    {
        . = ALIGN(4);
        *(.rodata)
        . = ALIGN(4);   
        *(.rodata.*)
    } >flash

    . = ALIGN(4);

    PROVIDE (__text__end = .);

    .data : AT (__text__end)
    {
        PROVIDE (__data__start = .);
        *(.data)
        *(.data.*)
        *(.gnu.linkonce.d*)
        PROVIDE (__data__end = .);
    } >ram0

   .bss :
    {
      PROVIDE (__bss__start = .);
      *(.bss)
      *(.bss.*)
      *(.gnu.linkonce.b*)
      . = ALIGN(4);
      PROVIDE (__bss__end = .);
    } >ram0

    _end = .;
    PROVIDE (end = .);
}