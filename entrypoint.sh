#!/bin/dumb-init /bin/sh
set -e

exec gosu $GOSU_USER "$@"
