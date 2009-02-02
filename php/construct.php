#!/usr/bin/env php
<?php

class A 
{
    function __construct () {
	echo "A\n";
    }
}

class B extends A
{
    function __construct () {
	parent::__construct();
	echo "B\n";
    }
}

$b = new B;

?>