#!/bin/bash -e
temp=$(mktemp )
date=$(date +%Y%m%d-%H%M)
os=debian-9
cache=/WDZBA365/archives/virt-builder

virt-builder \
    --cache $cache \
    --upload files/interfaces:/etc/network/interfaces \
    --upload files/issue:/etc/issue \
    --upload files/docker.keyring:/etc/apt/trusted.gpg.d/docker.gpg \
    --upload files/docker.list:/etc/apt/sources.list.d/docker.list \
    --upload files/docker.apt.pin:/etc/apt/preferences.d/docker \
    --upload files/backports.list:/etc/apt/sources.list.d/backports.list \
    --upload files/sysctl-no-ipv6.conf:/etc/sysctl.d/disable-ipv6.conf \
    --upload files/ssh-keygen.service:/etc/systemd/system/ssh-keygen.service \
    --update \
    --install dhcpcd5,sudo,vim,curl,ca-certificates,apt-transport-https,bash-completion \
    --delete '/var/cache/apt/archives/*' \
    --delete '/var/lib/apt/lists/*' \
    --edit "/boot/grub/grub.cfg:s/vda/sda/" \
    --copy-in ../workshop-scripts/:/opt \
    --firstboot files/install-packages.sh \
    --firstboot files/create-user.sh \
    --firstboot files/reboot-check.sh \
    --timezone Europe/London \
    --ssh-inject root:file:files/yubikey.pub \
    --link "/etc/systemd/system/ssh-keygen.service:/etc/systemd/system/multi-user.target.wants/ssh-keygen.service" \
    --link "/lib/systemd/system/serial-getty@.service:/etc/systemd/system/getty.target.wants/serial-getty@ttyS0.service" \
    --format qcow2 --size 10G -o $temp $os

virt-sparsify --inplace $temp

pigz --rsyncable --stdout $temp > /tmp/${os}-${date}.raw.gz

bmaptool create --output /tmp/${os}-${date}.bmap $temp

sha256sum /tmp/${os}-${date}.bmap /tmp/${os}-${date}.raw.gz > /tmp/${os}-${date}.sha256sum

rm $temp
