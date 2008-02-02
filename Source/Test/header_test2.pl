#!/usr/bin/perl -w

use ROBOTest;
ROBOTest::start("Indented Header Test");

# There are 12 headers numbered 1 .. 12
my $checksum = 0;
foreach my $n (1 .. 12) {
    $checksum += $n;
}

# Now we scan the output file for the headers
# The should occur after a and compute the sum
# of the header numbers 
my $sum = 0;
# count the number of testmarkers and the number of
# Headers in <A HREF> blocks (table of content)
# and between the word "testmark" in the NAME item
# We extract the header number and compute the sum.
while (my $line = <>) {
    if ($line =~ m/<PRE\S+\s+testmark\s+(\d+)\s/i) {
        $sum += $1;
    }
    # These are in the table of content
    if ($line =~ m/<A HREF[^\/]+\/Header_(\d+)<\/A>/i) {
        $sum += $1;
    }
}
# Dus each header number occur twice?
ROBOTest::assert($sum == 2 * $checksum);
ROBOTest::finish;

