#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

if ! $(gem list -i manpages) ;then
  gem install manpages
fi

if [[ -n "$(command -v git)" && \
        "$(basename $(git config --local remote.origin.url))" == "manpages.git" ]]; then
  DIR=$SCRIPT_DIR
else
  LIB_DIR="$(dirname "$(gem which manpages)")"
  DIR="$(readlink -f  ${LIB_DIR}/../)"
fi

if [ "$DIR" != "$(rbenv root)" ]; then
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
else
  echo "cannot find gem folder"
fi
