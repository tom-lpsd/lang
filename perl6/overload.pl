#!/usr/bin/env pugs

multi sub foo () returns Int { 0 }
multi sub foo ($x) returns Int { $x }

say foo;
say foo(10);

