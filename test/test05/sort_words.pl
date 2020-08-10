#!/usr/bin/perl -w

die "Usage: $0 <nothing>\n" if @ARGV != 0;


while (<STDIN>)
{
    @all_words = split /\s+/;
    @sort_words = sort @all_words;
    $result = join(" ", @sort_words);
    print "$result\n";
}


exit 0;
