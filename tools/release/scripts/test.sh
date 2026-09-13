#!/bin/sh

set -eu

cd test/monorepo
../../zig-out/bin/release http://localhost:8000
python3 -m http.server 8000 --directory release-out &
sleep 1

cd ../workbench/a
../../../../zig/build/stage3/bin/zig fetch --save=b http://localhost:8000/0.0.0/b.tar.gz
zig build

# clean up server
jobs -p | xargs kill
