#!/usr/bin/env sh

sed -i 's/write-read/read-write/g' *.svd
sed -i 's/read-only_write-only/read-write/g' *.svd
