#!/usr/bin/perl -w

die "Usage: $0 <save|load> (target_version)" if ($ARGV[0] ne "save") && ($ARGV[0] ne "load");

$back_version = 0;

# find current back_version
while (-r ".snapshot.$back_version" && -d ".snapshot.$back_version")
{
    $back_version ++;
}


$option = shift @ARGV;
if ($option eq "save")
{
    # iterate all files in current directory and copy them to repository
    # make directory
    $dir = ".snapshot.$back_version";
    mkdir($dir) or die "Cannot create $dir : $!";
    my @files = glob("./*");
    foreach $file (@files)
    {
        # ignore filenames started with '.' and two special files
        if ($file !~ /^\.\/\./ && $file !~ /snapshot\.pl/)  # . indicates any character so it needs to be escape
        {
            open my $in, '<', "$file" or die "Cannot open $file: $!";
            open my $out, '>', "$dir/$file" or die "Cannot open $dir/$file: $!";
            @file_lines = <$in>;
            print $out @file_lines;
            close $in;
            close $out;
        }
    }
    print "Creating snapshot $back_version\n";
    exit 0;
}
else  # in case of option eqs load
{
    $target_version = shift @ARGV;
    if ($target_version =~ /\d+/)
    {
        # first back up our files
        system ("snapshot.pl save");
        # step 1: remove our current directory files
        my @files = glob("./*");
        foreach $file (@files)
        {
            if ($file !~ /^\.\/\./ && $file !~ /snapshot\.pl/)
            {
                unlink $file;  # remove file
            }
        }

        # step 2: restore our target version files
        $target_dir = ".snapshot.$target_version";
        my @repo_files = glob("./$target_dir/*");
        foreach $file (@repo_files)  # $file = ./.snapshot.n/file
        {
            $curr_dir_file = $file;
            $curr_dir_file =~ s/\.\/$target_dir\///;
            open my $in, '<', "$file" or die "Cannot open $file: $!";
            open my $out, '>', "$curr_dir_file" or die "Cannot open $curr_dir_file: $!";
            @lines = <$in>;
            print $out @lines;
            close $out;
            close $in;
            # system ("cp $file ./");
        }
        print "Restoring snapshot $target_version\n";
        exit 0;
    }
}
