FROM alpine:3.5
MAINTAINER ninthwalker <ninthwalker@gmail.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler

#copy plexReport files
COPY root/ /
WORKDIR /config

# ---------------------------------------------
# THESE WERE THE COMMANDS IN PHUSION.
# RUN mkdir -p /etc/my_init.d && \
# mkdir -p /etc/service/httpserver
# ADD /root/add_web_body.sh /etc/my_init.d/add_web_body.sh
# ADD /root/httpserver.sh /etc/service/httpserver/run
# ----------------------------------------------------

RUN apk --no-cache add \
$BUILD_PACKAGES \
$RUBY_PACKAGES \
python
#make \
#gcc \

# may need build-base (includes make, gcc and others, but is large (like 100mb)

RUN cd /opt/gem
#gem install bundler -v 1.12.3 && \
RUN bundle install

#RUN add_web_body.sh

CMD ["python", "-m", "SimpleHTTPServer", "8080"]

VOLUME /config
EXPOSE 8080
