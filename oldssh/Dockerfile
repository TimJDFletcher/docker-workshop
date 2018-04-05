FROM debian:8

RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
        openssh-client && \
    rm -rf /var/cache/apt/*

RUN adduser --disabled-password --gecos '' oldssh

USER oldssh

ADD ssh_config /home/oldssh/.ssh/config

ENV SSH_AUTH_SOCK=/var/run/ssh-agent.sock

ENTRYPOINT ["/usr/bin/ssh"]
CMD [""]
