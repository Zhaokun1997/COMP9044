#!/usr/bin/perl -w


die "Usage: $0 <number>\n" if @ARGV != 1;


%hash_line = ();
$count = shift @ARGV;
while ($line = <STDIN>)
{
    if ($hash_line{$line} && $hash_line{$line} eq $count-1)
    {
        print "Snap: $line";
        exit 0;
    }
    $hash_line{$line}++;
    
}


