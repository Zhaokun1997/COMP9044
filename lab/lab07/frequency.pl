#!/usr/bin/perl -w

die "Usage: $0 <word>\n" if @ARGV != 1;

$query_word = shift @ARGV;

# build my artist hash
foreach $file (glob "lyrics/*.txt") 
{
    # get artist name
    $artist_name = $file;
    $artist_name =~ s/^lyrics\///;
    $artist_name =~ s/\.txt//;
    $artist_name =~ tr/_/ /;

    # read lyrics from every artist
    open my $in, '<', "$file" or die "Cannot open $file: $!\n";
    
    while ($line = <$in>)
    {
        @words = $line =~ /[a-zA-Z]+/g;
        foreach $word (@words)
        {
            $word =~ tr/[A-Z]/[a-z]/;
            $artist_hash{"$artist_name"}{"$word"}++;
        }
    }
    close $in;
}


foreach my $artist_name (sort keys %artist_hash)
{
    $sum_count_words = 0;
    foreach my $word (keys %{$artist_hash{$artist_name}})
    {
        $sum_count_words += $artist_hash{$artist_name}{$word};
    }
    if ($artist_hash{$artist_name}{$query_word})
    {
        $word_rate = $artist_hash{$artist_name}{$query_word} / $sum_count_words;
        printf "%4d/%6d = %.9f %s\n", $artist_hash{$artist_name}{$query_word}, $sum_count_words, $word_rate, $artist_name;
    }
    else
    {
        $word_rate = 0 / $sum_count_words;
        printf "%4d/%6d = %.9f %s\n", 0, $sum_count_words, $word_rate, $artist_name;
    }
}




# if (!$words_hash{$query_word})
# {
#     print "$query_word occurred 0 times\n";
# }
# else
# {
#     print "$query_word occurred $words_hash{$query_word} times\n";
# }
