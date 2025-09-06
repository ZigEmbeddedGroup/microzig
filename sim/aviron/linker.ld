MEMORY
{
    flash (rx) : ORIGIN = 0, LENGTH = 32K
    ram (rw!x) : ORIGIN = 0x800100, LENGTH = 2K
}

SECTIONS
{
    .text :
    {
        KEEP(*(.vectors))

        /* Ensure _start comes first */
        KEEP(*(.text._start))

        *(.text*)
    } > flash

    .data :
    {
        __data_start = .;
        *(.rodata*)
        *(.data*)
        __data_end = .;
    } > ram AT> flash

    .bss (NOLOAD) :
    {
        __bss_start = .;
        *(.bss*)
        __bss_end = .;
    } > ram

    __data_load_start = LOADADDR(.data);
}
