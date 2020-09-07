SHELL := bash

ALL_JS := \
    lib/debug-parser.js \
    lib/grammar.js \
    lib/parser.js \
    lib/prelude.js \
    lib/test-receiver.js \
    test/test.js \
    test/testml-bridge.js \

ROOT := $(shell cd ../..; pwd)

export PATH := $(ROOT)/parser/testml/bin:$(PATH)
export TESTML_RUN := node-tap

tests := test/*.tml

.DELETE_ON_ERROR:

default:

build: build-coffee $(ALL_JS)

test: build ../testml/src/node/lib
	prove -v $(tests)

.PHONY: trace
trace: build
	-TRACE=1 DEBUG=$(debug) \
	    $(BIN) test/test.$(EXT) \
	    '[1,2 2  ,333,]' \
	    |& grep -v '^Parse' \
	    > $@

clean:
	rm -fr ../testml

build-coffee:
	make -C ../coffeescript build

test/%.js: ../coffeescript/test/%.coffee
	coffee -cp $< > $@
	perl -pi -e 's{/coffee/}{/node/}' $@

lib/%.js: ../coffeescript/lib/%.coffee
	coffee -cp $< > $@

../testml/src/node/lib: ../testml
	(cd $(@:%/lib=%); make js-files)

../testml:
	git clone https://github.com/testml-lang/testml $@
	#(cd $@; make work)
