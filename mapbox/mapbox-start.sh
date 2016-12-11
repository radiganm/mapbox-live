#!/bin/bash
## mapbox-start.sh
## Mac Radigan

  export NODE_PATH=/opt/srv/mapbox/node_modules
  export PATH=$PATH:/usr/local/bin
  (cd /opt/srv/mapbox; nodejs server.js &)

## *EOF*
