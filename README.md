# ![MicroZig Logo](design/logo-text-auto.svg)

[![Chat](https://img.shields.io/discord/824493524413710336.svg?logo=discord)](link=https://discord.gg/ShUWykk38X)
[![Downloads](https://img.shields.io/badge/Zig_Package-Download-blue)](https://downloads.microzig.tech/)
[![Continuous Integration](https://github.com/ZigEmbeddedGroup/microzig-monorepo/actions/workflows/build.yml/badge.svg)](https://github.com/ZigEmbeddedGroup/microzig-monorepo/actions/workflows/build.yml)

> **NOTE:** This is in development; breaks in the API are bound to happen.

## What version of Zig to use

0.11.0

## Contributing

Please see the [project page](https://github.com/orgs/ZigEmbeddedGroup/projects/1/views/1), it’s used as a place to brainstorm and organize work in ZEG. There will be issues marked as good first issue or drafts for larger ideas that need scoping/breaking ground on.

## Introduction

This repo contains the infrastructure for getting started in an embedded Zig project; it "gets you to main()". Specifically, it offers:

* a single easy-to-use builder function that:
  * generates your linker script
  * sets up packages and startup code
* generalized interfaces for common devices, such as UART.
* device drivers for interacting with external hardware
* an uncomplicated method to define xref:interrupts[interrupts]

## Getting Started

Search for your chip family in [the examples](https://downloads.microzig.tech/examples/) and get the archive.

You can easily get started based on that.

## Design

For MicroZig internals please see the [Design Document](docs/design.adoc).

## Repository structure

- `build/` contains the build components of MicroZig.
- `core/` contains the shared components of MicroZig.
- `board-support/` contains all official board support package.
- `examples/` contains examples that can be used with the board support packages.
- `tools/` contains tooling to work *on* MicroZig itself, so deployment, testing, ...
- `design/` contains images and logos

## Versioning Scheme

MicroZig versions are tightly locked with Zig versions.

The general scheme is `${zig_version}-${commit}-${count}`, so the MicroZig versions will look really similar to
Zigs versions, but with our own commit abbreviations and counters.

As MicroZig sticks to tagged Zig releases, `${zig_version}` will show to which Zig version the MicroZig build is compatible.

Consider the version `0.11.0-abcdef-123` means that this MicroZig version has a commit starting with `abcdef`, which was the 123rd commit of the version that is compatible with Zig 0.11.0.

