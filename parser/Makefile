SHELL = bash

# .DELETE_ON_ERROR:

default:

.PHONY: test
test: test-coffee

test-coffee: build-coffee
	TRACE=1 coffee ./test.coffee

build-coffee: lib/grammar.coffee

lib/grammar.coffee: ../spec-1.2.yaml
	./bin/generate-yaml-grammar \
	    --from=$< \
	    --to=coffee \
	    --rule=l-yaml-stream \
	> $@

../spec-1.2.yaml:
	make -C .. $(@:../%=%)

clean:
	rm -f lib/grammar.coffee
