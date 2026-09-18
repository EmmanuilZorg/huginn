# Huginn for Render.com (Docker)

## Развёртывание

В репозитории есть готовый `render.yaml`. Создайте Blueprint в Render из этого
репозитория и примените его. Blueprint автоматически создаёт PostgreSQL,
передаёт приложению реальные параметры подключения и запускает миграции перед
стартом web/jobs-процессов.

После первого запуска задайте в настройках Web Service переменные `SEED_PASSWORD`
и `SEED_EMAIL` (либо оставьте значения по умолчанию, если они уже заданы), а
также `DOMAIN`, если нужны корректные ссылки в письмах и OAuth callback URL.

Не указывайте `your-postgres-host.render.com` или другие placeholder-значения:
адрес, пользователь, пароль и имя базы приходят из Render Postgres через
`fromDatabase` в `render.yaml`.
