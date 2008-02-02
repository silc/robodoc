#!/usr/bin/perl -w

# $Id: dos2unix.pl,v 1.2 2007/04/02 20:29:20 gumpu Exp $
#
# Convert all files to the unix-line-end convention.
# This ensures that all files in the ROBODoc package 
# follow the same convention.
#
use strict;
use IO::File;
use IO::Dir;


sub fix 
{
    my $path = shift;
    my $mode = shift;
    my $file;

    if ( -T $path ) {
        if ( !( $file = IO::File->new($path, "r") ) ) {
            print "Can't open $path to read : $!\n"; 
        } else {
            # Open in binmode otherwise Perl will do the cr/lf for
            # us while reading.
            binmode( $file );
            my @file_data = <$file>;
            $file->close();
            if ( !( grep { /\r/ } @file_data ) ) {
                print "$path is OK\n";
                # File is OK
            } else {
                print "$path contains CR/LF\n";
                if ( $mode eq "test" ) {
                    print "$path contains CR/LF\n";
                } else {
                    print "Fixing: $path\n";
                    map { s/\r//g; } (@file_data);
                    $file = IO::File->new("> $path") or die "Can't open $path to write : $!";
                    binmode( $file );
                    print $file @file_data;
                    $file->close();
                }
            }
        }
    }
}

sub scan_directory
{
    my $dirname = shift;
    my $mode    = shift;
    my $path;
    my $dir = IO::Dir->new($dirname) or die "Can't open $dirname : $!";
    my @files = $dir->read();
    $dir->close();

    foreach my $filename ( sort @files ) {
        $path = "$dirname/$filename";
        if ( -f $path ) {
            fix( $path, $mode );
        }
    }

    # Also fix any subdirectories.
    foreach my $subdirname ( sort @files ) {
        $path = "$dirname/$subdirname";
        if ( -d $path ) {
            unless ( $subdirname =~ m/^\.+$/ ) {
                scan_directory( $path, $mode );
            }
        }
    }
}

sub main
{
    my $out = IO::File->new(">fl.txt") or die "can't open fl.txt : $!";
    scan_directory( ".", "test" );
    $out->close();
}

main;

