#!/usr/bin/perl -w


die "Usage: $0 <files>\n" if @ARGV < 2;

# extract first file as comparasion 
$file1 = shift @ARGV;
open my $in, '<', "$file1" or die "Cannot open $file1: $!\n";
@file1_lines = <$in>;
$file1_content = join("", @file1_lines);
close $in;


foreach $file (@ARGV)
{
    open my $in, '<', "$file" or die "Cannot open $file: $!\n";
    @lines = <$in>;
    $content = join("", @lines);
    if ($file1_content ne $content)
    {
        print "$file is not identical\n";
        close $in;
        exit 0;
    }
    close $in;
}

print "All files are identical\n";
exit 0;