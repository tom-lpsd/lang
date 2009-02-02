package DB::Main;
use base qw/DBIx::Class::Schema::Loader/;

#__PACKAGE__->load_classes();
__PACKAGE__->loader_options( relationships => 1 );

1;
