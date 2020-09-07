SHELL := bash

ROOT := $(shell cd ..; pwd)

ALL := \
    coffeescript \
    javascript \
    perl \

ALL_BUILD := $(ALL:%=build-%)
ALL_TEST := $(ALL:%=test-%)
ALL_TRACE := $(ALL:%=trace-%)
ALL_CLEAN := $(ALL:%=clean-%)

default:

build: $(ALL_BUILD)

build-%:
	make -C $(@:build-%=%) build TRACE=$(trace) DEBUG=$(debug)

test: $(ALL_TEST)

test-%:
	make -C $(@:test-%=%) test TRACE=$(trace) DEBUG=$(debug)

trace: $(ALL_TRACE)

trace-%:
	make -C $(@:trace-%=%) trace TRACE=$(trace) DEBUG=$(debug)

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
