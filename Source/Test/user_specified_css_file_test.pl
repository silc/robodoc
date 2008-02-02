#!/usr/bin/perl -w

#
# This tests the option --css
#
#
# $Id: user_specified_css_file_test.pl,v 1.2 2003/08/31 09:29:28 gumpu Exp $

use strict;
use ROBOTest;
ROBOTest::start("Option --css Test");
#
#
# The file user_css.css 
# contains twice the word ROBO_UnitTest
# It should therefore also appear twice
# in the robodoc.css file.
#
my $sum = 0;
while (my $line = <>) {
    if ( $line =~ m/ROBO_UnitTest/ ) {
        $sum++;
    }
}

ROBOTest::assert( $sum == 2 );
ROBOTest::finish;

