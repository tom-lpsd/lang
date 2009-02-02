#!/usr/bin/perl -w
use strict;
use warnings;
use WebService::Validator::HTML::W3C;

my $v = WebService::Validator::HTML::W3C->new(
    detailed    =>  1
);

if ( $v->validate_file(shift) ) {
    if ( $v->is_valid ) {
	printf ("%s is valid\n", $v->uri);
    } else {
	printf ("%s is not valid\n", $v->uri);
	for my $error ( @{$v->errors} ) {
	    printf("%s at line %d\n", $error->msg,
		   $error->line);
	}
    }
} else {
    printf ("Failed to validate the website: %s\n", $v->validator_error);
}
