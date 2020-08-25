use v5.12;
package TestReceiver;
use boolean;

sub new {
  my ($class) = @_;
  bless {
    flow_start => false,
    events => [],
    flow_pair => false,
  }, $class;
}

sub output {
  join "\n", @{$_[0]->{events}}, '';

}

sub try__ns_flow_pair {
  $_[0]->{flow_pair} = true;
}
sub not__ns_flow_pair {
  $_[0]->{flow_pair} = false;
}
sub got__ns_flow_pair { die };

sub try__l_yaml_stream {
  push @{$_[0]->{events}}, '+STR';
}

sub got__l_yaml_stream {
  push @{$_[0]->{events}}, '-STR';
}

sub try__s_l_flow_in_block {
  push @{$_[0]->{flow_start}}, true;
}

sub try__l_bare_document {
  push @{$_[0]->{events}}, '+DOC';
}

sub got__l_bare_document {
  push @{$_[0]->{events}}, '-DOC';
}

sub got__c_flow_sequence__all__chr_5b {
  if ($_[0]->{flow_start}) {
    push @{$_[0]->{events}}, '+SEQ []';
  }
}

sub got__c_flow_sequence__all__chr_5d {
  if ($_[0]->{flow_start}) {
    push @{$_[0]->{events}}, '-SEQ';
  }
}

sub got__ns_plain {
  my ($self, $o) = @_;
  return if $self->{flow_pair};
  push @{$self->{events}}, "=VAL :#{o.text}";
}

1;
