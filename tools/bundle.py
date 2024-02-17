#!/usr/bin/env python3
#
# Prepares a full deployment of MicroZig.
# Creates all packages into ${repo}/microzig-deploy with the final folder structure.
#
# Just invoke this script to create a deployment structure for MicroZig.
#


import sys, os, datetime, re, shutil, json, hashlib
from pathlib import Path, PurePosixPath
from dataclasses import dataclass, field 
from dataclasses_json import dataclass_json, config as  dcj_config, Exclude as JsonExclude
from semver import Version
from marshmallow import fields
from enum import Enum as StrEnum
from argparse import ArgumentParser, BooleanOptionalAction
import pathspec
import stat 
import tarfile



from marshmallow import fields as mm_fields
from typing import Optional, Any

from lib.common import  execute_raw, execute, slurp, check_zig_version, check_required_tools
import lib.common as common

DEFAULT_DEPLOYMENT_BASE="https://download.microzig.tech/packages"
DEBUG_DEPLOYMENT_BASE="http://localhost:8080"

LEGAL_PACKAGE_NAME = re.compile("^[A-Za-z]$")

VERBOSE = False 
ALL_FILES_DIR=".data"
REQUIRED_TOOLS = [
    "zig",
    "git",
]


REPO_ROOT = Path(__file__).parent.parent
assert REPO_ROOT.is_dir()


common.VERBOSE = VERBOSE

class PackageType(StrEnum):
    build = "build"
    core = "core"
    board_support = "board-support"
    example = "example"

@dataclass_json
@dataclass
class Archive:
    size: str
    sha256sum: str

@dataclass_json
@dataclass
class Package:
    hash: str
    files: list[str] = field(default_factory=lambda:[])

@dataclass_json
@dataclass
class ExternalDependency:
    url: str
    hash: str 
    
@dataclass_json
@dataclass
class Timestamp:
    unix: str
    iso: str 
    
@dataclass_json
@dataclass
class PackageConfiguration:
    package_name: str 
    package_type: PackageType

    version: Optional[Version] = field(default=None, metadata=dcj_config(decoder=Version.parse, encoder=Version.__str__, mm_field=fields.String()))
    
    external_dependencies: dict[str,ExternalDependency] = field(default_factory=lambda:dict())
    inner_dependencies: set[str] = field(default_factory=lambda:set())
    
    archive: Optional[Archive] = field(default = None)
    created: Optional[Timestamp] = field(default = None)
    package: Optional[Package]  = field(default= None)

    download_url: Optional[str] = field(default=None)

    microzig: Optional[Any] = field(default=None)

    # inner fields:
    # package_dir: Path = field(default=None, metadata = dcj_config(exclude=JsonExclude.ALWAYS))

@dataclass_json
@dataclass
class PackageDesc:
    name: str
    type: PackageType
    version: str # semver
    metadata: str # url to json
    download: str # url to tar.gz

@dataclass_json
@dataclass
class PackageIndex:
    
    last_update: Timestamp
    packages: list[PackageDesc]

PackageIndexSchema = PackageIndex.schema()
PackageSchema = Package.schema()
PackageConfigurationSchema = PackageConfiguration.schema()

def file_digest(path: Path, hashfunc) -> bytes:
    BUF_SIZE = 65536

    digest = hashfunc()

    with path.open('rb') as f:
        while True:
            data = f.read(BUF_SIZE)
            if not data:
                break
            digest.update(data)

    return digest.digest()


FILE_STAT_MAP = {
    stat.S_IFDIR: "directory",
    stat.S_IFCHR: "character device",
    stat.S_IFBLK: "block device",
    stat.S_IFREG: "regular",
    stat.S_IFIFO: "fifo",
    stat.S_IFLNK: "link",
    stat.S_IFSOCK: "socket",
}

def file_type(path: Path) -> str:
    return FILE_STAT_MAP[stat.S_IFMT( path.stat().st_mode)]




def build_zig_tools():    
    # ensure we have our tools available:
    execute("zig", "build", "tools", cwd=REPO_ROOT)

    archive_info = REPO_ROOT / "zig-out/tools/archive-info"
    create_pkg_descriptor = REPO_ROOT / "zig-out/tools/create-pkg-descriptor"
    
    assert archive_info.is_file()
    assert create_pkg_descriptor.is_file()

    return {
        "archive_info": archive_info,
        "create_pkg_descriptor": create_pkg_descriptor,
    }


# Determines the correct version:
def get_version_from_git() -> str:

    raw_git_out = slurp("git", "describe", "--match", "*.*.*", "--tags", "--abbrev=9", cwd=REPO_ROOT).strip().decode()

    def render_version(major,minor,patch,counter,hash):
        return f"{major}.{minor}.{patch}-{counter}-{hash}"
    
    full_version = re.match('^([0-9]+)\.([0-9]+)\.([0-9]+)\-([0-9]+)\-([a-z0-9]+)$', raw_git_out)
    if full_version:
        return render_version(*full_version.groups())

    
    base_version = re.match('^([0-9]+)\.([0-9]+)\.([0-9]+)$', raw_git_out)
    if base_version:
        commit_hash = slurp("git", "rev-parse", "--short=9", "HEAD")
        return render_version(*base_version.groups(), 0, commit_hash) 

    raise RuntimeError(f"Bad result '{raw_git_out}' from git describe.")
    

def create_output_directory(repo_root: Path) -> Path:

    deploy_target=repo_root / "microzig-deploy"
    if deploy_target.is_dir():
        shutil.rmtree(deploy_target)
    assert not deploy_target.exists()

    deploy_target.mkdir()

    return deploy_target

def resolve_dependency_order(packages: dict[PackageConfiguration]) -> list[PackageConfiguration]:

    open_list = list(packages.values())

    closed_set = set()
    closed_list = []
    while len(open_list) > 0:

        head = open_list.pop(0)

        all_resolved = True
        for dep_name in head.inner_dependencies:
            
            dep = packages[dep_name]

            if dep.package_name not in closed_set:
                all_resolved = False
                break 
        
        if all_resolved:
            closed_set.add(head.package_name)
            closed_list.append(head)
        else:
            open_list.append(head)

    return closed_list

def get_batch_timestamp():
    render_time = datetime.datetime.now()
    return Timestamp(
        unix=str(int(render_time.timestamp())),
        iso=render_time.isoformat(),
    )

def list_of_str(arg):
    return arg.split(',')

def main():

    
    arg_parser = ArgumentParser()

    arg_parser.add_argument("--base-url", type=str, required=False, default=DEFAULT_DEPLOYMENT_BASE, help="Sets the download URL for the packages.")
    arg_parser.add_argument("--debug", action="store_true", required=False, default=False, help="Creates a deployment for local development, hosted by localhost:8080")
    arg_parser.add_argument("--examples", action=BooleanOptionalAction, required=False, default=True, help="Build the examples")
    arg_parser.add_argument("--boards", type=list_of_str, help='list of boards to build', default=[])

    cli_args = arg_parser.parse_args()

    base_url = cli_args.base_url if not cli_args.debug else DEBUG_DEPLOYMENT_BASE


    check_required_tools(REQUIRED_TOOLS)

    check_zig_version("0.11.0")

    print("preparing environment...")

    deploy_target = create_output_directory(REPO_ROOT)    

    # Some generic meta information:
    batch_timestamp = get_batch_timestamp()

    version = get_version_from_git()

    tools = build_zig_tools()

    # After building the tools, zig-cache should exist, so we can tap into it for our own caching purposes:

    cache_root = REPO_ROOT / "zig-cache"
    assert cache_root.is_dir()

    cache_dir = cache_root / "microzig"
    cache_dir.mkdir(exist_ok=True)

    # Prepare `.gitignore` pattern matcher:
    global_ignore_spec = pathspec.PathSpec.from_lines(
        pathspec.patterns.GitWildMatchPattern, 
        (REPO_ROOT / ".gitignore").read_text().splitlines(),
    )

    # also insert a pattern to exclude 
    global_ignore_spec.patterns.append(
        pathspec.patterns.GitWildMatchPattern("microzig-package.json")
    )

    # Fetch and find all packages:

    print("validating packages...")

    packages = {}
    validation_ok = True

    PACKAGES_ROOT = PurePosixPath("packages")
    EXAMPLES_ROOT = PurePosixPath("examples")

    for meta_path in REPO_ROOT.rglob("microzig-package.json"):
        assert meta_path.is_file()

        pkg_dir = meta_path.parent

        pkg_dict = json.loads(meta_path.read_bytes())
        pkg = PackageConfigurationSchema.load(pkg_dict)

        # Skip examples or non enabled boards
        if any([
            pkg.package_type == PackageType.example and not cli_args.examples,
            pkg.package_type == PackageType.board_support and cli_args.boards and pkg.package_name not in cli_args.boards
           ]):
            continue

        pkg.version = version
        pkg.created = batch_timestamp
        pkg.package_dir = pkg_dir



        if pkg.package_type == PackageType.build:
            pkg.out_rel_dir = PACKAGES_ROOT
            pkg.out_basename = pkg.package_name
            
        elif pkg.package_type == PackageType.core:
            pkg.out_rel_dir = PACKAGES_ROOT
            pkg.out_basename = pkg.package_name
            
            # Implicit dependencies:
            pkg.inner_dependencies.add("microzig-build") # core requires the build types

        elif pkg.package_type == PackageType.board_support:
            parsed_pkg_name = PurePosixPath( pkg.package_name)

            pkg.out_rel_dir = PACKAGES_ROOT / "board-support" / parsed_pkg_name.parent
            pkg.out_basename = parsed_pkg_name.name

            # Implicit dependencies:
            pkg.inner_dependencies.add("microzig-build") # BSPs also require build types
            pkg.inner_dependencies.add("microzig-core") # but also the core types (?)
            
            
        elif pkg.package_type == PackageType.example:
            parsed_pkg_name = PurePosixPath( pkg.package_name)

            pkg.package_name = "examples:" + pkg.package_name # patch the name so we can use the same name for BSP and Example 

            pkg.out_rel_dir = EXAMPLES_ROOT / parsed_pkg_name.parent
            pkg.out_basename = parsed_pkg_name.name

            # Implicit dependencies:
            pkg.inner_dependencies.add("microzig-build") # BSPs also require build types
            pkg.inner_dependencies.add("microzig-core") # but also the core types (?)

        else:
            assert False 

        download_path = pkg.out_rel_dir / ALL_FILES_DIR / f"{pkg.out_basename}-{version}.tar.gz"
        pkg.download_url = f"{base_url}/{download_path}"

        buildzig_path = pkg_dir / "build.zig"
        buildzon_path = pkg_dir / "build.zig.zon"
        
        if not buildzig_path.is_file():
            print("")
            print(f"The package at {meta_path} is missing its build.zig file: {buildzig_path}")
            print("Please create a build.zig for that package!")
            validation_ok = False
            
        if buildzon_path.is_file():
            print("")
            print(f"The package at {meta_path} has a build.zig.zon: {buildzon_path}")
            print("Please remove that file and merge it into microzig-package.json!")
            validation_ok = False
        
        if pkg.package_name not in packages:
            packages[pkg.package_name] = pkg
        else:
            print("")
            print(f"The package at {meta_path} has a duplicate package name {pkg.package_name}")
            print("Please remove that file and merge it into microzig-package.json!")
            validation_ok = False
        
    if not validation_ok:
        print("Not all packages are valid. Fix the packages and try again!" )
        exit(1)

    print("loaded packages:")
    for key in packages:
        print(f"  * {key}")

    print("resolving inner dependencies...")
    
    evaluation_ordered_packages = resolve_dependency_order(packages)

    # bundle everything:

    index = PackageIndex(
        last_update = batch_timestamp,
        packages = [],
    )

    print("creating packages...")
    for pkg in evaluation_ordered_packages:
        print(f"bundling {pkg.package_name}...")
        
        pkg_dir = pkg.package_dir        

        pkg_cache_dir = cache_dir / hashlib.md5(pkg.package_name.encode()).hexdigest()
        pkg_cache_dir.mkdir(exist_ok=True)
        
        meta_path = pkg_dir / "microzig-package.json"
        pkg_zon_file = pkg_cache_dir / pkg_dir.name / "build.zig.zon" 

        out_rel_dir: PurePosixPath = pkg.out_rel_dir
        out_basename: str = pkg.out_basename
        
        if pkg.package_type == PackageType.board_support:
            bsp_info = slurp(
                "zig", "build-exe",
                    f"{REPO_ROOT}/tools/extract-bsp-info.zig" ,
                    "--cache-dir", f"{REPO_ROOT}/zig-cache",
                    "--deps", "bsp,microzig-build",
                    "--mod", f"bsp:microzig-build:{pkg_dir}/build.zig",
                    "--mod", f"microzig-build:uf2:{REPO_ROOT}/build/build.zig",
                    "--mod", f"uf2::{REPO_ROOT}/tools/lib/dummy_uf2.zig",
                    "--name", "extract-bsp-info",
                cwd=pkg_cache_dir,
            )

            extra_json_str=slurp(pkg_cache_dir/"extract-bsp-info")

            pkg.microzig = json.loads(extra_json_str)


        assert out_rel_dir is not None
        assert out_basename is not None

        # File names:

        out_file_name_tar = f"{out_basename}-{version}.tar"
        out_file_name_compr = f"{out_file_name_tar}.gz"
        out_file_name_meta = f"{out_basename}-{version}.json"

        out_symlink_pkg_name = f"{out_basename}.tar.gz"
        out_symlink_meta_name = f"{out_basename}.json"

        
        # Directories_:        
        out_base_dir = deploy_target / out_rel_dir
        out_data_dir = out_base_dir / ALL_FILES_DIR

        # paths:
        out_file_tar = out_data_dir / out_file_name_tar
        out_file_targz = out_data_dir / out_file_name_compr
        out_file_meta = out_data_dir / out_file_name_meta

        out_symlink_pkg = out_base_dir / out_symlink_pkg_name
        out_symlink_meta = out_base_dir / out_symlink_meta_name
   
        # ensure the directories exist:
        out_base_dir.mkdir(parents = True, exist_ok=True)
        out_data_dir.mkdir(parents = True, exist_ok=True)

        # find files that should be packaged:

        package_files = [*global_ignore_spec.match_tree(pkg_dir,negate = True )]
        # package_files = [ 
        #     file.relative_to(pkg_dir)
        #     for file in pkg_dir.rglob("*") 
        #         if not global_ignore_spec.match_file(str(file))
        #         if file.name != 
        # ]

        if VERBOSE:
            print("\n".join(f"  * {str(f)} ({file_type(pkg_dir / f)})" for f in package_files))
            print()

        # tar -cf "${out_tar}" $(git ls-files -- . ':!:microzig-package.json')

        execute("tar", "-cf", out_file_tar, "--hard-dereference", *( f"{pkg_dir.name}/{file}" for file in package_files), cwd=pkg_dir.parent)

        zon_data = slurp(
            tools["create_pkg_descriptor"],
            pkg.package_name, 
            input=PackageConfigurationSchema.dumps(evaluation_ordered_packages, many=True ).encode(),
        )

        pkg_zon_file.parent.mkdir(exist_ok=True)

        with pkg_zon_file.open("wb") as f:
            f.write(zon_data)

        slurp("zig", "fmt", pkg_zon_file) # slurp the message away

        execute("tar", "-rf", out_file_tar, "--hard-dereference", f"{pkg_zon_file.parent.name}/{pkg_zon_file.name}", cwd=pkg_zon_file.parent.parent)

        # tar --list --file "${out_tar}" > "${pkg_cache_dir}/contents.list"
        
        zig_pkg_info_str = slurp(tools["archive_info"], out_file_tar)
        pkg.package = PackageSchema.loads(zig_pkg_info_str)

        # explicitly use maximum compression level here as we're shipping to potentially many people
        execute("gzip", "-f9", out_file_tar)
        assert not out_file_tar.exists()
        assert out_file_targz.is_file()
        del out_file_tar

        pkg.archive = Archive(
            sha256sum = file_digest(out_file_targz, hashlib.sha256).hex(),
            size = str(out_file_targz.stat().st_size),
        )
        
        with out_file_meta.open("w") as f:
            f.write(PackageConfigurationSchema.dumps(pkg))

        out_symlink_pkg.symlink_to(out_file_targz.relative_to(out_symlink_pkg.parent))
        out_symlink_meta.symlink_to(out_file_meta.relative_to(out_symlink_meta.parent))

        index.packages.append(PackageDesc(
            name = pkg.package_name,
            type = pkg.package_type,
            version = version,
            metadata = pkg.download_url.removesuffix(".tar.gz") + ".json",
            download = pkg.download_url,
        ))

    with (deploy_target / "index.json").open("w") as f:
        f.write(PackageIndexSchema.dumps(index))

    # TODO: Verify that each package can be unpacked and built



if __name__ == "__main__":
    main()
