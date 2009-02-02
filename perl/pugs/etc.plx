my @array = <1 2 3>;
say "@array[]";
say @array[2];

my $foo = "This is";
my $bar = "the end.";
my @baz = <<$foo $bar>>;
say @baz.elems;

say "2 + 2 = {2+2}";

my $f = =<>;
for =<> {
    say $_;
}

say $f;
say ~10;

my $i = 0;
repeat {
    say $i++;
} until($i >= 10);

loop (my $j=10;$j<20;++$j) {
    say $j;
}

loop {
    say $j++;
    last if $j == 30;
}

sub foo {
    say "@_[]";
}

my @numbers = (1,2,3);
my @trimults = map { $^あ - $^い - $^う }, (3,4,5,1,2,3);
say "@trimults[]";

