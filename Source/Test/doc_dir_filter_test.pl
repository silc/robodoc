#!/usr/bin/perl -w
#
#
# $Id: doc_dir_filter_test.pl,v 1.1 2004/06/20 09:24:36 gumpu Exp $
#

#****x* SystemTest/doc_dir_filter_test_pl
# FUNCTION
#   If a user specifies a doc dir that is a subdir of the source
#   dir that robodoc has to skip it when scanning the sources.
#   We test this by running robodoc twice with the options
#     --src .
#     --doc ./NotDoc
#   (These are specified in doc_dir_filter_test.rc
# SOURCE
#

use strict;
use ROBOTest;
ROBOTest::start("Doc Dir Filter Test");
ROBOTest::assertNotDir("DocNot/DocNot");
ROBOTest::finish;

#******
