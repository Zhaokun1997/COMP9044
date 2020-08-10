#!/usr/bin/perl -w

die "Usage: $0 <start> <end>\n" if @ARGV != 3;


$start = shift @ARGV;
$end = shift @ARGV;
$filename = shift @ARGV;

open my $out, '>>', $filename or die "Cannot open $filename: $!";
for ($number = $start; $number <= $end; $number++)
{
    print $out "$number\n";
}

close $out;
exit 0;
