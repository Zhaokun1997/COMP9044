#!/usr/bin/perl -w


foreach my $arg (@ARGV)
{
    print "$arg " if ($arg =~ /[aeiouAEIOU]{3}/g);
}
print "\n";
exit 0;