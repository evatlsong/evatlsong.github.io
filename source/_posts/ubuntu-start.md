---
title: ubuntu-start
date: 2017-11-15 05:36:28
tags:
---
sudo apt-get update
sudo apt-get upgrade
sudo apt-get update && apt-get install openssh-server
sudo rm /var/cache/apt/archives/lock && sudo rm /var/lib/dpkg/lock && sudo apt-get update && sudo apt-get upgrade
