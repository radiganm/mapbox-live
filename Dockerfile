## Dockerfile for mapbox-live
## Mac Radigan

  FROM ubuntu:latest

  MAINTAINER Mac Radigan <mac@radigan.org>

  ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

  ## update APT
  RUN ulimit -n 1024
  RUN apt-get update --fix-missing

  ## node.js

  RUN apt-get update &&              \
      apt-get install -y             \
        curl                         \
        git                          \
        nodejs                       \
        npm                           


  RUN npm cache clean
  RUN npm install -g n
  RUN n stable
  RUN curl -L https://npmjs.org/install.sh | sh

  RUN npm install update

  RUN mkdir -p /opt/srv/bin
  ADD srv_ctl /opt/srv/bin/srv_ctl

  RUN mkdir -p /opt/srv/mapbox
  COPY mapbox /opt/srv/mapbox
  RUN (cd /opt/srv/mapbox; npm install)
  RUN (cd /opt/srv/mapbox; npm install app)
  RUN (cd /opt/srv/mapbox; npm install express --save)
  RUN (cd /opt/srv/mapbox; npm install restify --save)
  RUN (cd /opt/srv/mapbox; npm install socket.io --save)
  RUN ln -fs /usr/bin/nodejs /usr/bin/node

  EXPOSE 8000
  EXPOSE 8888
  ENTRYPOINT ["/opt/srv/bin/srv_ctl"]

## *EOF*
