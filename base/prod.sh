#!/bin/bash
set -eu -o pipefail

OCI_BASE_IMAGE="${CI_REGISTRY_IMAGE:-docker.io/alpine:3.18.4}"
container=$(buildah from $OCI_BASE_IMAGE)
echo "Container id ${container}"

## General configuration
buildah config \
  --author='Jav <jotamontecino@gmail.com>' \
  --workingdir=/usr/src/app/ \
  $container

## Adding raw layers
function brun() {
  buildah run $container -- "$@"
}

function push() {
    buildah commit --rm $container "$image:$tag"
    buildah push "$image:$tag";
}