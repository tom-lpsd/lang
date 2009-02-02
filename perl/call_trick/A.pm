package A;
use 5.010;
use NEXT;

sub setup {
    my $class = shift;
    say "a";
    $class->NEXT::setup();
}

1;
