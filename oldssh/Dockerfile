FROM debian:8

RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
        openssh-client && \
    rm -rf /var/cache/apt/*

ADD docker-entrypoint.sh /entry
RUN chmod 0755 /entry

RUN adduser --disabled-password --gecos '' oldssh
USER oldssh

ENV SSH_AUTH_SOCK=/var/run/ssh-agent.sock
ADD --chown=oldssh:oldssh ssh_config /home/oldssh/.ssh/config

ENTRYPOINT ["/entry"]
CMD ["-V"]
