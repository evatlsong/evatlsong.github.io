---
title: docker
date: 2017-11-13 08:55:16
tags: ubuntu
---
镜像(Image)
容器(Container)
仓库(Repository)

Docker 镜像就是一个只读的模板 包含一个完整的操作系统环境
容器是从镜像创建的运行实例
镜像是只读的 容器在启动的时候创建一层可写层作为最上层

RUN 开头的指令会在创建中运行 比如安装一个软件包

docker build -t="evatlsong/redis:v2" .
docker save -o ubuntu.tar ubuntu:14.04
docker load --input ubuntu.tar
docker container rm $(docker container ls -a -q)
