#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
manifest=${manifest:-"manifests/manifest.yml"}

set -e

cd $DIR/..


if [[ ! -f releases/cf/version ]]; then
  echo "missing resource input ${stage}/releases/cf/version"
  exit 1
fi
CF_VERSION=$(cat releases/cf/version)

if [[ ! -f stemcell/version ]]; then
  echo "missing resource input ${stage}/stemcell/version"
  exit 1
fi
STEMCELL_VERSION=$(cat stemcell/version)

mkdir -p manifests
cat >manifests/pipeline-inputs.yml <<EOF
---
meta:
  release_versions:
    cf: "$CF_VERSION"
  stemcell:
    version: "$STEMCELL_VERSION"
EOF

./bin/make_manifest.sh $@ > $manifest
