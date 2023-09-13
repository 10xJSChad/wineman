#!/bin/sh
set -e
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
. "$SCRIPTPATH/config.sh"

echo "Cleaning deps directory"
rm -rf "$ROOT_PATH/deps/"*

wine_tarball_temp_file="$ROOT_PATH/tmp/wine.tar"

echo "Downloading wine"
wget "$WINE_URL" -O "$wine_tarball_temp_file"

echo "Extracting wine to $ROOT_PATH/deps"
tar -xf "$wine_tarball_temp_file" -C "$ROOT_PATH/deps"

echo "Renaming extracted directory"
mv "$ROOT_PATH/deps/"* "$ROOT_PATH/deps/wine"

echo "Deleting wine tarball"
rm "$wine_tarball_temp_file"

echo "Success!"
exit 0