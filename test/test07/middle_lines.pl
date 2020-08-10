#!/usr/bin/perl -w

die "Usage: $0 <number>\n" if @ARGV != 1;

my $filename = shift @ARGV;


open my $in, '<', "$filename" or die "Cannot open $filename: $!\n";
my @lines = <$in>;

my $lines_length = @lines;

if (!$lines_length)
{
    exit 0;
}
else
{
    if ($lines_length % 2 == 0)  # even lines
    {
        print "$lines[$lines_length / 2 - 1]";
        print "$lines[$lines_length / 2]";
    }
    else  # odd lines
    {
        print "$lines[$lines_length / 2]";
    }
}

close $in;
exit 0;