#!/bin/bash
set -eu -o pipefail

## General internal vars
image="${CI_REGISTRY_IMAGE:-node}"
tag="${CI_COMMIT_REF_SLUG:-18.18}"

echo ""
echo "Building $image:$tag"

. $PWD/base/prod.sh

buildah config \
    --env NODE_VERSION=18.18.2 \
    --env NODE_VERSION_CHECKSUM=b02028add9898575516a2626a5f1a262f080291d8f253ba1fd61cedb0e476591 \
    --env YARN_VERSION=1.22.19 \
    $container

. $PWD/nodejs/nodejs-raw.sh

## Creating image
buildah commit --rm $container "$image:$tag"
buildah push "$image:$tag";