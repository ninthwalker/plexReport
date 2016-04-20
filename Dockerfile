FROM phusion/baseimage:0.9.15

# Set correct environment variables
ENV HOME /root 
ENV DEBIAN_FRONTEND noninteractive 
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
 RUN \
 usermod -u 99 nobody && \
 usermod -g 100 nobody && \
 usermod -d /home nobody && \
 chown -R nobody:users /home
 
# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN \
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse" && \
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse" && \
apt-get update -q && \
apt-get install -qy ruby ruby-dev && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* && \
git clone https://github.com/ninthwalker/plexReport.git /opt/plexReport

#Mappings and ports
VOLUME ["/config"]
