#!/bin/bash

unsquashfs airootfs.sfs

arch-chroot squashfs-root /bin/bash <<< "pacman-key --init
    pacman-key --populate archlinux"
