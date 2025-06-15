FROM ruby:3.0
ENV RAILS_ENV=production

RUN apt-get update -qq && apt-get install -y \
  nodejs postgresql-client libvips \
  build-essential libxml2-dev libxslt1-dev \
  libcurl4-openssl-dev libssl-dev zlib1g-dev \
  libgdbm-dev libffi-dev python3

WORKDIR /app
COPY . /app

RUN gem install bundler -v 2.4.22
RUN bundle install --without development test

RUN bundle exec rake assets:precompile
RUN bundle exec rake assets:clean

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
