SHELL := bash

MODULES := \
    argparse \
    coffeescript \
    ingy-prelude \
    js-yaml \
    lodash \

update:
	(LC_ALL=C; rm -fr [a-z]* .bin)
	npm install $(MODULES)
	rm -f package*
	git add -A .
