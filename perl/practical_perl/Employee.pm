package Employee;

sub allocate {
    my ($class, $name, $age, $starting_position) = @_;
    my $self = bless {
	name => $name,
	age => $age,
	position =>$starting_position,
    }, $class;
    return $self;
}

sub promote {
    my $self = shift;
    my $current_position = $self->{position};
    my $next_position = $current_position . "+";
    $self->{position} = $next_position;
}

package HourlyEmployee;
@ISA = qw|Employee|;

sub new {
    my ($class, $name, $age, $starting_position,
	$hourly_rate, $overtime_rate) = @_;
    my $self = $class->allocate($name, $age, $starting_position);
    $self->{hourly_rate} = $hourly_rate;
    $self->{overtime_rate} = $overtime_rate;
    return $self;
}

1;
