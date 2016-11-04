#!/bin/bash
DIR="$( cd "$( dirname "$0" )/../" && pwd )"

. ${DIR}/rbenv/vars.sh

echo "removing $ROOT_MAN"
rm -rf "$ROOT_MAN"
echo "removing $PREFIX_MAN"
rm -rf "$PREFIX_MAN"
echo "removing $INSTALL_HOOK_DIR"
rm -rf "$INSTALL_HOOK_DIR"
echo "removing $EXEC_HOOK_DIR"
rm -rf "$EXEC_HOOK_DIR"

if [ -z $GEM_NAME ]; then
  GEM_NAME="manpages"
fi

gem uninstall "$GEM_NAME"
