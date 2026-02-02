SECTIONS {
  .bootmeta :
  {
    __bootmeta_start__ = .;
    KEEP(*(.bootmeta))
    __bootmeta_end__ = .;
  } > FLASH
}
INSERT AFTER .flash_start;

SECTIONS {
  .scratch_x : {
      microzig_scratch_x_start = .;
      *(.scratch_x.*)
      . = ALIGN(4);
      microzig_scratch_x_end = .;
  } > SCRATCH_X AT > FLASH

  .scratch_y : {
      microzig_scratch_y_start = .;
      *(.scratch_y.*)
      . = ALIGN(4);
      microzig_scratch_y_end = .;
  } > SCRATCH_Y AT > FLASH
}
