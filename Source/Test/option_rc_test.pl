#!/usr/bin/perl -w
#
# Test the --rc option
# If the works there should be a file called
# option_rc_test.html
#
# $Id: option_rc_test.pl,v 1.1 2003/08/13 20:42:07 gumpu Exp $
#

use strict;
use ROBOTest;
ROBOTest::start("Test of --rc");
ROBOTest::assertFile( "option_rc_test.html" );
ROBOTest::finish;
