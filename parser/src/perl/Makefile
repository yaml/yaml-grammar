SHELL := bash

ROOT := $(shell cd ../../..; pwd)
GENERATOR := $(ROOT)/parser/bin/generate-yaml-grammar
GENERATOR_LIB := $(ROOT)/parser/lib/generate-yaml-grammar-perl.coffee
YAML_SPEC_YAML := $(ROOT)/spec-1.2.yaml

GRAMMAR_SPEC := lib/GrammarSpec.pm

rule ?= l-yaml-stream

.DELETE_ON_ERROR:

test: build
	TRACE=$(TRACE) perl ./test/test.pl

build: $(GRAMMAR_SPEC)

.PHONY: trace
trace:
	make build-nodebug test TRACE=1 &> $@

$(GRAMMAR_SPEC): $(YAML_SPEC_YAML) $(GENERATOR_LIB)
	$(GENERATOR) \
	    --from=$< \
	    --to=perl \
	    --rule=$(rule) \
	> $@

build-debug:
	@touch $(GENERATOR_LIB)
	@make build YAML_GRAMMAR_DEBUG=1

build-nodebug:
	@touch $(GENERATOR_LIB)
	@make build
