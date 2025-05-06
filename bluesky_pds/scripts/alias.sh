#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

alias account='/opt/scripts/account.sh $*'
alias help='/opt/scripts/help.sh $*'
alias create-invite-code='/opt/scripts/create-invite-code.sh $*'
alias request-crawl='/opt/scripts/request-crawl.sh $*'