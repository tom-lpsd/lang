use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME' => 'Hello',
    'OBJECT' => 'hello.o hello_wrap.o'
);
