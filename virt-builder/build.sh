#!/bin/bash -e
temp=$(mktemp )
date=$(date +%Y%m%d-%H%M)
os=debian-9
cache=/WDZBA365/archives/virt-builder

virt-builder \
    --cache $cache \
    --upload interfaces:/etc/network/interfaces \
    --upload issue:/etc/issue \
    --upload docker.keyring:/etc/apt/trusted.gpg.d/docker.gpg \
    --upload docker.list:/etc/apt/sources.list.d/docker.list \
    --upload ssh-keygen.service:/etc/systemd/system/ssh-keygen.service \
    --install dhcpcd5,sudo,vim,apt-transport-https,bash-completion \
    --timezone Europe/London \
    --ssh-inject root:file:yubikey.pub \
    --firstboot-command 'useradd -s /bin/bash -m -G adm,sudo -p "$6$Krsex9Rv$2UmTsecgg/39WyvzN6bsHCTRNkgy9vQT6aIBCo1.uoFgB24bCJTyhGIscyQz6bTCYT0Q2pFQb9P2p1RXtyAwU/" admin' \
    --link '/etc/systemd/system/ssh-keygen.service:/etc/systemd/system/multi-user.target.wants/ssh-keygen.service' \
    --link '/lib/systemd/system/serial-getty@.service:/etc/systemd/system/getty.target.wants/serial-getty@ttyS0.service' \
    --size 10G -o $temp $os

virt-sparsify --inplace $temp

pigz -c $temp > /tmp/${os}-${date}.raw.gz

bmaptool create -o /tmp/${os}-${date}.bmap $temp

sha256sum /tmp/${os}-${date}.bmap /tmp/${os}-${date}.raw.gz

rm $temp

