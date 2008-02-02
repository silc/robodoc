#!/usr/bin/perl -w

use strict;
use ROBOTest;

#****x* SystemTest/cmode_test1_pl
# FUNCTION
#   Tests the option --cmode.  With this option
#   comments in C sourcecode should be colored.
#   We test this by looking for the <FONT> tag.
# SOURCE
#

ROBOTest::start("C-mode Test");

my $ok = 1;
while (my $line = <>) {
    if ($line =~ /TEST_COMMENT/) {
        my @match = ($line =~ m/FONT/ig);
        my $cnt = scalar(@match);
        if ($cnt != 2) {
            $ok = 0;
            last;
        }
    }
}

ROBOTest::assert($ok);
ROBOTest::finish();

0;

#*****
