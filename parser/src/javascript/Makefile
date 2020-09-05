SHELL := bash

ALL_JS := \
    test/test.js \
    lib/debug-parser.js \
    lib/grammar.js \
    lib/parser.js \
    lib/prelude.js \
    lib/test-receiver.js \

.DELETE_ON_ERROR:

default:

build: $(ALL_JS)

test: build
	TRACE=$(TRACE) node ./test/test.js

.PHONY: trace
trace: build
	-TRACE=1 DEBUG=$(DEBUG) node test/test.js '[1,2 2  ,333,]' &> $@

test/%.js: ../coffeescript/test/%.coffee
	coffee -cp $< > $@

lib/%.js: ../coffeescript/lib/%.coffee
	coffee -cp $< > $@
