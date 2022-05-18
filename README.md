# umi project

## Getting Started

Install dependencies,

```bash
$ yarn
```

Start the dev server,

```bash
$ yarn start
```

## Docker打包

```bash
# 打包测试
./docker_build.sh
# 打包生产
./docker_build_prod.sh
```

打包完成后可以启动，例如打包完成的docker镜像为`registry.cn-shanghai.aliyuncs.com/frbbs/umi-docker:latest-snapshot`

```bash
docker run -p 8081:80 registry.cn-shanghai.aliyuncs.com/frbbs/umi-docker:latest-snapshot
```

访问http://localhost:8081/可以看到

![image-20220518092730090](https://img.gcdd.top/img/image-20220518092730090.png)

## `docker_build.sh`和`docker_build_prod.sh`区别？

一般，我们测试时，为了方便发布，采用单一tag的方式，比如`latest-snapshot`，所以`docker_build.sh`长这样

```bash
#!/usr/bin/env bash

# fine-digit-edu-webui-old
org_name="xxx"
package_name="xxx"
set -ex; \
  yarn build \
  && docker build -f docker/Dockerfile \
    -t registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:latest-snapshot \
    --build-arg DIST_DIR=dist \
    . \
  && docker push registry.cn-shanghai.aliyuncs.com/${org_name}/${package_name}:latest-snapshot
```

而发布生产，要考虑版本隔离，便于回滚发布，所以`docker_build_prod.sh`长这样

```bash
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
```

其中，`VERSION`也可以使用`git version`

## Nginx？

```nginx
upstream xxx.ui {
    ip_hash localhost:8081;
}
server {
    server_name xxx.com;
    location / {
        proxy_pass http:xxx.ui;
    }
}
```



