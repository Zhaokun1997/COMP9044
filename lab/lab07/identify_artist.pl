#!/usr/bin/perl -w

die "Usage: $0 <list_files>\n" if @ARGV < 1;


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

foreach $file (@ARGV)
{
    # reset hash artist_sum_log
    %artist_sum_log = ();

    # read lyrics from every artist
    open my $in, '<', "$file" or die "Cannot open $file: $!\n";
    while ($line = <$in>)
    {
        @words = $line =~ /[a-zA-Z]+/g;
        foreach $query_word (@words)
        {
            $query_word =~ tr/[A-Z]/[a-z]/;
            # sum each word's probability for each artist
            foreach $artist_name (sort keys %artist_hash)
            {
                $sum_count_words = 0;
                foreach my $word (keys %{$artist_hash{$artist_name}})
                {
                    $sum_count_words += $artist_hash{$artist_name}{$word};
                }
                if ($artist_hash{$artist_name}{$query_word})
                {
                    $word_rate = ($artist_hash{$artist_name}{$query_word} + 1) / $sum_count_words;
                    $log_prob = log($word_rate);
                    $artist_sum_log{$artist_name} += $log_prob;

                }
                else
                {
                    $word_rate = 1 / $sum_count_words;
                    $log_prob = log($word_rate);
                    $artist_sum_log{$artist_name} += $log_prob;
                }
            }
        }
    }
    # find max value

    @log_values = (values %artist_sum_log);
    @log_values = sort @log_values;
    $max_log_prob = shift @log_values;
    for $key (keys %artist_sum_log)
    {
        if ($artist_sum_log{$key} == $max_log_prob)
        {
            printf "%s most resembles the work of %s (log-probability=%.1f)\n", $file, $key, $max_log_prob;
        }
    }
    close $in;
}
