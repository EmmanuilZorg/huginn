# Huginn for Render.com (Docker)

## Шаги

1. Разверни PostgreSQL сервис на Render
2. В Render UI создай Web Service на основе этого репозитория
3. Убедись, что `.env` переменные заданы в Render → Environment
4. Запустится Huginn

## Переменные окружения

- DATABASE_ADAPTER=postgresql
- DATABASE_HOST=your-postgres-host.render.com
- DATABASE_USERNAME=render_user
- DATABASE_PASSWORD=your_password
- DATABASE_NAME=huginn_production
- FORCE_SSL=false
