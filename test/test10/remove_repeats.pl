#!/usr/bin/perl -w

# use experimental 'smartmatch';

# @result = ();

# while (@ARGV)
# {
#     $word = shift @ARGV;
#     next if ($word ~~ @result);
#     push @result, $word;
# }
# $final_string = join (" ", @result);
# print $final_string, "\n";




use strict;

my %hash = ();
foreach my $arg (@ARGV)
{
    next if ($hash{$arg});
    $hash{$arg}++;
    print "$arg ";
}
print "\n";