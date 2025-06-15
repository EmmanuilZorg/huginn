FROM ruby:3.2.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn curl gnupg

WORKDIR /app

COPY . .

COPY .env.example .env

ENV RAILS_ENV=production

RUN gem install bundler -v "$(grep -A1 'BUNDLED WITH' Gemfile.lock | tail -n1)" || gem install bundler

RUN bundle config set without 'development test' && bundle install

RUN yarn install

RUN bundle exec rake assets:precompile

RUN bundle exec rake assets:clean

CMD ["bundle", "exec", "foreman", "start"]
