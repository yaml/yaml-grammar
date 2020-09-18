SHELL := bash

ALL_JS := \
    bin/yaml-parser \
    lib/debug-parser.js \
    lib/grammar.js \
    lib/parser.js \
    lib/prelude.js \
    lib/test-receiver.js \
    test/test.js \
    test/testml-bridge.js \

ROOT := $(shell cd ../..; pwd)

PATH := $(ROOT)/node_modules/.bin:$(PATH)
PATH := $(ROOT)/parser/test/testml/bin:$(PATH)
export PATH
export TESTML_RUN := node-tap

tests := test/*.tml

.DELETE_ON_ERROR:

default:

build: build-coffee $(ALL_JS)

test: build ../test/testml/src/node/lib
	prove -v $(tests)

clean:

build-coffee:
	make -C ../coffeescript build

bin/%: ../coffeescript/bin/%
	echo '#!/usr/bin/env node' > $@
	coffee -cp $< >> $@
	chmod +x $@

lib/%.js: ../coffeescript/lib/%.coffee
	coffee -cp $< > $@

test/%.js: ../coffeescript/test/%.coffee
	coffee -cp $< > $@
	perl -pi -e 's{/coffee/}{/node/}' $@

../test/testml/src/node/lib: ../test/testml
	make -C $(@:%/lib=%) js-files

../test/testml:
	git clone https://github.com/testml-lang/testml $@
	make -C $@ ext/perl
	make -C $@ src/node_modules
