#!/usr/bin/perl -w

# <td class="data"><a href="COMP9596.html">COMP9596</a></td>
# <td class="data"><a href="COMP9596.html">Research Project</a></td>

use LWP::Simple;

die "Usage: $0 <prefix>" if @ARGV != 1;

$prefix = shift @ARGV;
$url = "http://www.timetable.unsw.edu.au/current/" . $prefix . "KENS.html";
open my $in, '-|', "wget -q -O- $url" or die "$!\n";

%hash_course = ();
while ($line = <$in>)
{
    ($code, $name) = $line =~ /<a href=\"($prefix\d{4})\.html\">([^<]+)<\/a>/;
    if ($code && $name && $code ne $name)
    {
        $hash_course{$code} = $name;
    }
}
close $in;


foreach $key (sort keys %hash_course)
{
    print "$key $hash_course{$key}\n";
}