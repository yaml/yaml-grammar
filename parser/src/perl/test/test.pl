#!/usr/bin/env perl

use v5.12;
use lib 'lib';

use Prelude;
use Parser;
use TestReceiver;

sub main {
  my ($yaml, $rule, @args) = @_;
  $rule //= 'TOP';

  my $args = [
    map {
      if ($_ eq 'null') { undef }
      elsif (/^-?[0-9]+$/) { 0 + $_ }
      else { $_ }
    } @args
  ];

  test_parse($yaml, $rule, $args);
}

sub test_parse {
  my ($yaml, $rule, $args) = @_;
  $args //= [];

  my $parser = Parser->new(TestReceiver->new);

  if (not ref $rule) {
    $rule = $parser->{$rule};
  }
  if (@$args) {
    $rule = [$rule, @$args];
  }

  my $pass = 1;
  my $trace = $ENV{TRACE};
  my $start = timer;

  eval {
    $parser->parse($yaml, $rule, $trace);
  };
  if ($@) {
    warn $@;
    $pass = 0;
  }
  my $time = timer($start);

  my $n;
  if ($yaml =~ /\n./) {
    $n = "\n";
  }
  else {
    $n = '';
    $yaml =~ s/\n$/\\n/;
  }

  if ($pass) {
    say "PASS - '$n$yaml'";
    say $parser->{receiver}->output();
    say sprintf "Parse time %.5fs", $time;
    return 1
  }
  else {
    say "FAIL - '$n$yaml'";
    say $parser->{receiver}->output();
    say sprintf "Parse time %.5fs", $time;
    return 0;
  }
}

if (@ARGV) {
  if (main @ARGV) {
    exit 0;
  }
  else {
    exit 1;
  }
}


test_parse "[1,2 2  ,333,]";
# test_parse "[123]"
# test_parse "a: b"
# test_parse ""
# test_parse "---\n"
# test_parse "..."
# test_parse "[]  # foo"
# test_parse "[ foo ]"
# test_parse "{}"
# test_parse "{}\n"
# test_parse "''"
