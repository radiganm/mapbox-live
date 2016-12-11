#!/usr/bin/make
## makefile
##
## Copyright 2016 Mac Radigan
## All Rights Reserved

.PHONY: build

name = radigan/mapbox-live

build: 
	docker build -t $(name) .

clean: 
	docker rmi -f $(name)

## *EOF*
