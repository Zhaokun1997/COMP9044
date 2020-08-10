#!/usr/bin/perl -w

die "Usage: $0 <perl_tring>" if @ARGV != 1;

# perl -e ’print "Hello, world\n";’
$string = $ARGV[0];

if ($string =~ /\'+/)
{
	$cmd_string = "print \"$string\n\";";
	print $cmd_string;
	exit 0;
}

$cmd_string = "print \'$string\n\';";
print $cmd_string;
exit 0;
