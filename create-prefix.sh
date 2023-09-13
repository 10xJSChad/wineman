#!/bin/sh
set -e
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
. "$SCRIPTPATH/config.sh"

if [ "$1" = "" ]
then
    echo "No source prefix name specified"
    exit 1
fi

if [ "$2" = "" ]
then
    echo "No destination prefix name specified"
    exit 1
fi

SOURCE_PREFIX="$1"
DESTINATION_PREFIX="$2"

if [ -d "$ROOT_PATH/prefix/$DESTINATION_PREFIX" ]
then
    echo "Prefix already exists and will be updated"
else
    echo "Creating prefix directory"
    mkdir "$ROOT_PATH/prefix/$DESTINATION_PREFIX" 
fi

cp -Rsn "$ROOT_PATH/prefix/$SOURCE_PREFIX/." "$ROOT_PATH/prefix/$DESTINATION_PREFIX" 
find "$ROOT_PATH/prefix/$DESTINATION_PREFIX" -type l    \
! -name "*.exe" \
! -name "*.dll" \
! -name "*.ttf" \
! -name "*.installed" \
! -name "*.000" \
! -name "*.wav" \
-delete

cp -rn "$ROOT_PATH/prefix/$SOURCE_PREFIX/." "$ROOT_PATH/prefix/$DESTINATION_PREFIX"

echo "Success!"
exit 0