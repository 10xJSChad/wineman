#!/bin/sh
echo "Starting setup..."
./setup-wine.sh &&
./setup-prefix.sh
echo "Success!"
exit 0