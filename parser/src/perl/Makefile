LANG := perl
BIN := perl
EXT := pl
GRAMMAR := lib/Grammar.pm

include ../common.mk

export PATH := $(ROOT)/parser/src/testml/bin:$(PATH)
export TESTML_RUN := perl-tap

clean:
	rm -f diff

.PHONY: diff
diff:
	make trace
	make -C ../coffeescript/ trace
	diff -u ../coffeescript/trace ../perl/trace |& tee diff
