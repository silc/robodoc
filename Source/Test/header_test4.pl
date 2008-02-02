#!/usr/bin/perl -w

use strict;
use ROBOTest;

#****x* SystemTest/header_test4_pl
# FUNCTION
#   Test if robodoc can handle module and object names with
#   spaces in it.  For this we process a file with four
#   headers looking something like
#      A_Module_TEST/a function test
#   Each header has the words A, Module, TEST, a, function, and
#   test. They are either separated with spaces or with a '_'.
#   ROBODoc should find them all.
# SOURCE
#

ROBOTest::start("Names with Spaces Test");

my $count = 0;
while (my $line = <>) {
    if ( $line =~ m/HEADER_MODULE\s+(\S.*?)$/ ) {
        my $module = $1;
        if ( ( $module =~ m/A/ ) and
             ( $module =~ m/Module/ ) and
             ( $module =~ m/TEST/ ) ) {
            $count++;
        }
    }
    if ( $line =~ m/HEADER_FUNCTION_NAME\s+(\S.*?)$/ ) {
        my $object = $1;
        if ( ( $object =~ m/a/ ) and
             ( $object =~ m/function/ ) and
             ( $object =~ m/test/ ) ) {
            $count++;
        }
        ROBOTest::assert( $object !~ m/\s+$/, "no spaces at end of name" );
    }
}

# There are 4 valid headers, so the count should be 8
ROBOTest::assert( $count == 8, "All 4 headers found" );
ROBOTest::finish;

0;

#******
