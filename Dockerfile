FROM ruby:3.2-bookworm

LABEL MAINTAINER="Amir Pourmand"

# Install dependencies for Jekyll and native extensions
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    imagemagick \
    libmagickwand-dev \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Add Gemfile and install dependencies
ADD Gemfile /srv/jekyll/
RUN bundle install

# The rest of the app will be mounted as a volume in docker_run.sh
