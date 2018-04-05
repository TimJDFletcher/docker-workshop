FROM debian:8

RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
        openssh-client && \
    rm -rf /var/cache/apt/*

ADD --chmod 0755 docker-entrypoint.sh /entry

RUN adduser --disabled-password --gecos '' oldssh

USER oldssh

ADD --chown=oldssh:oldssh ssh_config /home/oldssh/.ssh/config

ENV SSH_AUTH_SOCK=/var/run/ssh-agent.sock

ENTRYPOINT ["/entry"]
CMD ["-V"]
