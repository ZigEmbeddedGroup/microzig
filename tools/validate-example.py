#!/usr/bin/env python3


from lib.common import execute_raw, execute, slurp, check_zig_version, check_required_tools
from pathlib import Path, PurePosixPath
import argparse
import sys 
import shutil

REQUIRED_TOOLS = ["zig", "curl", "tar", "gunzip"]


def main():

    check_required_tools(REQUIRED_TOOLS)

    check_zig_version("0.11.0")

    parser = argparse.ArgumentParser()

    parser.add_argument("--example", type=PurePosixPath, required=True)
    parser.add_argument("--build-root", type=Path, required=True)
    args = parser.parse_args()

    example_id: PurePosixPath = args.example 
    build_root: Path = args.build_root

    if len(example_id.parents) != 2 or str(example_id.parents[1]) != ".":
        print(f"example must be <group>/<id>", file=sys.stderr)
        exit(1)


    example_group: str = example_id.parent.name
    example_name: str = example_id.name

    if not build_root.is_dir():
        print(f"{build_root} is not a directory", file=sys.stderr)
        exit(1)

    execute(
        "curl",
        "-o",
        f"{example_name}.tar.gz",
        f"https://public.devspace.random-projects.net/examples/{example_group}/{example_name}.tar.gz",
        cwd=build_root,
    )

    any_path = slurp(
        "tar",
        "-tf",
        f"{example_name}.tar.gz",
        cwd=build_root,
    ).splitlines()[0].decode()

    root_folder_name = any_path.split(sep='/')[0]

    example_build_root = build_root / root_folder_name

    if example_build_root.exists():
        shutil.rmtree(example_build_root)

    execute(
        "tar",
        "-xf",
        f"{example_name}.tar.gz",
        cwd=build_root,
    )

    execute(
        "zig",
        "build",
        cwd = example_build_root,
    )

    out_dir = example_build_root / "zig-out"

    print("all files:")
    for path in out_dir.rglob("*"):
        if path.is_file():
            print(f"- {path}")

if __name__ == "__main__":
    main()
