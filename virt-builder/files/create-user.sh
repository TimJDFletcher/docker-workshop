#!/bin/sh
password=Docker2018
user=admin

useradd -s /bin/bash -m -G adm,sudo,docker -p "" $user
echo ${user}:${password} | chpasswd
