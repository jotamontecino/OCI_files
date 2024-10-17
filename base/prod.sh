#!/bin/bash
set -eu -o pipefail

OCI_BASE_IMAGE="${CI_REGISTRY_BASE_IMAGE:-docker.io/alpine:3.20}"
container=$(buildah from $OCI_BASE_IMAGE)
echo "Container id ${container}"

## General configuration
buildah config \
  --author='Jav <jotamontecino@gmail.com>' \
  --workingdir=/usr/src/app/ \
  --env OCI_BASE_IMAGE=alpine:3.20 \
  $container

## Adding raw layers
function brun() {
  buildah run --add-history $container -- "$@"
}
function bprint() {
  buildah run $container -- /bin/sh -c "echo $@"
}

function push() {
    buildah commit --rm $container "$image:$tag"
    buildah push "$image:$tag";
}

function bcopy() {
  buildah copy --add-history $container -- "$@"
}