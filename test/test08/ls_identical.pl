#!/usr/bin/perl -w

use strict;
use File::Compare;
use experimental 'smartmatch';

die "Usage: $0 <number_list>\n" if @ARGV != 2;

my $dirname1 = shift @ARGV;
my $dirname2 = shift @ARGV;

my @all_files = glob("$dirname1/*");
foreach my $filename (@all_files)
{
    # filename = "dirname1/example.c"
    $filename =~ s/.*\///;
    if (-e "$dirname2/$filename")  # $dirname2/$filename exists
    {
        if (compare("$dirname1/$filename", "$dirname2/$filename") == 0)
        {
            print "$filename\n";
        }
    }
}
