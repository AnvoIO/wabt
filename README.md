# wabt — WebAssembly Binary Toolkit for CDT

[![Build & Test](https://github.com/AnvoIO/wabt/actions/workflows/build.yaml/badge.svg)](https://github.com/AnvoIO/wabt/actions/workflows/build.yaml)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](LICENSE)

A fork of [WebAssembly/wabt](https://github.com/WebAssembly/wabt) (v1.0.36)
for the Anvo Network Contract Development Toolkit (CDT).

## Upstream

**[WebAssembly/wabt](https://github.com/WebAssembly/wabt)** — the canonical
WebAssembly Binary Toolkit, maintained by the WebAssembly Community Group.

This fork tracks `WebAssembly/wabt` directly. CDT additions are limited to
two files (`src/tools/postpass.cc` and `cdt-tools.cmake`) plus a single
`include()` line at the end of the root `CMakeLists.txt`. This design keeps
upstream merges clean — no modifications to existing upstream source files.

## Upstream Improvements Over Previous Fork

The previous CDT wabt fork (cdt-wabt) was based on wabt ~1.0.12 (circa 2019).
By forking from wabt 1.0.36, this repository includes 7 years of upstream
development:

- **WASM proposal support**: bulk memory, reference types, multi-memory,
  exception handling, extended-const, relaxed SIMD, and more
- **BF16 support** and SIMD improvements
- **wasm-decompile** — new tool for human-readable WASM decompilation
- **wasm-stats** — new tool for binary size analysis
- **C++ standard modernization** — C++17 throughout (no more polyfills)
- **Namespaced headers** — `include/wabt/` instead of flat `src/` includes
- **Build system improvements** — modern CMake with proper targets and exports
- Hundreds of bug fixes and performance improvements

## CDT-Specific Tool

| Tool | Binary Name | Description |
|------|-------------|-------------|
| **postpass** | `core-net-pp` | WASM post-processor: strips zero-initialized data segments (BSS), coalesces remaining memory segments, and fixes the heap pointer global. Invoked automatically by `cdt-ld` after `wasm-ld` linking. |

Original postpass code by Bucky Kittinger and arhag (block.one/EOSIO).
API port to wabt 1.0.36 by Anvo Network.

## Keeping Upstream Current

To merge upstream updates:

```bash
git remote add upstream https://github.com/WebAssembly/wabt.git
git fetch upstream
git merge upstream/main
# Resolve any conflicts in CMakeLists.txt (the single include() line)
# postpass.cc and cdt-tools.cmake should merge cleanly
```

## Usage

This library is used as a git submodule by [CDT](https://github.com/AnvoIO/cdt).

```bash
# As part of CDT build:
git submodule update --init tools/external/wabt
```

## Building Standalone

```bash
git submodule update --init
cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF
cmake --build build --target core-net-pp
```

## License

[Apache License 2.0](LICENSE)

Copyright (c) 2016 WebAssembly Community Group participants.
Copyright (c) 2018-2019 block.one and its contributors.
Copyright (c) 2026 Stratovera LLC and its contributors.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.
