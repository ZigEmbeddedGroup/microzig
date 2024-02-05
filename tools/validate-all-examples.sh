#!/bin/sh

set -e 

root="$(dirname "$(realpath "$0")")"
tmpdir="/tmp/microzig-test"

mkdir -p "${tmpdir}"

"${root}/validate-example.py" --build-root "${tmpdir}" --example raspberrypi/rp2040
"${root}/validate-example.py" --build-root "${tmpdir}" --example stmicro/stm32
