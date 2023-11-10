#!/bin/bash
set -eu -o pipefail

## General internal vars
IMAGE_REPO="${CI_REGISTRY_IMAGE:-docker.io/trashnochados/node}"
IMAGE_TAG="${CI_COMMIT_REF_SLUG:-18.18}"

echo ""
echo "Building $IMAGE_REPO:$IMAGE_TAG"

. $PWD/base/dev.sh

buildah config \
    --env NODE_VERSION=18.18.2 \
    --env NODE_VERSION_CHECKSUM=b02028add9898575516a2626a5f1a262f080291d8f253ba1fd61cedb0e476591 \
    --env YARN_VERSION=1.22.19 \
    $container

. $PWD/nodejs/nodejs-raw.sh

. $PWD/base/commit.sh