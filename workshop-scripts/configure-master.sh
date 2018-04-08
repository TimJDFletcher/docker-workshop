#!/bin/bash -e
my_ip="$(ip route get 8.8.8.8| grep -oP '(?<=src ).*')"
hostname=rancher-server

set_hostname()
{
    echo ${my_ip}       ${hostname} | sudo tee --append /etc/hosts > /dev/null
    sudo hostnamectl set-hostname ${hostname}
}

set_hostname
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
