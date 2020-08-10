#!/usr/bin/perl -w


die "Usage: $0 <number>\n" if @ARGV != 1;

# @a = (1,2,3);
# $b = "aaaa";
# $l = length($b);
# print "$l\n";

my %hash_line = ();
my $filename = shift @ARGV;
open my $in, '<', "$filename" or die "Cannot open $filename: $!\n";

while (my $line = <$in>)
{
    chomp $line;
    $hash_line{$line} = length($line);
}

foreach my $line (sort {$hash_line{$a} <=> $hash_line{$b}} sort {$a cmp $b} keys %hash_line)
{
    print "$line\n";
}
close $in;
