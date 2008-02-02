#!/usr/bin/perl -w

#****x* SystemTest/internalheader_test
# FUNCTION
#   Test to see if robodoc handles all the internal
#   headers and the options to go with it correctly.
#   For this we created a testfile with internal and 
#   normal headers.  We generate the documentation for
#   it and check if the internal headers show up.
# SOURCE
#

use strict;
use ROBOTest;

ROBOTest::start("Internalheader Test");

# There are 8 internal headers numbered 1 .. 8 in the .dat file
my $checksum = 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8;

# We now extract them and compute the sum of all the numbers
my %seen = ();

while (my $line = <>) {
# the internal header names end with it_1, it_2, etc, so
# we extract these numbers.
    if ($line =~ m/it_(\d+)</) {
        $seen{$1}++;
    }
}
my $sum = 0;
foreach my $key (keys %seen) {
    $sum += $key;
}

ROBOTest::assert($sum == $checksum);
ROBOTest::finish;

#*******

