#!/usr/bin/env perl
use strict;
use warnings;
use CGI;
use Class::Inspector;

local $, = " ";
print @{Class::Inspector->functions('CGI')}, "\n";
