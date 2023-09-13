#!/bin/sh
set -e
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
. "$SCRIPTPATH/config.sh"


if [ "$1" = "" ] || [ "$2" = "" ]
then
    echo "Usage: create-application.sh [NAME] [EXECUTABLE]"
    exit 1
fi

NEW_APPLICATION_NAME="$1"
NEW_APPLICATION_EXECUTABLE=$(realpath "$2")
NEW_APPLICATION_PATH="$ROOT_PATH/applications/$NEW_APPLICATION_NAME"

if [ -d "$NEW_APPLICATION_PATH" ]
then
    echo "Application already exists"
    exit 1
fi

mkdir "$NEW_APPLICATION_PATH"
echo "Creating application at $NEW_APPLICATION_PATH"

echo "#!/bin/sh -a" >> "$NEW_APPLICATION_PATH/application.conf"
echo "APPLICATION_NAME=\"$NEW_APPLICATION_NAME\"" >> "$NEW_APPLICATION_PATH/application.conf"
echo "APPLICATION_EXECUTABLE=\"$NEW_APPLICATION_EXECUTABLE\"" >> "$NEW_APPLICATION_PATH/application.conf"
echo "APPLICATION_DXVK_CONFIG=\"$NEW_APPLICATION_PATH/dxvk.conf\"" >> "$NEW_APPLICATION_PATH/application.conf"
echo "APPLICATION_ENVIRONMENT=\"$NEW_APPLICATION_PATH/environment.conf\"" >> "$NEW_APPLICATION_PATH/application.conf"
echo "APPLICATION_SHADER_CACHE=\"$NEW_APPLICATION_PATH/shadercache\"" >> "$NEW_APPLICATION_PATH/application.conf"
echo "APPLICATION_PREFIX=\"$NEW_APPLICATION_PATH/prefix\"" >> "$NEW_APPLICATION_PATH/application.conf"

mkdir "$ROOT_PATH/shadercache/$NEW_APPLICATION_NAME"
"$ROOT_PATH/create-prefix.sh" pf_base "pf_$NEW_APPLICATION_NAME"

ln -s "$ROOT_PATH/shadercache/$NEW_APPLICATION_NAME" "$NEW_APPLICATION_PATH/shadercache"
ln -s "$ROOT_PATH/prefix/pf_$NEW_APPLICATION_NAME" "$NEW_APPLICATION_PATH/prefix"
ln -s "$ROOT_PATH/defaults/environment.conf" "$NEW_APPLICATION_PATH"
ln -s "$ROOT_PATH/defaults/dxvk.conf" "$NEW_APPLICATION_PATH"
