package Role::Foo;
use 5.010;
use Moose::Role;

requires qw(foo);

sub bar {
    my $self = shift;
    $self->foo;
    say "bar";
}

1;
