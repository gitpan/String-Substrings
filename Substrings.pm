package String::Substrings;

use 5.006;
use strict;
use warnings;

use Carp;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	substrings
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	substrings
);

our $VERSION = '0.01';

sub substrings($) {
    my ($string) = @_;
    return undef unless defined $string;
    if (my $r = ref($string)) { 
        croak "Please call me  `substrings STRING`, but not with $r";
    }
    my $strlength = length($string);
    my @s = ();
    foreach my $length (1 .. $strlength) {
        push @s, map {substr $string, $_, $length} (0 .. $strlength - $length);
    }
    return @s;
}

1;
__END__

=head1 NAME

String::Substrings - module to extract some/all substrings from a string

=head1 SYNOPSIS

  use String::Substrings;
 
  my @parts = substrings $string;
  
=head1 DESCRIPTION

This module has only one method C<substrings>.
It is called as

  substrings STRING
  
It returns all substrings with a length of 1 or greater 
including the string itselfs. The substrings returned are
sorted for the length (starting with length 1) and for their index.
E.g. C<substrings "abc"> returns C<("a","b","c","ab","bc","abc")>.
This order is guaranteed to stay even in future versions.
That also includes that the returned list of substrings needn't be unique.
E.g. C<substrings "aaa"> returns C<("a","a","a","aa","aa","aaa")>.

C<substrings ""> returns an empty list,
C<substrings undef> returns undef and
every call with a hash/array-reference let substrings die.

In scalar context it returns the number of substrings found,
allthough I can't imagine that it is useful. (It's simple to calculate
without determining all the substrings: 
C<length($string) * (length($string)+1) / 2>.
Especially the scalar context behavior could be changed in future versions.

Please take care to the length of the strings passed.
The number of substrings grows with the square of the string's length.
I only tested it till a string length of 100.

=head2 EXPORT

C<substrings>

=head1 SEE ALSO

L<Algorithm::ChooseSubsets>

=head1 AUTHOR

Janek Schleicher, E<lt>bigj@kamelfreund.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2002 by Janek Schleicher

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
