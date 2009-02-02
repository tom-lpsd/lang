#!/usr/bin/env perl
package Foo;
use strict;

no strict 'refs';
*Foo::bar::hoge = sub {};

package main;
use Devel::InnerPackage;

print Devel::InnerPackage::list_packages('Foo'), "\n";
