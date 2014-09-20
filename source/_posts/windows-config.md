title: windows-config
date: 2014-09-20 11:52:53
tags:
---
## 配置VIM
安装Msysgit

git bash下执行命令

	git clone https://github.com/evatlsong/system.git
	git clone https://github.com/gmarik/vundle.git "C:\Users\evasong10\.vim\bundle\vundle"
以管理员权限运行ms-dos

	mklink "C:\Users\evasong10\.vimrc" "E:\system\config\.win_vimrc"
git bash下执行命令

	vim +BundleInstall +qall
