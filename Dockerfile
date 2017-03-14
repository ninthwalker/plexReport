FROM alpine:3.4
MAINTAINER ninthwalker <ninthwalker@gmail.com>

VOLUME /config
EXPOSE 6878

ENV BUILD_PACKAGES curl-dev ruby-dev
# ENV RUBY_PACKAGES
ENV BUNDLER_VERSION 1.12.3

#copy nowShowing files
COPY root/ /
WORKDIR /opt/gem

RUN apk add --update \
$BUILD_PACKAGES \
ruby \
ruby-io-console \
python \
ruby-irb \
ruby-json \
ruby-rake \
ruby-rdoc \
make \
gcc
# $RUBY_PACKAGES \
# may need build-base (includes make, gcc and others, but is large (like 100mb)

RUN gem install bundler -v $BUNDLER_VERSION --no-ri --no-rdoc
RUN bundle config --global silence_root_warning 1
RUN bundle install

CMD ["python", "-m", "SimpleHTTPServer", "6878"]
