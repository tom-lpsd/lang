#!/usr/bin/perl -w
use strict;

#process_args();
my $spec_file = "emp.om";
my $template_file = "oo.tpl";
my $inter_file = "oo.tpl.pl";
my $spec_parser = "OO_Schema";
my $verbose = 1;
my $debugging = 0;

require 'TemplateParser.pm';
my $compile_template = 1;
if ((-e $inter_file) && (-M $inter_file) >= (-M $template_file)) {
    $compile_template = 0;
}
if ($compile_template) {
    if (TemplateParser->parse ($template_file, $inter_file) == 0) {
	print STDERR ("Translated $template_file to $inter_file\n") if $verbose;
    }
    else {
	die "Could not parse template file - exiting\n";
    }
}

require "${spec_parser}.pm"; $spec_parser->import;
our $ROOT = $spec_parser->parse($spec_file);
print STDERR ("Parsed $spec_file\n") if $verbose;
$ROOT->print() if $debugging;

require "$inter_file";
die "$@" if $@;
exit(0);

sub Usage {
    print STDERR <<"_EOT_";
-t <template file name> 
_EOT_
exit(1);
}

