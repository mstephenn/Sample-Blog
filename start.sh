#!/bin/bash
#
# This script builds your application containers and bootstraps the database
#

DCD='docker-compose'

# Build containers and initialize the app for the first time!
echo "Building the containers..."
$DCD build

echo "Setting up the database..."
$DCD run web /bin/sh -c "RACK_ENV=development rake db:drop db:create db:migrate db:seed"

# Starting it all!
echo "Starting..."
$DCD up
