SHELL := bash

ROOT := $(shell cd ../..; pwd)
GENERATOR := $(ROOT)/parser/bin/generate-yaml-grammar
GENERATOR_LIB := $(ROOT)/parser/lib/generate-yaml-grammar-$(LANG).coffee
YAML_SPEC_YAML := $(ROOT)/yaml-spec-1.2.yaml

export PATH := $(ROOT)/parser/testml/bin:$(PATH)

tests := test/*.tml

.DELETE_ON_ERROR:

default:

build: $(GRAMMAR)

test: build ../testml
	TRACE=$(trace) DEBUG=$(debug) prove -v $(tests)

.PHONY: trace
trace: build
	-TRACE=1 DEBUG=$(debug) \
	    $(BIN) test/test.$(EXT) \
	    '[1,2 2  ,333,]' \
	    |& grep -v '^Parse' \
	    > $@

$(GRAMMAR): $(YAML_SPEC_YAML) $(GENERATOR_LIB)
	$(GENERATOR) \
	    --from=$< \
	    --to=$(LANG) \
	    --rule=l-yaml-stream \
	> $@

../testml:
	git clone https://github.com/testml-lang/testml $@
