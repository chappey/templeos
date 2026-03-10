#!/bin/bash

ISO_URL="https://templeos.org/Downloads/TempleOS.ISO"
ISO_IMG="TempleOS.ISO"
DISK_IMG="templeos_disk.qcow2"
MEM="512"
CORES="2"

if [ ! -f "$ISO_IMG" ]; then
    echo "ISO missing. Fetching TempleOS ISO..."
    wget -O "$ISO_IMG" "$ISO_URL"
fi

if [ ! -f "$DISK_IMG" ]; then
    echo "Disk image not found; Creating 2GB Virtual Disk... "
    qemu-img create -f qcow2 "$DISK_IMG" 2G
fi

QEMU_ARGS=(
    -enable-kvm
    -m "$MEM"
    -cpu host
    -smp "$CORES"
    # Controller 0
    -drive "file=templeos_disk.qcow2,format=qcow2,bus=0,unit=0,media=disk"
    -drive "file=TempleOS.ISO,format=raw,bus=0,unit=1,media=cdrom"
    # Controller 1
    # -drive "file=TOS_Supplemental1.ISO.C,format=raw,bus=1,unit=0,media=cdrom"
    # -drive "file=TOS_Supplemental2.ISO.C,format=raw,bus=1,unit=1,media=cdrom"
    -display sdl,gl=off
    -vga std
    -rtc base=localtime
    -machine pcspk-audiodev=snd0
    -audiodev pa,id=snd0
)

echo "Launching TempleOS..."
qemu-system-x86_64 "${QEMU_ARGS[@]}"
