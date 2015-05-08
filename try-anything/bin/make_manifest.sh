#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/..
DIR=$(pwd)

stage=$(basename $DIR)

spiff merge \
  pipeline/cf-release/cf-deployment.yml \
  pipeline/cf-release/cf-jobs.yml \
  pipeline/cf-release/cf-properties.yml \
  pipeline/cf-release/cf-lamb.yml \
  pipeline/cf-release/cf-infrastructure-warden.yml \
  pipeline/cf-stub.yml \
  environment/networks.yml \
  environment/secrets.yml \
  environment/director.yml \
  environment/name.yml \
  manifests/pipeline-inputs.yml
