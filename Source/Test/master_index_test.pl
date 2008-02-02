#!/usr/bin/perl -w
#
#
# $Id: master_index_test.pl,v 1.1 2003/12/14 17:45:10 gumpu Exp $
#

use strict;
use ROBOTest;
ROBOTest::start("Masterindex Test");
ROBOTest::assertFile("Doc2/robo_functions.html");
ROBOTest::assertFile("Doc2/robo_variables.html");
ROBOTest::finish;

