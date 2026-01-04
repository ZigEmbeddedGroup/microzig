SECTIONS
{
  .isr_vector :
  {
    KEEP(*(.isr_vector*))
  } > isr_vector
}
INSERT BEFORE .flash_end;
