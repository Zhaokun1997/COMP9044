#!/usr/bin/perl -w


die "Usage: $0 <file_name>\n" if @ARGV != 1;

$filename = $ARGV[0];

# read my input file
open my $in, '<', "$filename" or die "Cannot open $filename: $!\n";
@lines = <$in>;
close $in;

foreach $line (@lines)
{
    $line =~ s/\d/\#/g;
}

# rewrite previous file
open my $out, '>', "$filename" or die "Cannot open $filename: $!\n";
print $out @lines;
close $out;

exit 0;