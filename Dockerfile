FROM ubuntu:16.04

LABEL version "0.1"
LABEL description "Play RuneScape in a docker container!"
LABEL homepage "https://github.com/Densaugeo/runescape-docker"
LABEL repository "https://github.com/Densaugeo/runescape-docker.git"

# apt-transport-https - RS repo uses HTTPS
# libcurl3 - unlisted dependency for RS
# xserver-xorg-video-all - return video to host
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    libcurl3 \
    xserver-xorg-video-all

# Set up official RS repo
COPY runescape.gpg.key /
RUN apt-key add runescape.gpg.key
RUN echo "deb https://content.runescape.com/downloads/ubuntu trusty non-free" > /etc/apt/sources.list.d/runescape.list

# libglew version 1.10 is no longer in the main Ubuntu repo
COPY libglew1.10_1.10.0-3_amd64.deb /
RUN dpkg -i libglew1.10_1.10.0-3_amd64.deb

RUN apt-get update && apt-get install -y runescape-launcher
