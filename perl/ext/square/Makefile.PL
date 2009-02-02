use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME' => 'MyExt',
    'OBJECT' => 'square.o square_wrap.o'
);

