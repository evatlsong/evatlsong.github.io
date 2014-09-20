title: git-svn-useage
date: 2014-09-02 22:47:43
tags: git svn
---
## 操作方法
* 从svn切换到git
	> `git svn clone --no-metadata your_svn_repository_url`
	> `git clone --bare git_repository_url git_server_url`
* 检出一个已存在svn repository(类似于svn checkout)
	> 我们可以通过 `git-svn clone` 命令完成这个操作： `git-svn clone your_svn_repository_url`

* 从中心服务器的svn repository获取最新更新
	>这个操作可以通过 `git-svn rebase` 完成。注意这里用的是rebase，而不是update。update命令对于通过git-svn检出的svn repostory的git版本库是不可用的。

* 查看提交历史日志
	>这个简单，使用 `git-svn log` ，加上-v选项，还可以提供每次commit操作涉及的相关文件的详细信息。

* 将本地代码同步到Svn服务器
	>完成这一操作需要通过 `git-svn dcommit` 命令。这个命令会将你在本地使用 `git commit` 提交到本地代码库的所有更改逐一提交到svn库中。加上-n选项，则该命令不会真正执行commit到svn的操作，而是会显示会有哪些本地变动将被commit到svn服务器。 `git-svn dcommit` 似乎不能单独提交某个本地版本的修改，而是一次批量提交所有与svn中心版本库的差异。

## 一般使用流程：

1. `git-svn clone your_svn_repository`；
2. 修改本地代码，使用 `git add/commit` 将修改提交到本地git库；
3. 定期使用 `git-svn rebase` 获取中心svn repository的更新；
4. 使用 `git-svn dcommit` 命令将本地git库的修改同步到中心svn库。

## 注意事项
1. 处理冲突
	* 假设某svn中心库上的某个项目foo中只有一个源码文件foo.c：
	* 我在使用 `git-svn clone` 检出版本时，foo.c当时只有一个commit版本信息："svn v1"；
	* clone出来后，我在本地git库中修改foo.c，并通过 `git commit` 提交到本地git库中，版本为"git v1"；
	* 不过与此同时另外一个同事也在修改foo.c这个文件，并已经将他的修改提交到了svn库中，版本为"svn v2"；
	* 此时我使用 `git-svn dcommit` 尝试提交我的改动，git-svn提示我：
	
			Committing to svn://10.10.1.1:80/foo ...
			M foo.c
			事务过时: 过期: ”foo/foo.c“在事务“260-1” at /usr/lib/git-core/git-svn line 570

	* 使用 `git-svn rebase` 获取svn服务器上的最新foo.c，导致与foo.c冲突，不过此时svn版本信息已经添加到本地git库中(通过git log可以查看)，`git-svn rebase` 提示你在解决foo.c的冲突后，运行 `git rebase --continue` 完成rebase操作；
	* 打开foo.c，修改代码，解决冲突；
	* 执行 `git rebase --continue` ，git提示我：

		    You must edit all merge conflicts and then
		    mark them as resolved using git add

	* 执行 `git add foo.c` ，告知git已完成冲突解决；
	* 再次执行 `git rebase --continue` ，提示"Applying: git v1"，此时"git v1"版本又一次成功加入本地版本库，你可通过 `git log` 查看；
	* 执行 `git-svn dcommit` 将foo.c的改动同步到svn中心库，到此算是完成一次冲突解决。

2. 分支问题

	git分支合并回master后要删除 因为使用 `git-svn rebase` 获取版本库更新会改变git历史