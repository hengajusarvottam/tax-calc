#!/bin/sh

# Added some delay here to allow postgres db to start up properly
sleep 5

bundle exec rails db:create
bundle exec rails db:migrate

bundle exec rails server -b 0.0.0.0
