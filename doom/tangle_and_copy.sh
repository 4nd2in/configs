#!/usr/bin/env sh
echo "tangle config.org"
emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "config.org")'
echo "copying tangled file config.el to ~/.doom.d/config.el"
cp config.el ~/.doom.d/config.el

