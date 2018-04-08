#!/bin/sh
tmpfile=$(mktemp /tmp/virsh-XXXXXX.xml)
cat docker-vm.xml | sed -e s/%VMNAME%/$1/g > $tmpfile && sudo virsh define $tmpfile 
rm $tmpfile
