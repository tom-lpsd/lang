#!/usr/bin/env perl -w
use strict;
use HTML::Template;

my $template = HTML::Template->new(filename => 'template/loop.tmpl');

$template->param(global => 'Foo');
$template->param(foo => [
    {name => 'foo', val => 1},
    {name => 'bar', val => 2}
    ]);

print $template->output();
