#!/usr/bin/perl -w


die "Usage: $0 < <input_file>\n" if @ARGV != 0;

@lines = ();
$line_number = 0;

# record all input lines
while ($line = <STDIN>)
{
    last if !$line;
    $lines[$line_number++] = $line;
}

# then print them randomly
$count = 0;
$rm_value = "";
while (1)
{
    $rm_value = $lines[rand($line_number + 1)];
    # print $rm_value;
    while (1)
    {
        $pop_value = pop @lines;
        if (!$rm_value || $pop_value eq $rm_value)
        {
            print $pop_value;
            $count ++;
            last;
        }
        unshift @lines, $pop_value;
    }
    last if !@lines;
}





# =================test program=================
# @list = ();
# $list[0] = 1;
# $list[1] = 2;
# print @list;

# $pop_val = pop @list;
# unshift @list, $pop_val;
# print @list;
# if($list[0] == $list[1]){
#     print "Not empty!\n";
#     print "@list\n";
# }
# else
# {
#     print "Empty!\n";
# }