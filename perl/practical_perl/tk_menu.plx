#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();
my $menu_bar = $top->Frame()->pack(-side=>'top');

my $search_mb = $menu_bar->Menubutton(
	-text => 'Search',
	-relief => 'raised',
	-borderwidth => 2,
	)->pack(-side => 'left', -padx => 2);

$search_mb->command(
	-label => 'Find',
	-accelerator => 'Meta+F',
	-underline => 0,
	-command => sub {print "find\n"});

$search_mb->command(
	-label => 'Find Again',
	-accelerator => 'Meta+A',
	-underline => 5,
	-command => sub {print "find again\n"});

$search_mb->separator();

my $match_type = 'regexp';
my $case_type = 1;

$search_mb->radiobutton(
	-label => 'Regexp match',
	-value => 'regexp',
	-variable => \$match_type);

$search_mb->radiobutton(
	-label => 'Exact match',
	-value => 'exact',
	-variable => \$match_type);

$search_mb->separator();

$search_mb->checkbutton(
	-label => 'Ignore case?',
	-variable => \$case_type);

MainLoop();

