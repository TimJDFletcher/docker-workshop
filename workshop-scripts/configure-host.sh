#!/bin/bash -e
# Initialize some defaults
my_ip="$(ip route get 8.8.8.8| grep -oP '(?<=src ).*')"
hostname="host-$(echo $my_ip| cut --delimiter=. --fields 3,4 --output-delimiter= | tr -d '\0')"
agent_version=v1.2.10

get_opts()
{
    while [[ $# > 0 ]] ; do
        key="$1"
        case $key in
            -u|--url) rancher_url="$2"
                shift 
                ;;
            -n|--name) hostname="$2"
                shift
                ;;
            -v|--version) agent_version="$2"
                shift
                ;;
            *) show_help
                exit 0
                ;;
        esac
        shift 
    done
    if [ -z ${rancher_url+x} ] ; then
        show_help
        exit 1
    fi
}

show_help()
{
    echo "Script to set hostname via systemd and join a rancher server, call as"
    echo "$0 -n <hostname> -u <rancher join url> -v <agent version to use>"
}

set_hostname()
{
    echo ${my_ip}       ${hostname} | sudo tee --append /etc/hosts > /dev/null
    sudo hostnamectl set-hostname ${hostname}
}

join_rancher()
{
    if docker ps | grep --quiet "rancher/agent:$agent_version" ; then
        echo Rancher agent container appears to be running already, bailing out
        exit 1
    fi
    printf "Starting rancher agent container, ID is: "
    docker run -d --privileged \
        -v /var/run/docker.sock:/var/run/docker.sock \
        rancher/agent:$agent_version $rancher_url
}

get_opts $@
echo "Setting hostname to $hostname and joining the rancher server at $rancher_url"
set_hostname
join_rancher
