#!/usr/bin/perl -w
#
#
# $Id: sort_test.pl,v 1.2 2004/06/20 09:24:36 gumpu Exp $
#

use strict;
use warnings;
use ROBOTest;
use IO::File;

#****x* SystemTest/sort_test_pl
# FUNCTION
#   ROBODoc sorts the TOC and the headers so that they appear in
#   a particular order in the documentation.
#   Here we test if the order is the order we expect.
#   This is done by generating the documentation and comparing
#   the order with a table.  There are two source files, one
#   that is already sorted, and one that is unsorted.
#   The documentation for both should end up sorted.
# SOURCE
#


ROBOTest::start("Sort Test");

# in the documentation for the sorted file when
# it is sorted the TOC should look like this.
my @toc_sorted_names = qw(
    AA_Header/BB_header
    BB_header/aaa_function
    BB_header/bbb_function
    BB_header/ccc_function
);

my @toc_unsorted_names = qw(
    AA_Header/CC_header
    XX_Header/AA_Header
    XX_Header/ZZ_Header
    ZZ_Header/DD_Header
    CC_header/aaa_function
    CC_header/ccc_function
    CC_header/eee_function
    CC_header/fff_function
    DD_header/aaa_function
);


sub check_toc_order {
    my $ok = 1;
    my $filename = shift;  # filename of the file with the headers
    my $order    = shift;  # order of the headers
    my $number   = shift;  # number of headers
    my $file = IO::File->new("<$filename") or die;
    my $index = 0;
    while( my $line = <$file> ) {
        if ( $line =~ m/robo\d">([^<]+)</ ) {
            my $name = $1;
            if ( $name eq ${$order}[ $index ] ) {
                # All is OK.
            } else {
                $ok = 0;
            }
            ++$index;
            last if ( $index == $number );
        }
    }
    $file->close();

    return $ok;
}

ROBOTest::assertFile("Doc1/sorted_c.html");
ROBOTest::assert( 
    check_toc_order( "Doc1/sorted_c.html", \@toc_sorted_names, 4 ),
    "Is the TOC still sorted"
);

ROBOTest::assertFile("Doc1/unsorted_c.html");
ROBOTest::assert( 
    check_toc_order( "Doc1/unsorted_c.html", \@toc_unsorted_names, 4 ),
    "Is the TOC now sorted"
);

ROBOTest::finish;

#*****
