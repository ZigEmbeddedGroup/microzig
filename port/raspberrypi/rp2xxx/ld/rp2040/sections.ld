SECTIONS
{
  .boot2 : {
    __boot2_start__ = .;
    KEEP (*(.boot2))
    __boot2_end__ = .;
  } > FLASH

  ASSERT(__boot2_end__ - __boot2_start__ == 256,
    "ERROR: Pico second stage bootloader must be 256 bytes in size")
}
INSERT BEFORE .flash_start;

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
