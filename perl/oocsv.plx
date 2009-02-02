#!/usr/bin/perl -w
use strict;
use OpenOffice::OODoc;

my $output_file = "output.ods";
my ($max_rows, $max_columns) = (0,0);
my @data;

while(<>) {
  chomp;
  $max_rows++;
  my @a = split /,/,$_;
  my $columns = scalar(@a);
  my $max_columns = $columns if $max_columns < $columns;
  push @data, \@a;
}

my $doc = ooDocument(file => $output_file, create => 'spreadsheet');
my $table = $doc->getTable(0, $max_rows, $max_columns);
$doc->renameTable($table, "表の名前");

my @rows = $doc->getTableRows($table);
for my $x (@data) {
  my @values = @$x;
  my $row = shift @rows;
  my @cells = $doc->getRowCells($row);
  for my $value (@values) {
    my $cell = shift @cells;
    if($value =~ m/\A[0-9.+-]+([eE][0-9+-]+)?\Z/) {
      $doc->cellValueType($cell, 'float');
      $doc->cellValue($cell,$value, $value);
    }
    elsif($value =~ m/\A=/){
      $doc->cellFormula($cell, $value);
    }
    else{
      $doc->cellValue($cell, $value);
    }
  }
}

$doc->save;
