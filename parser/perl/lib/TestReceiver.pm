use v5.12;
package TestReceiver;
use Prelude;

sub new {
  my ($class) = @_;
  bless {
    event => [],
    pools => [],
  }, $class;
}

sub add {
  my ($self, $event) = @_;
  if (@{$self->{pools}}) {
    push @{$self->{pools}[-1]}, $event;
  }
  else {
    $self->send($event);
  }
}

sub pool_up {
  my ($self) = @_;
  push @{$self->{pools}}, [];
}

sub pool_down {
  my ($self) = @_;
  my $events = pop @{$self->{pools}} or xxxxx @_;
  $self->add($_) for @$events;
}

sub pool_drop {
  my ($self) = @_;
  pop @{$self->{pools}} or xxxxx @_;
}

sub send {
  my ($self, $event) = @_;
  push @{$self->{event}}, $event;
}

sub output {
  my ($self) = @_;
  join "\n", @{$self->{event}}, '';
}

sub try__l_yaml_stream {
  my ($self, $o) = @_;
  $self->add('+STR');
}

sub got__l_yaml_stream {
  my ($self, $o) = @_;
  $self->add('-STR');
}

sub try__l_bare_document {
  my ($self, $o) = @_;
  $self->add('+DOC');
}

sub got__l_bare_document {
  my ($self, $o) = @_;
  $self->add('-DOC');
}

sub got__c_flow_sequence__all__x5b {
  my ($self, $o) = @_;
  $self->add('+SEQ []');
}

sub got__c_flow_sequence__all__x5d {
  my ($self, $o) = @_;
  $self->add('-SEQ');
}

sub got__c_flow_mapping__all__x7b {
  my ($self, $o) = @_;
  $self->add('+MAP {}');
}

sub got__c_flow_mapping__all__x7d {
  my ($self, $o) = @_;
  $self->add('-MAP');
}

sub got__ns_plain {
  my ($self, $o) = @_;
  $self->add("=VAL :${\ $o->{text}}");
}

sub got__c_single_quoted {
  my ($self, $o) = @_;
  my $value = substr($o->{text}, 1, -1);
  $self->add("=VAL \'$value");
}

sub got__c_double_quoted {
  my ($self, $o) = @_;
  my $value = substr($o->{text}, 1, -1);
  $self->add("=VAL \"$value");
}

sub got__e_scalar {
  my ($self, $o) = @_;
  $self->add("=VAL :");
}

sub try__ns_flow_pair { $_[0]->pool_up; }
sub got__ns_flow_pair { xxxxx @_ }
sub not__ns_flow_pair { $_[0]->pool_drop }

sub try__c_ns_flow_map_empty_key_entry { $_[0]->pool_up }
sub got__c_ns_flow_map_empty_key_entry { xxxxx @_ }
sub not__c_ns_flow_map_empty_key_entry { $_[0]->pool_drop }

1;

# vim: sw=2:
