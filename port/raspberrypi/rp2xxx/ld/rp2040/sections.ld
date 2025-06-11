SECTIONS
{
  .boot2 : {
    __boot2_start__ = .;
    KEEP (*(.boot2))
    __boot2_end__ = .;
  } > flash0

  ASSERT(__boot2_end__ - __boot2_start__ == 256,
    "ERROR: Pico second stage bootloader must be 256 bytes in size")
}
INSERT BEFORE .flash_start;

SECTIONS {
  .flash1 :
  {
    *(.flash1)
  } > flash1
}
INSERT AFTER .text;
