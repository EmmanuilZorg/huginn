FROM ruby:3.2.4

# Устанавливаем зависимости
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs curl gnupg

# Устанавливаем Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Создаём директорию для приложения
WORKDIR /app

# Копируем файлы приложения
COPY . .

# Копируем переменные окружения
COPY .env.example .env

# Устанавливаем нужную версию bundler
RUN gem install bundler -v "$(grep -A1 'BUNDLED WITH' Gemfile.lock | tail -n1)" || gem install bundler

# Установка гемов
RUN bundle config set without 'development test' && bundle install

# Сборка ассетов
RUN bundle exec rake assets:precompile

# Очистка старых ассетов
RUN bundle exec rake assets:clean

# Команда по умолчанию
CMD ["bundle", "exec", "foreman", "start"]
