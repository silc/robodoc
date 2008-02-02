#!/usr/bin/perl -w
#
use strict;
use IO::File;

my $count = 0;

sub scan_file {
    my $file = shift;
    my $sourcefile = IO::File->new("<$file") or
    die "can't open $file";
    my @source = <$sourcefile>;
    my @todos;
    my $key = "???";
    foreach my $line (@source) {
        if ($line =~ /TODO/i) {
            push(@todos, $line);
        }
    }
    if (scalar(@todos)) {
        print "File: $file\n";
        foreach my $line (@todos) {
            if ($line =~ m/TODO(.*)$/i) {
                print "    TODO $1\n";
                ++$count;
            }
        }
    }
}


sub scan_directory {
    my $file;
    opendir(DIR, '.') or die;
    while (defined($file = readdir(DIR))) {
        if ($file =~ m/\.(c|h)$/i) {
            scan_file($file);
        }
    }
    closedir(DIR);
}


sub main {
    if (@ARGV) {
        foreach my $file (@ARGV) {
            if ($file =~ m/\.(c|h)$/) {
                scan_file $file;
            }
        }
    } else {
        scan_directory;
    }
    print $count, " TODOs to go\n";

}

main;


