package C;
use 5.010;
use NEXT;

sub init {
    my $caller = caller(0);
    push @{"$caller\::ISA"}, "C";
}

sub setup {
    my $class = shift;
    unshift @{"$class\::ISA"}, qw/A Foo/;
    say "c";
    {
	no warnings qw/redefine/;
	local *setup = sub {};
	$class->setup;
    }
}

1;
