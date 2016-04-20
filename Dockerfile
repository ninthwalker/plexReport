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

RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
RUN apt-get update -q
RUN apt-get install -qy ruby ruby-dev git make gcc inotify-tools
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/ninthwalker/plexReport.git /opt/plexReport
RUN cd /opt/plexReport/
RUN gem install bundle
RUN bundle install
  
#Adding Custom files
COPY /opt/plexReport/initial_setup.sh /etc/my_init.d/
RUN chmod -v +x /etc/my_init.d/*.sh
ln -s /config/config.yaml /etc/plexReport/config.yaml && \ ln -s /config/email_body.erb /etc/plexReport/email_body.erb

#Mappings and ports
VOLUME ["/config"]
