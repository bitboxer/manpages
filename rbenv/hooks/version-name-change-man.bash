#!/bin/bash

set -e
[ -n "$RBENV_DEBUG" ] && set -x

SHARE_MAN="$(rbenv root)/share"
ROOT_MAN="$SHARE_MAN/man"
PREFIX_MAN="$(rbenv prefix)/share/man"

if [ "$(readlink $ROOT_MAN)" != "$PREFIX_MAN" ]; then
  [ -n "$RBENV_DEBUG" ] && echo "linking ${PREFIX_MAN} -> ${ROOT_MAN}"
  mkdir -p $SHARE_MAN
  ln -f -s $PREFIX_MAN $SHARE_MAN
fi
