package Monitor::Array;

sub TIEARRAY {
    my ($pkg, $array, $name) = @_;
    my $obj = [$name, [@$rarray]];
    bless $obj, $pkg;
    return $obj;
}

sub FETCH {
    my ($obj, $index) = @_;
    my $val = $obj->[1]->[$index];
    print STDERR 'Read    $', $obj->[0], "[$index] ... $val\n";
    return $val;
}

sub STORE {
    my ($obj, $index, $val) = @_;
    print STDERR 'Wrote   $', $obj->[0], "[$index] ... $val\n";
    $obj->[1]->[$index] = $val;
    return $val;
}

sub DESTROY {
    my ($obj) = @_;
    if ($obj->[0] ne '_UNMONITORED_') {
	print STDERR 'Died    %', $obj->[0];
    }
}

sub unmonitor {
    my ($pkg, $r_var) = @_;
    my $r_array;
    {
	my $obj = tied @$r_var;
	$r_array = $obj->[1];
	$obj->[0] = "_UNMONITORED_";
    }
    untie @$r_var;
    @$r_var = @$r_array;
}
1;

