LANG := perl
BIN := perl
EXT := pl
GRAMMAR := lib/Grammar.pm

include ../.common.mk

export TESTML_RUN := perl-tap
export PERL5LIB := $(ROOT)/parser/perl5lib/lib/perl5

clean:
	rm -f diff

.PHONY: diff
diff:
	make trace
	make -C ../coffeescript/ trace
	diff -u ../coffeescript/trace ../perl/trace |& tee diff
