#!/Users/tom/apps/perl6/bin/perl -w
use Mac::Growl;

Mac::Growl::PostNotification(
    'growlalert',
    'alert',
    "This is a title",
    "This is a description.",
);

