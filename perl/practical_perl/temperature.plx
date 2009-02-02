#!/usr/bin/perl -w
package AC;
sub TIESCALAR {
  my $class = shift;
  bless {}, $class;
}

sub FETCH {
  my $self = shift;
  print $self->{value} . "\n";
  $self->{value}/10;
}

sub STORE {
  my ($self,$value) = @_;
  $self->{value} = $value*12;
  $value;
}

sub DESTROY {
  print "I died.\n";
}

sub shout {
  print "I am AC.\n"
}

package main;
use strict;

my $a;
tie $a, 'AC';
$a = 100;
my $b = $a;
print "$b\n";
(tied $a)->shout;

untie $a;
print $a;
