SECTIONS {
  .scratch_x : {
      microzig_scratch_x_start = .;
      *(.scratch_x.*)
      . = ALIGN(4);
      microzig_scratch_x_end = .;
  } > SCRATCH_X AT > FLASH
  microzig_scratch_x_load_start = LOADADDR(.scratch_x);

  .scratch_y : {
      microzig_scratch_y_start = .;
      *(.scratch_y.*)
      . = ALIGN(4);
      microzig_scratch_y_end = .;
  } > SCRATCH_Y AT > FLASH
  microzig_scratch_y_load_start = LOADADDR(.scratch_y);
}
