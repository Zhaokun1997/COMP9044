#!/bin/sh

if test $# != 1
then
    echo "Usage: $0 <course-prefix>"
    exit 1
fi

# get basic URL address
course_prefix=$1
head_name=`echo $course_prefix | cut -c1` #extract first letter
basic_URL="http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp"

# echo $head_name
# echo $basic_URL

under_URL="$basic_URL?StudyLevel=Undergraduate&descr=$head_name"
post_URL="$basic_URL?StudyLevel=Postgraduate&descr=$head_name"

wget -q -O- "$under_URL" "$post_URL" | egrep "$course_prefix[0-9]{4}.html" | egrep -o "$course_prefix[0-9]{4}.html\">.* *<" | sed 's/\.html">/ /' | sed 's/ *<.*<//' | sort | uniq

    
