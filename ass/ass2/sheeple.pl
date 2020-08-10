#!/usr/bin/perl -w

use strict;
# use experimental 'smartmatch';
use List::Util qw(max min);

my %hash_operator = ("-lt" => "<", 
                  "-le" => "<=", 
                  "-eq" => "==", 
                  "-gt" => ">", 
                  "-ge" => ">=" );

sub match_head 
{
    my ($line) = @_;
    if ($line =~ /^#!.*/)  # match head
    {
        print "#!/usr/bin/perl -w\n";
    }
}

sub match_comment
{
    my ($line) = @_;
    if ($line =~ /^# (.*)/)
    {
        my $comment = $1;
        print "# $comment\n";
    }
}

sub match_empty_line
{
    my ($line) = @_;
    if ($line =~ /^$/)
    {
        print "\n";
    }
}


sub match_special_arguments
{
    my ($line) = @_;
    $line =~ s/\$1/\$ARGV\[0\]/;
    $line =~ s/\$2/\$ARGV\[1\]/;
    $line =~ s/\$3/\$ARGV\[2\]/;
    $line =~ s/\$4/\$ARGV\[3\]/;
    $line =~ s/\$5/\$ARGV\[4\]/;
    return $line;
}


sub match_echo 
{
    my ($line) = @_;
    if ($line =~ /^echo (.*)/)  # match head
    {
        my $echo_content = $1;
        $echo_content = match_special_arguments($echo_content);
        $echo_content =~ s/^'(.*)'$/$1/;  # remove '' if 
        $echo_content =~ s/^"(.*)"$/$1/;  # remove "" if
        $echo_content =~ s/\"/\\\"/g;  # "truth beauty" -> \"truth beauty\"
        print "print \"$echo_content\\n\";\n";
    }
    elsif ($line =~ /^(\s+)echo (.*)/)
    {
        my $indent = $1;
        my $echo_content = $2;
        $echo_content = match_special_arguments($echo_content);
        $echo_content =~ s/^'(.*)'/$2/;  # if content surounded by "" or ''
        $echo_content =~ s/^"(.*)"/$2/;
        print "$indent", "print \"$echo_content\\n\";\n";
    }
}

sub match_ls_pwd_id_date
{
    my ($line) = @_;
    if ($line =~ /^((ls|pwd|id|date).*)/)  # match (ls|pwd|id|date)
    {
        my $ls_content = $1;
        print "system \"$1\";\n";
    }
}


sub match_var_assign
{
    my ($line) = @_;
    if ($line =~ /^(\s+)(\w+)=(.*)/)  # match variable assignment
    {
        my $indent = $1;
        my $var_name = $2;
        my $var_value = $3;
        if ($var_value eq "\$1")  # when n=$1 ==> $n = $_[0]
        {
            print "$indent", "\$$var_name = \$_[0];\n";
            return
        }
        elsif ($var_value eq "\$2")
        {
            print "$indent", "\$$var_name = \$_[1];\n";
            return
        }
        elsif ($var_value eq "\$3")
        {
            print "$indent", "\$$var_name = \$_[2];\n";
            return
        }
        elsif ($var_value eq "\$4")
        {
            print "$indent", "\$$var_name = \$_[3];\n";
            return
        }
        elsif ($var_value eq "\$5")
        {
            print "$indent", "\$$var_name = \$_[4];\n";
            return
        }
        my $temp_value = $var_value;
        if ($temp_value =~ '^[0-9]')  # when i=2 ==> $i = 2;
        {
            print "$indent", "\$$var_name = $var_value;\n";
        }
    }
    elsif ($line =~ /^(\w+)=(.*)/)  # match variable assignment
    {
        my $var_name = $1;
        my $var_value = $2;
        if ($var_value eq "\$1")  # when start=$1 ==> $start = $ARGV[0]
        {
            print "\$$var_name = \$ARGV[0];\n";
            return
        }
        elsif ($var_value eq "\$2")
        {
            print "\$$var_name = \$ARGV[1];\n";
            return
        }
        elsif ($var_value eq "\$3")
        {
            print "\$$var_name = \$ARGV[2];\n";
            return
        }
        elsif ($var_value eq "\$4")
        {
            print "\$$var_name = \$ARGV[3];\n";
            return
        }
        elsif ($var_value eq "\$5")
        {
            print "\$$var_name = \$ARGV[4];\n";
            return
        }
        my $temp_value = $var_value;
        if ($temp_value =~ '^\$')  # when number=$start ==> $number = $start
        {
            print "\$$var_name = $var_value;\n";
        }
        elsif ($temp_value =~ '^[0-9]')  # when i=2 ==> $i = 2;
        {
            print "\$$var_name = $var_value;\n";
        }
        else  # when a=hello ==> $a = 'hello'
        {
            print "\$$var_name = '$var_value';\n";
        }
    }
}

sub match_cd
{
    my ($line) = @_;
    if ($line =~ /^cd (.*)/)  # match cd
    {
        my $cd_content = $1;
        print "chdir '$cd_content';\n";
    }
}

sub match_exit
{
    my ($line) = @_;
    if ($line =~ /^exit (.*)/)  # match head
    {
        my $exit_code = $1;
        print "exit $exit_code;\n";
    }
    elsif ($line =~ /^(\s+)exit (.*)/)
    {
        my $indent = $1;
        my $exit_code = $2;
        print "$indent", "exit $exit_code;\n";
    }
}

sub match_read
{
    my ($line) = @_;
    if ($line =~ /^read (.*)/)  # match head
    {
        my $read_content = $1;
        print "\$$read_content = <STDIN>;\n";
        print "chomp \$$line;\n";
    }
    elsif ($line =~ /^(\s+)read (.*)/)
    {
        my $indent = $1;
        my $read_content = $2;
        print "$indent", "\$$read_content = <STDIN>;\n";
        print "$indent", "chomp \$$read_content;\n";
    }
}

sub match_expr
{
    my ($line) = @_;
    if ($line =~ /^(\s+)(\w+)=`expr (.*)`  # (.*)$/)
    {
        my $indent = $1;
        my $var = $2;
        my $expr = $3;
        my $comment = $4;
        # $number = $number + 1;  # increment number
        print "$indent\$$var = $expr;  # $comment\n";
    }
}

sub match_expr2
{
    my ($line) = @_;
    if ($line =~ /^(\s+)(\w+)=\$\(\((.*)\)\)  # (.*)$/)
    {
        my $indent = $1;
        my $var = $2;
        my $expr = $3;
        my $comment = $4;
        # $number = $number + 1;  # increment number
        print "$indent\$$var = \$$expr;  # $comment\n";
    }
    elsif ($line =~ /^(\s+)(\w+)=\$\(\((.*)\)\)$/)
    {
        my $indent = $1;
        my $var = $2;
        my $expr = $3;
        # $number = $number + 1;
        print "$indent\$$var = \$$expr;\n";
    }
}

sub match_local
{
    # s/local (\w+) (\w+)/my \(\$$1, \$$2\);/;
    my ($line) = @_;
    if ($line =~ /(\s+)local (\w+) (\w+)/)
    {
        print "$1", "my \(\$$2, \$$3\);\n";
    }
}


sub match_and
{
    my ($line) = @_;
    if ($line =~ /^(\s+)test (.*) && (.*)/)
    {
        my $indent = $1;
        my $expression = $2;
        my $right = $3;
        print "$indent";
        if (my ($a, $b, $c, $d, $e) = $expression =~ /\$\(\((.*) (.*) (.*)\)\) (.*) (.*)/)
        {
            print "\$$a $b \$$c $hash_operator{$d} $e and ";
            match_block($right);
        }
        
    }
    elsif ($line =~ /^(.*) && (.*)/)
    {
        print "$1 or ";
        match_block($2);
    }
}



sub match_return
{
    my ($line) = @_;
    if ($line =~ /^return (\d)/)
    {
        print "return $1;\n";
    }
    elsif ($line =~ /^(\s+)return (\d)/)
    {
        print "$1", "return $2;\n";
    }
}


sub match_block
{
    my ($line) = @_;
    match_comment($line);
    match_empty_line($line);
    match_echo($line);
    match_ls_pwd_id_date($line);
    match_var_assign($line);
    match_cd($line);
    match_exit($line);
    match_read($line);
    match_expr($line);
    match_expr2($line);
    match_local($line);
    match_and($line);
    match_return($line);
}


sub match_for_loop
{
    my ($line) = @_;
    if ($line =~ /^for (\w+) in ([\d\w\s]+)/)  # match for loop
    {
        # convert for head
        my $var_name = $1;
        my $var_list = $2;
        my @elements = split /\s/, $var_list;
        print "foreach \$$var_name (";
        my $text = "";
        foreach my $e (@elements)
        {
            $text .= "'$e', ";
        }
        $text =~ s/, $//;
        print "$text) {\n";

        # until now, we done with for head, then convert for loop inside
        $line = <>;  # skip "do" statement
        while ($line = <>)
        {
            last if $line =~ /done/;
            match_block($line);
        }
        print "}\n";
    }
    elsif ($line =~ /^for (\w+) in (\*.*)/)
    {
        # convert for head
        my $var_name = $1;
        my $var_list = $2;
        print "foreach \$$var_name (";
        my $text = "glob(\"$var_list\")";
        print "$text) {\n";

        while ($line = <>)
        {
            last if $line =~ /done/;
            match_block($line);
        }
        print "}\n";
    }
}



sub match_while
{
    my ($line) = @_;
    if ($line =~ /^while test (\S+) (-[a-z]+) (\S+)/)  # match for loop
    {
        # convert for head
        my $var_name1 = $1;
        my $operator = $2;
        my $var_name2 = $3;
        $operator = $hash_operator{$operator};
        print "while ($var_name1 $operator $var_name2) {\n";

        # until now, we done with for head, then convert for loop inside
        $line = <>;  # skip "do" statement
        while ($line = <>)
        {
            last if $line =~ /done/;
            match_block($line);
        }
        print "}\n";
    }
    elsif ($line =~ /^(\s+)while test (\S+) (-[a-z]+) (\S+)/)  # match for loop
    {
        # convert for head
        my $indent = $1;
        my $var_name1 = $2;
        my $operator = $3;
        my $var_name2 = $4;
        $operator = $hash_operator{$operator};
        print "$indent", "while ($var_name1 $operator $var_name2) {\n";

        # until now, we done with for head, then convert for loop inside
        $line = <>;  # skip "do" statement
        while ($line = <>)
        {
            last if $line =~ /done/;
            match_block($line);
        }
        print "$indent", "}\n";
    }
}


sub match_if_test
{
    my ($line) = @_;
    if ($line =~ /^if test (\S+) = (\S+)/)  # match if statement
    {
        # convert for head
        my $left = $1;
        my $right = $2;
        print "if ('$left' eq '$right') {\n";

        # until now, we done with if head, then convert if block inside
        while ($line = <>)
        {
            if ($line =~ /^then/)
            {
                next;
            }
            elsif ($line =~ /^else/)
            {
                print "} else {\n";
                next;
            }
            elsif ($line =~ /^elif test (\w+) = (\S+)/)
            {
                my $left = $1;
                my $right = $2;
                print "} elsif ('$left' eq '$right') {\n";
            }
            last if $line =~ /^fi/;
            match_block($line);
        }
        print "}\n";
    }
    elsif ($line =~ /if \[ (\-[a-z]) (\S+) \]/ || $line =~ /if test (\-[a-z]) (\S+)/)
    {
        # convert for head
        my $left = $1;
        my $right = $2;
        print "if ($left '$right') {\n";
        while ($line = <>)
        {
            if ($line =~ /^then/)
            {
                next;
            }
            elsif ($line =~ /^else/)
            {
                print "} else {\n";
                next;
            }
            elsif ($line =~ /^elif \[ (\-[a-z]) (\S+) \]/)
            {
                my $left = $1;
                my $right = $2;
                print "} elsif ($left '$right') {\n";
            }
            last if $line =~ /^fi/;
            match_block($line);
        }
        print "}\n";
    }
}



sub match_functions
{
    my ($line) = @_;
    if ($line =~ /^(\S+)\(\) \{/)
    {
        my $fc_name = $1;
        print "sub $fc_name {\n";
        while ($line = <>)
        {
            
            match_block($line);
            match_while($line);
            last if $line =~ /^\}/;
        }
        print "}\n";
    }
}


# read from command line or STDIN
while(my $line = <>)
{
    # head
    match_head($line);

    # functions
    match_functions($line);

    # match block
    match_block($line);

    # for loop
    match_for_loop($line);

    # while loop
    match_while($line);
    
    # if test
    match_if_test($line);

}