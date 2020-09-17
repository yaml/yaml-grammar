ROOT := $(shell cd ../..; pwd)
LANG := perl
BIN := perl
GRAMMAR := lib/Grammar.pm

BUILD_DEPS := \
    $(ROOT)/node_modules \

TEST_DEPS := \
    ../test/testml \
    ext/perl \

include ../.common.mk

export TESTML_RUN := perl-tap
export PERL5LIB := $(ROOT)/parser/perl/ext/perl/lib/perl5

ext/perl:
	git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

clean::
	rm -fr ext/
