
sinopia
sinopia
bao镜像比较快。但是仍然不如在本地设个私服务器。

sudo npm install -g sinopia
sinopia
修改npm的registry到http://localhost:4873


创建新用户

$ npm adduser --registry http://localhost:4873
发布npm包

$ npm publish

npm install -g nrm
nrm add local http://localhost:4873 
nrm use local
想切换回来的时候:

nrm use npm
