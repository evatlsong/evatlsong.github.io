---
title: git-usage
date: 2014-09-15 16:35:26
tags: [git]
---

## 配置
	$ git config --global user.name "Your Name Comes Here"
	$ git config --global user.email you@yourdomain.example.com
	$ git config --list 查看相关信息
## 初始化
	$ mkdir gitdata
	$ cd gitdata
	$ git init
	or Server
	$ git --bare init

## 在~/.gitconfig设置别名
    ### command
    git config --global alias.lg "log --oneline --all --graph --decorate --color"
    ### file
	[alias]
	st = status
	ci = commit -a
	co = checkout  
## 文件操作
	$ git add .
	$ git add file1 file2 file3
	$ git add -u
	$ git add -p // 为你做的每次修改，Git将为你展示变动的代码，并询问该变动是否应是下一次提交的一部分。回答“y”或者“n”。也有其他选项，比如延迟决定：键入“？”来学习更多。
	$ git rm file1 file2 file3
	$ git mv file1 file2

## 提交更改
	$ git commit -a -m ' '
	$ git commit --amend -a -m ' ' // 修改上一次的信息，不作为新的提交
	$ git stash // 保存当前草稿，便于切换分支
	$ git stash pop
	$ git stash apply
	$ git stash list
	$ git stash apply stash@{1}
	$ git stash clear

## 撤销更改
	$ git reset HEAD file1 // 取消暂存区的文件快照(即恢复成最后一个提交版本)，这不会影响工作目录的文件修改。
	$ git reset --hard HEAD^ // 将整个项目回溯到以前的某个版本，可以使用 "git reset"。可以选择的参数包括默认的 "--mixed" 和 "--hard"，前者不会取消工作目录的修改，而后者则放弃全部的修改。该操作会丢失其后的日志
	$ git checkout -- file1 // 使用暂存区快照恢复工作目录文件，工作目录的文件修改被抛弃。
	$ git checkout HEAD^ file1 // 直接 "签出" 代码仓库中的某个文件版本到工作目录，该操作同时会取消暂存区快照。
	$ git checkout "@{10 minutes ago}" // 直接 "签出" 10分钟之前代码仓库中的某个文件版本到工作目录，该操作同时会取消暂存区快照。
	$ git checkout "@{5}" // 直接 "签出" 倒数第五次保存的某个文件版本到工作目录，该操作同时会取消暂存区快照。
	$ git revert SHA1_HASH // 还原特定哈希值对应的提交。该还原记录作为一个新的提交。

## 查看历史纪录或者当前状态
    $ git log --all --graph --oneline --decorate
	$ git log
	$ git log -p
	$ git log --stat --summary
	$ git log V3..V7 //显示V3之后直至V7的所有历史记录
	$ git log V3.. //显示所有V3之后的历史记录。注意<since>..<until>中任何一个被省略都将被默认设置为HEAD。所以如果使用..<until>的话，git log在大部分情况下会输出空的。
	$ git log –since=”2 weeks ago” //显示2周前到现在的所有历史记录。具体语法可查询git-ref-parse命令的帮助文件。
	$ git log stable..experimental //将显示在experimental分支但不在stable分支的历史记录
	$ git log experimental..stable //将显示在stable分支但不在experimental分支的历史记录
	$ git log -S'你要找的内容'，就可以从全部的历史纪录，瞬間找到你要找的东西
	$ git blame FILE // 标注出一个指定的文件里每一行内容的最后修改者，和最后修改时间。
	$ git diff // 这个命令只在git add之前使用有效。如果已经add了，那么此命令输出为空
	$ git diff –cached // 这个命令在git add之后在git commit之前有效。
	$ git diff "@{yesterday}" // 比较当前和昨天的内容
	$ git status // 这个命令在git commit之前有效，表示都有哪些文件发生了改动
	$ git show 5b888 // 使用git show再加上述的commit名称来显式更详细的commit信息
	$ git show master // 显示分支信息
	$ git show HEAD // 使用HEAD字段可以代表当前分支的头（也就是最近一次commit)
	$ git show HEAD^ //查看HEAD的父母的信息, 可以使用^表示parent
	$ git show HEAD^^ //查看HEAD的父母的父母的信息
	$ git show HEAD~4 //查看HEAD上溯4代的信息
	$ git tag V3 5b888 //以后可以用V3来代替复杂的名称(5b888…)
	$ git show V3
	$ git branch stable V3 //建立一个基于V3的分支
	$ git grep “print” V3 //在V3中搜索所有的包含print的行
	$ git grep “print” //在所有的历史记录中搜索包含print的行

    $ git show branch:filepath

## 协作操作
	$ git clone git://server/path/to/files // Git deamon
	$ git clone your.computer:/path/to/script  or git clone ssh://car.colorado.edu/home/xxx ./xxxxx // SSH
	$ git pull
	$ git push // 在将代码提交(push)到服务器之前，首先要确认相关更新已经合并(merge)到主分支(master)。还应该先从服务器刷新(pull)最新代码，以确保自己的提交不会和别人最新提交的代码冲突。

如果想在merge前先查看更改：

	$ git fetch /home/bob/myrepo master:bobworks //此命令意思是提取出bob修改的代码内容，然后放到我（rocrocket）工作目录下的bobworks分支中。之所以要放到分支中，而不是master中，就是要我先仔仔细细看看bob的开发成果，如果我觉得满意，我再merge到master中，如果不满意，我完全可以直接git branch -D掉。
	$ git whatchanged -p master..bobworks //用来查看bob都做了什么
	$ git checkout master //切换到master分区
	$ git pull . bobworks //如果我检查了bob的工作后很满意，就可以用pull来将bobworks分支合并到我的项目中了
## 分支管理
	$ git branch: 查看当前分支
	$ git checkout -b/branch experimental： 创建新分支
	$ git checkout experimental： 切换到另一分支
	$ git merge experimental：合并分支
	$ git branch -d experimental：删除分支, 使用的是小写的-d，表示“在分支已经合并到主干后删除分支”。
	$ git branch -D experimental：删除分支, 表示“不论如何都删除分支”，-D使用在“分支被证明失败”
## 补丁工作
git format-patch：当你想给一个开源项目（例如Rails）提交一段代码的时候，或者你想给小组成员展示一段你并不想提交的代码，那么你还是需要 patch的，Git的'format-patch'命令良好的支持了这个功能。

1. 利用branch命令 创建一个分支；
2. 修改你的代码；
3. 在该分支上提交你的修改；
4. 使用`git format-patch`命令来生成一个patch文件，
   例如：`git format-patch master --stdout > ~/Desktop/tmp.patch`就是将工作分支与master主干的不同，
   存放在`~/Desktop`文件夹下，生成一个叫做 tmp.patch的文件
   （另一种简单的版本是利用diff命令，例如`git diff ..master > ~/Desktop/tmp.patch`），
   这样就生成了patch文件。那么别人就可以使用`git apply`命令来应用patch，例如`git apply ~/Desktop/tmp.patch`就是将patch打在当前的工作分支上

## 仓库维护
	$ git fsck: 不加–full参数的情况下，这个命令一般会以非常低廉的代价确保仓库在一个不错的健康状态之中。
	$ git count-objects: 统计有多少松散的对象，没有 repack 的对象消耗了多少硬盘空间。
	$ git gc: 在本地仓库进行 repack，并进行其他日常维护工作。
	$ git filter-branch --tree-filter `rm top/secret/file` HEAD //在所有记录中永久删除某个文件
	$ git rebase -i HEAD~10 // 后10个提交会出现在你喜爱的$EDITOR。通过删除行来移去提交。通过为行重新排序来为提交重新排序。用“edit”来替换“pick”来标志一个提交可修改。用“squash”来替换“pick”来将一个提交和前一个合并。
## 错误查询
刚刚发现程序里有一个功能出错了，即使你过去经常提交变更，Git还是可以精确的找出问题所在：

	$ git bisect start
	$ git bisect bad SHA1_OF_BAD_VERSION
	$ git bisect good SHA1_OF_GOOD_VERSION

Git从历史记录中检出一个中间的状态，在这个状态上测试功能，如果还是错误的：

	$ git bisect bad

如果可以工作了，则把"bad"替换成"good"。 Git会再次帮你找到一个以确定的好版本和坏版本之间的状态，经过一系列的迭代，这种二进制查询会帮你找到导致这个错误的那次提交。一旦完成了问题定位的调查，你可以返回到原始状态，键入：

	$ git bisect reset

不需要手工测试每一次改动，执行如下命令可以自动的完成上面的搜索：

	$ git bisect run COMMAND

Git使用指定命令（通常是一个一次性的脚本）的返回值来决定一次改动是否是正确的：命令退出时的代码0代表改动是正确的，125代表要跳过对这次改动的检查，1到127之间的其他数值代表改动是错误的。返回负数将会中断整个bisect的检查。
