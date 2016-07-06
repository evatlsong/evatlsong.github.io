---
title: front-end
date: 2015-09-15 15:51:22
tags: [front-end]
---

## nvm 
https://github.com/creationix/nvm
## node
https://nodejs.org
## npm
https://www.npmjs.com/
npm init
npm install package
npm uninstall package
npm -g install package
npm -g uninstall package
npm help json

npm install -g sinopia
sinopia

npm install -g nrm
nrm add local http://localhost:4873 
nrm use local

## yeoman
http://yeoman.io
npm install -g yo bower grunt-cli gulp
## bower
http://bower.io
## grunt

nodejs调试
npm install -g node-inspector
node-inspector
node --debug-brk app.js

node提供了两种debug模式运行：
node —debug[=port] filename （这种方式，其实就是在指定的端口（默认为 5858）监听远程调试连接）
node —debug-brk[=port] filename （这种方式在监听的同时，会在代码执行的时候，强制断点在第一行，这样有个好处就是：可以debug到node内部的是如何运行的）
