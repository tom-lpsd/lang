use File::HomeDir;
use File::Spec;

BEGIN {
    my $home = File::HomeDir->users_home("tom");
    my $lib = File::Spec->catfile($home, qw/src mod_perl lib/);
    push @INC, $lib;
}

1;
