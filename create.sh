#/bin/sh
docker container exec -t hexo-server hexo new $1
vim source/_posts/$1.md
