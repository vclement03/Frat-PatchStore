FROM ruby:2.5-slim

RUN apt-get update && apt-get install -y sqlite3 build-essential patch ruby-dev zlib1g-dev liblzma-dev libsqlite3-dev nodejs libcurl3 curl

RUN gem install bundler

RUN mkdir /app

WORKDIR /app

COPY Gemfile Gemfile

RUN bundle --without development test

COPY . .

RUN bundle --without development test

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN rails RAILS_ENV=production SECRET_KEY_BASE=asdf assets:precompile

CMD bundle exec puma -e production