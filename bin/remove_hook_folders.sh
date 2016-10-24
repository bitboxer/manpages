#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${DIR}/../libexec/vars.sh
echo "removing ${ROOT_MAN}"
rm -rf "${ROOT_MAN}"
echo "removing ${PREFIX_MAN}"
rm -rf "${PREFIX_MAN}"
echo "removing ${INSTALL_HOOK_DIR}"
rm -rf "${INSTALL_HOOK_DIR}"
echo "removing ${EXEC_HOOK_DIR}"
rm -rf "${EXEC_HOOK_DIR}"
