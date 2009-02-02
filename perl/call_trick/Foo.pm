package Foo;
use 5.010;
use NEXT;

sub setup {
    my $class = shift;
    say "foo";
    $class->NEXT::setup();
}

1;
