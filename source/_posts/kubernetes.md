---
title: kubernetes
date: 2017-11-26 03:24:55
tags: kubernetes
---

根据Service的唯一名字 容器可以从环境变量中获取到Service对应的Cluster IP地址和端口 从而发起请求

service 通过标签选择器 选择pod
node 既可以是物理机 也可以是虚拟机
pod 运行在node中 具有标签
每个pod里运行一个pause容器 pod中的其他容器共享 pause容器的网络栈与volume挂载卷

节点分master节点与工作节点
master节点
kubernetes api server
kubernetes controller manager
kubernetes scheduler
etcd server

工作节点
kubelet
kube-proxy
docker engine
