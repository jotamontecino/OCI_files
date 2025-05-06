#!/bin/bash
set -eu -o pipefail

## General internal vars
IMAGE_REPO="${CI_REGISTRY_IMAGE:-docker.io/trashnochados/bluesky-pds}"
IMAGE_TAG="${CI_COMMIT_REF_SLUG:-0.4.67}"

CI_REGISTRY_BASE_IMAGE=ghcr.io/bluesky-social/pds:0.4.67

echo ""
echo "Building $IMAGE_REPO:$IMAGE_TAG"

. $PWD/base/prod.sh

brun apk add --no-cache curl
brun mkdir -p /opt/scripts
buildah copy --add-history $container $PWD/bluesky_pds/scripts/account.sh /opt/scripts
buildah copy --add-history $container 'bluesky_pds/scripts/help.sh' '/opt/scripts/help.sh'
buildah copy --add-history $container 'bluesky_pds/scripts/create-invite-code.sh' '/opt/scripts/create-invite-code.sh'
buildah copy --add-history $container 'bluesky_pds/scripts/request-crawl.sh' '/opt/scripts/request-crawl.sh'
buildah copy --add-history $container 'bluesky_pds/scripts/alias.sh' '/etc/profile.d/alias.sh'


buildah config \
    --env BLUESKY_PDS_VERSION=0.4.67 \
    --env BLUESKY_SCRIPTS_VERSION=0.4.67 \
    --workingdir=/app/ \
    --env OCI_BASE_IMAGE=ghcr.io/bluesky-social/pds:0.4.67 \
    $container

. $PWD/base/commit.sh