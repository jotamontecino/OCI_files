#!/bin/bash
set -eu -o pipefail

## Commit the Image with the given repo/tag and push it
buildah commit --rm $container "$IMAGE_REPO:$IMAGE_TAG"
buildah push "$IMAGE_REPO:$IMAGE_TAG";