#!/usr/bin/perl -w
use strict;
use Tk;
require Tk::HList;

my $top = MainWindow->new();
my $hlist = $top->Scrolled('HList',
	-drawbranch => 1,
	-separator => '/',
	-indent => 15,
	-command => \&show_or_hide_dir);
$hlist->pack(-fill=>'both',-expand=>'y');

show_or_hide_dir("/");

MainLoop();

sub show_or_hide_dir {
    my $path = $_[0];
    return if (! -d $path);
    if ($hlist->info('exists', $path)) {
	my $next_entry = $hlist->info('next',$path);
	if(!$next_entry || (index ($next_entry, "$path/") == -1)) {
	    $hlist->entryconfigure($path);
	    add_dir_contents($path);
	}
	else {
	    $hlist->entryconfigure($path);
	    $hlist->delete('offsprings', $path);
	}
    }
    else {
	die "'$path' is not a direactory\n" if (! -d $path);
	$hlist->add($path, -itemtype => 'text',
		-text=>$path);
	add_dir_contents($path);
    }
}

sub add_dir_contents {
    my $path = $_[0];
    my $oldcursor = $top->cget('cursor');
    my $text;
    $top->configure(-cursor => 'watch');
    $top->update();
    my @files = glob "$path/*";
    for my $file (@files) {
	$file =~ s|//|/|g;
	($text = $file) =~ s|^.*/||g;
	if (-d $file) {
	    $hlist->add($file, -itemtype => 'text',
		    -text => $text);
	}
	else {
	    $hlist->add($file, -itemtype => 'text',
		    -text => $text);
	}
    }
    $top->configure(-cursor => $oldcursor);
}

