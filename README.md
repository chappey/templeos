1. Install iso
```sh
wget https://templeos.org/Downloads/TempleOS.ISO
```
2. Install QEMU (or other emulator)
Fedora 43
```sh
sudo dnf install qemu-kvm qemu-system-x86 libvirt virt-install -y
```

3. Create a virtual disk
```sh
qemu-img create -f qcow2 templeos_disk.qcow2 2G
```

4. Run QEMU

```sh
qemu-system-x86_64 \
  -enable-kvm \
  -m 512 \
  -cpu host \
  -smp 2 \
  -drive file=templeos_disk.qcow2,format=qcow2 \
  -cdrom /path/to/your/TempleOS.ISO \
  -boot order=d \
  -display gtk \
  -vga std \
  -rtc base=localtime
```
