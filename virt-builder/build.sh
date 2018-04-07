#!/bin/bash -e
temp=$(mktemp )
date=$(date +%Y%m%d-%H%M)
os=debian9
XDG_CACHE_HOME=/var/cache 

virt-builder \
    --install dhcpcd5 \
    --upload admin.sudoers:/etc/sudoers.d/admin \
    --upload interfaces:/etc/network/interfaces \
    --upload ssh-keygen.service:/etc/systemd/system/ssh-keygen.service \
    --firstboot-command 'useradd -m -G sudo -p "" admin ; chage -d 0 admin'
    --link '/etc/systemd/system/ssh-keygen.service:/etc/systemd/system/multi-user.target.wants/ssh-keygen.service' \
    --link '/lib/systemd/system/serial-getty@.service:/etc/systemd/system/getty.target.wants/serial-getty@ttyS0.service' \
    --size 20G -o $temp $os

virt-sparsify --inplace $temp

pigz -c $temp > /tmp/${os}-${date}.raw.gz

bmaptool create -o /tmp/${os}-${date}.bmap $temp

sha256sum /tmp/${os}-${date}.bmap /tmp/${os}-${date}.raw.gz

rm $temp

