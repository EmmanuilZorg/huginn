FROM ruby:3.0
ENV RAILS_ENV=production

RUN apt-get update -qq && apt-get install -y \
    nodejs postgresql-client libvips \
    build-essential libxml2-dev libxslt1-dev \
    libcurl4-openssl-dev libssl-dev zlib1g-dev \
    libgdbm-dev libffi-dev python3

WORKDIR /app
COPY . /app

# Устанавливаем версию Bundler из lock-файла
RUN gem install bundler -v "$(grep -A1 'BUNDLED WITH' Gemfile.lock | tail -n1)" || gem install bundler

COPY .env.example .env  # <-- add this line

RUN bundle install --without development test || { bundle config unset deployment; bundle install; }

RUN bundle exec rake assets:precompile
RUN bundle exec rake assets:clean

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
