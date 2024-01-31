#!/bin/bash
set -eu -o pipefail

. $PWD/base/prod.sh

brun apk add --no-cache bash nano httpie git curl