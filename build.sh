#!/bin/bash

# Paths
ARCH_ISO=/home/archiso
ISO_VOL=/root

# The ISO label must remain the same as the original label for the image to boot successfully
# Change this manually if you are not using the most recent iso release
ISO_LABEL="ARCH_$(date +%Y%m)"

# If this command fails try rebuilding the Docker image from scratch
unsquashfs airootfs.sfs

# Add commands to customize the ISO to chroot.sh
arch-chroot squashfs-root /bin/bash < chroot.sh

# TODO kernel/initramfs steps

# Build the new ISO
mv squashfs-root/pkglist.txt "$ARCH_ISO/arch/pkglist.x86_64.txt"
rm airootfs.sfs
mksquashfs squashfs-root airootfs.sfs
#md5sum airootfs.sfs > airootfs.md5
openssl sha512 airootfs.sfs > airootfs.sha512

# Cleanup
rm -r squashfs-root

# Generate the new iso image
cd "$ARCH_ISO"
genisoimage -l -r -J -V "$ISO_LABEL" -b isolinux/isolinux.bin -no-emul-boot \
    -boot-load-size 4 -boot-info-table -c isolinux/boot.cat -o "$ISO_VOL/arch-custom.iso" ./

# Required for USB compatability
rm -r "$ISO_VOL/*"
cd "$ISO_VOL"
isohybrid arch-custom.iso
