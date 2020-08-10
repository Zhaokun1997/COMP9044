#!/usr/bin/perl -w

die "Usage: $0 <word> < <file_as_STDIN>\n" if @ARGV != 1;

$query_word = shift @ARGV;
while ($line = <STDIN>)
{
    @words = $line =~ /[a-zA-Z]+/g;
    foreach $word (@words)
    {
        $word =~ tr/[A-Z]/[a-z]/;
        $words_hash{"$word"}++;
    }
}
if (!$words_hash{$query_word})
{
    print "$query_word occurred 0 times\n";
}
else
{
    print "$query_word occurred $words_hash{$query_word} times\n";
}
