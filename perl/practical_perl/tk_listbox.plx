#!/usr/bin/perl -w
use strict;
use Tk;
my $top = MainWindow->new();
my $wine_list = $top->Listbox(-width=>20, -height=>5)->pack();
$wine_list->insert('end',
	"Napa Valley Chardonnay",
	"Cabernet Sauvignon",
	"Dry Chenin Blanc",
	"Merlot", "Sangiovese");
$wine_list->bind('<Double-1>', \&buy_wine);

sub buy_wine {
    my $wine = $wine_list->get('active');
    return if (!$wine);
    print "Ah, '$wine'. An excellent choice\n";
    $wine_list->delete('active');
}
MainLoop();

