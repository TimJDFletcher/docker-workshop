#!/bin/sh -e
if [ -f /var/run/reboot-required ] ; then
    reboot
fi
