# How to Add GPU to VFIO and Isolate from Host

## Overview

This guide walks you through the process of adding a GPU to the VFIO (Virtual Function I/O) framework, allowing the GPU to be isolated from the host and passed through to a virtual machine (VM). 
This is commonly used in scenarios like GPU passthrough for virtualization (e.g., with QEMU/KVM) or for hardware-accelerated workloads in virtualized environments.
By isolating the GPU, the host system will not be able to directly access it, ensuring that the GPU is available exclusively to the virtual machine.

---

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- **Linux-based Host** (e.g., Ubuntu, Debian)
- **Kernel with VFIO Support** (5.x or later preferred)
- **IOMMU Support** (AMD-Vi for AMD)
- **A compatible GPU** (usually dedicated, not integrated)
- **At least 2 GPUs at host** (1 can be used for VMs(dedicated), another for system(integrated))
---

## Steps

### 1. **Gather info about graphics cards you want to add to VFIO and isolate**
```bash
lspci -nn | grep 'NVIDIA'
```
Output:
```
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU106 [GeForce RTX 2060 SUPER] [10de:1f06] (rev a1)
01:00.1 Audio device [0403]: NVIDIA Corporation TU106 High Definition Audio Controller [10de:10f9] (rev a1)
01:00.2 USB controller [0c03]: NVIDIA Corporation TU106 USB 3.1 Host Controller [10de:1ada] (rev a1)
01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU106 USB Type-C UCSI Controller [10de:1adb] (rev a1)
```
You need to collect the following information from this above output(all NVIDIA devices):
```
VGA compatible controller - 10de:1f06
Audio device - 10de:10f9
USB controller - 10de:1ada
Serial bus controller - 10de:1adb
10de:1f06,10de:10f9,10de:1ada,10de:1adb
```

### 2. **Modify configuration of Linux Bootloader(`/etc/default/grub`)**

Open the following file via command:
1. Edit the GRUB configuration:
```bash
sudo nano /etc/default/grub
Adjust there the following line, exactly the same you shoul put:
GRUB_CMDLINE_LINUX_DEFAULT="iommu=1 amd_iommu=on iommu=pt vfio-pci.ids=10de:1f06,10de:10f9,10de:1ada,10de:1adb vfio_iommu_type1.allow_unsafe_interrupts=1"
```
2. Save this config.
3. Update GRUB bootloader:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
### 3. **Modify configuration of initramfs**
1.Create the following file:
```bash
sudo touch /etc/modprobe.d/vfio.conf
```
2.Modify it with the following content:
```bash
options vfio-pci ids=10de:1f06,10de:10f9,10de:1ada,10de:1adb
softdep nvidia pre: vfio-pci
```
3. Save the file.
4. Enable VFIO modules. Adjust the `/etc/initramfs-tools/modules`. add the following:
```bash
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
vhost-net
```
5.Update initramfs by the following commands:
```bash
sudo update-initramfs -c -k $(uname -r)
sudo update-initramfs -u -k all
```
### 4. **Reboot your system and verify that GPU is used by VFIO and isolated**
1. Reboot your system:
```bash
sudo reboot now
```
2. Verify GPUs.
```bash
lspci -k | grep -E 'vfio-pci|NVIDIA'
```
You should receive the following output if everything works as expected:
```
01:00.0 VGA compatible controller: NVIDIA Corporation TU106 [GeForce RTX 2060 SUPER] (rev a1)
	Subsystem: NVIDIA Corporation TU106 [GeForce RTX 2060 SUPER]
	Kernel driver in use: vfio-pci
01:00.1 Audio device: NVIDIA Corporation TU106 High Definition Audio Controller (rev a1)
	Subsystem: NVIDIA Corporation TU106 High Definition Audio Controller
	Kernel driver in use: vfio-pci
01:00.2 USB controller: NVIDIA Corporation TU106 USB 3.1 Host Controller (rev a1)
	Subsystem: NVIDIA Corporation TU106 USB 3.1 Host Controller
01:00.3 Serial bus controller: NVIDIA Corporation TU106 USB Type-C UCSI Controller (rev a1)
	Subsystem: NVIDIA Corporation TU106 USB Type-C UCSI Controller
	Kernel driver in use: vfio-pci
```
Excellent!!! Now you can use your GPU in Virt manager, add it as PCI host device, all the devices which you isolated.
