#!/bin/bash

set -euC
# set -o pipefail

command -v flavours > /dev/null || exit 0

if [ ! -f ~/.config/quickshell/hyprmenu/Base16.qml ] || [ ! -f ~/.config/quickshell/launcher/Base16.qml ]
then
  flavours apply atlas
fi
