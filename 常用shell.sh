#!/bin/bash
docker run -it -v /Users/abner/work/ffdev:/root --entrypoint='sh'  jrottenberg/ffmpeg:4.1-alpine 
# 进入容器 docker attach jrottenberg/ffmpeg:4.1-alpine 
# ffmpeg  -i 'https://www.formax23.xyz/20210926/tFYne1GS/index.m3u8' -vcodec copy -acodec copy  a.mp4