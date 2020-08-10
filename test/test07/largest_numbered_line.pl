#!/usr/bin/perl -w


use List::Util qw(max min);

$largest_number = -99999;
@output = ();
@lines = <STDIN>;

foreach $line (@lines)
{
    while ($line =~ /(-?\d+(\.\d+)?)/g)
    {
        $number = $1;
        if ($number && $number > $largest_number)
        {
            $largest_number = $1;
            @output = ($line);
        }
        elsif ($1 == $largest_number)
        {
            push @output, $line;
        }
    }
}

print @output;
exit 0;

