SECTIONS {
  .eh_frame_hdr (INFO) : AT(0)
  {
    *(.eh_frame_hdr)
  }
  .eh_frame (INFO) :
  {
    *(.eh_frame)
  }
}
