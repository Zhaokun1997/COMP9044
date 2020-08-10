#!/usr/bin/perl -w

die "Usage: $0 <filename>" if @ARGV != 1;

$filename = shift @ARGV;
$back_version = 0;

open my $in, '<', "$filename" or die "Cannot open $filename: $!";
@lines = <$in>;
close $in;

while (-e ".$filename.$back_version")
{
    $back_version ++;
}

$back_file = ".$filename.$back_version";
open my $out, '>', $back_file or die "Cannot open $back_file: $!";
print $out @lines;
print "Backup of '$filename' saved as '.$filename.$back_version'\n";
close $out;
