#!/usr/bin/perl -w


die "Usage: $0 <prefixs>" if @ARGV == 0;

# <td class="data">Thu 09:00 - 10:00 (Weeks:1-10), Thu 10:00 - 12:00 (Weeks:1-10)</td>
# <td class="data">Tue 13:00 - 14:00 (Weeks:11), Tue 14:00 - 16:00 (Weeks:11), Fri 13:00 - 14:00 (Weeks:1-7,9-10), Fri 14:00 - 16:00 (Weeks:1-7,9-10)</td>


foreach $course (@ARGV)
{
    $url = "http://timetable.unsw.edu.au/2020/$course.html";
    open my $in, '-|', "wget -q -O- $url" or die "$!\n";
    @lines = <$in>;
    foreach $i (0..$#lines)
    {
        print "$lines[$i]" if ($lines[$i] =~ /Lecture/);
        
    }
    # $sep = 16;
    # $i = 0;
    # @target_lines = ();
    # while ($line = <$in>)
    # {
    #     if ($line =~ /Lecture/)
    #     {
    #         push @target_lines, $line;
    #         while ($line = <$in> && $i <= $sep)
    #         {
    #             push @target_lines, $line;
    #             $i++;
    #         }
    #     }
    # }
    close $in;
    
}



