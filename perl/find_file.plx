#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use File::Find;

find (sub {
	  say if /\.css$/;
      }, $ARGV[0]);
