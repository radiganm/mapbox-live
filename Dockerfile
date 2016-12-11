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
        mongodb                      \
        nginx                        \
        g++                          \
        nodejs                       \
        npm                           

  RUN npm cache clean
  RUN npm install -g n
  RUN n stable
  RUN curl -L https://npmjs.org/install.sh | sh
  RUN ln -fs /usr/bin/nodejs /usr/bin/node

  RUN npm install -g serve
# RUN npm install -g contextify --verbose
  RUN npm install update

  ADD radigan_org.nginx /etc/nginx/sites-available/radigan_org
  RUN (cd /etc/nginx/sites-enabled; ln -s /etc/nginx/sites-available/radigan_org .)

  RUN mkdir -p /opt/srv/bin
  ADD srv_ctl /opt/srv/bin/srv_ctl
  RUN chmod 775 /opt/srv/bin/srv_ctl

  RUN mkdir -p /opt/srv/mapbox
  COPY mapbox /opt/srv/mapbox
  RUN chmod 775 /opt/srv/mapbox/mapbox-start.sh
  RUN (cd /opt/srv/mapbox; npm install)
  RUN (cd /opt/srv/mapbox; npm install app)
  RUN (cd /opt/srv/mapbox; npm install express --save)
  RUN (cd /opt/srv/mapbox; npm install restify --save)
  RUN (cd /opt/srv/mapbox; npm install socket.io --save)
  RUN (cd /opt/srv/mapbox; npm install consolidate --save)
  RUN (cd /opt/srv/mapbox; npm install swig --save)

  RUN mkdir -p /opt/srv/geojson.io
  COPY geojson.io /opt/srv/geojson.io
# RUN (cd /opt/srv/geojson.io; make)

  EXPOSE 80
  EXPOSE 8000
  EXPOSE 8001
  EXPOSE 8002
  EXPOSE 8888
  EXPOSE 27017
  ENTRYPOINT ["/opt/srv/bin/srv_ctl"]

## *EOF*
