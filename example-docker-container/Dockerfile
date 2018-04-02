FROM debian:9

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get --yes --no-install-recommends install python \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
COPY hello.bash /app/hello
COPY docker-entrypoint.sh /entry

RUN chmod 0755 /entry /app/hello

USER nobody
CMD ["-hello"]
ENTRYPOINT ["/entry"]
