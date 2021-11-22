#!/bin/bash

# Lets ensure we are in the correct workspace
cd $APP_DIR

echo "start----------"

set -e
#
#while ! nc -z $DATABASE_HOST 5432; do sleep 0.1; done
#
## Only one pod should be enabled to run migrations
if [[ "$DB_MIGRATE" == "true" ]]
then
  echo "db migrations----------"
  bundle exec rake db:migrate
fi

# Execute rails server on port 3000
if [[ "$APP_SERVER" == "true" ]]
then
  echo "app server boot-------------"
  rm -f tmp/pids/server.pid
  bundle exec rails server -p 3000 -b 0.0.0.0
fi
