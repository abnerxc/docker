#!/bin/bash
docker run -it -v /Users/abner/work/ffdev:/root --entrypoint='sh'  jrottenberg/ffmpeg:4.1-alpine 



# ffmpeg -i 'https://vod.bunediy.com/20200504/hzsbE24q/index.m3u8' -c copy xuchen.mp4