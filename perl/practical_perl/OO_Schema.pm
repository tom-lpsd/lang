package OO_Schema;
use Ast;
use Carp;
use strict;

our $line;

sub parse {
    my ($package, $filename) = @_;
    open (P, $filename) || die "Could not open $filename : $@";
    my $root = Ast->new("Root");
    eval {
	while (1) {
	    get_line();
	    next unless ($line =~ /^\s*class +(\w+)/);
	    my $c = Ast->new($1);
	    $c->add_prop("class_name" => $1);
	    $root->add_prop_list("class_list", $c);
	    while (1) {
		get_line(); #{
		last if $line =~ /^\s*}/;
		if ($line =~ s/^\s*(\w+)\s*(\w+)//) {
		    $a = Ast->new($2);
		    $a->add_prop("attr_name", $2);
		    $a->add_prop("attr_type", $1);
		    $c->add_prop_list("attr_list", $a);
		}
		my $curr_line = $line;
		while ($curr_line !~ /;/) {
		    get_line();
		    $curr_line .= $line;
		}
		my @props = split (/[,;]/, $curr_line);
		for my $prop (@props) {
		    if ($prop =~ /\s*(\w*)\s*=\s*(.*)\s*/) {
			$a->add_prop($1, $2);
		    }
		}
	    }
	}
    };
    die $@ if ($@ && ($@ !~ /END OF FILE/));
    return $root;
}

sub get_line {
    while (defined($line = <P>)) {
	chomp $line;
	$line =~ s#//.*$##;
	return if $line !~ /^\s*$/;
    }
    die "END OF FILE";
}
1;

