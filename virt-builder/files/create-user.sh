#!/bin/sh
password=Docker2018
user=admin
groups="sudo adm docker"

useradd -s /bin/bash -m -p "" $user
echo ${user}:${password} | chpasswd

for group in $groups ; do
    usermod $user -G $group -a
done
