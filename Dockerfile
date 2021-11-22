FROM ruby:2.7.3

RUN apt update && \
    apt install -y --no-install-recommends \
    curl \
    netcat \
    build-essential \
    imagemagick \
    libpq-dev \
    gnupg

# Workaround see https://github.com/docker-library/ruby/pull/285
ENV BUNDLE_PATH=$GEM_HOME \
    LANG=C.UTF-8 \
    APP_DIR=/usr/src/app/

ARG BUNDLER_VERSION="2.1.4"
RUN gem update --system && gem install bundler:${BUNDLER_VERSION}

ARG SECRET_KEY_BASE='secret'

WORKDIR $APP_DIR
COPY Gemfile* $APP_DIR

RUN bundle install --jobs 4 --retry 3 && \
    rm -rf $BUNDLE_PATH/cache/*.gem && \
    find $BUNDLE_PATH/gems/ -name "*.c" -delete && \
    find $BUNDLE_PATH/gems/ -name "*.o" -delete

WORKDIR $APP_DIR
COPY . $APP_DIR

COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
CMD docker-entrypoint.sh
