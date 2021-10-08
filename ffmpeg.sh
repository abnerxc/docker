#!/bin/bash
docker run -it -v /Users/abner/work/ffdev:/root --entrypoint='sh'  jrottenberg/ffmpeg:4.1-alpine "$@"
# 进入容器 docker attach jrottenberg/ffmpeg:4.1-alpine 
# ffmpeg  -i 'https://cdn.oss-cn-shanghai.myqcloud.com.xuetuiguang.cn/m3u8/1633084389713.m3u8' -vcodec copy -acodec copy  nh.mp4
