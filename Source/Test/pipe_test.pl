#!/usr/bin/perl -w
# $Id: pipe_test.pl,v 1.1 2003/11/18 12:10:26 petterik Exp $

use strict;
use ROBOTest;

my $n = $ARGV[0] || 1;
my $expected = $ARGV[1] || 0;

sub test1 {
	my $res = 1;
	while (my $line = <STDIN>) {
		if ($line =~ m/<CENTER>This will be included in <B>HTML<\/B> output.<\/CENTER>/) {
			$res = 0;
		}
	}
	return $res;
}

sub test2 {
	my $res = 1;
	while (my $line = <STDIN>) {
		if ($line =~ m/\\centerline{This will be included in \\LaTeX output}/) {
			$res = 0;
		}
	}
	return $res;
}

sub test3 {
	my $res = 1;
	while (my $line = <STDIN>) {
		if ($line =~ /\|html&lt\;B&gt\;Moi!&lt\;\/B&gt\;/) {
			$res = 0;
		}
	}
	return $res;
}

my %tests = (
			 1 => \&test1,
			 2 => \&test2,
			 3 => \&test3
			 );

ROBOTest::start("Pipe Test $n-$expected");

my $status = $tests{$n}();

ROBOTest::assert( $status == $expected );
ROBOTest::finish;
