#!/usr/bin/perl -w
#
#
# $Id: filter_test_2.pl,v 1.1 2004/08/20 21:52:47 gumpu Exp $
#

use strict;
use ROBOTest;
ROBOTest::start("File Filter Test 2");
ROBOTest::assertFile("Doc3/robo_functions.html");
ROBOTest::assertFile("Doc3/accept_c.html");
ROBOTest::assertFile("Doc3/accept_pl.html");
ROBOTest::assertDir("Doc3/AcceptDir");
ROBOTest::assertFile("Doc3/AcceptDir/accept_h.html");
ROBOTest::assertNotDir("Doc3/ToBeIgnored");
ROBOTest::assertNotFile("Doc3/ignore_ign.html");
ROBOTest::assertNotFile("Doc3/ignore_xxx.html");
ROBOTest::finish;

