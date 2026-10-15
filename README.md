# Sultan & GKI Kernel for Google Pixel 8 / Pixel 8 Pro (zuma)

Automated GitHub Actions CI/CD workflows for building kernel variants for Google Tensor G3 devices: **Google Pixel 8 (`shiba`)** and **Google Pixel 8 Pro (`husky`)**. Both devices use the shared **zuma / shusky** kernel platform. The workflows retain KernelSU (xxKSU) and optional SuSFS integration.

## Supported devices (only)

| Codename | Device | SoC / platform | Kernel family |
|---|---|---|---|
| `shiba` | Google Pixel 8 | Google Tensor G3 (`zuma`) | Android common 6.1 / Sultan zuma target |
| `husky` | Google Pixel 8 Pro | Google Tensor G3 (`zuma`) | Android common 6.1 / Sultan zuma target |

Pixel 7 series, Pixel 8a, Pixel Fold, Pixel Tablet, and other devices are not targets of this repository. The Pixel 8 and Pixel 8 Pro share the zuma kernel platform, but firmware and boot/vendor_boot packaging must still match the device's installed build.

## Workflows

- **Build Google GKI KSU** — uses the official Google kernel manifest branch `android-gs-shusky-6.1-android16`.
- **Build Sultan KSU** — builds the Sultan source against the zuma defconfig and zuma DTBs.
- **Build Sultan 17 KSU** — Android 17 Sultan source workflow, using the zuma target.
- **Test Sultan LD** — test build for the zuma target.
- **Get Patch** — helper workflow for testing kernel patches.

Each workflow supports the configured KernelSU branch, hook mode, optional SuSFS, caching, and release generation where provided by the workflow inputs.

## Important compatibility notes

- This repository has been adapted for Pixel 8 / Pixel 8 Pro, but GitHub Actions builds have **not** been run as part of this offline modification.
- The Sultan workflow expects the upstream Sultan source to provide `zuma_defconfig` and `google-devices/zuma/dts/`, and expects the AnyKernel3 source to have a `sultan-zuma` branch. Confirm those upstream refs exist before running the workflow.
- KernelSU and SuSFS patches must match the checked-out kernel revision. A successful compile alone does not prove compatibility with every stock firmware build.
- Always keep a matching stock `boot.img` and `vendor_boot.img` available and verify the ZIP's device checks before flashing.

## Build artifact naming

Artifacts identify the `zuma` kernel platform and include the kernel version, KernelSU version/branch, hook mode, optional SuSFS version, and build date.

## Installation

1. Download the artifact built for the exact Pixel 8 or Pixel 8 Pro firmware/kernel combination.
2. Verify that the installer explicitly allows your device codename (`shiba` or `husky`).
3. Keep a backup of the matching stock boot images and follow the maintainer's flashing instructions.

## Disclaimer

Custom kernels can cause boot loops, loss of connectivity, or data loss. Flash at your own risk.

## Credits

- Sultan kernel: [kerneltoast](https://github.com/kerneltoast)
- KernelSU / xxKSU: [tiann](https://github.com/tiann/KernelSU) and [backslashxx](https://github.com/backslashxx/KernelSU)
- SuSFS: [simonpunk](https://gitlab.com/simonpunk/susfs4ksu)
- AnyKernel3: [osm0sis](https://github.com/osm0sis/AnyKernel3)
