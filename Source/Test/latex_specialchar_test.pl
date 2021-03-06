#!/usr/bin/perl -w

use strict;
use ROBOTest;

ROBOTest::start("LaTeX Special Char Test");

# In the headers there are three bad names
# bad1$bad1
# bad2$bad2
# bad3%bad3
# bad4$bad4
# bad5_bad5
#
# These should all have been escaped and no longer occur
# in the output

my $count = 0;
while (my $line = <>) {
    if (($line =~ m/begin{verbatim/) ..
        ($line =~ m/end{verbatim/)) {

    } else {
        if ($line =~ m/bad\d([^b]+)bad/) {
            my $string = $1;
            if (($string eq "\$") or
            ($string eq "_") or
            ($string eq "%")) {
                ++$count;
            }
        }
    }
}

ROBOTest::assert($count == 0);
ROBOTest::finish;
