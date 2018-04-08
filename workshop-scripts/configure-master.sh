#!/bin/bash -e
sudo hostnamectl set-hostname rancher-server
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
