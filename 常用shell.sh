#!/bin/bash
docker run -it -v /Users/abner/Movies:/root --entrypoint='sh'  jrottenberg/ffmpeg:4.1-alpine 
# ffmpeg  -i 'https://new.iskcd.com/20210921/WQP04lpt/3509kb/hls/index.m3u8' -vcodec copy -acodec copy  zgys.mp4