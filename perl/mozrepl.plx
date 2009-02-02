#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use MozRepl;

my $repl = MozRepl->new;
$repl->setup({ log => ['info'] });

my $href = $repl->execute('content.location.href');

say $href;

