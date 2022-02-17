#!/bin/bash
set -eu -o pipefail

## General internal vars
image="${CI_REGISTRY_IMAGE:-node16-raw}"
tag="${CI_COMMIT_REF_SLUG:-latest}"

echo ""
echo "Building $image:$tag"
node_container=$(buildah from alpine)

## General configuration
buildah config \
  --author='Jav <jotamontecino@gmail.com>' \
  --workingdir=/usr/src/app/ \
  $node_container

## Adding raw layers
function brun() {
  buildah run $node_container -- "$@"
}

## Set alpine as starting point
brun apk add --no-cache bash
brun apk add --no-cache --update nodejs npm

brun npm i -g npx yarn

## Creating image
buildah commit --rm $node_container "$image:$tag"
