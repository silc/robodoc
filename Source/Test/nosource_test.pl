#!/usr/bin/perl -w

#
# Test whether robodoc can handle the --lock mode
# In the lock mode it will lock on to one kind of header marker
# per file and one kind of remark marker per header.  All
# other ones should be skipped.
#

use strict;
use ROBOTest;

ROBOTest::start("--nosource Test");
my $checksum = 0;

while (my $line = <>) {
    if ($line =~ m/should\snot\sappear/) {
        ++$checksum;
    }
}
ROBOTest::assert( $checksum == 0 );
ROBOTest::finish;

