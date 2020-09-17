SHELL := bash

ifeq ($(ROOT),)
    $(error ROOT not defined)
endif

YAML_SPEC_YAML_PATCH := $(ROOT)/yaml-spec-1.2-patch.yaml
GENERATOR := $(ROOT)/parser/tool/bin/generate-yaml-grammar
GENERATOR_LIB := $(ROOT)/parser/tool/lib/generate-yaml-grammar.coffee
GENERATOR_LANG_LIB := $(ROOT)/parser/tool/lib/generate-yaml-grammar-$(LANG).coffee
NODE_MODULES := $(ROOT)/node_modules

PATH := $(NODE_MODULES)/.bin:$(PATH)
PATH := $(ROOT)/parser/test/testml/bin:$(PATH)
export PATH

tests := test/*.tml

.DELETE_ON_ERROR:

default:

build:: $(BUILD_DEPS) $(GRAMMAR)

test:: build $(TEST_DEPS)
	TRACE=$(TRACE) TRACE_QUIET=$(TRACE_QUIET) DEBUG=$(DEBUG) \
	    prove -v $(tests)

.PHONY: trace
trace:: build
	-TRACE=1 DEBUG=$(DEBUG) \
	    ./bin/yaml-parser \
	    '[1,2 2  ,333,]' \
	    |& grep -v '^Parse' \
	    > $@

clean::

$(GRAMMAR): $(YAML_SPEC_YAML_PATCH) $(GENERATOR) $(GENERATOR_LIB) $(GENERATOR_LANG_LIB)
	$(GENERATOR) \
	    --from=$< \
	    --to=$(LANG) \
	    --rule=l-yaml-stream \
	> $@

../test/testml:
	git clone https://github.com/testml-lang/testml $@
	make -C $@ ext/perl
	make -C $@ src/node_modules

$(NODE_MODULES) $(YAML_SPEC_YAML_PATCH):
	make -C $(ROOT) $(@:$(ROOT)/%=%)
