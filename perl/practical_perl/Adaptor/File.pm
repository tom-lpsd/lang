package Adaptor::File;
use Carp;
use strict;
use Storable qw();

our $object_cnt = 0;
our $debugging = 0;
our %g_attr_names;

sub new {
    my ($class, $file, $config) = @_;
    require $config;
    my $self = bless {all_instances => {},
		      file => $file,
		      config => \%g_attr_names} , $class;
    $self->load_all;
    $self;
}

sub get_attrs_for_class {
    my ($self, $class) = @_;
    return @{$self->{config}->{$class}}; 
}

sub store {
    (@_ == 2) || die 'Usage adaptor->store($obj_to_store)';
    my ($this, $obj_to_store) = @_;
    my ($id) = $obj_to_store->get_attributes('_id');
    my $all_instances = $this->{all_instances};
    if(!defined($id)) {
	$id = $this->_get_next_id();
	$obj_to_store->set_attributes('_id'=>$id);
    }
    $all_instances->{$id} = $obj_to_store;
    $id;
}

sub flush {
    my $this = $_[0];
    my $all_instances = $this->{all_instances};
    my $file = $this->{file};
    return unless defined $file;
    open (F, ">$file") || die "Error opening $file: $!\n";
    my ($id, $obj);
    while (($id, $obj) = each %$all_instances) {
	my $class = ref($obj);
	my @attrs = 
	    $obj->get_attributes($this->get_attrs_for_class($class));
	Storable::store_fd([$class, $id, @attrs], \*F);
    }
    close(F);
}

sub load_all {
    my $self = shift;
    my $file = $self->{file};
    return undef unless -e $file;
    open (F, $file) || croak "Unable to load $file: $!";

    my ($class, $id, $obj, $rh_attr_names, @attrs, $all_instances);
    $all_instances = $self->{all_instances};
    eval {
	while(1) {
	    ($class, $id, @attrs) = @{Storable::retrieve_fd(\*F)};
	    $obj = $all_instances->{$id};
	    $obj = $class->new() unless defined($obj);
	    $rh_attr_names = $self->get_attrs_for_class($class);
	    $obj->set_attributes(
		    "_id" => $id,
		    map {$rh_attr_names->[$_] => $attrs[$_]}
		        (0.. $#attrs)
		    );
	    $all_instances->{$id} = $obj;
	}
    };
    close(F);
    $all_instances;
}

sub retrieve_where {
    my ($this, $class, $query) = @_;
    my $all_instances = $this->{all_instances};
    return $this->retrieve_all() if ($query !~ /\S/);

    my ($boolean_expression, @attrs) = parse_query($query);
    my $fetch_stmt = "my (" . join(",", map{'$' . $_} @attrs) . ") = " .
	"\$obj->get_attributes(qw(@attrs))";

    my (@retval);

    my $eval_str = qq|
	my \$dummy_key; my \$obj;
	while ((\$dummy_key, \$obj) = each \%\$all_instances) {
	    next unless ref(\$obj) eq "$class";
	    $fetch_stmt;
	    push (\@retval, \$obj) if ($boolean_expression);
	}
    |;
    print STDERR "EVAL:\n\t$eval_str\n" if $debugging;
    eval ($eval_str);
    if ($@) {
	print STDERR "Ill-formed query:\n\t$query\n";
	print STDERR $@ if $debugging;
    }
    @retval;
}

my %string_op = (
	'==' => 'eq',
	'<'  => 'lt',
	'<=' => 'le',
	'>'  => 'gt',
	'>=' => 'ge',
	'!=' => 'ne',
	);
my $ANY_OP = '<=|>=|<|>|!=|==';

sub parse_query {
    my ($query) = @_;

    return 1 if ($query =~ /^\s*$/);
    $query =~ s/\\[']/\200/g;
    $query =~ s/\\["]/\201/g;
    $query =~ s/([^!><=])=/$1 == /g;

    my %attrs;
    $query =~
	s/(\w+)\s*($ANY_OP)/$attrs{$1}++, "\$$1 $2"/eg;

    $query =~
	s{
	    ($ANY_OP)
		\s*
		['"]([^'"]*)['"]
	}{$string_op{$1} . ' \'' . $2 . '\''}goxse;

#$query =~ /\200/\\'/g;
#$query =~ /\201/\\"/g;
    ($query , keys %attrs);
}

sub _get_next_id {
    time()+$object_cnt++;
}

1;

