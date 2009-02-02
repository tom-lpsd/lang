#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Benchmark;


sub length_cps {
    my ($list, $cont) = @_;
    if (shift @$list) {
	length_cps($list, sub {
		       $cont->(1+shift);
		   });
    } else {
	$cont->(0);
    }
}

sub length_cps2 {
    my ($list, $cont) = @_;
    if (shift @$list) {
	$_[1] = sub {
	    $cont->(1+ shift);
	};
	goto &length_cps2;
    }
    $cont->(0);
}

timethese(20000, {
    naive => sub { length_cps([1,2,3], sub {  }) },
    goto => sub { length_cps2([1,2,3], sub {  }) },
});

