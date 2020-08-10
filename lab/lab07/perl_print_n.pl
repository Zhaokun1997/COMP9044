#!/usr/bin/perl -w

die "Uasge: $0 <integer> <string>" if @ARGV != 2;

# ./perl_print_n.pl 1 'Perl that prints Perl'
# print "Perl that prints Perl\n"

# $cmd_string = "print \'$string\n\';";
# print $cmd_string;
# exit 0;


# perl_print_n.pl 6 "backslashes \ " |perl|perl|perl|perl|perl|perl
# backslashes \\ 


$times = shift @ARGV;
$string = shift @ARGV;

# $n = 0;
if ($times == 1)
{
    print "print \"";
    print $string;
    print "\\n\";";
    print "\n";
}
else
{
    if ($string =~ /\\+/)
    {
        $string =~ s/\\/\\\\/g;
    }
    if ($string =~ /\"+/)
    {
        $string =~ s/\"/\\\"/g;
    }
    $n = 0;
    $head_string = "print \"";
    $back_string = "\\n\";";
    while ($n < $times - 1)
    {
        $head_string =~ s/\\/\\\\/g;
        $head_string =~ s/\"/\\\"/g;
        $head_string = "print \"$head_string";
        $back_string =~ s/\\/\\\\/g;
        $back_string =~ s/\"/\\\"/g;
        $back_string = "$back_string\\n\";";

        if ($string =~ /\\+/)
        {
            $string =~ s/\\/\\\\/g;
        }
        if ($string =~ /\"+/)
        {
            $string =~ s/\"/\\\"/g;
        }
        $n++;
    }
    print "$head_string";
    print "$string";
    print "$back_string";
}
print "\n";
