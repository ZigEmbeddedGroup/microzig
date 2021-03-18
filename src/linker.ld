MEMORY
{
  flash    (rx)   : ORIGIN = 0x0001F000, LENGTH = 1024k - 0x1F000
  data_ram (rw!x) : ORIGIN = 0x20000000, LENGTH = 128k
  code_ram (rwx)  : ORIGIN = 0x00800000, LENGTH = 128k
}

SECTIONS
{
    . = 0;
    /* Code-Speicher im Flash ***********/
    .text :
    {
        __code_start__ = .;

        LONG( ORIGIN(data_ram) + LENGTH(data_ram) )
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
    } >data_ram

   .bss :
    {
      PROVIDE (__bss__start = .);
      *(.bss)
      *(.bss.*)
      *(.gnu.linkonce.b*)
      . = ALIGN(4);
      PROVIDE (__bss__end = .);
    } >data_ram

    _end = .;
    PROVIDE (end = .);
}
