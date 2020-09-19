ROOT := $(shell cd ../..; pwd)
LANG := python
BIN := python
GRAMMAR := lib/grammar.py

BUILD_DEPS := \
    $(ROOT)/node_modules \

TEST_DEPS := \
    ../test/testml \

export PYTHONPATH := $(ROOT)/parser/python/lib:$(PYTHONPATH)
export TESTML_RUN := python-tap

include ../.common.mk
