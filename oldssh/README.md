# Older version of ssh in a container

A docker container with an older version of SSH to allow ssh access embedded ssh systems

The current version of openssh no longer supports RSA server keys <1024 bit

## Usage

`docker run -it oldssh:latest host`
