yaml-grammar
============

[The YAML 1.2 Specification's Grammar Productions as YAML](https://github.com/yaml/yaml-grammar/blob/spec/yaml-spec-1.2.yaml).

# Overview

The [YAML 1.2 Spec](https://yaml.org/spec/1.2/spec.html) contains the formal grammar for YAML 1.2.
The 211 grammar rules are formatted into the web page's HTML along with lots of textual descriptions of the language and grammar.
The grammar uses a rare "Parameterized BNF" format, and some of the rule components are just textual comments indicating what should happen.

Fully comprehending the YAML grammar is quite an undertaking for most mortals.
Creating a fully compliant parser has proven [almost impossible](http://matrix.yaml.io/).

This project starts by programmatically pulling out all of the rules, parsing them into data structures and storing the entire structured grammar data graph as YAML.
The YAML output is commented and pretty printed.
It is intended to be both a reference for people trying to understand the rules, and as a mechanism to automate the creation of YAML tools.

From there that starting point, the grammar data is further formatted into various forms that should be useful in creating scanner/lexer/parser code in many programming languages.

Eventually this project aims to generate the scanner/lexer/parser code itself (for all the relevant languages).

The generated code hopes to be completely correct since it is created directly from the YAML 1.2 definition.
