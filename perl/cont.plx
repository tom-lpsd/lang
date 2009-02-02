#!/usr/bin/perl -w
use strict;
use warnings;
use Benchmark qw/:all/;

sub leaf_count_cps {
    my ($tree, $cont) = @_;
    unless (ref $tree){
	goto sub { $cont->(1) };
    }
    $_[0] = $tree->[0];
    $_[1] = sub {
	my $n = shift;
	leaf_count_cps($tree->[1],
		       sub { $cont->($n + shift) } )
    };
    goto &leaf_count_cps;
}

sub leaf_count_cps2 {
    my ($tree, $cont) = @_;
    unless (ref $tree){
        $cont->(1);
    } else {
        my $cps = sub {
            my $cc = $cont;
            leaf_count_cps($tree->[0],
                           sub {
                               my $n = shift;
                               leaf_count_cps($tree->[1],
                                              sub { $cont->($n + shift) }
                                             )
                           });
        };
        goto &$cps;
    }
}

timethese(10000, {
    my => sub {
	my $t = [[1, 2], [[3, 4], [5, 6]]];
	leaf_count_cps($t, sub { });
    },
    other => sub {
	my $t = [[1, 2], [[3, 4], [5, 6]]];
	leaf_count_cps2($t, sub { });
    }
});
