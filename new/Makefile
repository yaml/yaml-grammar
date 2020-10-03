SHELL := bash

GRAMMAR_1N := grammar-1.n.txt
GRAMMAR_1N_YAML := grammar-1.n.yaml
GRAMMAR_12_ORIG := ../yaml-spec-1.2-patch.yaml
GRAMMAR_12 := grammar-1.2.yaml
GRAMMAR_PEGEX := grammar-pegex.pgx
GRAMMAR_PEGEX_YAML := grammar-pegex.yaml
NODE_MODULES := ../node_modules

export PATH := $(NODE_MODULES)/.bin:$(PATH)
export PERL5LIB := ../../pegex-pm/lib
export NODE_PATH := $(NODE_MODULES)/pegex/lib


.DELETE_ON_ERROR:
build: $(GRAMMAR_1N_YAML) $(GRAMMAR_12) $(GRAMMAR_PEGEX_YAML)

regen:
	rm -f $(GRAMMAR_1N_YAML) $(GRAMMAR_12) $(GRAMMAR_PEGEX_YAML)


$(GRAMMAR_1N_YAML): $(GRAMMAR_1N) $(NODE_MODULES)
	./.bin/grammar-txt-to-yaml < $< > $@

$(GRAMMAR_12): $(GRAMMAR_12_ORIG)
	./.bin/reverse-grammar-1.2 $< > $@

$(GRAMMAR_PEGEX_YAML): $(GRAMMAR_PEGEX)
	pegex compile --to=yaml $< > $@

$(NODE_MODULES):
	make -C .. node_modules
