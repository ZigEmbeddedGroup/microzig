
import subprocess, sys

VERBOSE = False

def execute_raw(*args,hide_stderr = False,**kwargs):
    args = [ str(f) for f in args]
    if VERBOSE:
        print(*args)
    res = subprocess.run(args, **kwargs, check=False)
    if res.stderr is not None and (not hide_stderr or res.returncode != 0):
        sys.stderr.buffer.write(res.stderr)
    if res.returncode != 0:
        sys.stderr.write(f"command {' '.join(args)} failed with exit code {res.returncode}")
        sys.exit(res.returncode)
    return res 

def execute(*args,**kwargs):
    execute_raw(*args, **kwargs, capture_output=False)

def slurp(*args, **kwargs):
    res = execute_raw(*args, **kwargs, capture_output=True)
    return res.stdout

def check_zig_version(expected):
    actual = slurp("zig", "version")
    if actual.strip() != expected.encode():
        raise RuntimeError(f"Unexpected zig version! Expected {expected}, but found {actual.strip()}!")

def check_required_tools(tools):
    for tool in tools:
        slurp("which", tool)