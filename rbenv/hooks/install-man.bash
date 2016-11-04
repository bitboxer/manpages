#!/bin/bash

if declare -Ff after_install >/dev/null; then
  after_install install_manpages
else
  echo "rbenv: rbenv-default-gems plugin requires ruby-build 20130129$"
fi

install_manpages() {
  gem install manpages < /dev/null || {
    echo "rbenv: error installing gem 'manpages'"
  } >&2
}
