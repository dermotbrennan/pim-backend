FROM alpine:3.2

MAINTAINER CenturyLink Labs <innovationslab@ctl.io>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev git imagemagick-dev" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-json yaml"

RUN mkdir /app
VOLUME ["/app"]
WORKDIR /app

ADD Gemfile /app/
ADD Gemfile.lock /app/

ENV BUNDLE_GEMFILE=/app/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN \
  apk --update --upgrade add $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
  gem install -N bundler

RUN gem install -N nokogiri -- --use-system-libraries && \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  cd /app && \
  # cleanup and settings
  bundle config --global build.nokogiri  "--use-system-libraries" && \
  bundle config --global build.nokogumbo "--use-system-libraries" && \
  bundle install && \

  find / -type f -iname \*.apk-new -delete && \
  rm -rf /var/cache/apk/* && \
  rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
  rm -rf ~/.gem

RUN chown -R nobody:nogroup /app
WORKDIR /app

# Default command is to run a rails server on port 3000
CMD ["rails", "server", "--binding", "0.0.0.0", "--port", "3000"]
EXPOSE 3000
