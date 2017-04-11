---
title: solr
date: 2017-03-16 03:47:45
tags: solr
---
# 安装
# 配置
# 启动

    bin/solr start -force -c -z 192.168.60.74:8082 -s /soft/solr/data/node1/
    bin/solr stop -all
    bin/solr create -force -c resource  -d /soft/solr/config/nerc/ -n nercConfig
    bin/solr zk upconfig -z 192.168.60.74:8082 -n nercConfig -d /soft/solr/config/nerc/

# 原理
