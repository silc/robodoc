#!/usr/bin/perl -w

use strict;
use ROBOTest;

#****x* SystemTest/header_test_pl
# FUNCTION
#   Test if robodoc recognizes all the different headers in the
#   various languages that robodoc supports.  The input file for this
#   test is generated with the makefile entry header_test
# SOURCE
#

ROBOTest::start("Header Test");

# We scan the output file for the headers.
# Each header has a name item with the text
#    testmark <number> testmark
# the name of each header has the form
#   Header_<number>
# We compute the sum of all the numbers.

# There are 15 headers numbered 1 .. 15
my $checksum = 0;
foreach my $n (1 .. 15) {
    $checksum += $n;
}

my $sum = 0;
while (my $line = <>) {
    # The numbers between the marks.
    if ($line =~ m/<PRE\S+\s+testmark\s+(\d+)\s/i) {
        $sum += $1;
    }
    # These numbers in the names, listed in the table
    # of content.
    if ($line =~ m/<A HREF[^\/]+\/Header_(\d+)<\/A>/i) {
        $sum += $1;
    }
}

# Does each header number occur twice?
ROBOTest::assert( $sum == (2 * $checksum) );
ROBOTest::finish;

0;

#******
