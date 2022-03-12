#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
MIX_ENV=prod mix assets.deploy

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite

# expose ENV variables
source .env

# Run migrations
_build/prod/rel/quizzez/bin/quizzez eval "Quizzez.Release.migrate"
