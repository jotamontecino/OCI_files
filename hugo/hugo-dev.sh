#!/bin/bash
set -eu -o pipefail

## General internal vars
IMAGE_REPO="${CI_REGISTRY_IMAGE:-docker.io/trashnochados/hugo}"
IMAGE_TAG="${CI_COMMIT_REF_SLUG:-0.143.0-ext}"

CI_REGISTRY_BASE_IMAGE=docker.io/golang:1.22rc2-bookworm

echo ""
echo "Building $IMAGE_REPO:$IMAGE_TAG"

. $PWD/base/prod.sh

echo "Copying DART SASS"
DART_SASS=$(curl -s https://api.github.com/repos/sass/dart-sass/releases/latest | grep "browser_download_url.*dart-sass-.*-linux-x64.tar.gz" | cut -d : -f 2,3 | tr -d \")
wget $DART_SASS -O /tmp/dart_saas.tar.gz
tar -zxf /tmp/dart_saas.tar.gz -C /tmp/
buildah copy --add-history $container '/tmp/dart-sass/sass' '/bin'
rm -r /tmp/dart*

echo "Copying HUGO"
HUGO=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "browser_download_url.*hugo_extended.*_linux-amd64.tar.gz" | head --lines 1 | cut -d : -f 2,3 | tr -d \")
wget $HUGO -O /tmp/hugo.tar.gz
tar -xzf /tmp/hugo.tar.gz -C /tmp/
buildah copy --add-history $container '/tmp/hugo' '/bin'
rm /tmp/hugo*


buildah config \
    --env HUGO_VERSION=0.143.0 \
    $container

. $PWD/base/commit.sh
