SHELL := bash

ROOT := $(shell cd ../..; pwd)

ALL := \
    coffeescript \
    javascript \
    perl \

ALL_BUILD := $(ALL:%=build-%)
ALL_TEST := $(ALL:%=test-%)
ALL_TRACE := $(ALL:%=trace-%)

TEST_DEPS := \
    node_modules \
    perl5lib \
    testml \

export PATH := $(ROOT)/parser/src/node_modules/.bin:$(PATH)

default:

build: $(ALL_BUILD)

build-%:
	make -C $(@:build-%=%) build TRACE=$(TRACE) DEBUG=$(DEBUG)

test: $(TEST_DEPS) $(ALL_TEST)

test-%:
	make -C $(@:test-%=%) test TRACE=$(TRACE) DEBUG=$(DEBUG)

trace: $(ALL_TRACE)

trace-%:
	make -C $(@:trace-%=%) trace TRACE=$(TRACE) DEBUG=$(DEBUG)

node_modules perl5lib:
	git worktree prune
	git worktree add $@ $@

testml:
	git clone https://github.com/testml-lang/testml $@
	make -C $@ ext/perl
	make -C $@ src/node_modules

docker-build:
	docker build -t yaml-grammar-test test

docker-test: docker-build
	docker run -t \
	    -v"$(ROOT):/yaml-grammar" \
	    -u $$(id -u "$$USER"):$$(id -g "$$USER") \
	    yaml-grammar-test \
	    make -C /yaml-grammar/parser/src test

clean:
	rm -fr node_modules perl5lib testml test/.testml
