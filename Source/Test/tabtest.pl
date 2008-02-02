#!/usr/bin/perl -w
#
#
# $Id: tabtest.pl,v 1.3 2003/08/13 20:42:07 gumpu Exp $
#

use strict;
use ROBOTest;

ROBOTest::start("Tab Test");

my $count = 0;
while (my $line = <>) {
    if ($line =~ m/^\s\s\s\s\s\sXXX/i) {
       $count++;
    }
}

ROBOTest::assert( $count == 5, "Testing tabsize of 4" );
ROBOTest::finish;

