# Manpages

[![Build Status](https://travis-ci.org/bitboxer/manpages.svg?branch=master)](https://travis-ci.org/bitboxer/manpages)
[![Gem](https://img.shields.io/gem/v/manpages.svg?maxAge=2592000)](https://rubygems.org/gems/manpages)

This plugin will add man pages support to ruby gems. Instead 
of adding a new command like [gem-man](https://github.com/defunkt/gem-man)
it will try to link the files to a place the `man` command automatically
discovers.

With rvm and chruby it works out of the box, but sadly for rbenv we need to [add
hooks that](#using-this-with-rbenv) modify the `MANPATH` depending on the ruby version currently used.

# Installation

`gem install manpages`

This plugin automatically hooks into the ruby gems system. Every gem
installed afterwards is checked for manpages. If this gem finds them, it
exposes them to the `man` command.

# Using this with rbenv

Sadly rbenv uses shims to hide the actual executables. This makes it impossible for
man to find the pages. The only solution is to add hooks that modify the `MANPATH`
environment variable.

This gem will [soon](https://github.com/bitboxer/manpages/issues/2) provide a hook to fix this problem.

# How this works

After a gem is installed, this plugin will check for a directory called `man` within the 
gem and link the manpages it finds to `BIN_DIR/../share/man`, where `BIN_DIR` is the
directory where the executable of the gem is installed.

Most man versions will automatically search this directory and no additional work
is required. If you install a gem that includes a man page (e.g. [guard](https://github.com/guard/guard)), you can
simply use `man guard` and you will see the man page the gem provided.

# Providing man pages with your gem

The most common way in the ruby world to create a man page is through a tool
called [ronn](https://github.com/rtomayko/ronn#readme). Ronn uses a modified
variant of markdown as source file. More details about the format can be found
[here](https://github.com/rtomayko/ronn/blob/master/man/ronn-format.7.ronn).

Make sure the resulting manpage is in a folder called `man` in the root of the
gem. Files stored in that directory will automatically be exposed to the
`man` command.

Examples for gems with manpages are [guard](https://github.com/guard/guard/tree/master/man) or
[gem-man](https://github.com/defunkt/gem-man/tree/master/man).
