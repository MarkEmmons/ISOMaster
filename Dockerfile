FROM base/archlinux

COPY build.sh /bin/build

COPY archiso /home/archiso

RUN cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup && \
    sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup && \
    rankmirrors -n 12 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist && \
    pacman -Syyu --noconfirm && \
    pacman -S --noconfirm squashfs-tools cdrtools syslinux

WORKDIR /home/archiso/arch/x86_64

CMD [ "bash" ]
