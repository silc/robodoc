#!/usr/bin/perl -w

#
# Test whether robodoc can handle the --lock mode
# In the lock mode it will lock on to one kind of header marker
# per file and one kind of remark marker per header.  All
# other ones should be skipped.
#

use strict;
use ROBOTest;

ROBOTest::start("ignore items: Test");
my $checksum_not_appear = 0;
my $checksum_appear = 0;
while (my $line = <>) {
    if ($line =~ m/not\sbe\sdisplayed/) {
        ++$checksum_not_appear;
    }
    if ( $line =~ m/appear/ ) {
        ++$checksum_appear;
    }
}
ROBOTest::assert( $checksum_not_appear == 0 );
ROBOTest::assert( $checksum_appear == 2 );
ROBOTest::finish;

