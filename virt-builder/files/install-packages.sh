#!/bin/sh -e
DEBIAN_FRONTEND=noninteractive
APT="apt-get --yes --no-install-recommends"
PACKAGES="docker-ce git vim curl bash-completion"
count=0

while ! ip route get 8.8.8.8 ; do 
    sleep 3
    count=$((count+1))
    [ $count -gt 10 ] && break
done

$APT update
$APT dist-upgrade
$APT install $PACKAGES
$APT autoremove
