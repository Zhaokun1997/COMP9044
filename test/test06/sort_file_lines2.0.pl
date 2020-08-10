#!/usr/bin/perl -w


die "Usage: $0 <number>\n" if @ARGV != 1;

#!/usr/bin/perl


open $in, "<", $ARGV[0];
@list = `cat $ARGV[0] | sort -n`; #sorted by alp
$count = 0;
foreach $line (@list) {
    $lineLength[$count] = length($line);
    $count += 1;
}
@sortLength = sort{$a <=> $b}(@lineLength);
# Go from shortest to longest
foreach $lineLength (@sortLength) {    
    $count2 = 0;    
    foreach $line (@list) {
        if (length($line) == $lineLength){
            splice @list, $count2, 1;
            print $line;
            last;
        }
        $count2 += 1;
    }
}
close $in;
