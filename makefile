#!/usr/bin/make
## makefile
##
## Copyright 2016 Mac Radigan
## All Rights Reserved

.PHONY: build clobber clean update start mongo cmd run

name = radigan/mapbox-live

build: 
	docker build -t $(name) .

clean: 
	docker rmi -f $(name)

clobber: clean
	sudo rm -Rf ./data/mongodb/_tmp
	sudo rm -Rf ./data/mongodb/journal
	sudo rm -f ./data/mongodb/mongod.lock
	sudo rm -f ./data/mongodb/local.0
	sudo rm -f ./data/mongodb/local.ns

update: 
	./update.sh

start: 
	./run start

mongo: 
	./cmd mongo mongo

cmd: 
	./cmd $(ARGS)

## *EOF*
