#!/usr/bin/perl -w


%hash = ();
foreach $arg (@ARGV)
{
    next if $hash{$arg};
    print "$arg ";
    $hash{$arg}++;
}

print "\n";
exit 0;