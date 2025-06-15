FROM ruby:3.2.4

# Установить зависимости
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

COPY . .

# Переименуй .env.example → .env до установки зависимостей
RUN cp .env.example .env                         # ← ключевая строка

# Установить bundler из Gemfile.lock
RUN gem install bundler -v "$(grep -A1 'BUNDLED WITH' Gemfile.lock | tail -n1)" || gem install bundler

# Установить зависимости
RUN bundle install --without development test || { bundle config unset deployment; bundle install; }

# Сборка ассетов
RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "foreman", "start"]
