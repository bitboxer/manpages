#!/bin/bash

set -e
[ -n "$RBENV_DEBUG" ] && set -x

ROOT_MAN="$(rbenv root)/man"
PREFIX_MAN="$(rbenv prefix)/share/man"

if [ "$(readlink $ROOT_MAN)" != "$PREFIX_MAN" ]; then
  [ -n "$RBENV_DEBUG" ] && echo "removing ${ROOT_MAN}"
  rm -rf "${ROOT_MAN}"
  [ -n "$RBENV_DEBUG" ] && echo "linking ${PREFIX_MAN} -> ${ROOT_MAN}"
  ln -s "${PREFIX_MAN}" "${ROOT_MAN}"
fi

