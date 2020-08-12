#!/usr/bin/perl -w


@lines = <>;


foreach $line (@lines)
{
    if ($line =~ /^#(\d+)\n$/)
    {
        $line_number = $1;
        if ($line_number - 1 < @lines)
        {
            $line = $lines[$line_number - 1];
        }
    }
}

print @lines;