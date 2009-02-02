#!/usr/bin/perl -w
use strict;
use Tk;

our (@block_cells, @tile_ids, @heap, $state, $w_top, $w_heap, $w_start);
our ($MAX_COLS, $MAX_ROWS, $TILE_WIDTH, $TILE_HEIGHT) = (10, 14, 15, 15);

my $ACTIVE = 0;
my $PAUSED = 1;
my $GAMEOVER = 2;

my $interval = 200;
my $shoot_row = int($MAX_ROWS/2);

init();
MainLoop();

sub init {
    $state = $PAUSED;
    @heap = ();
    @block_cells = ();
    @tile_ids = ();
    create_screen();
    bind_key(' ', \&fall);
    bind_key('h', \&move_left);
    bind_key('l', \&move_right);
    bind_key('k', \&rotate);
    bind_key('s', \&start_pause);
    bind_key('a', \&shoot);
    bind_key('q', sub {exit(0)});
}

sub tick {
    return if ($state == $PAUSED);
    if (!@block_cells) {
	if (!create_random_block()) {
	    game_over();
	    return;
	}
	$w_top->after($interval, \&tick);
	return;
    }
    move_down();
    $w_top->after($interval, \&tick);
}

sub start_pause {
    if ($state == $PAUSED) {
	$state = $ACTIVE;
	$w_start->configure(-text=>'Pause');
	tick();
    }
    elsif ($state == $GAMEOVER) {
	$state = $ACTIVE;
	$w_start->configure(-text=>'Pause');
	$w_heap->delete('all');
	create_shootbox();
	@heap = ();
	@block_cells = ();
	@tile_ids = ();
	tick();
    }
    else {
	$state = $PAUSED;
	$w_start->configure(-text=>'Start');
    }
}

sub create_random_block {
    my ($r, $color);
    my $center = $MAX_COLS/2;
    my @patterns = ([$center-2,$center-1,$center,$center+1],
	    [$center-1,$center,$center+1,$center+$MAX_COLS],
	    [$center-1,$center,$center+1,$center+$MAX_COLS+1],
	    [$center-1,$center,$center+1,$center+$MAX_COLS-1],
	    [$center-1,$center,$center+$MAX_COLS,$center+$MAX_COLS+1],
	    [$center,$center+1,$center+$MAX_COLS-1,$center+$MAX_COLS],
	    [$center-1,$center,$center-1+$MAX_COLS,$center+$MAX_COLS]);
    my @colors = ('red','green','blue','yellow','violet','gray','orange');

    $r = rand()*1000000%(scalar @patterns);
    @block_cells = @{$patterns[$r]};
    $color = $colors[$r];
    for my $cell (@block_cells) {
	return 0 if ($heap[$cell]);
	push (@tile_ids, $w_heap->create('rectangle', 
		($cell % $MAX_COLS)*$TILE_WIDTH,
		(int($cell / $MAX_COLS))*$TILE_HEIGHT,
		(($cell % $MAX_COLS) +1)*$TILE_WIDTH,
		(int($cell / $MAX_COLS) +1)*$TILE_HEIGHT,
	       -tags => 'block', -fill => $color)); 
    }
    return 1;
}

sub game_over {
    $w_start->configure(-text=>'Retry');
    $w_heap->create(
	    'text', $MAX_COLS * $TILE_WIDTH/2, $MAX_ROWS*$TILE_HEIGHT/2,
	    -text=>'game over',
	    -font=>'-adobe-helvetica-medium-r-normal--20-100-75-75-p-56-*-*');
    $state = $GAMEOVER;
}

sub fall {
    return if (!@block_cells);
    1 while (move_down());
}

sub move_down {
    my $cell;
    my $first_cell_last_row = ($MAX_ROWS-1)*$MAX_COLS;

    for $cell (@block_cells) {
	if (($cell >= $first_cell_last_row) ||
		($heap[$cell+$MAX_COLS])) {
	    merge_block_and_heap();
	    return 0;
	}
    }
    for $cell (@block_cells) {
	$cell += $MAX_COLS;
    }
    $w_heap->move('block', 0, $TILE_HEIGHT);
    return 1;
}

sub merge_block_and_heap {
    my $cell;
    for $cell (@block_cells) {
	$heap[$cell] = shift @tile_ids;
    }
    $w_heap->dtag('block');

    my $last_cell = $MAX_COLS * $MAX_ROWS;
    my $filled_cell_count;
    my $rows_to_be_deleted = 0;
    my $i;
    for ($cell = 0;$cell < $last_cell;) {
	$filled_cell_count = 0;
	my $first_cell_in_row = $cell;
	for ($i = 0; $i < $MAX_COLS; $i++) {
	    $filled_cell_count++ if ($heap[$cell++]);
	}
	if ($filled_cell_count == $MAX_COLS) {
	    for ($i = $first_cell_in_row; $i < $cell; $i++) {
		$w_heap->addtag('delete', 'withtag' => $heap[$i]);
	    }
	    splice (@heap, $first_cell_in_row, $MAX_COLS);
	    unshift(@heap, (undef) x $MAX_COLS);
	    $rows_to_be_deleted = 1;
	}
    }
    @block_cells = ();
    @tile_ids = ();
    if ($rows_to_be_deleted) {
	$w_heap->itemconfigure('delete', -fill => 'white');
	$w_top->after(300, 
		sub {
                    $w_heap->delete('delete');
		    my ($i);
		    my $last = $MAX_COLS * $MAX_ROWS;
		    for ($i=0;$i<$last;$i++) {
		        next if !$heap[$i];
			my $col = $i % $MAX_COLS;
			my $row = int($i / $MAX_COLS);
			$w_heap->coords(
			    $heap[$i],
			    $col * $TILE_WIDTH,
			    $row * $TILE_HEIGHT,
			    ($col+1)*$TILE_WIDTH,
			    ($row+1)*$TILE_HEIGHT);
		    }
		});
    }
}

sub move_left {
    my $cell;
    for $cell (@block_cells) {
	if ((($cell % $MAX_COLS) == 0) ||
		($heap[$cell-1])) {
	    return;
	}
    }
    for $cell (@block_cells) {
	$cell--;
    }
    $w_heap->move('block', - $TILE_WIDTH, 0);
}

sub move_right {
    my $cell;
    for $cell (@block_cells) {
	if ((($cell % $MAX_COLS) == $MAX_COLS-1) ||
		($heap[$cell+1])) {
	    return;
	}
    }
    for $cell (@block_cells) {
	$cell++;
    }
    $w_heap->move('block', $TILE_WIDTH, 0);
}

sub rotate {
    return if (!@block_cells);
    my $cell;

    my $row_total = 0;
    my $col_total = 0;
    my ($row, $col);
    my @cols = map {$_ % $MAX_COLS} @block_cells;
    my @rows = map {int($_ / $MAX_COLS)} @block_cells;
    for (0 .. $#cols) {
	$row_total += $rows[$_];
	$col_total += $cols[$_];
    }
    my $pivot_row = int ($row_total / @cols + 0.5);
    my $pivot_col = int ($col_total / @cols + 0.5);

    my @new_cells = ();
    my @new_rows = ();
    my @new_cols = ();
    my ($new_row, $new_col);
    while (@rows) {
	$row = shift @rows;
	$col = shift @cols;

	$new_col = $pivot_col + ($row - $pivot_row);
	$new_row = $pivot_row - ($col - $pivot_col);
	$cell = $new_row * $MAX_COLS + $new_col;

	if (($new_row < 0) || ($new_row > $MAX_ROWS) ||
		($new_col < 0) || ($new_col > $MAX_COLS) ||
		$heap[$cell]) {
	    return 0;
	}
	push (@new_rows, $new_row);
	push (@new_cols, $new_col);
	push (@new_cells, $cell);
    }
    my $i = @new_rows - 1;
    while ($i >= 0) {
	$new_row = $new_rows[$i];
	$new_col = $new_cols[$i];
	$w_heap->coords($tile_ids[$i],
		$new_col * $TILE_WIDTH,
		$new_row * $TILE_HEIGHT,
		($new_col+1) * $TILE_WIDTH,
		($new_row+1) * $TILE_HEIGHT);
	$i--;
    }
    @block_cells = @new_cells;
    1;
}

sub shoot {
    my ($dir) = @_;
    my $first_cell_shoot_row = $shoot_row * $MAX_COLS;
    my $last_cell_shoot_row = $first_cell_shoot_row + $MAX_COLS;
    my $cell;
    my (@indices) = 
	sort {
	    $dir eq 'left' ?
		$block_cells[$a] <=> $block_cells[$b] :
		$block_cells[$b] <=> $block_cells[$a]
	} (0 .. $#block_cells);
    my $found = -1;
    my $i;
    for $i (@indices) {
	$cell = $block_cells[$i];
	if (($cell >= $first_cell_shoot_row) &&
		($cell < $last_cell_shoot_row)) {
	    $found = $i;
	    last;
	}
    }
    if ($found != -1) {
	my $shot_tile = $tile_ids[$found];
	($cell) = splice (@block_cells, $found, 1);
	splice (@tile_ids, $found, 1);
	my $y = ($shoot_row + 0.5)*$TILE_HEIGHT;
	my $arrow = $w_heap->create(
		'line',0,$y,(($cell % $MAX_COLS) + 0.5)*$TILE_WIDTH,
		$y,
	       	-fill => 'white',
		-arrow => 'last',
		-arrowshape => [7,7,3]);
	$w_heap->itemconfigure($shot_tile,
		-stipple => 'gray25');
	$w_top->after(200, sub {
		$w_heap->delete($shot_tile);
		$w_heap->delete($arrow);
		});
    }
}

sub create_screen {
    $w_top = MainWindow->new(
	    -title => 'Tetris - Perl/Tk');
    $w_heap = $w_top->Canvas(
	    -width => $MAX_COLS * $TILE_WIDTH,
	    -height => $MAX_ROWS * $TILE_HEIGHT,
	    -border => 1,
	    -relief => 'ridge');
    $w_start = $w_top->Button(
	    -text => 'Start',
	    -command => \&start_pause);
    my $w_quit = $w_top->Button(
	    -text => 'Quit',
	    -command => sub {exit(0)});
    $w_heap->pack();
    $w_start->pack(
	    -side => 'left',
	    -fill => 'y',
	    -expand => 'y');
    $w_quit->pack(
	    -side => 'right',
	    -fill => 'y',
	    -expand => 'y');
    create_shootbox();
}

sub bind_key {
    my ($keychar, $callback) = @_;
    if ($keychar eq ' ') {
	$keychar = "KeyPress-space";
    }
    $w_top->bind("<${keychar}>", $callback);
}

sub create_shootbox {
    $w_heap->create('polygon',$TILE_WIDTH/2.0,($shoot_row*$TILE_HEIGHT)+($TILE_HEIGHT/2.0),
	    0,($shoot_row+1)*$TILE_HEIGHT,
	    0,$shoot_row*$TILE_HEIGHT,-fill=>'red');
}

