package circular;
sub new {
    shift;
    bless { name => shift };
}

sub DESTROY {
    my $self = shift;
    print "$self->{name}: nuked\n";
}

package main;
{
    my $a = new circular 'a';
    my $b = new circular 'b';
    $a->{next} = $b;
    $b->{next} = $a;
}
print "the end\n";

