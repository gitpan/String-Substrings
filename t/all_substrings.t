#!/usr/bin/perl

use strict;
use warnings;

use String::Substrings;
use String::Random qw/random_string/;
use Test::Differences;

use constant STANDARD_STRINGS => (
    [""    => []                                 ],
    ["a"   => ["a"]                              ], 
    ["ab"  => ["a", "b", "ab"]                   ],
    ["aa"  => ["a", "a", "aa"]                   ],
    ["aba" => ["a", "b", "a", "ab", "ba", "aba"] ]
);

use Test::More tests => STANDARD_STRINGS() + 2;

foreach (STANDARD_STRINGS) {
    my $string         =   $_->[0];
    my @substrings_exp = @{$_->[1]};
    eq_or_diff [substrings $string], \@substrings_exp,
               "Expected substrings of '$string'";
}

is substrings(undef), undef, "undef string returns undef result";

my $long_string = random_string("." x 100);
my @substrings_exp = ();
foreach my $length (1 .. 100) {
    foreach my $index (0 .. 100-$length) {
        push @substrings_exp, substr $long_string, $index, $length;
    }
}
eq_or_diff [substrings $long_string], \@substrings_exp,
           "Expected substrings of '$long_string'";

1;
