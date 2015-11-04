#!/usr/bin/env bash

if [ "$EUID" != 0 ]; then
    echo "This script uses functionality which requires root priviligies"
    exit 1;
fi

# start
acbuild --debug begin

# Exiting
trap "{ export EXT=$?; acbuild --debug end && exit $EXT; }" EXIT

# Name
acbuild --debug set-name example.com/nginx

# Based on alpine
acbuild --debug dep add quay.io/coreos/alpine.sh

# Install
acbuild --debug run apk update
acbuild --debug run apk add nginx

# Port
acbuild --debug port add http tcp 80

# Mount
acbuild --debug mount add html /usr/share/nginx/html

# Run
acbuild --debug set-exec -- /usr/sbin/nginx -g "daemon off;"

# Save
acbuild --debug write --overwrite nginx-latest-linux-amd64.aci

