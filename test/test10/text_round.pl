#!/usr/bin/perl -w


while ($line = <>)
{
    while ($line =~ /(\d+\.\d+)/)
    {
        $number = $1;
        $new_number = int($number + 0.5);
        $line =~ s/$number/$new_number/;
    }
    print "$line";
}