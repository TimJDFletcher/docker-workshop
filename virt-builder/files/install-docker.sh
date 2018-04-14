#!/bin/sh -e
DEBIAN_FRONTEND=noninteractive
APT="apt-get --yes -qq"
$APT update
$APT dist-upgrade
$APT install docker-ce
$APT autoremove
