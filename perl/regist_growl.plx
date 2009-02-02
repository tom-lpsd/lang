#!/Users/tom/apps/perl6/bin/perl -w
use Mac::Growl;

Mac::Growl::RegisterNotifications (
    'growlalert',
    [ 'alert' ],
    [ 'alert' ],
);

