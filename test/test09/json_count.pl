#!/usr/bin/perl -w

use strict;

# ./json_count.pl Orca whales.json

# {
#     "date": "09/09/18",
#     "how_many": 11,
#     "species": "Orca"
# },

die "Usage: $0 <species> <filename>\n" if @ARGV != 2;

my $species = shift @ARGV;
my $filename = shift @ARGV;

my %hash = ();
my $how_many;
my $curr_species;
open my $in, '<', "$filename" or die "Cannot open $filename: $!\n";
while (my $line = <$in>)
{
    if ($line =~ /\"how_many\": (.*),/)
    {
        $how_many = $1;
    }
    elsif($line =~ /\"species\": \"(.*)\"/)
    {
        $curr_species = $1;
        if (!$hash{$curr_species})
        {
            $hash{$curr_species} = $how_many;
        }
        else
        {
            $hash{$curr_species} += $how_many;
        }
    }
}
close $in;

print "$hash{$species}\n";
