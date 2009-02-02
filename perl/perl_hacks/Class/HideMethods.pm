package Class::HideMethods;

use strict;
use warnings;
use Attribute::Handlers;

our $foo = 100;
sub foo {
    print "hogehogehoge!\n";
}

package UNIVERSAL;

sub Private :ATTR
{
    my ($package, $symbol, $referent, $attr, $data, $phase) = @_;
    print "$package " . *$symbol{NAME} . " $referent $attr $data $phase\n";
    no strict 'refs';
    *$symbol = \(my $foo = 100); 
    *$symbol = $Class::HideMethods::{foo};
}

sub Foo :ATTR
{
    print "fooooo\n";
}

1;

