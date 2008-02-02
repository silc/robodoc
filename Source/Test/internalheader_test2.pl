#!/usr/bin/perl -w

#
# Test to see if robodoc handles all the internal
# headers and the options to go with it correctly.
#

use strict;
use ROBOTest;

ROBOTest::start("Internalheader Test 2");

# There are 8 internal headers numbered 1 .. 8 in the .dat file
# None of them should occur in the output.
my $checksum = 0;

# We now extract them and compute the sum of all the numbers
my %seen = ();

while (my $line = <>) {
    if ($line =~ m/it_(\d+)</) {
        $seen{$1}++;
    }
}

my $sum = 0;
foreach my $key (keys %seen) {
    $sum += $key;
}
ROBOTest::assert( $sum == $checksum);
ROBOTest::finish;
