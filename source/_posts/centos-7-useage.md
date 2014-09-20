title: centos-7-useage
date: 2014-09-17 18:03:32
tags:
---
centos7 有两个防火墙 firewalld iptables 默认firewalld 不能同时共存

	systemctl status iptables.service
	systemctl stop firewalld.service
	systemctl disable firewalld.service
	systemctl enable iptables.service
	systemctl start iptables.service

centos7 网络管理从network.service 换成了NetworkManager.service

管理服务用systemctl

