FROM base/archlinux

ARG W_DIR=/home/archiso/arch/x86_64

VOLUME /root

COPY archiso /home/archiso
COPY build.sh /bin/build
COPY chroot.sh "$W_DIR/chroot.sh"

RUN cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup && \
    sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup && \
    rankmirrors -n 12 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist && \
    pacman -Syyu --noconfirm && \
    pacman -S --noconfirm squashfs-tools cdrtools syslinux

WORKDIR "$W_DIR"

CMD [ "build" ]
