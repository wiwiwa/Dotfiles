#!/bin/sh

set -e
SCRIPT_NAME=$(basename "$0")
DIR=$(readlink -f $(dirname "$0"))
for file in $DIR/dot/*; do
  destFile=$HOME/.${file##*/}
  test ! -e $destFile &&
        echo Creating link for $destFile ... &&
        ln -sf $file $destFile
done
