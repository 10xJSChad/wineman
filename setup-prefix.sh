#!/bin/sh -a
set -e
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
. "$SCRIPTPATH/config.sh"

echo "Downloading winetricks"
curl "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks" > "$WINETRICKS"

echo "Creating base prefix"


echo "Installing corefonts"
sh "$WINETRICKS" -q corefonts

# echo "Installing ie8"
# sh "$WINETRICKS" -q ie8

echo "Installing dxvk"
sh "$WINETRICKS" -q dxvk

echo "Installing vkd3d"
sh "$WINETRICKS" -q vkd3d

echo "Enabling csmt"
sh "$WINETRICKS" csmt=on

echo "Setting Windows version to win10"

sed -i '/CurrentBuildNumber/c\"CurrentBuildNumber"="19042"' "$WINEPREFIX/system.reg"
sed -i '/CurrentBuild"/c\"CurrentBuild"="19042"' "$WINEPREFIX/system.reg"

echo "Initializing prefix"
exec "$WINEBOOT"

echo "Success!"
exit 0