#!/bin/bash
## run
##
## Copyright 2016 Mac Radigan
## All Rights Reserved

  d=${0%/*}; f=${0##*/}; n=${f%.*}; e=${f##*.}

  name=radigan/mapbox-live
  docker run     \
    -p 80:80     \
    -p 8000:8000 \
    -p 8001:8001 \
    -p 8002:8002 \
    -p 8888:8888 \
    -e LIVE__MAPBOX_API_KEY=${LIVE__MAPBOX_API_KEY} \
    -it $name $*

## *EOF*
