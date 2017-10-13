#!/bin/bash
aa=`docker container ps -q --filter "name=hexo-server" --filter "status=running"`
if [ -n "$aa" ]; then
    echo "running"
    exit 0
fi
aa=`docker container ps -q --filter "name=hexo-server" --filter "status=exited"`
if [ -n "$aa" ]; then
    echo "restart"
    docker container start hexo-server
    exit 0
fi
docker container run -p 4000:80 --name hexo-server -d -v "$PWD"/source:/Hexo/source -v "$PWD"/themes:/Hexo/themes -v "$PWD"/_config.yml:/Hexo/_config.yml evatlsong/hexo:3.3.9-alpine s
echo "start"
