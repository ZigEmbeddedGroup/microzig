SECTIONS {
  .bootmeta :
  {
    __bootmeta_start__ = .;
    KEEP(*(.bootmeta))
    __bootmeta_end__ = .;
  } > ram0
}
INSERT AFTER .ram_start;
