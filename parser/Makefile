SHELL := bash

ROOT := $(shell cd ..; pwd)

ALL := \
    coffeescript \
    javascript \
    perl \

ALL_BUILD := $(ALL:%=build-%)
ALL_TEST := $(ALL:%=test-%)
ALL_CLEAN := $(ALL:%=clean-%)

default:

build: $(ALL_BUILD)

build-%:
	make -C $(@:build-%=%) build

test: $(ALL_TEST)

test-%:
	make -C $(@:test-%=%) test TRACE=$(TRACE) DEBUG=$(DEBUG)

clean: $(ALL_CLEAN)
	rm -fr test/testml
	rm -fr test/.testml

clean-%:
	make -C $(@:clean-%=%) clean

docker-build:
	docker build -t yaml-grammar-test test

docker-test: docker-build
	docker run -t \
	    -v"$(ROOT):/yaml-grammar" \
	    -u $$(id -u "$$USER"):$$(id -g "$$USER") \
	    yaml-grammar-test \
	    make -C /yaml-grammar/parser test
