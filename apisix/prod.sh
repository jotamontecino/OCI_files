#!/bin/bash
set -eu -o pipefail

IMAGE_REPO="docker.io/trashnochados/apisix"
IMAGE_TAG="3.12.0-debian"
OCI_BASE_IMAGE="${CI_REGISTRY_BASE_IMAGE:-docker.io/apache/apisix:3.12.0-debian}"
container=$(buildah from $OCI_BASE_IMAGE)
echo "Container id ${container}"

## General configuration
buildah config \
  --author='Jav <jotamontecino@gmail.com>' \
  --workingdir=/usr/src/app/ \
  --env OCI_BASE_IMAGE=apisix-3.12.0-debian \
  $container


buildah copy --chown apisix:apisix --add-history $container './apisix/src/plugins/*' '/usr/local/apisix/apisix/plugins'
buildah copy --chown apisix:apisix --add-history $container './apisix/src/t/*' '/usr/local/apisix/apisix/t'


. $PWD/base/commit.sh