---
title: ssh
date: 2015-08-15 12:58:36
tags: [ssh]
---

    sshd status
    sudo apt install openssh-server

    ssh-keygen -f openwrt_rsa // 在mac下密码不能为空 否则提示输入时 没有输入的话会报错
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/openwrt_rsa.pub
    ssh-add ~/.ssh/openwrt_rsa // 解决mac下总是要输入key的密码的问题 即使密码为空也要输入 用到了ssh-agent

    scp ~/.ssh/openwrt_rsa.pub openwrt:/tmp

    cat /tmp/openwrt_rsa.pub >> /etc/dropbear/authorized_keys
    chmod 0600 authorized_keys

