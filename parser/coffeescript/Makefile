ROOT := $(shell cd ../..; pwd)
LANG := coffeescript
BIN := coffee
GRAMMAR := lib/grammar.coffee

BUILD_DEPS := \
    $(ROOT)/node_modules \

TEST_DEPS := \
    ../test/testml \

export TESTML_RUN := coffee-tap

include ../.common.mk
