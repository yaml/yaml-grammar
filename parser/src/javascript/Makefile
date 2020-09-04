SHELL := bash

ALL_JS := \
    test/test.js \
    lib/grammar-spec.js \
    lib/grammar.js \
    lib/parser.js \
    lib/prelude.js \
    lib/test-receiver.js \

.DELETE_ON_ERROR:

test: build
	TRACE=$(TRACE) node ./test/test.js

build: $(ALL_JS)

test/%.js: ../coffeescript/test/%.coffee
	coffee -cp $< > $@

lib/%.js: ../coffeescript/lib/%.coffee
	coffee -cp $< > $@


.PHONY: trace
trace:
	-TRACE=1 node test/test.js '[1,2 2  ,333,]' &> $@
