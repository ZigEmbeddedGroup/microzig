SECTIONS {
  .bootmeta :
  {
    __bootmeta_start__ = .;
    KEEP(*(.bootmeta))
    __bootmeta_end__ = .;
  } > flash0

  .vectors :
  {
    KEEP(*(core_vectors))
    KEEP(*(flash_vectors))
  } > flash0
}
INSERT AFTER .flash_start;

SECTIONS {
  .ram_vectors (NOLOAD)  :
  {
    KEEP(*(ram_vectors))
  } > ram0
}
INSERT AFTER .bss;
