# ISOMaster

Build custom Arch Linux installation ISOs quickly with Docker.

#### Note

This is heavily based on the instructions provided [here](https://wiki.archlinux.org/index.php/Remastering_the_install_ISO)

#### TODO

Add the steps required for when changes are made to the kernel/initrd

### Instructions

Clone this repository with git. Download the latest [installation image](https://www.archlinux.org/download/). 

Because Docker doesn't play nicely with the `mount` command we need to mount the image manually then copy it to its own folder in the repo:

```Shell
# See the instructions in the note above for more information
mkdir /mnt/archiso
mount -t iso9660 -o loop /path/to/archISO /mnt/archiso

# The Dockerfile expects a folder named 'archiso' in the project folder
cp -a /mnt/archiso /path/to/ISOMaster/archiso
```

Add the commands you wish to run (install packages, create/download files, etc...) to the indicated area of _chroot.sh_, then build the image.

```Shell
# Call it what you like, I use the tag isomaster
docker image build -t <tag-name> .
```

In order for `arch-chroot` to be run in Docker we must run the container with the `--privileged` flag. It is also advised that you name the volume so that the finished custom ISO can be easily retrieved. For readability I like to detach the container and follow the logs.

```Shell
docker container run -d --rm --privileged -v iso_vol:/root --name new_iso isomaster && \
    docker logs -f new_iso
```

Once the above command completes the custom iso will be finished. It can be found within the volume, probably somewhere like `/var/lib/docker/volumes/<volume_name>/_data`.

### Why Docker?

There's a handful of packages I would only ever install to modify the usb. Keeping them confined to a Docker container feels cleaner to me. Also, this should work on any system hosting Docker, not just an Arch-specific approach.
