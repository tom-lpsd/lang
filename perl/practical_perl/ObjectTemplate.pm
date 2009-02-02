package ObjectTemplate;
require Exporter;
@ObjectTemplate::ISA = qw|Exporter|;
@ObjectTemplate::EXPORT = qw|attributes|;

my $debugging = 0;

sub attributes {
    my ($pkg) = caller;
    @{"${pkg}::_ATTRIBUTES_"} = @_;
    my $code = "";
    for my $attr (get_attribute_names($pkg)) {
        @{"${pkg}::_$attr"} = ();
	unless ($pkg->can("$attr")){
	    $code .= _define_accessor($pkg, $attr);
        }
    }
    $code .= _define_constructor($pkg);
    eval $code;
    if ($@) {
        die "ERROR defining constructor and attributes for '$pkg':"
	    . "\n\t$@\n"
	    . "-----------------------------------------------------"
	    . $code;
    } 
}

sub _define_accessor {
    my ($pkg,$attr) = @_;

    my $code = qq|
        package $pkg;
	sub $attr {
	    \@_ > 1 ? \$_${attr} \[\${\$_[0]}] = \$_[1]
	            : \$_${attr} \[\${\$_[0]}];
        }
	if (!defined \$_free) {
	    \*_free = \*_$attr;
	    \$_free = 0;
        };

    |;
    $code;
}

sub _define_constructor {
    my $pkg = shift;
    my $code = qq|
        package $pkg;
	sub new {
	    my \$class = shift;
	    my \$inst_id;
	    if (defined(\$_free[\$_free])) {
	        \$inst_id = \$_free;
		\$_free = \$_free[\$_free];
		undef \$_free[\$inst_id];
            }
	    else {
	        \$inst_id = \$_free++;
            }
	    my \$obj = bless \\\$inst_id, \$class;
	    \$obj->set_attributes(\@_) if \@_;
	    \$obj->initialize;
	    \$obj;
        }
    |;
    $code;
}

sub get_attribute_names {
    my $pkg = shift;
    $pkg = ref($pkg) if ref($pkg);
    my @result = @{"${pkg}::_ATTRIBUTES_"};
    if (defined (@{"${pkg}::ISA"})) {
        for my $base_pkg (@{"${pkg}::ISA"}) {
	    push (@result, get_attribute_names($base_pkg));
	}    
    }
    @result;
}

sub set_attributes {
    my $obj = shift;
    my $attr_name;
    if (ref($_[0])) {
        my ($attr_name_list, $attr_value_list) = @_;
	my $i = 0;
	for $attr_name (@$attr_name_list) {
	    $obj->$attr_name($attr_value_list->[$i++]);
        }
    }
    else {
        my ($attr_name, $attr_value);
	while (@_) {
	    $attr_name = shift;
	    $attr_value = shift;
	    $obj->$attr_name($attr_value);
        }
    }
}

sub get_attributes {
    my $obj = shift;
    my (@retval);
    map $obj->${_}(), @_;
}

sub set_attribute {
    my ($obj, $attr_name, $attr_value) = @_;
    my ($pkg) = ref($obj);
    ${"${pkg}::_$attr_name"}[$$obj] = $attr_value;
}

sub get_attribute {
    my ($obj, $attr_name) = @_;
    my ($pkg) = ref($obj);
    return ${"${pkg}::_$attr_name"}[$$obj];
}

sub DESTROY {
    my $obj = $_[0];
    my $pkg = ref($obj);
    local *_free = *{"${pkg}::_free"};
    my $inst_id = $$obj;

    local (@attributes) = get_attribute_names(${pkg});
    for my $attr (@attributes) {
        undef ${"${pkg}::_$attr"}[$inst_id];
    }
    $_free[$inst_id] = $_free;
    $_free = $inst_id;
}

sub initialize { };

1;

