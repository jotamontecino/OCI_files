#!/bin/bash
set -eu -o pipefail

## General internal vars
IMAGE_REPO="${CI_REGISTRY_IMAGE:-docker.io/trashnochados/cosign}"
IMAGE_TAG="${CI_COMMIT_REF_SLUG:-2.2}"

echo ""
echo "Building $IMAGE_REPO:$IMAGE_TAG"

. $PWD/base/prod.sh

buildah config \
    --env COSIGN_VERSION=v2.2.1 \
    --env COSIGN_VERSION_CHECKSUM=b02028add9898575516a2626a5f1a262f080291d8f253ba1fd61cedb0e476591 \
    --workingdir=/usr/src/cosign/ \
    $container

echo ""
bprint 'Installing Cosgin: "$COSIGN_VERSION"'
echo "###################"
bprint 'Installing Cosgin: https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-linux-amd64'

brun /bin/sh -c 'wget https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-linux-amd64'
brun /bin/sh -c 'mv ./cosign-linux-amd64 /usr/bin/cosign'
brun /bin/sh -c 'chmod +x /usr/bin/cosign'

. $PWD/base/commit.sh