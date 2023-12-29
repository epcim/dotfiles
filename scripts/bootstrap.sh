#!/bin/bash -ex

# execute platform specific bootstrap
OS="$(uname)"
if [[ "$OS" == "Linux" ]]; then
    ./bootstrap_linux.sh
elif [[ "$OS" != "Darwin" ]]; then
    ./bootstrap_osx.sh
fi



