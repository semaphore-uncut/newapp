FROM ruby:2.5-slim

WORKDIR /app

# 1: Install necessary packages for gem compilation
RUN apt-get update && apt-get install -y -qq \
      build-essential \
      curl \
      wget \
      g++ \
      gcc \
      git \
      libcurl4-openssl-dev \
      libffi-dev \
      libgmp-dev \
      libgmp3-dev \
      libpq-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libxslt1-dev \
      libyaml-dev \
      make \
      zlib1g \
      zlib1g-dev \
      zlib1g-dev \
      zlibc \
      vim

# 2: Install node as a javascript runtime for asset compilation:
RUN wget -O - https://nodejs.org/dist/v6.10.0/node-v6.10.0-linux-x64.tar.xz | tar Jx --strip=1 -C /usr/local

# 3: Install gems
ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install --jobs 8
RUN bundle check

ADD . /app

CMD bundle exec rails server -b 0.0.0.0
