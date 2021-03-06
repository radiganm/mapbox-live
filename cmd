#!/bin/bash
## cmd
##
## Copyright 2016 Mac Radigan
## All Rights Reserved

  d=${0%/*}; f=${0##*/}; n=${f%.*}; e=${f##*.}
  root=$(readlink -f $d)

  name=radigan/mapbox-live
  docker run     \
    -v ${root}/data/mongodb:/data/db \
    -v ${root}/logs/mongodb:/var/log/mongodb \
    -e LIVE__MAPBOX_API_KEY=${LIVE__MAPBOX_API_KEY} \
    -it $name $*

## *EOF*
