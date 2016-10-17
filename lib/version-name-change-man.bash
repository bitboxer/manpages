#!/bin/bash

ROOT_MAN="$(rbenv root)/man"
PREFIX_MAN="$(rbenv prefix)/share/man"

if [ "$(readlink $ROOT_MAN)" != "$PREFIX_MAN" ]; then
  rm -rf "${ROOT_MAN}"
  ln -s "${PREFIX_MAN}" "${ROOT_MAN}"
fi
