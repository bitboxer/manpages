# Manpages

[![Build Status](https://travis-ci.org/bitboxer/manpages.svg?branch=master)](https://travis-ci.org/bitboxer/manpages)

This plugin will add man pages support to ruby gems. Instead 
of adding a new command like [gem-man](https://github.com/defunkt/gem-man)
it will try to link the files to place that the `man` command can find.

With rvm and chruby it works out of the box, but sadly for rbenv we need to add
hooks that modify the `MANPATH` depending on the ruby version currently used.

# Installation

`gem install manpages`

This plugin automatically hooks into the ruby gems system.

# How this works

After a gem is installed, this plugin will check for a directory called `man` and
will link the manpages it finds to `BIN_DIR/../share/man`, where `BIN_DIR` is the
directory where the executable of the gem is installed.

Most man versions will automatically search this directory and no additional work
is required. So if you install a gem that includes a man page (e.g. guard), you can
simply use `man guard` and you will see the man page the gem provided.

# Using this with rbenv

Sadly rbenv uses shims to hide the actual executables. This makes it impossible for
man to find the pages. The only solution is to add hooks that modify the `MANPATH`
environment variable.

This gem will provide a hook soon to fix this issue.

