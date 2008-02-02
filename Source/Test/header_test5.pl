#!/usr/bin/perl -w

use strict;
use ROBOTest;

#****x* SystemTest/header_test5_pl
# FUNCTION
#   ROBODoc allows a user to define that some items should
#   work similar to the source item. These tests check wether
#   this works.
# SOURCE
#

ROBOTest::start("Source Item Test");

# We scan the output file for the headers.
# In each header there are items that contains
#    testmark 1 testmark
#    testmark 2 testmark
#    testmark 3 testmark
#    testmark 4 testmark
#    testmark 5 testmark
# in such locations that they end-up in the final
# documentation.  We scan the final documentation
# and collect and the numbers between the test
# marks.

my $checksum = 1 + 2 + 3 + 4 + 5;

my $sum = 0;
my $sum_empty_remark = 0;

while (my $line = <>) {
    # The numbers between the marks.
    if ( $line =~ m/testmark\s(\d+)/ ) {
        $sum += $1;
    }
    # There should be no empty '/*' or '*/' in the documentation
    # robodoc is supposed to remove these from the begin and
    # end of a 'source' item.

    # No  /*
    if ( $line =~ m/^\s*\/\*\s*$/ ) {
        $sum_empty_remark++;
    }
    # No  */
    if ( $line =~ m/^\s\*\/\s*$/ ) {
        $sum_empty_remark++;
    }
}

# There are 4 headers so:
ROBOTest::assert( $sum == (4 * $checksum), "All source is included" );
ROBOTest::assert( $sum_empty_remark == 0, "No empty remark begin or ends" );
ROBOTest::finish;
#

0;

#******
