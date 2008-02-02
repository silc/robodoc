#!/usr/bin/perl -w

use strict;
use ROBOTest;

ROBOTest::start("URL Test");

my $count = 0;
while (my $line = <>) {
    if (($line =~ m/<A\sHREF="file:\/my_file\.testmark_\d"/i) or
        ($line =~ m/<A\sHREF="http:\/\/my_http\.testmark_\d"/i) or
        ($line =~ m/<A\sHREF="ftp:\/\/my_href\.testmark_\d"/i) or
        ($line =~ m/<A\sHREF="mailto:my_mail\@testmark_\d"/i) or
        ($line =~ m/<img\ssrc="http:\/\/www\.jinwicked\.com\/images\/art\/stallman\.jpg">/i)
       ) {
       $count++;
    }
}

# there should be 6
#
ROBOTest::assert($count == 6);
ROBOTest::finish;

