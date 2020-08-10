#!/usr/bin/perl -w

use strict;
use experimental 'smartmatch';
# # Makefile generated at Mon 27 Jul 17:26:43 AEST 2020

# CC = gcc
# CFLAGS = -Wall -O3

# easymain:   easymain.o graphics.o world.o
#     $(CC) $(LDFLAGS) -o $@ easymain.o graphics.o world.o

# easymain.c  graphics.c  graphics.h  world.c  world.h

my $date = `date`;
print "# Makefile generated at $date\n";

print "CC = gcc\n";
print "CFLAGS = -Wall -O3\n\n";

my @c_files = glob("*.c");
my $main_filename = "main";
my $o_filenames = "";
foreach my $c_filename (sort @c_files)
{
    if ($c_filename =~ /main/)  # find target file
    {
        my $tmp_c_file = $c_filename;
        $tmp_c_file =~ s/\.c//;
        $main_filename = $tmp_c_file;
    }
    my $o_filename = $c_filename;
    $o_filename =~ s/\.c/\.o/;
    $o_filenames .= "$o_filename ";
    # print "$o_filename : $dependence{$c_filename}", "$c_filename\n";
}

print "$main_filename: ", "$o_filenames\n";
print "\t\$(CC) \$(LDFLAGS) -o \$\@ $o_filenames\n\n";

# graphics.o: graphics.h world.h graphics.c
# easymain.o: world.h graphics.h easymain.c
# world.o:    world.h world.c

my %dependence = ();

sub explore_file
{
    my ($filename, $c_filename) = @_;
    # print "$filename, $c_filename\n";
    if (-e $filename)
    {
        # print "$h_file exits\n";
        open my $h_in, '<', "$filename" or die "Cannot open $filename: $!\n";
        while (my $h_line = <$h_in>)
        {
            # print "$h_line\n";
            if ($h_line =~ /#include \"(.*)\"/)
            {
                # print "$1\n";
                next if ($1 =~ /std/ || $1 =~ /ctype/);
                my $h_file2 = $1;
                my @curr_files = split " ", $dependence{$c_filename};
                next if $h_file2 ~~ @curr_files;  # h_file already exist in our list
                $dependence{$c_filename} .= "$h_file2 ";
                explore_file($h_file2, $c_filename);
            }
        }
        close $h_in;
    } 
}


foreach my $c_file (@c_files)
{
    open my $in, '<', "$c_file" or die "Cannot open $c_file: $!\n";
    while (my $line = <$in>)
    {
        if ($line =~ /#include \"(.*)\"/)
        {
            next if ($1 =~ /std/ || $1 =~ /ctype/);
            my $h_file = $1;
            $dependence{$c_file} .= "$h_file ";
            explore_file($h_file, $c_file);
        }
    }
    close $in;
}


foreach my $key (sort keys %dependence)
{
    my $o_filename = $key;
    $o_filename =~ s/\.c/\.o/;
    print "$o_filename : $dependence{$key}", "$key\n" if $dependence{$key};
}




















