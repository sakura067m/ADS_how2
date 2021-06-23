#!/bin/bash

# kill process on error
# do not use unset variables
set -eu

# check state
echo "State check:"
echo "Jekyll needs 'ruby-full' 'build-essential' 'zlib1g-dev'"
apt list --installed 2>/dev/null | grep -e ruby-full -e build-essential -e zlib1g-dev

if [ -f config.yml ]; then
    echo "run this script on root dir where _config.yml exists"
    exit 1
fi

# use bundle to setup
# http://jekyllrb-ja.github.io/tutorials/using-jekyll-with-bundler/
## pre
echo "set bundle local"
bundle config set --local path 'vendor/bundle'

## setup jekyll
# echo "add jekyll"
# bundle add jekyll
echo "exec jekyll"
bundle exec jekyll build
echo "install"
bundle install