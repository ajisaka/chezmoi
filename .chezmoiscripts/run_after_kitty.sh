#!/bin/bash

set -euC
# set -o pipefail

killall -SIGUSR1 kitty ||:
