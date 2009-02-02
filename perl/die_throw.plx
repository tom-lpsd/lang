#!/usr/bin/env perl
package MyException;
use 5.010;
use strict;
use warnings;

sub new {
    my ($class, $msg) = @_;
    bless \$msg, shift;
}

sub frames {
    ${+shift};
}

package main;
use 5.010;
use strict;
use warnings;
use Data::Dumper;

our $FINISHED = MyException->new('');

sub throw {
    die MyException->new(shift);
}

sub finished {
    die $FINISHED;
}

eval {
    finished;
    throw "hogehoge";
};
if ($@) {
    if ($@ == $FINISHED) {
	say "OK";
    } else {
	say $@->frames;
    }
}
