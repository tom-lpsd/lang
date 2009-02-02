#!/usr/bin/perl -w

use strict;
use Template;
use CGI;

$| = 1;
print "Content-type: text/html\n\n";

my $file = 'ex2.tt';
my $vars = {'version'  => 3.14,
	    'days'     => [  qw|mon tue wed thu fri sat sun| ],
	    'worklist' => \&get_user_projects,
	    'cgi'      => CGI->new(),
	    'me'       => {'id'     => 'abw',
			   'name'   => 'Andy Wardley',},
	    'email'    => 'hoge@mail.com',
	   };

sub get_user_projects {
  my $user = shift;
  my @projects =({url => "hoge.jp", name => $user}); # do something to retrieve data
  return \@projects;
}

my $template = Template->new({
			      INCLUDE_PATH => 'template',
			      PRE_PROCESS  => '',
			      ABSOLUTE => 1,
			     });

$template->process($file, $vars)
  || die $template->error();
