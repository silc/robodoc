#!/usr/bin/perl -w
use strict;
use ROBOTest;

#****x* SystemTest/link_test_pl
# FUNCTION
#   Test if ROBODoc correctly creates links between words
#   and headers.
#
#   There are four links, link_1_, _link_2_, link3, and -link4
#   they should each occur four times in a <A HREF></A>
# SOURCE
#


ROBOTest::start("Link Test");

my %count = ();
$count{"link_1_"} = 0;
$count{"_link_2_"} = 0;
$count{"link3"} = 0; 
$count{"-link4"} = 0; 
$count{"Llink5"} = 0; 

while (my $line = <>) {
    if ($line =~ m#<A\sHREF=[^>]+>([^<]+)</A>#i) {
        my $link_name = $1;
        ++$count{$link_name};
    }
}

ROBOTest::assert( 
    ($count{"link_1_"} == 4) and
    ($count{"_link_2_"} == 4) and
    ($count{"link3"} == 4) and
    ($count{"-link4"} == 4) and
    ($count{"Llink5"} == 4),
    "linking");

#*****
