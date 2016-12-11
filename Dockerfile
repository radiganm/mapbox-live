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
        wget                         \
        git                          \
        nginx                        \
        g++                          \
        nodejs                       \
        npm                           

# RUN apt-get update &&              \
#     apt-get install -y             \
#       mongodb

  RUN (cd /tmp; \
       wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-3.4.0.tgz; \
       tar -xvf mongodb-linux-x86_64-ubuntu1604-3.4.0.tgz; \
       cd mongodb-linux-x86_64-ubuntu1604-3.4.0; \
       cp -f bin/* /usr/bin \
      )

  RUN npm cache clean
  RUN npm install -g n
  RUN n stable
  RUN curl -L https://npmjs.org/install.sh | sh
  RUN ln -fs /usr/bin/nodejs /usr/bin/node

  RUN npm install -g serve
# RUN npm install -g contextify --verbose
  RUN npm install update

  ADD config/site.nginx /etc/nginx/sites-available/site
  RUN (cd /etc/nginx/sites-enabled; ln -s /etc/nginx/sites-available/site .)

  RUN mkdir -p /opt/srv/bin
  ADD bin/srv_ctl /opt/srv/bin/srv_ctl
  RUN chmod 775 /opt/srv/bin/srv_ctl

  RUN mkdir -p /opt/srv/site
  COPY site /opt/srv/site
  RUN chmod 775 /opt/srv/site/site-start.sh
  RUN (cd /opt/srv/site; npm install)
  RUN (cd /opt/srv/site; npm install app)
  RUN (cd /opt/srv/site; npm install express --save)
  RUN (cd /opt/srv/site; npm install restify --save)
  RUN (cd /opt/srv/site; npm install socket.io --save)
  RUN (cd /opt/srv/site; npm install consolidate --save)
  RUN (cd /opt/srv/site; npm install swig --save)
  RUN (cd /opt/srv/site; npm install mongojs --save)
  RUN (cd /opt/srv/site; npm install mongoose --save)
  RUN (cd /opt/srv/site; npm install async --save)

  RUN mkdir -p /opt/srv/geojson.io
  COPY geojson.io /opt/srv/geojson.io
# RUN (cd /opt/srv/geojson.io; make)

  ADD config/mongodb.conf /etc/mongodb.conf

  EXPOSE 80
  EXPOSE 8000
  EXPOSE 8001
  EXPOSE 8002
  EXPOSE 8888
  EXPOSE 27017
  ENTRYPOINT ["/opt/srv/bin/srv_ctl"]

## *EOF*
