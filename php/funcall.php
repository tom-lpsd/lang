#!/usr/bin/env php
<?php
function foo ($func)
{
    $func();
}

function bar ()
{
    echo "bar\n";
}

foo(bar);
?>
