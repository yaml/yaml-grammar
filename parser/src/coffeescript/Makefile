SHELL := bash

ROOT := $(shell cd ../../..; pwd)
GENERATOR := $(ROOT)/parser/bin/generate-yaml-grammar
GENERATOR_LIB := $(ROOT)/parser/lib/generate-yaml-grammar-coffeescript.coffee
YAML_SPEC_YAML := $(ROOT)/spec-1.2.yaml

GRAMMAR := lib/grammar.coffee

rule ?= l-yaml-stream

.DELETE_ON_ERROR:

test: build
	TRACE=$(TRACE) coffee ./test/test.coffee

build: $(GRAMMAR)

$(GRAMMAR): $(YAML_SPEC_YAML) $(GENERATOR_LIB)
	$(GENERATOR) \
	    --from=$< \
	    --to=coffeescript \
	    --rule=$(rule) \
	> $@

.PHONY: trace
trace:
	-TRACE=1 DEBUG=$(DEBUG) coffee test/test.coffee '[1,2 2  ,333,]' &> $@
