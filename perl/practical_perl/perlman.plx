#!/usr/bin/perl -w
use strict;
use utf8;
use Tk;

our ($show, $text, $search);
our ($match_type, $ignore_case);
our (%sections, $menu_headings);

create_ui();
MainLoop();

sub is_valid_section {
    $_[0] =~ /^\d+$/;
}

sub show_man {
    my $entry = $show->get();
# $entryの内容は「csh」や「csh(1)」のような文字列
    my ($man, $section) = ($entry =~ /^(\w+)(\(.*\))?/);
    if ($section && (!is_valid_section($section))) {
	undef $section;
    }
    my $cmd_line = get_command_line($man, $section);

    $text->delete('1.0','end');
    $text->insert('end',
	    "Formatting \"$man\" .. please wait", 'section');
    $text->update();
    $menu_headings->menu()->delete(0,'end');
    my $mark;
    for $mark ($text->markNames) {
	$text->markUnset($mark);
    }

    if (!open (F, $cmd_line)) {
	$text->insert('end', "\nError in running man or rman");
	$text->update();
	return;
    }

    $text->delete('1.0','end');
    my $lines_added = 0;
    my $line;

    while (defined($line=<F>)) {
	$lines_added = 1;
	if ($line =~ /^[A-Z]/) {
	    ($mark = $line) =~ s/\s.*$//g;
	    my $index = $text->index('end');
	    $text->insert('end', "$mark\n\n", 'section');
	    $menu_headings->command(
		    -label => $mark,
		    -command => [sub {$text->see($_[0])}, $index]);
	}
	else {
	    $text->insert('end',$line);
	}
    }
    if (! $lines_added ) {
	$text->insert('end', "Sorry. No information found on $man");
    }
    close(F);
}

sub get_command_line {
    my ($man, $section) = @_;
    if ($section) {
	$section =~ s/[()]//g;
	return "man -s $section $man 2> /dev/null | rman |";
    }
    else {
	return "man $man 2> /dev/null | rman |";
    }
}

sub pick_word {
    my $start_index = $text->index('insert wordstart');
    my $end_index = $text->index('insert lineend');
    my $line = $text->get($start_index, $end_index);
    my ($page, $section) = ($line =~ /^(\w+)(\(.*?\))?/);
    return unless $page;
    $show->delete('0', 'end');
    if ($section && is_valid_section($section)) {
	$show->insert('end', "$page${section}");
    }
    else {
	$show->insert('end', $page);
    }
    show_man();
}

sub search {
    my $search_pattern = $search->get();
    $text->tagDelete('search');

    $text->tagConfigure('search',
	    -background => 'yellow',
	    -foreground => 'red');

    my $current = '1.0';
    my $length = '0';

    while(1) {
	if ($ignore_case) {
	    $current = $text->search(
		    -count => \$length,
		    $match_type,
		    '-nocase', '--',
		    $search_pattern,
		    $current,
		    'end');
	}
	else {
	    $current = $text->search(
		    -count => \$length,
		    $match_type, '--',
		    $search_pattern,
		    $current,
		    'end');
	}
	last if (!$current);

	$text->tagAdd('search', $current, "$current + $length char");
	$current = $text->index("$current + $length char");
    }
}

sub create_ui {
    my $top = MainWindow->new();
    my $menu_bar = $top->Frame()->pack(-side=>'top',-fill=>'x');

    my $menu_file = $menu_bar->Menubutton(
	    -text => 'File',
	    -relief => 'raised',
	    -borderwidth => 2
	    )->pack(-side=>'left',-padx=>2);

    $menu_file->separator();
    $menu_file->command(-label=>'Quit',-command=>sub {exit(0)});

    $menu_headings = $menu_bar->Menubutton(
	    -text=>'Headings',
	    -relief=>'raised',
	    -borderwidth => 2
	    )->pack(-side=>'left',-padx=>2);
    $menu_headings->separator();

    my $search_mb = $menu_bar->Menubutton(
	    -text=>'Search',
	    -relief=>'raised',
	    -borderwidth=>2
	    )->pack(-side=>'left',-padx=>2);
    $match_type = "-regexp";
    $ignore_case = 1;
    $search_mb->separator();

    $search_mb->radiobutton(
	    -label => 'Regexp match',
	    -value => '-regexp',
	    -variable => \$match_type);
    $search_mb->radiobutton(
	    -label => 'Exact match',
	    -value => '-exact',
	    -variable => \$match_type);
    $search_mb->separator();

    $search_mb->checkbutton(
	    -label => 'Ignore case?',
	    -variable => \$ignore_case);

    my $menu_sections = $menu_bar->Menubutton(
	    -text => 'sections',
	    -relief => 'raised',
	    -borderwidth => 2
	    )->pack(-side=>'left',-padx=>2);

    my $section_name;
    for $section_name (sort keys %sections) {
	$menu_sections->command(
		-label => "($section_name)",
		-command => [\&show_section_contents, $section_name]);
    }

    $text = $top->Text(
	    -width => 80,
	    -height => 40)->pack();
    $text->tagConfigure(
	    'section', -font =>
	    '-adobe-helvetica-bold-r-normal--14-140-75-75-p-82-iso-8859-1');

    $text->bind('<Double-1>', \&pick_word);
    $top->Label(-text=>'Show:')->pack(-side=>'left');

    $show = $top->Entry(-width=>20)->pack(-side=>'left');
    $show->bind('<KeyPress-Return>', \&show_man);

    $top->Label(-text=>'Search:')->pack(-side=>'left',-padx=>10);
    $search = $top->Entry(-width=>20)->pack(-side=>'left');
    $search->bind('<KeyPress-Return>', \&search);
}

