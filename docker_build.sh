#!/usr/bin/env bash

# fine-digit-edu-webui-old
org_name="frbbs"
package_name="umi-docker"
set -ex; \
  yarn build \
  && docker build -f docker/Dockerfile \
    -t registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:latest-snapshot \
    --build-arg DIST_DIR=dist \
    . \
  && docker push registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:latest-snapshot
