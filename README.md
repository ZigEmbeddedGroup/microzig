# MicroZig

## Overview

- `core/` contains the shared components of MicroZig.
- `board-support/` contains all official board support package.
- `examples/` contains examples that can be used with the board support packages.
- `tools/` contains tooling to work *on* MicroZig.

## Versioning Scheme

MicroZig versions are tightly locked with Zig versions.

The general scheme is `${zig_version}-${commit}-${count}`, so the MicroZig versions will look really similar to
Zigs versions, but with our own commit abbreviations and counters.

As MicroZig sticks to tagged Zig releases, `${zig_version}` will show to which Zig version the MicroZig build is compatible.

Consider the version `0.11.0-abcdef-123` means that this MicroZig version has a commit starting with `abcdef`, which was the 123rd commit of the version that is compatible with Zig 0.11.0.
