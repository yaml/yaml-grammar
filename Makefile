SHELL := bash

MODULES := \
    argparse \
    coffeescript \
    ingy-prelude \
    lodash \
    sprintf \
    yaml \


update:
	(LC_ALL=C; rm -fr [a-z]* .bin)
	npm install $(MODULES)
	rm -f package*
	git add -A .
