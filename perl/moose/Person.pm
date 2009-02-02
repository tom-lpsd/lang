package Person;
use 5.010;
use Moose;
use Moose::Util::TypeConstraints;

subtype 'Foo'
    => as Str
    => where {
        /^[0-4]$/
    };

sub BUILD {
    say "BUILD!!!!";
    say $_[1]->{first_name};
}

has first_name => (
    is  => 'rw',
    isa => 'Foo',
);

1;
