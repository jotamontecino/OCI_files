#!/bin/bash
set -eu -o pipefail

## General internal vars
IMAGE_REPO="${CI_REGISTRY_IMAGE:-docker.io/trashnochados/node}"
IMAGE_TAG="${CI_COMMIT_REF_SLUG:-20.17}"

echo ""
echo "Building $IMAGE_REPO:$IMAGE_TAG"

. $PWD/base/prod.sh

buildah config \
    --env NODE_VERSION=20.17.0 \
    --env NODE_VERSION_CHECKSUM=913547514c21152f09d46b8b140d30dd5ea40d2e3ac4ddc6ff3e12a666bec482 \
    --env YARN_VERSION=1.22.22 \
    $container

. $PWD/nodejs/nodejs-raw.sh

. $PWD/base/commit.sh