# ![MicroZig Logo](design/logo-text-auto.svg)

[![Chat](https://img.shields.io/discord/824493524413710336.svg?logo=discord)](https://discord.gg/ShUWykk38X)
[![Downloads](https://img.shields.io/badge/Zig_Package-Download-blue)](https://downloads.microzig.tech/)
[![Continuous Integration](https://github.com/ZigEmbeddedGroup/microzig/actions/workflows/build.yml/badge.svg)](https://github.com/ZigEmbeddedGroup/microzig/actions/workflows/build.yml)

> **NOTE:** This is in development; breaks in the API are bound to happen.

## What version of Zig to use

0.11.0

## Getting Started With MicroZig

### I Want To Use MicroZig

**IMPORTANT:** You don't have to clone this repository to get started!

MicroZig uses a monorepo architecture, but provides a lot of different packages. If you just want to get started, head over to [downloads.microzig.tech](https://downloads.microzig.tech/) and download an example for the chip family you desire.

We support several chip families like the [RP2 family by RaspberryPi Foundation](https://www.raspberrypi.com/products/rp2040/), [STM32 by STMicroelectronics](https://www.st.com/content/st_com/en.html), and many others.

Unpack the example, and run `zig build` in the resulting example folder gives you `zig-out/firmware` which contains the resulting files.

Right now, you gotta figure out how to flash the MCU yourself, but as people say: Google is your friend. But you can also ask for help [on our Discord server](https://discord.gg/ShUWykk38X).

### I Want To Contribute To MicroZig

**IMPORTANT:** Developer experience is degraded right now, and not really good. Windows isn't really a supported dev target and you got to expect some friction. [There's a project for improving DX, feel free to grab tasks from there!](https://github.com/orgs/ZigEmbeddedGroup/projects/4)

Please see the [project page](https://github.com/orgs/ZigEmbeddedGroup/projects/1/views/1), it’s used as a place to brainstorm and organize work in ZEG. There will be issues marked as good first issue or drafts for larger ideas that need scoping/breaking ground on.

More words on contribution and development on MicroZig are [further down below](#developing).

## Introduction

This repo contains the infrastructure for getting started in an embedded Zig project; it "gets you to main()". Specifically, it offers:

* a single easy-to-use builder function that:
  * generates your linker script
  * sets up packages and startup code
* generalized interfaces for common devices, such as UART.
* device drivers for interacting with external hardware
* an uncomplicated method to define xref:interrupts[interrupts]

## Design

For MicroZig internals please see the [Design Document](docs/design.adoc).

## Developing

Right now, the developer experience is not optimal due to 0.11 not really supporting what we're doing at all.

If you want to test your changes, you gotta to the following:

**Step 1:** Install required python packages, either systemwide or via a [virtual environment](https://docs.python.org/3/library/venv.html):

```sh-session
# systemwide:
[user@host] microzig-monorepo/ $ pip install -r tools/requirements.txt
[user@host] microzig-monorepo/ $ 

# using virtual environments:
[user@host] microzig-monorepo/ $ python3 -m venv .venv
[user@host] microzig-monorepo/ $ . .venv/bin/activate # on linux, macos
[user@host] microzig-monorepo/ $ . .venv/Scripts/activate # on windows
[user@host] microzig-monorepo/ $ pip3 install -r tools/requirements.txt
[user@host] microzig-monorepo/ $ 
```

**Step 2:** Create a deployment for local usage:

```sh-session
[user@host] microzig-monorepo/ $ python3 ./tools/bundle.py --debug
preparing environment...
validating packages...
loaded packages:
  * microzig-build
  * examples:microchip/avr
  * examples:...
  * microzig-core
  * microchip/avr
  * ...
resolving inner dependencies...
creating packages...
bundling microzig-build...
bundling microzig-core...
bundling microchip/avr...
...
[user@host] microzig-monorepo/ $ 
```

This command yields output in `./microzig-deploy` that is meant to be fetched via `http://localhost:8080/`.

**Step 3:** To serve the files on this port, you can start a pre-bundled web server:

```sh-session
[user@host] microzig-monorepo/ $ python3 ./tools/demo-server.py
...
```

This way, you spawn a local HTTP server that will serve `./microzig-deploy` on port 8080 on your machine, and you can then
start fetching packages from this.

Now you can use curl to fetch the packages, or you can just create a local development project.

**Step 4:** Create a local test environment

This is basically done by unpacking an example from the `./microzig-deploy/examples` folder, and starting to test changes.
As the `build.zig.zon` has to be updated after running `./tools/bundle.py` again, there's a script that helps here:
`tools/patch-build-zon.py` can be used to patch/upgrade your development project inplace based on what it finds in `./microzig-deploy`:

```sh-session
[user@host] microzig-monorepo/ $ python3 ./tools/patch-build-zon.py /tmp/dev-project/build.zig.zon
Updating hash of http://localhost:8080/packages/microzig-build.tar.gz to 12200040a36bbbb2fe09809861f565fcda9a10ec3064d70357aa40ad0a61596c16fb
Updating hash of http://localhost:8080/packages/microzig-core.tar.gz to 122013a37ce9ac295303f26057c203e722b9ceaefa5b4403fe5a18ab065f03079e7d
Updating hash of http://localhost:8080/packages/board-support/stmicro/stm32.tar.gz to 12207c278b78c5aeb08cd7889647d7d0d9a359cb28fe68105d2e43f85dabb3865981
[user@host] microzig-monorepo/ $
```

Both compiling the local example and updating the `build.zig.zon` requires running the local development server.

## Repository structure

* `build/` contains the build components of MicroZig.
* `core/` contains the shared components of MicroZig.
* `board-support/` contains all official board support package.
* `examples/` contains examples that can be used with the board support packages.
* `tools/` contains tooling to work *on* MicroZig itself, so deployment, testing, ...
* `design/` contains images and logos

## Versioning Scheme

MicroZig versions are tightly locked with Zig versions.

The general scheme is `${zig_version}-${commit}-${count}`, so the MicroZig versions will look really similar to
Zigs versions, but with our own commit abbreviations and counters.

As MicroZig sticks to tagged Zig releases, `${zig_version}` will show to which Zig version the MicroZig build is compatible.

Consider the version `0.11.0-abcdef-123` means that this MicroZig version has a commit starting with `abcdef`, which was the 123rd commit of the version that is compatible with Zig 0.11.0.

