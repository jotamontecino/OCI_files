#!/bin/bash
set -eu -o pipefail

## General internal vars
image="${CI_REGISTRY_IMAGE:-kratos}"
tag="${CI_COMMIT_REF_SLUG:-v0.8.2-alpha.1}"

echo ""
echo "Building $image:$tag"
kratos_container=$(buildah from docker.io/golang:1.17-alpine3.15)

## General configuration
buildah config \
  --author='Jav <jotamontecino@gmail.com>' \
  --workingdir=/home/ory/ \
  $kratos_container

buildah run $kratos_container -- apk add -U --no-cache ca-certificates gcompat

## Pull the version birany from Github Release Sources
wget https://github.com/ory/kratos/releases/download/v0.8.2-alpha.1/kratos_${tag:1}-linux_64bit.tar.gz

mkdir release
tar -xzvf kratos_${tag:1}-linux_64bit.tar.gz -C ./release
rm kratos_${tag:1}-linux_64bit.tar.gz

buildah copy $kratos_container ./release/kratos /usr/bin/kratos
rm -rf release
