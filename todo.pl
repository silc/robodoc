#!/usr/bin/perl -w
# vi: ff=unix spell
#
# Usage:
#
#    todo.pl [filenames]
#
# 

use strict;
use IO::Dir;
use IO::File;

my $count = 0;

sub scan_file {
    my $filename = shift;
    unless ( $filename =~ m/tags$/ ) {

        my $file = IO::File->new("<$filename") or die "can't open $filename";
        my %todos;
        my $nr = 1;

        # Scan for TODOs
        while (my $line = <$file>) {
            # The sentence after the TODO ~should start with a letter.
            # This ensures we skip the TODO's like the one below.
            if ($line =~ /TODO(|:)\s+[A-Za-z]/i) {
                $todos{$nr} = $line;
            }
            ++$nr;
        }
        $file->close();

        # Show results.
        if (scalar(keys %todos)) {
            foreach my $key (sort { $a <=> $b } keys %todos) {
                my $line = $todos{$key};
                if ($line =~ m/TODO(.*)$/i) {
                    my $comment = $1;
                    $comment =~ s/^(:|\s)+//;
                    $comment =~ s/\*\/\s*$//;
                    # Print as:   foobar.c(10)  The stuff to be done
                    printf( "%-30s %s\n", "$filename($key)", $comment );
                    ++$count;
                }
            }
        }

    }
}


# Scan all the files in a directory.
# Then repeat the process for all the subdirectories.
#

sub scan_directory {
    my $dirname = shift;

    my $dir = IO::Dir->new($dirname) or die "can't open $dirname : $!";
    my @files = $dir->read();
    $dir->close();

    my @source_files = grep { -T "$dirname/$_" } @files;

    foreach my $filename ( sort @source_files ) {
        my $path = "$dirname/$filename";
        $path =~ s/\.\///;
        scan_file( $path );
    }

    # Repeat the process for all subdirectories.
    foreach my $filename ( sort @files ) {
        my $path = "$dirname/$filename";
        if ( ( -d $path ) and ( $filename !~ m/^\./ ) ) {
            scan_directory( $path );
        }
    }
}


sub main {
    if (@ARGV) {
        # We are given a set of file names on the command line.
        foreach my $file (grep { -T } @ARGV) {
            scan_file( $file );
        }
    } else {
        # No parameters, scan the current directory and
        # all its subfolders.
        scan_directory( '.' );
    }
    print $count, " TODOs to go\n";

}

main;


