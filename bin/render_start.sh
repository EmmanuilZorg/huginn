#!/usr/bin/env bash
set -euo pipefail

# Render starts the web and jobs processes from the same container. Migrations
# must complete before either process loads the Rails application.
bundle exec rake db:migrate

# Seed only on a new database. Huginn's seeder is idempotent, and these values
# allow the first admin account to be configured from Render environment vars.
bundle exec rake db:seed

exec bundle exec foreman start
