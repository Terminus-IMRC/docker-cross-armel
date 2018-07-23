FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture armel \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends crossbuild-essential-armel \
 && apt-get clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

WORKDIR /root
ENV HOME /root
