#!/bin/sh
# docker-compose 启动无效  ，教程文章https://blog.csdn.net/u012960155/article/details/129277193
docker run -itd --rm --privileged --pull always --name redroid -v /data/redroid/dev_fs:/data -p 5555:5555 redroid/redroid:13.0.0_64only-latest ro.secure=0 androidboot.redroid_width=1080 androidboot.redroid_height=1920 androidboot.redroid_dpi=480