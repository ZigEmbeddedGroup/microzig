#!/bin/sh

#
# Prepares a full deployment of MicroZig.
# Creates all packages into /microzig-deploy with the final folder structure.
#

set -euo pipefail

all_files_dir=".data"

# test for all required tools:
which zig date find jq mkdir dirname realpath > /dev/null

[ "$(zig version)" == "0.11.0" ]

repo_root="$(dirname "$(dirname "$(realpath "$0")")")"
[ -d "${repo_root}" ]

echo "preparing environment..."

alias create_package="${repo_root}/tools/create-package.sh"

# Some generic meta information:

unix_timestamp="$(date '+%s')"
iso_timestamp="$(date --iso-8601=seconds)"

# Determine correct version:

git_description="$(git describe --match "*.*.*" --tags --abbrev=9)"
version=""

# render-version <major> <minor> <patch> <counter> <hash>
function render_version()
{
    [ "$#" -eq 5 ] 
    echo "$1.$2.$3-$4-$5"
}

case "${git_description}" in 
    *.*.*-*-*)
        version="$(render_version $(echo "${git_description}" | sed -E 's/^([0-9]+)\.([0-9]+)\.([0-9]+)\-([0-9]+)\-([a-z0-9]+)$/\1 \2 \3 \4 \5/'))"
        ;;

    *.*.*)
        # a "on point" tagged version still has a hash as well as the counter 0!
        version="$(render_version $(echo "${git_description}" | sed -E 's/^([0-9]+)\.([0-9]+)\.([0-9]+)$/\1 \2 \3/') 0 $(git rev-parse --short=9 HEAD))"
        ;;
    
    *)
        echo "Bad result '${git_description}' from git describe." >&2
        exit 1
        ;;
esac

if [ -z "${version}" ]; then
    echo "Could not determine a version. Please verify repository state!" >&2
    exit 1
fi

deploy_target="${repo_root}/microzig-deploy"

[ -d "${deploy_target}" ] && rm -r "${deploy_target}"
mkdir -p "${deploy_target}"

cd "${repo_root}"

# ensure we have our tools available:
zig build tools

[ -x "${repo_root}/zig-out/tools/archive-info" ]
alias archive_info="${repo_root}/zig-out/tools/archive-info"

for dir in $(find -type f -name microzig-package.json -exec dirname '{}' ';'); do
    dir="$(realpath "${dir}")"
    meta_path="$(realpath "${dir}/microzig-package.json")"

    pkg_name="$(jq -r .package_name < "${meta_path}")"
    pkg_type="$(jq -r .package_type < "${meta_path}")"

    (
        cd "${dir}"

        echo "bundling ${dir}..."

        out_dir=""
        out_basename=""

        case "${pkg_type}" in
            core)
                out_dir="${deploy_target}"
                out_basename="${pkg_name}"
                ;;
            
            board-support)
                out_dir="${deploy_target}/board-support/$(dirname "${pkg_name}")"
                out_basename="$(basename "${pkg_name}")"
                ;;

            *)
                echo "Unsupported package type: '${pkg_type}'!" >&2
                exit 1
                ;;
        esac

        [ ! -z "${out_dir}" ] && [ ! -z "${out_basename}" ]

        out_fullname="${out_basename}-${version}.tar.gz"
        out_fullmeta="${out_basename}-${version}.json"

        out_name="${out_basename}.tar.gz"
        out_meta="${out_basename}.json"
        
        out_path="${out_dir}/${all_files_dir}/${out_fullname}"

        mkdir -p "${out_dir}/${all_files_dir}"

        # first, compile package
        create_package "${dir}" "${out_path}"

        # get some required metadata
        file_hash=($(sha256sum "${out_path}" | cut -f 1))
        file_size="$(stat --format="%s" "${out_path}")"

        pkg_info="$(archive_info ${out_path})"

        jq \
            --arg vers "${version}" \
            --arg ts_unix "${unix_timestamp}" \
            --arg ts_iso "${iso_timestamp}" \
            --arg fhash "${file_hash}" \
            --arg fsize "${file_size}" \
            --argjson pkg "${pkg_info}" \
                '. + {
                    version: $vers,
                    created: {
                        unix: $ts_unix,
                        iso: $ts_iso,
                    },
                    archive: {
                        size: $fsize,
                        sha256sum: $fhash,
                    },
                    package: $pkg
                }' \
            "${meta_path}" \
            > "${out_dir}/${all_files_dir}/${out_fullmeta}" \

        (
            cd "${out_dir}"
            ln -s "${all_files_dir}/${out_fullname}" "${out_name}"
            ln -s "${all_files_dir}/${out_fullmeta}" "${out_meta}"
        )

    )
done
