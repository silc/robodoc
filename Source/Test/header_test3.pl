#!/usr/bin/perl -w

use strict;
use ROBOTest;

ROBOTest::start("Header Item Body Test");

# There are a number of headers. They contain items that
# have lines numbered __1__ to __20__
# They should all show up.
#
my $checksum = 0;
foreach my $n (1 .. 20) {
    $checksum += $n;
}

# Now we scan the output file for the headers
# find the numbers and add them...
my $sum = 0;
while (my $line = <>) {
    if ($line =~ m/__(\d+)__/) {
        $sum += $1;
    }
}

# Does each number occur ?

ROBOTest::assert( $sum == $checksum );
ROBOTest::finish;

