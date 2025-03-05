# boxzer: a Zig and C/C++ package builder and analyzer

This tool is for generating small tarballs for large Zig monorepos.

The other usecase for this tool is for out-of-source build.zig packaging for
C/C++ libraries. Ideally one would have the C library as a git submodule, but
submodules are not included in GitHub's archive API so people tend to fork
these libraries and add a `build.zig` to get the archive API for free. There are
ups and downs to either direction, and this tool tries to level the convenience
by bundling the submodule source for you.
