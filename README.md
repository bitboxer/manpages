# Manpages

[![Build Status](https://travis-ci.org/bitboxer/manpages.svg?branch=master)](https://travis-ci.org/bitboxer/manpages)
[![Gem](https://img.shields.io/gem/v/manpages.svg)](https://rubygems.org/gems/manpages)

This plugin will add man pages support to ruby gems. Instead 
of adding a new command like [gem-man](https://github.com/defunkt/gem-man)
it will try to link the files to a place the `man` command automatically
discovers.

With rvm and chruby it works out of the box, but sadly for rbenv we need to
[add hooks that](#using-this-with-rbenv) modify the `man` symlink depending on
the ruby version currently used.

# Installation

`gem install manpages && gem manpages --update-all`

This plugin automatically hooks into the ruby gems system. Every gem
installed afterwards is checked for manpages. If this gem finds them, it
exposes them to the `man` command.

# Using this with rbenv

Sadly rbenv uses shims to hide the actual executables. This makes it a bit
harder to make this gem work in that environment.

This gem provides hooks to change the man path for the current used ruby version.
To install them execute the following line:

```
curl -o- https://raw.githubusercontent.com/bitboxer/manpages/master/rbenv/rbenv_hook_install.sh | bash
```

After the hooks are installed, rbenv will always change the man symlink to the
currently used ruby version. Sadly rbenv does not provide a hook that is fired
when switching ruby versions. This means that the path can only be corrected
when executing a command provided by a gem. If you want to have the correct
man page for a gem, you need to execute the command of that gem, first.

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
In the newest version [kramdown](http://kramdown.gettalong.org/converter/man.html) also
is able to generate man pages.

Make sure the resulting manpage is in a folder called `man` in the root of the
gem. Files stored in that directory will automatically be exposed to the
`man` command.

Examples for gems with manpages are [guard](https://github.com/guard/guard/tree/master/man) or
[gem-man](https://github.com/defunkt/gem-man/tree/master/man).
