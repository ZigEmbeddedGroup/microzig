#!/usr/bin/env python3
#
# Hacky auto-patcher to update dependencies in examples.
#
# Receives a **formatted(!)** build.zig.zon that requires ".url" and ".hash" to be written in that order on different lines.
#

import sys
import json
from urllib.parse import urlparse, urlunparse
from urllib.request import urlopen
from pathlib import Path, PurePosixPath
import re 


def main():

    build_zig_zon = Path(sys.argv[1])
    assert build_zig_zon.is_file()

    input_lines = build_zig_zon.read_text().splitlines()

    output_lines = []

    last_pkg_url: urllib.parse.ParseResult = None
    for line in input_lines:

        stripped = line.strip()
        if stripped.startswith(".url = \""):
            
            match = re.match('\s*\.url\s*=\s*"([^"]+)",', line)
            
            urlstr = match.group(1)

            last_pkg_url = urlparse(urlstr)

            output_lines.append(line)

        elif stripped.startswith(".hash = \""):
            try:
                pkg_path = PurePosixPath(last_pkg_url.path)
                assert pkg_path.suffixes[-2:] ==  ['.tar', '.gz']
                pkg_json_url = urlunparse(
                    # scheme, netloc, url, params, query, fragment
                    (
                        last_pkg_url.scheme,  # scheme
                        last_pkg_url.netloc, # netloc
                        pkg_path.with_suffix("").with_suffix(".json").as_posix(), # url
                        last_pkg_url.params, # params
                        last_pkg_url.query, # query
                        last_pkg_url.fragment, # fragment
                    )
                )
                
                metadata = json.loads(urlopen(pkg_json_url).read())

                pkg_hash = metadata["package"]["hash"]

                line_prefix = re.match("^(\s*)", line).group(1)

                print(f"Updating hash of {urlunparse(last_pkg_url)} to {pkg_hash}")

                output_lines.append(f'{line_prefix}.hash = "{pkg_hash}",')
                last_pkg_url = None 
            except AssertionError:
                raise 
            except BaseException as ex:
                print(f"error: {type(ex)} {ex}")
                output_lines.append(line)
        else:
            output_lines.append(line)
    
    build_zig_zon.write_text("\n".join(output_lines))

if __name__ == "__main__":
    main()