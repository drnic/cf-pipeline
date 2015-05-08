#!/bin/bash

# Inputs are:
# - {name: make-manifest, path: .}
# - {name: release-version}
# - {name: release-cf}
# - {name: stemcell}

if [[ ! -f release-version/number ]]; then
  echo "save_deployment_pipeline.sh requires release-version/number to contain the candidate version number"
  exit 1
fi
release_version=$(cat release-version/number)

mkdir -p pipeline-assets/releases/cf
mkdir -p pipeline-assets/stemcell

cp release-concourse/* pipeline-assets/releases/cf/
rm pipeline-assets/releases/cf/*.tgz

cp stemcell/* pipeline-assets/stemcell/
rm pipeline-assets/stemcell/*.tgz

pipeline=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
cp -r $pipeline/pipeline pipeline-assets/
cp -r $pipeline/bin pipeline-assets/

# do not include environment/ folder as each subsequent stage has own environment/ folder for its specific differences

ls -la pipeline-assets/

tar -cvzf pipeline-assets-${release_version}.tgz pipeline-assets

ls -lah pipeline-assets*.tgz
