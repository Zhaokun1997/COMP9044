#!/usr/bin/perl -w
use strict;

die "Usage: $0 <n>" if @ARGV != 1;

my $line_count = 0;
my $arg1 = shift @ARGV;
my %hash = ();
my $dis_count = 0;
while (my $line = <STDIN>)
{
    $line =~ tr/[A-Z]/[a-z]/;
    $line =~ s/\s+//g;
    if (!$hash{$line})
    {
        $hash{$line}++;
        $dis_count++
    }
    $line_count++;
    if ($dis_count == $arg1)
    {
        print "$dis_count distinct lines seen after $line_count lines read.\n";
        last;
    }
    
}

if ($arg1 > $dis_count)
{
    print "End of input reached after $line_count lines read - $arg1 different lines not seen.\n"
}
