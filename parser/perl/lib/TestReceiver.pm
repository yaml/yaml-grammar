use v5.12;
package TestReceiver;
use Prelude;

sub new {
  my ($class) = @_;
  bless {
    flow_start => false,
    events => [],
    flow_pair => false,
  }, $class;
}

sub output {
  my ($self) = @_;
  join "\n", @{$self->{events}}, '';

}

sub try__ns_flow_pair {
  my ($self, $o) = @_;
  $self->{flow_pair} = true;
}
sub not__ns_flow_pair {
  my ($self, $o) = @_;
  $self->{flow_pair} = false;
}
sub got__ns_flow_pair { die };

sub try__l_yaml_stream {
  my ($self, $o) = @_;
  push @{$self->{events}}, '+STR';
}

sub got__l_yaml_stream {
  my ($self, $o) = @_;
  push @{$self->{events}}, '-STR';
}

sub try__s_l_flow_in_block {
  my ($self, $o) = @_;
  $self->{flow_start} = true;
}

sub try__l_bare_document {
  my ($self, $o) = @_;
  push @{$self->{events}}, '+DOC';
}

sub got__l_bare_document {
  my ($self, $o) = @_;
  push @{$self->{events}}, '-DOC';
}

sub got__c_flow_sequence__all__chr_5b {
  my ($self, $o) = @_;
  return unless $self->{flow_start};
  return if $self->{flow_pair};
  push @{$self->{events}}, '+SEQ []';
}

sub got__c_flow_sequence__all__chr_5d {
  my ($self, $o) = @_;
  return unless $self->{flow_start};
  return if $self->{flow_pair};
  push @{$self->{events}}, '-SEQ';
}

sub got__c_flow_mapping__all__chr_7b {
  my ($self, $o) = @_;
  return unless $self->{flow_start};
  return if $self->{flow_pair};
  push @{$self->{events}}, '+MAP {}';
}

sub got__c_flow_mapping__all__chr_7d {
  my ($self, $o) = @_;
  return unless $self->{flow_start};
  return if $self->{flow_pair};
  push @{$self->{events}}, '-MAP';
}

sub got__ns_plain {
  my ($self, $o) = @_;
  return if $self->{flow_pair};
  push @{$self->{events}}, "=VAL :${\ $o->{text}}";
}

sub got__c_single_quoted {
  my ($self, $o) = @_;
  return if $self->{flow_pair};
  my $value = substr($o->{text}, 1, -1);
  push @{$self->{events}}, "=VAL \'$value";
}

sub got__c_double_quoted {
  my ($self, $o) = @_;
  return if $self->{flow_pair};
  my $value = substr($o->{text}, 1, -1);
  push @{$self->{events}}, "=VAL \"$value";
}

# sub got__e_scalar {
#   my ($self, $o) = @_;
#   return if $self->{flow_pair};
#   push @{$self->{events}}, "=VAL :";
# }

1;

# vim: sw=2:
