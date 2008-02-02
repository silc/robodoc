#!/usr/bin/perl -w
#
#
# $Id: filter_test_1.pl,v 1.2 2004/08/20 21:29:00 gumpu Exp $
#

use strict;
use ROBOTest;
ROBOTest::start("File Filter Test 1");
ROBOTest::assertFile("Doc1/robo_functions.html");
ROBOTest::assertFile("Doc1/test2_c.html");
ROBOTest::assertDir("Doc1/ToBeAccepted");
ROBOTest::assertNotDir("Doc1/ToBeIgnored");
ROBOTest::assertNotFile("Doc1/test1_pas.html");
ROBOTest::assertNotFile("Doc1/README.html");
ROBOTest::finish;

