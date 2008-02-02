#!/usr/bin/perl -w
#
#
# $Id: robohdrs_test.pl,v 1.2 2003/12/26 22:31:29 gumpu Exp $
#

use strict;
use ROBOTest;
ROBOTest::start("ROBOHDRS Test");
ROBOTest::assertFile("Doc1/robo_functions.html");
ROBOTest::assertFile("Doc1/robo_variables.html");
ROBOTest::finish;

