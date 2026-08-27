# Sultan & GKI Kernel for Google Pixel 7 / Pro (gs201)

Automated GitHub Actions CI/CD pipeline for building and packaging **Sultan Kernel** and **Official Google ACK GKI Kernel (Android 14 6.1)** with **KernelSU (xxKSU)** and **SuSFS** for Google Tensor G2 devices (`gs201` — Cheetah, Panther, Lynx, Felix, Tangorpro).

---

## 📱 Supported Devices

| Codename | Device Name | SoC / Platform | Kernel Base | Compatibility |
| :--- | :--- | :--- | :--- | :---: |
| **Cheetah** | Google Pixel 7 Pro | Google Tensor G2 (`gs201`) | Sultan (6.1) / ACK GKI (6.1) | 🌟 Full Native |
| **Panther** | Google Pixel 7 | Google Tensor G2 (`gs201`) | Sultan (6.1) / ACK GKI (6.1) | 🌟 Full Native |
| **Lynx** | Google Pixel 7a | Google Tensor G2 (`gs201`) | Sultan (6.1) / ACK GKI (6.1) | 🌟 Full Native |
| **Felix** | Google Pixel Fold | Google Tensor G2 (`gs201`) | Sultan (6.1) / ACK GKI (6.1) | ✅ Compatible |
| **Tangorpro** | Google Pixel Tablet | Google Tensor G2 (`gs201`) | Sultan (6.1) / ACK GKI (6.1) | ✅ Compatible |

> **Supported OS**: Google Stock Android 14 / Android 15 (All QPRs), GrapheneOS, CalyxOS, LineageOS 21/22, and all GKI-compliant ROMs.

---

## 🤖 Automated Upstream Tracking & CI Triggering

This repository features a fully automated upstream monitoring system:
- **🔄 Scheduled Polling**: Automatically polls upstream repositories every **3 hours** (`cron: '0 */3 * * *'`).
- **🎯 Dual-Upstream Tracking**:
  - **KernelSU**: Monitors `backslashxx/KernelSU:master` for new commits.
  - **SuSFS**: Monitors `gitlab.com/simonpunk/susfs4ksu:gki-android14-6.1` for new commits.
- **🚀 Automated Build Dispatch**: Whenever an upstream update is detected, the workflow automatically updates state and triggers both Google GKI (`build-gki-ksu.yml`) and Sultan (`build-sultan-ksu.yml`) build pipelines concurrently.
- **🏷️ Dynamic Commit Short Hash**: All release notes record and display the exact upstream commit IDs (e.g. `master (v32595 @ 06d3e0a)` and `SuSFS v2.2.0 (598370f)`).

---

## 🧹 Automated Safe Actions & Cache Cleanup

An integrated, zero-dependency cleanup workflow runs daily at **04:00 AM Beijing Time (20:00 UTC)**:
- **✅ Successful Runs**: Retains the latest **5** completed runs per workflow, automatically pruning older runs.
- **⏱️ Failed/Cancelled Runs**: Preserves failed runs within **24 hours** for diagnostic troubleshooting, and automatically purges failure records older than 24 hours.
- **⚡ Cache Optimization**: Prunes stale GitHub Actions caches older than **7 days** to maintain optimal Ccache speed within the 10GB repository limit.
- **🔒 100% Release Protection**: Releases and Git Tags are **never deleted**, guaranteeing historical downloads remain accessible.

---

## 📦 Release Artifact Naming Convention

Artifact packages follow the standardized naming format:

```text
KSU_<Base>_gs201_<KernelVer>+<KSU_VER>[-staging]-<Hook>[-SUSFS_v<SuSFS_VER>]-<YYMMDD>.zip
```

### Examples:
- **`KSU_Sultan_gs201_6.1.145+32595-manual-SUSFS_v2.2.0-260827.zip`**
  *(Sultan: Manual Security Hooks + SuSFS, Stable KSU `master` release)*
- **`KSU_GKI_gs201_6.1.162+32595-manual-SUSFS_v2.2.0-260827.zip`**
  *(GKI: Manual Security Hooks + SuSFS, Stable KSU `master` release)*
- **`KSU_GKI_gs201_6.1.162+32595-staging-lsm-SUSFS_v2.2.0-260827.zip`**
  *(GKI: LSM Security Hooks + SuSFS, KSU `staging` pre-release)*

---

## 🪝 Hook Modes & Variant Breakdown

| Variant | Hook Mode | Description | Stealth / Recommendation |
| :--- | :--- | :--- | :--- |
| **`manual-SUSFS`** | Direct Patch (`manual`) | Inlines KSU hooks directly into kernel security functions. | 🛡️ **Highest stealth** (Recommended) |
| **`manual`** | Direct Patch (`manual`) | Clean KernelSU integration via manual patches without SuSFS. | Standard root |
| **`lsm-SUSFS`** | ARM64 BL Hookless (`lsm`) | Uses LSM security hooks with Branch-Link trampoline hooking. | Alternative hookless approach |
| **`lsm`** | ARM64 BL Hookless (`lsm`) | Clean LSM security hooks without SuSFS. | Standard hookless root |

---

## ⚡ Build Features & Performance Enhancements

- **Toolchains**:
  - **Google GKI**: Official Google Clang 17.0.6 (`r487747c`) + GCC 14.2 Toolchain.
  - **Sultan GS201**: Bare-Metal ARM GNU Toolchain 14.2 (`aarch64-none-linux-gnu`).
- **High-Efficiency Caching Suite**:
  - 🧰 **Toolchain Cache**: Instant zero-delay compiler restoration via `actions/cache@v6.1.0`.
  - ⚡ **Memory Tmpfs (`/dev/shm`)**: Intermediate compiler objects stored in RAM disk to eliminate virtual disk I/O latency.
  - 🎯 **Ccache 90%+ Hit Rate**: Relocatable cache configuration compressing full builds down to minutes.
  - 🚀 **Git Protocol v2 & HTTP/2**: Shallow single-branch fast cloning with zero patch collision.
- **Networking & Routing Optimizations**:
  - TCP Congestion: BBR v1 + FQ default
  - Policy Routing (Table 1066) & 64k IPSet support
  - Google VPN (XFRM) & TTL 64 share compatibility

---

## 📥 Installation

1. Download the flashable AnyKernel3 `.zip` matching your preference from [Releases](../../releases).
2. Flash using any root/kernel manager app:
   - [Kernel Flasher](https://github.com/capntrips/KernelFlasher)
   - [Horizon Kernel Flasher](https://github.com/libxzr/HorizonKernelFlasher)
   - Or flash via custom recovery (TWRP).
3. Reboot your device.

---

## 📜 Disclaimer

Flashing custom kernels and modifying system partitions involves inherent risks. Please make sure you have backups before proceeding. **Proceed at your own risk.**

---

## 🙏 Credits & Acknowledgements

- **Sultan Kernel**: [kerneltoast (Sultan Alsawaf)](https://github.com/kerneltoast)
- **KernelSU**: [tiann](https://github.com/tiann/KernelSU) & [backslashxx (xxKSU)](https://github.com/backslashxx/KernelSU)
- **SuSFS**: [simonpunk](https://gitlab.com/simonpunk/susfs4ksu)
- **AnyKernel3**: [osm0sis](https://github.com/osm0sis/AnyKernel3)
