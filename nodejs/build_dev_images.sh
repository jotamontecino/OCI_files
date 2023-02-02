#!/bin/bash
set -eu -o pipefail

## General internal vars
read -p 'Service: ' CI_REGISTRY_IMAGE
read -p 'Tag: ' CI_COMMIT_REF_SLUG
image="${CI_REGISTRY_IMAGE:-node-dev_env-16}"
tag="${CI_COMMIT_REF_SLUG:-latest}"

cls
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
brun yarn install

echo ""
echo "Building $image:$tag"
node_container=$(buildah from alpine)
