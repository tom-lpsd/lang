package Megalith;

use strict;
use Carp;

### 新しい巨石オブジェクトを作成し，メンバフィールドを初期化する．
sub new {
    my $class = shift;
    my ( $name, $location, $mapref, $type, $description ) = @_;
    my $self = {};
    bless $self => $class;

    ### 引数を１つしか持たないなら，文字列はすべてのフィールド値を$nameに
    ### 含んでいると仮定し，アンパックする．

    if ( @_ == 1 ){
	$self->unpack( $name );
    }
    else {
	$self->{name} = $name;
	$self->{location} = $location;
	$self->{mapref} = $mapref;
	$self->{type} = $type;
	$self->{description} = $description;
    }
    return $self;
}

### コロンで区切られたレコードに現在のフィールド値をパックし，それを返す．
sub pack {
    my ( $self ) = @_;

    my $record = join ( ':', $self->{name}, $self->{location},
			$self->{mapref}, $self->{type},
			$self->{description} );

    ### フィールドがコロンを含まないことを簡単に確認する．
    croak "Record field contains ':' delimiter character"
	if $record =~ tr/:/:/ != 4;

    return $record;
}

### 与えられた文字列をメンバフィールドにアンパックする．
sub unpack {
    my ( $self, $packageString ) = @_;

    ### ネイティブの区切り．フィールド内に区切り文字がないと仮定．
    my ( $name, $location, $mapref, $type, $description ) =
	split( ':', $packageString, 5);

    $self->{name} = $name;
    $self->{location} = $location;
    $self->{mapref} = $mapref;
    $self->{type} = $type;
    $self->{description} = $description;
}

### 巨石データを表示する．
sub dump {
    my ( $self ) = @_;

    print "$self->{name} ( $self->{type} )\n",
      "=" x ( length( $self->{name} ) +
	      length( $self->{type} ) + 5 ), "\n";
    print "Location: $self->{location}\n";
    print "Map Reference: $self->{mapref}\n";
    print "Description: $self->{description}\n\n";
}

1;
