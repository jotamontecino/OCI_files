#!/bin/bash
set -eu -o pipefail

## General internal vars
image="${CI_REGISTRY_IMAGE:-node16-raw}"
tag="${CI_COMMIT_REF_SLUG:-latest}"

echo ""
echo "Building $image:$tag"
node_container=$(buildah from alpine)
