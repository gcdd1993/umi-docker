#!/usr/bin/env bash

# ${package_name}
VERSION=$(date "+%Y%m%d")
set -ex; \
  yarn build \
  && docker build -f docker/Dockerfile \
     -t registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:latest-snapshot \
    -t registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:"$VERSION" \
    --build-arg DIST_DIR=dist \
    . \
  && docker push registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:latest \
  && docker push registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:"$VERSION"
