# runescape-docker

Play RuneScape in a docker container!

## Installation

Install docker (https://docs.docker.com/). It is available in most major distro's repositories.

Start docker and check which storage driver it is using:

~~~
sudo systemctl start docker
sudo docker info | grep Storage
~~~

If it's using devicemapper storage, change to overlayfs. The devicemapper driver often doesn't release unused space properly, and can quickly expand to fill the drive it's on. On Fedora, overlayfs can be turned on by editing the right config files:

~~~
sudo vi /etc/sysconfig/docker
# Add --selinux-enabled=false to the OPTIONS line

sudo vi /etc/sysconfig/docker-storage
# Add -s overlay to the DOCKER_STORAGE_OPTIONS line

sudo systemctl restart docker
~~~

Then clone this repo and run the build script:

~~~
git clone https://github.com/Densaugeo/runescape-docker.git
cd runescape-docker
sudo ./build.sh
sudo ln -s $(pwd)/run.sh /bin/runescape
~~~

If you don't want to install git, you can run the following in place of `git clone`:

~~~
wget https://github.com/Densaugeo/runescape-docker/archive/master.zip
unzip master.zip
mv runescape-docker-master runescape-docker
~~~

## Use

Start the container by running:

~~~
sudo runescape
~~~

If you get an error that says it cannot connect to the docker daemon, the daemon may need to be started first. On SystemD distros this can be done by running `sudo systemctl start docker`.

## Known Issues

**Audio.** Audio on the host OS can break. This can usually be fixed by restarting PulseAudio:

~~~
pulseaudio --kill
pulseaudio --start
~~~

**Xhost security.** The start script opens xhost to any client connections, which can be a security issue.

**Propriety graphics drivers.** I don't have a GPU new enough to be supported by proprietary drives, so they aren't tested. Open an issue if you are interested in testing them.
