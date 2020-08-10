#!/usr/bin/perl -w

die "Usage: $0 < <file_as_STDIN>\n" if @ARGV != 0;

$word_count = 0;
while ($line = <STDIN>)
{
    @words = $line =~ /[a-zA-Z]+/g;
    $word_count += ($#words + 1);
}
print "$word_count words\n";