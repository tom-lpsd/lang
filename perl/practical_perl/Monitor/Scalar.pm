package Monitor::Scalar;

sub TIESCALAR {
    my ($pkg, $rval, $name) = @_;
    my $obj = [$name, $$rval];
    bless $obj, $pkg;
    return $obj;
}

sub FETCH {
    my ($obj) = @_;
    my $val = $obj->[1];
    print STDERR 'Read    $', $obj->[0], " ... $val\n";
    return $val;
}

sub STORE {
    my ($obj, $val) = @_;
    print STDERR 'Wrote    $', $obj->[0], " ... $val\n";
    $obj->[1] = $val;
    return $val;
}

sub unmonitor {
    my ($pkg, $r_var) = @_;
    my $val;
    {
	my $obj = tied $$r_var;
	$val = $obj->[1];
	$obj->[0] = "_UNMONITORED_";
    }
    untie $$r_var;
    $$r_var = $val;
}

sub DESTROY {
    my ($obj) = @_;
    if ($obj->[0] ne '_UNMONITORED_') {
	print STDERR 'Died    $', $obj->[0];
    }
}
1;

