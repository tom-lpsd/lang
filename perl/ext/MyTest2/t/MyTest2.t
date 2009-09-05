# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl MyTest2.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use Test::More tests => 5;
BEGIN { use_ok('MyTest2') };


my $fail = 0;
foreach my $constname (qw(
	TESTVAL)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined MyTest2 macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is( &MyTest2::foo(1, 2, "Hello, World!"), 7);
is( &MyTest2::foo(1, 2, "0.0"), 7);
ok( abs(&MyTest2::foo(0, 0, "-3.4") - 0.6) <= 0.01);
