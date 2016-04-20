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
apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* && \
useradd -ms /bin/bash app

USER app

RUN \
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
/bin/bash -l -c "curl -L get.rvm.io | bash -s stable --rails" && \
/bin/bash -l -c "rvm install 2.1" && \
/bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc" && \
/bin/bash -l -c "gem install bundler --no-ri --no-rdoc" && \
git clone https://github.com/ninthwalker/plexReport.git /opt/plexReport
  
#Adding Custom files
COPY scripts/ /etc/my_init.d/
RUN chmod -v +x /etc/my_init.d/*.sh
# RUN ln -s /etc/plexReport/config.yaml /config/config.yaml && \ 
# ln -s /etc/plexReport/email_body.erb /config/email_body.erb

#Mappings and ports
VOLUME ["/config"]
