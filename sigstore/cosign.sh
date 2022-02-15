#!/bin/bash
set -eu -o pipefail

## General internal vars
image="${CI_REGISTRY_IMAGE:-cosign}"
cosign_version="${COSIGN_VERSION:-v1.5.1}"
arch="${ARCH:-amd64}"

echo ""
echo "Building $image:$cosign_version"
cosign_container=$(buildah from alpine:3.14)

## General configuration
buildah config \
  --author='Jav <jotamontecino@gmail.com>' \
  --workingdir=/usr/src/cosign/ \
$cosign_container

## Adding raw layers
function brun() {
  buildah run $cosign_container -- "$@"
}

## add he cosign runtime
brun wget https://github.com/sigstore/cosign/releases/download/${cosign_version}/cosign-linux-${arch}
brun mv ./cosign-linux-${arch} /usr/bin/cosign
brun chmod +x /usr/bin/cosign

## Creating image
buildah commit --rm $cosign_container "$image:$cosign_version"
