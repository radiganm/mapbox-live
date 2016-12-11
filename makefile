#!/usr/bin/make
## makefile
##
## Copyright 2016 Mac Radigan
## All Rights Reserved

.PHONY: build clean update start mongo cmd

name = radigan/mapbox-live

build: 
	docker build -t $(name) .

clean: 
	docker rmi -f $(name)

update: 
	./update.sh

start: 
	./cmd start

mongo: 
	./cmd mongo mongo

cmd: 
	./cmd $(ARGS)

## *EOF*
