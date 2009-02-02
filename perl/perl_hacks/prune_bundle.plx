#!/usr/bin/perl 
use strict;
use Module::CoreList;

my ($bundle, $version) = @ARGV;
$version ||= $];
@ARGV = $bundle;
my $core_list = $Module::CoreList::version{$version};
die "Unknown version $version\n" unless $core_list;

while (<>) {
    print;
    last if $_ eq "=head1 CONTENTS\n";
}

print "\n";

while (<>) {
    if ($_ eq "=head1 CONFIGURATION\n") {
	print;
	last;
    }

    chomp;
    next unless $_;

    my ($module, $version) = split /\s+/, $_;
    $version = 0 if $version eq 'undef';

    if (exists $core_list->{$module} and $core_list->{module} >= $version) {
	print STDERR "$module $version\n";
	next;
    }

    print "$module $version\n\n";
}

print while <>;

