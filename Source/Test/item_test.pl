#!/usr/bin/perl -w

use ROBOTest;

ROBOTest::start("Item Test");

#
# In the .dat file there are 43 items numbered from 1 .. 43
# The number is located between the words testmark in the item text
#
my $checksum = 0;
foreach my $n (1 .. 43) {
    $checksum += $n;
}

# We now scan the .res file find the item number, compute the
# sum, and see if this is equal to the checksum...
my $sum = 0;
while (my $line = <>) {
    if ($line =~ m/<PRE\S+\s+testmark\s+(\d+)\s/) {
        $sum += $1;
    }
}

# there should be 43 different items
#
ROBOTest::assert($sum = $checksum, "Are all items there?");
ROBOTest::finish;
