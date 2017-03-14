FROM alpine:3.2
MAINTAINER ninthwalker <ninthwalker@gmail.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
# ENV RUBY_PACKAGES
ENV BUNDLER_VERSION 1.12.3

#copy plexReport files
COPY root/ /
WORKDIR /opt/gem

# ---------------------------------------------
# THESE WERE THE COMMANDS IN PHUSION.
# RUN mkdir -p /etc/my_init.d && \
# mkdir -p /etc/service/httpserver
# ADD /root/add_web_body.sh /etc/my_init.d/add_web_body.sh
# ADD /root/httpserver.sh /etc/service/httpserver/run
# ----------------------------------------------------

RUN apk add --update \
$BUILD_PACKAGES \
ruby \
ruby-io-console \
python \
ruby-irb \
ruby-json \
ruby-rake \
ruby-rdoc
# $RUBY_PACKAGES \
#make \
#gcc \
# may need build-base (includes make, gcc and others, but is large (like 100mb)

RUN cd /opt/gem/
RUN gem install bundler -v $BUNDLER_VERSION --no-ri --no-rdoc
RUN bundle config --global silence_root_warning 1
RUN bundle install

#RUN add_web_body.sh

CMD ["python", "-m", "SimpleHTTPServer", "8080"]

VOLUME /config
EXPOSE 8080
