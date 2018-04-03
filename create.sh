#/bin/sh
running=`docker container ps -q --filter "name=hexo-server" --filter "status=running"`
exited=`docker container ps -q --filter "name=hexo-server" --filter "status=exited"`
if [ -n "$running" ]; then
    echo "running"
elif [ -n "$exited" ]; then
    echo "restart"
    docker container start hexo-server
else
    echo "start"
    docker container run -p 4000:80 --name hexo-server -d -v "$PWD"/source:/Hexo/source -v "$PWD"/scaffolds:/Hexo/scaffolds -v "$PWD"/themes:/Hexo/themes -v "$PWD"/_config.yml:/Hexo/_config.yml evatlsong/hexo:3.3.9-alpine s
fi
docker container exec -t hexo-server hexo new $1
vim source/_posts/$1.md
