#!/usr/bin/perl
package DumpVar;
sub dumpvar {
  my ($packageName) = @_;
  local (*alias);
  *stash = *{"${packageName}::"};
  $, = " ";
  while(($varName, $globValue) = each %stash) {
    print "$varName ============================ \n";
    *alias = $globValue;
    if(defined ($alias)){
      print "\t \$$varName $alias \n";
    }
    if(defined (@alias)){
      print "\t \$$varName @alias \n";
    }
    if(defined (%alias)){
      print "\t \%$varName ", %alias, " \n";
    }
  }
}

package A;
$x = 10;
@y = (1,3,4);
%z = (1,2,3,4,5,6);
$z = 300;
DumpVar::dumpvar("A");
print ${$A::{x}}, "\n";

package B;
$a = 1000;
@a = (200,300,400);
$A::{d} = *a;

package A;
print "$d @d \n";
