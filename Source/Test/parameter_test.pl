#!/usr/bin/perl -w
#
# Test of the various ways we can specify files 
# and directories to the  --src and --doc options.
# Created to solve bug:  
# [770251 ] Absolute filename causes an assertion to fail
#
#
# $Id: parameter_test.pl,v 1.3 2003/08/13 20:42:07 gumpu Exp $
#

use strict;
use ROBOTest;
ROBOTest::start("Parameter Test");
ROBOTest::assertFile( "parameter_test.html" );
ROBOTest::finish;
