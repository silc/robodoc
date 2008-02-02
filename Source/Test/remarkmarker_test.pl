#!/usr/bin/perl -w

use strict;
use ROBOTest;

ROBOTest::start("RemarkMarker Test");

#
# The ,res should look like
#   LINE 1
#   LINE 2
#   LINE 3
#   etc
#   We extract all the numbers and store them
#   in a hash 
#
my %count = ();
while (my $line = <>) {
    if ($line =~ m/\s*LINE\s+(\d+)\s/) {
        $count{$1}++;
    }
}

# there should be 15 different lines
#
my $number_of_lines = scalar(keys %count);

ROBOTest::assert($number_of_lines == 15, "header types");
ROBOTest::finish;
