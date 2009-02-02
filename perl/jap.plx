#!/usr/bin/perl -w
use strict;
use utf8;

sub 言う {
  my ($単語) = @_;
  utf8::encode($単語);
  print "$単語\n";
}

言う("こんにちは");
