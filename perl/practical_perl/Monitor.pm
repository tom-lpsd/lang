package Monitor;
require Exporter;
@ISA = ("Exporter");
@EXPORT = qw|monitor unmonitor|;
use strict;
use Monitor::Scalar;
use Monitor::Array;
use Monitor::Hash;

sub monitor {
    my ($r_var, $name) = @_;
    my ($type) = ref($r_var);
    if ($type =~ /SCALAR/){
	return tie $$r_var, 'Monitor::Scalar', $r_var, $name;
    } elsif ($type =~ /ARRAY/){
	return tie @$r_var, 'Monitor::Array', $r_var, $name;
    } elsif ($type =~ /HASH/){
	return tie %$r_var, 'Monitor::Hash', $r_var, $name;
    } else {
	print STDERR "require ref. to scalar, array or hash" unless $type;
    }
}

sub unmonitor {
    my ($r_var) = @_;
    my ($type) = ref($r_var);
    my $obj;
    if ($type =~ /SCALAR/) {
	Monitor::Scalar->unmonitor($r_var);
    } elsif ($type =~ /ARRAY/) {
	Monitor::Array->unmonitor($r_var);
    } elsif ($type =~ /HASH/) {
	Monitor::Hash->unmonitor($r_var);
    } else {
	print STDERR "require ref. to scalar, array or hash" unless $type;
    }
}
1;

