#!/bin/bash

# Do not remove these commands, they are required to install new packages
pacman-key --init
pacman-key --populate archlinux
pacman -Syy --noprogressbar
sed -i 's|^CheckSpace|#CheckSpace|' /etc/pacman.conf

# Install extra packages here, for example:
pacman -S --noconfirm --noprogressbar git parallel

# More goes here

parallel --citation <<< "will cite
"

# If the kernel or initrd is updated uncomment these steps
## TODO

# Create a list of all installed packages and clear the cache
LANG=C pacman -Sl | awk '/\[installed\]$/ {print $1 "/" $2 "-" $3}' > /pkglist.txt
pacman -Scc <<< "y
y
"
