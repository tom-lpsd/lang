#!/usr/bin/env perl

=head1 USAGE

Execute command

$ perl genconf.plx > APACHE_ROOT/conf/extra/httpd-mod_perl.conf

And insert following directive to httpd.conf.

Include conf/extra/httpd-mod_perl.conf

=cut

use strict;
use warnings;
use Template;
use File::Spec;
use File::HomeDir;

my $template = Template->new;

my $home = File::HomeDir->home;

$template->process(\*DATA, { home => $home })
    or die $template->error;

__DATA__
LoadModule perl_module modules/mod_perl.so

PerlRequire [% home %]/src/mod_perl/startup.pl

<Location /drive>
    SetHandler perl-script
    PerlResponseHandler Drive
</Location>
