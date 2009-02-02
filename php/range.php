#!/usr/bin/env php
<?php
$r = range(0, 10);

function foo ($ary)
{
    $ary[0] = 100;
    return $ary;
}

foo($r);

print_r($r);
?>
