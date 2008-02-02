#!/usr/bin/perl -w
#

use strict;
use ROBOTest;
ROBOTest::start("Multidoc Test");

use IO::File;



sub Fail {
    my $ok = shift;
    if ( $ok ) {
        print "OK\n";
    } else {
        print "FAIL\n";
    }
}


sub Test_Master_Index {
    my $mi = IO::File->new("Doc1/masterindex.html");
    my @lines = <$mi>;
    $mi->close;
    my %seen = ();
    my $ok = 1;

    # All header types are in the source files,
    # so they should also be listed in the master index.
    # Lets test this.
    foreach my $line (@lines) {
        if ($line =~ m/top">([^<]+)<\/a>]/i) {
            $seen{$1}++;
        }
    }
    foreach my $file ("Modules", "Sourcefiles",
                      "Classes", "Structures", "Functions",
                      "Variables", "Procedures",
                      "Types", "Exceptions", "Definitions" ) {
        $ok = 0 unless ( defined($seen{$file}) and $seen{$file} == 1 );
    }
    # Test if all source files are listed.
#    foreach my $line (@lines) {
#        if (($line =~ m/Source\sFiles/) ..
#            ($line =~ m/\/table/i)) {
#            if ($line =~ m/([a-z][a-z]file\.dat)/) {
#                $seen{$1}++;
#            }
#        }
#    }
#    foreach my $file ( qw( ccfile.dat bbfile.dat aafile.dat) ) {
#        $ok = 0 unless ( defined($seen{$file}) and $seen{$file} == 1 );
#    }
#    # Test table for /****d* 
#    foreach my $line (@lines) {
#        if (($line =~ m/Constants/) ..
#            ($line =~ m/\/table/i)) {
#            if ($line =~ m/_test_(\S+)_test_/) {
#                $seen{$1}++;
#            }
#        }
#    }
#    foreach my $name ( qw( def1 def2 ) ) {
#        $ok = 0 unless ( defined($seen{$name}) and $seen{$name} == 1 );
#    }
#    # Test table for /****f*
#    foreach my $line (@lines) {
#        if (($line =~ m/Functions/) ..
#        ($line =~ m/\/table/i)) {
#            if ($line =~ m/_test_(\S+)_test_/) {
#                $seen{$1}++;
#            }
#        }
#    }
#    foreach my $name ( qw( fun1 fun2 ) ) {
#        $ok = 0 unless ( defined($seen{$name}) and $seen{$name} == 1 );
#    }
#    # Test table for /****c*
#    foreach my $line (@lines) {
#        if (($line =~ m/Classes/) ..
#        ($line =~ m/\/table/i)) {
#            if ($line =~ m/_test_(\S+)_test_/) {
#                $seen{$1}++;
#            }
#        }
#    }
#    foreach my $name ( qw( class1 class2 class3 ) ) {
#        $ok = 0 unless ( defined($seen{$name}) and $seen{$name} == 1 );
#    }
    return $ok;
}

#
# This tests the TOC of aafile.dat
#
#
sub Test_aafile_dat {
    my $mi = IO::File->new("Doc1/aafile_dat.html");
    my @lines = <$mi>;
    $mi->close;
    my %seen = ();
    my $ok = 1;
    # Scan the table of content
    foreach my $line (@lines) {
        if (($line =~ m/TABLE\sOF\sCONTENTS/i) ..
        ($line =~ m/\/UL/i)) {
            if ($line =~ m/\/([ABCD][ab][ab]__level\d__)/) {
                $seen{$1}++;
            }
        }
    }
    foreach my $name ( qw( Aaa__level1__ Bbb__level2__ Abb__level3__ Bbb__level3__ Cbb__level3__  Dbb__level3__ ) ) {
        $ok = 0 unless ( defined($seen{$name}) and $seen{$name} == 1 );
    }

    return $ok;
}

ROBOTest::assertFile("Doc1/masterindex.html");
ROBOTest::assertDir("Doc1/Subdir");
ROBOTest::assertFile("Doc1/Subdir/ccfile_dat.html");
ROBOTest::assertFile("Doc1/aafile_dat.html");
ROBOTest::assertFile("Doc1/bbfile_dat.html");
ROBOTest::assert( Test_Master_Index(), "Master index content" );
ROBOTest::assert( Test_aafile_dat(), "aafile TOC" );

ROBOTest::finish;
