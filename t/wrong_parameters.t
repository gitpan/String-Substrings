#!/usr/bin/perl

use String::Substrings;
use Test::Exception;

use Test::More tests => 2;

dies_ok {substrings ["aa"]}         "Array reference as argument";
dies_ok {substrings {"aa" => "bb"}} "Hash reference as argument";
