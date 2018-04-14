#!/bin/sh -e
DEBIAN_FRONTEND=noninteractive
APT="apt-get --yes"
count=0

while ! ip route get 8.8.8.8 ; do 
    sleep 3
    count=$((count+1))
    [ $count -gt 10 ] && break
done
printf "\033c"
$APT update
$APT dist-upgrade
$APT install docker-ce
$APT autoremove
