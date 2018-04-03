title: windows10 subsystem linux
date: 2014-08-26 00:09:31
tags: windows subsystem linux
---
windows 10 subsystem linux 安装后配置
装好oh my zsh后进入系统是不启动zsh解决方案
home目录 .bashrc 文件开头加入以下代码

    # Launch Zsh
    if [ -t 1 ]; then
    cd ~
    exec zsh
    fi
