#!/usr/bin/env php
<?php
$foo = array('foo', 'bar', 'baz');
$foo = array_flip($foo);
foreach ($foo as $index => $value) {
    echo "$index $value\n";
}
?>
