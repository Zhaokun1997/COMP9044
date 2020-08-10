#!/usr/bin/perl -w

die "Usage: $0 <line_index> <file>" if @ARGV != 2;

$line_index = shift @ARGV;
$file = shift @ARGV;

open my $in, '<', $file or die "Cannot open $file: $!";
@lines = <$in>;
$actual_index = $line_index - 1;
if ($actual_index <= $#lines)
{
    print "$lines[$actual_index]";
}
else
{
    # print nothing
    print "";
}
close $in;
exit 0;