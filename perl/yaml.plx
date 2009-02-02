#!/usr/bin/perl -w
use YAML;

# Load a YAML stream of 3 YAML documents into Perl data structures.
my ($hashref, $arrayref, $string) = Load(<<'...');
---
name: ingy
age: old
weight: heavy
# I should comment that I also like pink, but don't tell anybody.
favorite colors:
  - red
  - green
  - blue
---
- Clark Evans
- Oren Ben-Kiki
- Ingy dA9|t Net
---
...

print Dump($string, $arrayref, $hashref);
