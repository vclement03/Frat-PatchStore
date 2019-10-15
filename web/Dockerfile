FROM ruby:2.5.7-slim
 
RUN apt-get update && apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev libsqlite3-dev nodejs libcurl4 curl postgresql-client libpq-dev

RUN gem install bundler

RUN mkdir /app

WORKDIR /app

COPY Gemfile Gemfile

RUN bundle install

COPY . .

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

EXPOSE 3000

#RUN rails RAILS_ENV=production SECRET_KEY_BASE=asdf assets:precompile
#CMD bundle exec puma -e production

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]