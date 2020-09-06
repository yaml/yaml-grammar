SHELL := bash

ALL := \
    coffeescript \
    javascript \
    perl \

ALL_BUILD := $(ALL:%=build-%)
ALL_TEST := $(ALL:%=test-%)
ALL_TRACE := $(ALL:%=trace-%)

default:

build: $(ALL_BUILD)

build-%:
	make -C $(@:build-%=%) build TRACE=$(TRACE) DEBUG=$(DEBUG)

test: $(ALL_TEST)

test-%:
	make -C $(@:test-%=%) test TRACE=$(TRACE) DEBUG=$(DEBUG)

trace: $(ALL_TRACE)

trace-%:
	make -C $(@:trace-%=%) trace TRACE=$(TRACE) DEBUG=$(DEBUG)

clean:
	rm -fr testml test/.testml
