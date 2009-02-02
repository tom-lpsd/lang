#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();
my $car_list = $top->Listbox(
	-width => 15,
	-height => 4)->pack(-side=>'left',-padx=>10);

$car_list->insert('end',
	"Acura", "BMW","Ferrati","Lotus",
	"Maserati","Lamborghini","Chevrolet");

my $scroll = $top->Scrollbar(
	-orient => 'vertical',
	-width => 10,
	-command => ['yview',$car_list]
	)->pack(
	    -side => 'left',
	    -fill => 'y',
	    -padx => 10);

$car_list->configure(-yscrollcommand=>['set',$scroll]);

MainLoop();

