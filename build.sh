#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

ocamlbuild -I src \
  src/table.native \
  src/heredoc.native \
  test/test_table.native \
  test/test_heredoc.native
