#!/usr/bin/perl -w

use strict;
# use experimental 'smartmatch';

die "Usage: $0 <number_list>\n" if @ARGV == 0;

if (@ARGV)
{
    my @numbers = sort {$a <=> $b} @ARGV;
    print "$numbers[($#numbers + 1) / 2]\n";
}
