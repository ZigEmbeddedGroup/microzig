#!/bin/sh

set -euo pipefail

# test for all required tools:
which tar gzip jq basename dirname realpath > /dev/null

if [ "$#" -ne 2 ]; then 
    echo "usage: $(basename "$0") <folder> <output tar ball>" >&2
    exit 1
fi

input_folder="$(realpath "$1")"
output_file="$(realpath "$2")"

if [ ! -d "${input_folder}" ]; then 
    echo "${input_folder} does not exist or is not a directory!" >&2
    exit 1
fi


if [ ! -f "${input_folder}/microzig-package.json" ]; then 
    echo "The input folder does not contain a microzig-package.json!" >&2
    exit 1
fi 

if [ -e "${output_file}" ]; then 
    echo "${output_file} already exists, please delete first!" >&2
    exit 1
fi 

if [ ! -d "$(dirname "${output_file}")" ]; then 
    echo "${output_file} does not point to a path where a file can be created!" >&2
    exit 1
fi 

(
    cd "${input_folder}"
    # explanation on ls-files: 
    # https://stackoverflow.com/a/53083343
    tar -caf "${output_file}" $(git ls-files -- . ':!:microzig-package.json')
)

# echo "included files:"
# tar -tf "${output_file}"
