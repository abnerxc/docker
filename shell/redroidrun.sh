#!/bin/sh
docker run -itd --rm --privileged --pull always -v /data/redroid/dev_fs:/data -p 5555:5555 redroid/redroid:13.0.0_64only-latest