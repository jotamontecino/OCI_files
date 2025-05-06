#!/bin/bash
set -eu -o pipefail

## General internal vars
IMAGE_REPO="${CI_REGISTRY_IMAGE:-docker.io/trashnochados/node}"
IMAGE_TAG="${CI_COMMIT_REF_SLUG:-22.14-dev}"

echo ""
echo "Building $IMAGE_REPO:$IMAGE_TAG"

. $PWD/base/dev.sh

buildah config \
    --env NODE_VERSION=22.14.0 \
    --env NODE_VERSION_CHECKSUM=87f163387ac85df69df6eeb863a6b6a1aa789b49cda1c495871c0fe360634db3 \
    --env YARN_VERSION=1.22.22 \
    $container

. $PWD/nodejs/nodejs-raw.sh

brun yarn global add clinic eslint jest vm2 @usebruno/cli

. $PWD/base/commit.sh