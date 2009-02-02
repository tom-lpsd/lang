package TieFile;
use Symbol;
use strict;

my $F_OFFSETS = 0;
my $F_FILEHANDLE = 1;

sub TIEARRAY {
    my ($pkg, $filename) = @_;
    my $fh = gensym();
    open ($fh, $filename) || die "Could not open file: $!\n";
    bless [ [0], $fh ], $pkg;
}

sub FETCH {
    my ($obj, $index) = @_;
    my $rl_offsets = $obj->[$F_OFFSETS];
    my $fh = $obj->[$F_FILEHANDLE];
    if ($index >= @$rl_offsets) {
	$obj->read_until ($index);
    }
    else {
	seek ($fh, $rl_offsets->[$index], 0);
    }
    return (scalar <$fh>);
}

sub STORE {
    die "Sorry. Cannot update file using package TieFile\n";
}

sub DESTROY {
    my ($obj) = @_;
    close($obj->[$F_FILEHANDLE]);
}

sub read_until {
    my ($obj, $index) = @_;
    my $rl_offsets = $obj->[$F_OFFSETS];
    my $last_index = @$rl_offsets - 1;
    my $last_offset = $rl_offsets->[$last_index];
    my $fh = $obj->[$F_FILEHANDLE];
    seek ($fh, $last_offset, 0);
    my $buf;
    while (defined ($buf = <$fh>)) {
	$last_offset += length($buf);
	$last_index++;
	push (@$rl_offsets, $last_offset);
	last if $last_index >= $index;
    }
}

1;

