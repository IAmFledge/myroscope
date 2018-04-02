FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myroscope
WORKDIR /myroscope
COPY Gemfile /myroscope/Gemfile
COPY Gemfile.lock /myroscope/Gemfile.lock
RUN bundle install
COPY . /myroscope
