SHELL := bash

ROOT := $(shell cd ../../..; pwd)
GENERATOR := $(ROOT)/parser/bin/generate-yaml-grammar
GENERATOR_LIB := $(ROOT)/parser/lib/generate-yaml-grammar-$(LANG).coffee
YAML_SPEC_YAML := $(ROOT)/spec-1.2.yaml


.DELETE_ON_ERROR:

default:

build: $(GRAMMAR)

test: build
	TRACE=$(TRACE) $(BIN) ./test/test.$(EXT)

.PHONY: trace
trace: build
	-TRACE=1 DEBUG=$(DEBUG) $(BIN) test/test.$(EXT) '[1,2 2  ,333,]' &> $@

$(GRAMMAR): $(YAML_SPEC_YAML) $(GENERATOR_LIB)
	$(GENERATOR) \
	    --from=$< \
	    --to=$(LANG) \
	    --rule=l-yaml-stream \
	> $@
