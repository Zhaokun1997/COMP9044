#!/usr/bin/perl -w
use strict;

die "Usage: $0 <species> <filename>" if @ARGV != 2;

my $species = shift @ARGV;
my $filename = shift @ARGV;

my $pre_line = "";
my $curr_line = "";
my $num = 0;

open my $in, '<', "$filename" or die "Cannot open $filename: $!\n";

while (my $line = <$in>)
{
    if ($line =~ /\"how_many\": (\d+),/)
    {
        $pre_line = $1;
    }
    elsif ($line =~ /\"species\": \"(.*)\"/)
    {
        $curr_line = $1;
        if ($curr_line eq $species)
        {
            $num += $pre_line;
        }
    }
    # print "$hash{$curr_line}\n";
}
close $in;
print "$num\n";
