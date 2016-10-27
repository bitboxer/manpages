#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

if ! $(gem list -i manpages) ;then
  gem install manpages
fi

if [ -d "$(readlink -f ${SCRIPT_DIR}/.git)" ]; then
  DIR=$SCRIPT_DIR
else
  LIB_DIR="$(dirname "$(gem which manpages)")"
  DIR="$(readlink -f  ${LIB_DIR}/../)"
fi

source ${DIR}/libexec/vars.sh

mkdir -p "${PREFIX_MAN}"

mkdir -p $EXEC_HOOK_DIR
mkdir -p $INSTALL_HOOK_DIR

cp "${DIR}/lib/version-name-change-man.bash" $EXEC_HOOK_DIR/
cp "${DIR}/lib/install-man.bash" $INSTALL_HOOK_DIR/

ln -s $PREFIX_MAN "${RBENV_ROOT}/man"

cat <<EOM
# add the following to ~/.bashrc:
MANPATH="${RBENV_ROOT}/man:\${MANPATH}"
EOM

