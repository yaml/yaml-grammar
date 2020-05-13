SHELL = bash

.DELETE_ON_ERROR:

default:

.PHONY: test
test: test-coffeescript

build: build-coffeescript

test-%:
	make -C src/$(@:test-%=%) test

build-%:
	make -C src/$(@:build-%=%) build
