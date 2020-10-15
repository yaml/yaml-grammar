yaml-grammar
============

[The YAML 1.2 Specification's Grammar Productions as YAML](https://github.com/yaml/yaml-grammar/blob/master/yaml-spec-1.2.yaml).

# Overview

The purpose of this project is present the YAML 1.2 Grammar as a machine readable and human comprehendable YAML file.

The [YAML 1.2 Spec](https://yaml.org/spec/1.2/spec.html) contains the formal grammar for YAML 1.2.
The 211 grammar rules are formatted into the web page's HTML along with lots of textual descriptions of the language and grammar.
The grammar uses a rare "Parameterized BNF" format, and some of the rule components are just textual comments indicating what should happen.

Fully comprehending the YAML grammar is quite an undertaking for most mortals.
Creating a fully compliant parser has proven [almost impossible](http://matrix.yaml.io/).

This project programmatically pulls out all of the rules, parsing them into data structures and storing the entire structured grammar data graph as YAML.
The YAML output is commented and pretty printed.
It is intended to be both a reference for people trying to understand the rules, and as a mechanism to automate the creation of YAML tools.

# Generating Compliant Parsers

The [YAML Reference Parser](https://github.com/yaml/yaml-reference-parser) project uses the YAML grammar from this repo to generate 100% compliant parsers.
