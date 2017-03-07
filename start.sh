#!/bin/sh
docker container run -p 4000:80 --name hexo-server -d -v "$PWD"/source:/Hexo/source -v "$PWD"/themes:/Hexo/themes -v "$PWD"/_config.yml:/Hexo/_config.yml evatlsong/hexo:6.10 s
