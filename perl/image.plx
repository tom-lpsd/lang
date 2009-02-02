#!/usr/bin/perl -w
use strict;
use Image::Magick;

my $image = new Image::Magick;
$image->Read($ARGV[0]);
$image->Display();

