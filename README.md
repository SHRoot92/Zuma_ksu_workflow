# Sultan Kernel for Google Pixel 7 / Pro (gs201)

Automated GitHub Actions CI/CD pipeline for building and packaging **Sultan Kernel** with **KernelSU (xxKSU)** and **SuSFS** for Google Tensor G2 devices (`gs201` — Cheetah & Panther).

---

## 📱 Supported Devices

| Codename | Device Name | Platform | Kernel Base |
| :--- | :--- | :--- | :--- |
| **Cheetah** | Google Pixel 7 Pro | Google Tensor G2 (`gs201`) | Sultan (Linux 6.1) |
| **Panther** | Google Pixel 7 | Google Tensor G2 (`gs201`) | Sultan (Linux 6.1) |

---

## 📦 Release Artifact Naming Convention

Artifact packages follow a standardized, structured naming format:

```text
KSU_Sultan_gs201_6.1+<KSU_VER>[-staging]-<Hook>[-SUSFS_v<SuSFS_VER>]-<YYMMDD>.zip
```

### Examples:
- **`KSU_Sultan_gs201_6.1+12000-manual-SUSFS_v2.2.0-260826.zip`**
  *(Manual Security Hooks + SuSFS, Stable KSU `master` release)*
- **`KSU_Sultan_gs201_6.1+12000-manual-260826.zip`**
  *(Manual Security Hooks, Clean KSU without SuSFS)*
- **`KSU_Sultan_gs201_6.1+12055-staging-lsm-SUSFS_v2.2.0-260826.zip`**
  *(LSM Security Hooks + SuSFS, KSU `staging` pre-release)*

---

## 🪝 Hook Modes & Variant Breakdown

Sultan kernel disables `CONFIG_KPROBES` by default. This repository provides two specialized hook implementations:

| Variant | Hook Mode | Description | Stealth / Recommendation |
| :--- | :--- | :--- | :--- |
| **`manual-SUSFS`** | Direct Patch (`manual`) | Inlines KSU hooks directly into kernel security functions. | 🛡️ **Highest stealth** (Recommended) |
| **`manual`** | Direct Patch (`manual`) | Clean KernelSU integration via manual patches without SuSFS. | Standard root |
| **`lsm-SUSFS`** | ARM64 BL Hookless (`lsm`) | Uses LSM security hooks with Branch-Link trampoline hooking. | Alternative hookless approach |
| **`lsm`** | ARM64 BL Hookless (`lsm`) | Clean LSM security hooks without SuSFS. | Standard hookless root |

---

## ⚡ Build Features & Enhancements

- **ARM GNU Toolchain (14.2.rel1)**: Built with official Bare-Metal ARM toolchain for maximum performance and stability.
- **Full Speedup Suite**:
  - 🌲 **Kernel Tree Cache**: Instant source tree recovery keyed by upstream commit SHA.
  - 🧰 **Toolchain Cache**: Zero-delay compiler restoration.
  - ⚡ **Memory Tmpfs (`/dev/shm`)**: Intermediate compiler objects stored in RAM disk to eliminate virtual disk I/O latency.
  - 🎯 **Ccache 90%+ Hit Rate**: Relocatable cache configuration for 3-minute rapid rebuilds.
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
- **AnyKernel3**: [osm0sis](https://github.com/osm0sis/AnyKernel3) & [TheWildJames](https://github.com/TheWildJames/AnyKernel3)
