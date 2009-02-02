package Ast;
use strict;

sub new {
    my ($pkg, $name) = @_;
    bless {ast_node_name => $name}, $pkg;
}

sub add_prop {
    my ($node, $prop_name, $prop_value) = @_;
    $node->{$prop_name} = $prop_value;
}

sub add_prop_list {
    my ($node, $prop_name, $node_ref) = @_;
    if (! exists $node->{$prop_name}) {
	$node->{$prop_name} = [];
    }
    push (@{$node->{$prop_name}}, $node_ref);
}

my @saved_values_stack;

sub visit {
    no strict 'refs';
    my $node = shift;
    package main;
    my ($var, $val, $old_val, %saved_values);
    while ( ($var,$val) = each %{$node}) {
	if (defined ($old_val = $$var)) {
	    $saved_values{$var} = $old_val;
	}
	$$var = $val;
    }
    push (@saved_values_stack, \%saved_values);
}

sub bye {
    my $rh_saved_values = pop(@saved_values_stack);
    no strict 'refs';
    package main;
    my ($var, $val);
    while (($var, $val) = each %$rh_saved_values) {
	$$var = $val;
    }
}
1;

