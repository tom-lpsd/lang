// ==UserScript==
// @name          MyFirstGreasemonkey
// @namespace     http://tom-lpsd.dyndns.org/greasemonkey/
// @description   example script to insert message to end of body on every page in tom-lpsd
// @include       http://tom-lpsd.dyndns.org/*
// @exclude       http://tom-lpsd.dyndns.org/tom/*
// ==/UserScript==

var elem = document.createElement('div');
elem.innerHTML = 'This is Test.';
var body = document.getElementsByTagName('body')[0];
body.appendChild(elem);
