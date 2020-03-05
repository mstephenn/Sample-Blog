FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client libxml2-dev libcurl4-openssl-dev nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN mkdir /my-blog
WORKDIR /my-blog
RUN gem install bundler
COPY Gemfile /my-blog/Gemfile
COPY Gemfile.lock /my-blog/Gemfile.lock
RUN bundle install
COPY . /my-blog
