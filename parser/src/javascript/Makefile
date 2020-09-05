SHELL := bash

ALL_JS := \
    lib/debug-parser.js \
    lib/grammar.js \
    lib/parser.js \
    lib/prelude.js \
    lib/test-receiver.js \
    test/test.js \
    test/testml-bridge.js \

ROOT := $(shell cd ../../..; pwd)

export PATH := $(ROOT)/parser/src/testml/bin:$(PATH)
export TESTML_RUN := node-tap

tests := test/*.tml

.DELETE_ON_ERROR:

default:

build: $(ALL_JS)

test: build ../testml
	prove -v $(tests)

.PHONY: trace
trace: build
	-TRACE=1 DEBUG=$(debug) \
	    $(BIN) test/test.$(EXT) \
	    '[1,2 2  ,333,]' \
	    |& grep -v '^Parse' \
	    > $@

test/%.js: ../coffeescript/test/%.coffee
	coffee -cp $< > $@

lib/%.js: ../coffeescript/lib/%.coffee
	coffee -cp $< > $@

../testml:
	git clone https://github.com/testml-lang/testml $@
