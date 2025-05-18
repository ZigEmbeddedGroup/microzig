ENTRY(_start);

MEMORY
{
    irom (rx) : ORIGIN = 0x42000020, LENGTH = 0x800000 - 0x20
    drom (r) : ORIGIN = 0x3C000020, LENGTH = 0x800000 - 0x20

    /* Offset by ICache size which is fixed to 16KB on ESP32-C3 */
    iram (rwx) : ORIGIN = 0x4037C000 + 0x4000, LENGTH = 313K
    dram (rw) : ORIGIN = 0x3FC7C000 + 0x4000, LENGTH = 313K
}

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
    } > irom

    .drom.dummy (NOLOAD) :
    {
        . = ORIGIN(drom) + (microzig_text_end - microzig_text_start);

        /* Add alignment of MMU page size + 0x20 bytes for the mapping header. */
        . = ALIGN(0x10000) + 0x20;
    } > drom

    .drom.rodata :
    {
        microzig_rodata_start = .;

        KEEP(*(.app_desc))
        *(.rodata*)

        microzig_rodata_end = .;
    } > drom

    .iram.text :
    {
        microzig_rwtext_start = .;

        KEEP(*(.trap))
        *(.rwtext*)

        microzig_rwtext_end = .;

        /* TODO: in the case of memory protection there should be some alignment
         * and offset done here (NOLOAD) */
    } > iram

    .dram.dummy (NOLOAD) :
    {
        . = ORIGIN(dram) + (microzig_rwtext_end - microzig_rwtext_start);
    } > dram

    .dram.data :
    {
        microzig_data_start = .;
        *(.sdata*)
        *(.data*)
        microzig_data_end = .;
    } > dram

    .dram.bss (NOLOAD) :
    {
        microzig_bss_start = .;
        *(.bss*)
        *(.sbss*)
        microzig_bss_end = .;
    } > dram

    PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
