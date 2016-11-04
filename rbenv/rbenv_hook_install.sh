#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "$0" )/../" && pwd )"

if [ -z $GEM_NAME ]; then
  GEM_NAME="manpages"
fi
if ! $(gem list -i "$GEM_NAME") ;then
  gem install "$GEM_NAME"
fi

if [ -n "$(command -v git)" ] && \
  [ "$(basename $(git config --local remote.origin.url) 2>/dev/null)" = "manpages.git" ]; then
  DIR=$SCRIPT_DIR
else
  LIB_DIR="$(dirname "$(gem which manpages)")"
  DIR="$(readlink -f  ${LIB_DIR}/../)"
fi

if [ "$DIR" != "$(rbenv root)" ]; then
  . "${DIR}/rbenv/vars.sh"

  mkdir -p "${PREFIX_MAN}"

  mkdir -p $EXEC_HOOK_DIR
  mkdir -p $INSTALL_HOOK_DIR

  cp "${DIR}/rbenv/hooks/version-name-change-man.bash" $EXEC_HOOK_DIR/
  cp "${DIR}/rbenv/hooks/install-man.bash" $INSTALL_HOOK_DIR/

  ln -sf $PREFIX_MAN "${ROOT_MAN}"
  echo "manpages gem installed"
else
  echo "cannot find gem folder"
fi
