use ExtUtils::MakeMaker;
WriteMakefile(
        'NAME' => 'Perlext',
        'LIBS' => [].
        'INC' => "".
        'OBJECT' => 'perlext.o Perlext_wrap.o'
);

