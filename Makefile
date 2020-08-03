SHELL := bash

CWD := $(shell pwd)

SPEC12_URL := https://yaml.org/spec/1.2/spec.html
SPEC12_TXT := spec-1.2.txt
SPEC12_YAML := spec-1.2.yaml
SPEC12_INDEX_YAML := spec-1.2.index.yaml
SPEC12_DSL_YAML := $(SPEC12_YAML:%.yaml=%.dsl.yaml)
SPEC12_PCRE_YAML := $(SPEC12_YAML:%.yaml=%.pcre.yaml)
SPEC12_PERL_YAML := $(SPEC12_YAML:%.yaml=%.perl.yaml)

BUILD := $(SPEC12_YAML)

BUILD_ALL := \
    $(SPEC12_INDEX_YAML) \
    $(SPEC12_DSL_YAML) \
    $(SPEC12_PCRE_YAML) \
    $(SPEC12_PERL_YAML) \

WORK_BRANCHES := \
    node_modules \

export PATH := $(CWD)/bin:$(CWD)/node_modules/.bin:$(PATH)

.DELETE_ON_ERROR:
#------------------------------------------------------------------------------
default:

build: $(BUILD)

build-all: build $(BUILD_ALL)

check: $(SPEC12_YAML) $(SPEC12_INDEX_YAML)
	@( \
	    for f in $^; do \
	        echo -n "$$f: "; \
		perl -MYAML::XS -E 'YAML::XS::LoadFile(shift); say "OK"' $$f; \
	    done; \
	)

clean:
	rm -fr $(SPEC12_TXT) $(BUILD_ALL)

realclean: clean
	rm -fr $(WORK_BRANCHES)

$(SPEC12_TXT):
	lynx --dump $(SPEC12_URL) > $@

$(SPEC12_YAML): $(SPEC12_TXT) Makefile
	yaml-grammar-html-to-yaml < $< > $@

$(SPEC12_INDEX_YAML): $(SPEC12_TXT)
	yaml-grammar-html-to-yaml --index < $< > $@

$(SPEC12_DSL_YAML): $(SPEC12_YAML) node_modules Makefile
	yaml-grammar-generator --to=dsl.yaml $< > $@

$(SPEC12_PCRE_YAML): $(SPEC12_YAML) node_modules Makefile
	yaml-grammar-generator --to=pcre.yaml $< > $@

$(SPEC12_PERL_YAML): $(SPEC12_YAML) node_modules Makefile
	yaml-grammar-generator --to=perl.yaml $< > $@

work: $(WORK_BRANCHES)

$(WORK_BRANCHES):
	git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@
