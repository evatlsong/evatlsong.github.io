title: tmux
date: 2015-07-23 16:02:12
tags:
---
#Learning The Basics
##Installing tmux
###Installing Via a Package Manager

    sudo apt-get install tmux
check version

    tmux -V
###Installing from Source
The process of installing tmux is the same on both Mac OS X and Linux
You'll need the GCC compiler in either case.
For Linux users, the package management tools usually have the GCC compilers.
On Ubuntu, you simply type

    sudo apt-get install build-essential
tmux also depends on libevent and ncurses, and you'll nedd the prerequisites
for these as well. On Ubuntu, you can install these using the package manager
like this:

    sudo apt-get install libevent-dev libncurses5-dev

    ./configure
    make
    sudo make install
##Starting tmux
Starting tmux

    tmux
Close the tmux session

    exit
###Creating Named Sessions

    tmux new-session -s basic
shorten this command

    tmux new -s basic
##Detaching and Attaching Sessions
list existing tmux sessions using the command

    tmux list-sessions
shorten this command

    tmux ls
attach to the session

    tmux attach
    tmux attach -t basic
###Killing Sessions

    tmux kill-session -t basic
##Working with Windows

    tmux new -s windows -n shell
###Creating and Naming Windows
create a window

    PREFIX c
rename a window

    PREFIX ,
###Moving Between Windows

    PREFIX n
    PREFIX p
    PREFIX nubmer

display a visual menu of our windows so we can select the one we'd like

    PREFIX w
###close a window

    exit
    or
    PREFIX &
##Working with Panes

###split new pane

    PREFIX %
    PREFIX "
###cycle through the panes

    PREFIX o
    PREFIX UP, DOWN, LEFT, RIGHT
###cycle through layouts

    PREFIX SPACEBAR
###closing panes

    exit
    or
    PREFIX x

#notebook
    假定[prefix] = ctrl-b
    session
    =========================
    创建一个被命名的session -> $ tmux new -s name
    detach当前session -> [prefix] d
    查看仍然存在的session列表 -> $ tmux ls
    attach session -> $ tmux attach
    创建一个后台session -d -> $ tmux new -s second_session -d
    选择一个session进行attach -t -> $ tmux attach -t second_session
    关闭一个session -> $ tmux kill-session -t basic
    window
    ========================
    创建一个session并为默认window命名 -> $ tmux new -s basic -n shell
    创建一个window在当前的session -> [prefix] c
    重命名window -> [prefix] ,
    下一个window -> [prefix] n
    上一个window -> [prefix] p
    快速跳至$num编号的window -> [prefix] $num
    按名字打开window -> [prefix] $filename
    现实window列表并选择 -> [prefix] w
    关闭window -> [prefix] & 或 输入exit
    pane
    ==================
    竖直切pane -> [prefix] %
    水平切pane -> [prefix] "
    循环选pane -> [prefix] o
    选pane可以[prefix] 加 上下左右箭头进行选择
    循环显示5种默认样式 -> [prefix] space
    关闭pane -> [prefix] x 或 输入exit
    命令模式
    ===============
    进入命令模式 -> [prefix] :
    在buffer中操作
    ==============
    进入选择模式 -> [prefix] [
    退出 -> enter
    移动 -> 默认上下左右，可以在配置文件中选择vim模式(setw -g mode-keys vi)
    涂蓝选择 -> space
    搜索 -> ?向上搜索 /向下搜索 下一个结果n 反方向N
    复制 -> 涂蓝状态下按enter
    粘贴 -> [prefix] ]
    复制当前pane的全部可见buffer -> [prefix] : capture-pane
    其他
    =============
    把pane转化成window -> [prefix] !
    把[session]:[window].[pane]转化成当前window中的pane -> [prefix] : join-pane -s [session_name]:[window].[pane]


    Tmux – terminal multiplexer
     
    Managing tmux server
    tmux    #start tmux server
    tmux at  #attach running sesseion to terminal
    tmux ls  #list running tmux sessions
    exit     #close tmux session
     
    Sharing session between terminals
    tmux new –s session_name  #make new named session
    tmux at –t session_name    #attach to exists session(s)
    tmux kil-session –t session_name #killnamed session
     
    所有的命令以ctrl+b组合
     
    c       create new window
    n/p    move to next/previous windows
    f      find window  by name
    w     menu with all windows
    &     kill current window
    ,      rename window
     
    %     split window. Add vertical pane to right
    “      split window add horizontal pane below
    ←/ →   move focus to left/right pane
    ↑/↓      move focus to upper/lower pane
     
    !        break current pane into new window
    x        kill the current pane
     
    [        enter copy mode
    CTRL-SPACE or CTRL+@  开始选择
    移动光标到选择区域
    Alt+w 复制选择区域
    ]       粘贴选则的区域

    ?       show tmux key bindings 
