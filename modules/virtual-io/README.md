# Virtual Io interface for Zig
A Zig Io implemention that keeps the directory structure and file contents in ram.
- All Io operations that would touch the disk go into ram, backed by a hash map
- Everything else fails
