#!/bin/bash
## site-start.sh
## Mac Radigan

  export NODE_PATH=/opt/srv/site/node_modules
  export PATH=$PATH:/usr/local/bin
  (cd /opt/srv/site; nodejs server.js)

## *EOF*
