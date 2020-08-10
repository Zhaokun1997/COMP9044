#!/usr/bin/perl -w


die "Usage: $0 <number of lines> <string>\n" if @ARGV != 2;

$n = $ARGV[0];
$string = $ARGV[1];


die "$0: argument 1 must be a non-negative integer\n" if $n !~ /^\d+$/;
for ($i = 0; $i < $n; $i++)
{
	print "$string\n";
}

exit 0;
