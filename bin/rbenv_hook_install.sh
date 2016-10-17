#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PREFIX_MAN="$(rbenv prefix)/share/man"
mkdir -p "${PREFIX_MAN}"

RBENV_ROOT=`rbenv root`

HOOK_DIR="${RBENV_ROOT}/plugins/tst/etc/rbenv.d/exec"

mkdir -p $HOOK_DIR

cp "${DIR}/../lib/version-name-change-man.bash" $HOOK_DIR/

gem install manpages

ln -s $PREFIX_MAN "${RBENV_ROOT}/man"

cat <<EOM
# add the following to ~/.bashrc:
MANPATH="${RBENV_ROOT}/man:\${MANPATH}"
EOM

