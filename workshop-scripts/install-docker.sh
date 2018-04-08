#!/bin/bash -e
sudo apt-get --yes update
sudo apt-get --yes dist-upgrade
sudo apt-get --yes install docker-ce
sudo apt-get --yes autoremove
sudo usermod admin -a -G docker
