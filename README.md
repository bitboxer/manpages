# Manpages

[![Build Status](https://travis-ci.org/bitboxer/manpages.svg?branch=master)](https://travis-ci.org/bitboxer/manpages)

This experiment will add man pages support to ruby gems. Instead 
of adding a new command like [gem-man](https://github.com/defunkt/gem-man)
it will try to copy the files to place that the `man` command can find.

Sadly this means that for rbenv and rvm we need to add hooks that modify
the `MANPATH` depending on the ruby version currently used.

