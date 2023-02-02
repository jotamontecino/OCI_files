#!/bin/bash
set -eu -o pipefail

## General internal vars
image="${CI_REGISTRY_IMAGE:-node-dev_env-16}"
tag="${CI_COMMIT_REF_SLUG:-latest}"


echo ""
echo "Building $image:$tag"
node_container=$(buildah from node16-raw:latest)

## General configuration
buildah config \
  --author='Jav <jotamontecino@gmail.com>' \
  --workingdir=/usr/src/app/ \
  $node_container

## Adding raw layers
function brun() {
  buildah run $node_container -- "$@"
}

#
brun npm install -g clinic jest yarn newman

echo ""
echo "Building $image:$tag"
node_container=$(buildah from alpine)
