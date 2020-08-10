#!/usr/bin/perl -w


# by default print 10 lines
$nb_lines = 10;

# no arguments: read from STDIN
if (0 == @ARGV)
{
    @lines = ();
    $line_number = 0;
    while ($line = <STDIN>)
    {
        last if !$line;
        $lines[$line_number++] = $line;
    }
    for ($line_number = $#lines - $nb_lines + 1; $line_number <= $#lines; $line_number++)
    {
        print $lines[$line_number];
    }
    exit 0;
}

foreach $arg (@ARGV) 
{
    if ($arg =~ /^-\d+$/)
    {
        $arg =~ s/^-//g;
        $nb_lines = $arg;
        # print "we need to print $nb_lines lines\n";
    }
    else 
    {
        push @files, $arg;
    }
}

# if there is one file
if (1 == @files)
{
    open my $in, '<', $files[0] or die "$0: Can't open $files[0]: $!\n";
    @lines = ();
    $line_number = 0;
    while ($line = <$in>)
    {
        $lines[$line_number++] = $line;
    }
    if ($nb_lines <= $#lines)
    {
        for ($line_number = $#lines - $nb_lines + 1; $line_number <= $#lines; $line_number++)
        {
            print $lines[$line_number];
        }
    }
    else
    {
        foreach $line (@lines)
        {
            print $line;
        }
    }
    close $in;
}
else
{
    foreach $file (@files) 
    {
        print "==> $file <==\n";

        open my $in, '<', $file or die "$0: Can't open $file: $!\n";
        @lines = ();
        $line_number = 0;
        while ($line = <$in>)
        {
            $lines[$line_number++] = $line;
        }
        if ($nb_lines <= $#lines)
        {
            for ($line_number = $#lines + 1 - $nb_lines; $line_number <= $#lines; $line_number++)
            {
                print $lines[$line_number];
            }
        }
        else
        {
            foreach $line (@lines)
            {
                print $line;
            }
        }
        close $in;
    }
}

