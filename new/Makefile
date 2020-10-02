SHELL := bash

GRAMMAR_12_ORIG := ../yaml-spec-1.2-patch.yaml
GRAMMAR_12 := grammar-1.2.yaml
GRAMMAR_PEGEX := grammar-pegex.pgx
GRAMMAR_PEGEX_YAML := grammar-pegex.yaml

export PERL5LIB := ../../pegex-pm/lib


.DELETE_ON_ERROR:
build: $(GRAMMAR_12) $(GRAMMAR_PEGEX_YAML)

regen:
	rm -f $(GRAMMAR_12) $(GRAMMAR_PEGEX_YAML)


$(GRAMMAR_12): $(GRAMMAR_12_ORIG)
	./.bin/reverse-grammar-1.2 $< > $@

$(GRAMMAR_PEGEX_YAML): $(GRAMMAR_PEGEX)
	pegex compile --to=yaml $< > $@
