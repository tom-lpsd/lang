package File;
use Symbol;

sub open {
    my ($pkg, $filename) = @_;
    $obj = gensym();
    open ($obj, $filename) || return undef;
    bless $obj, $pkg;
}

sub put_back {
    my ($r_obj, $line) = @_;
    ${*$r_obj} = $line;
}

sub next_line {
    my ($r_obj) = $_[0];
    my $retval;
    if (${*$r_obj}){
	$retval = ${*$r_obj};
	${*$r_obj} = "";
    }
    else {
	$retval = <$r_obj>;
	push (@{*$r_obj}, $retval);
    }
    $retval;
}
1;
