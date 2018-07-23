FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture armel \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends crossbuild-essential-armel

WORKDIR /root
ENV HOME /root
