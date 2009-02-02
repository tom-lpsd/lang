package D;
use 5.010;
use A;
use Foo;
use C;

C->init();

__PACKAGE__->setup;

1;
