SECTIONS {
  .bootmeta :
  {
    __bootmeta_start__ = .;
    KEEP(*(.bootmeta))
    __bootmeta_end__ = .;
  } > flash0
}
INSERT AFTER .flash_start;
