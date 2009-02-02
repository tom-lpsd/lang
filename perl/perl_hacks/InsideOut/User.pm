{
    package InsideOut::User;
    use Scalar::Util 'refaddr';

    my %names;
    my %address;

    sub new {
	my ($class, $data) = @_;
	bless \(my $self), $class;

	my $id = refaddr(\$self);
	$names{$id} = $data->{name};
	$address{$id} = $data->{address};

	return \$self;
    }

    sub get_name {
	my $self = shift;
	return $names{ refaddr($self) };
    }

    sub get_address {
	my $self = shift;
	return $address{ refaddr($self) };
    }

    sub DESTROY {
	my $self = shift;
	my $id = refaddr($self);
	delete $names{$id};
	delete $address{$id};
    }
}

1;
