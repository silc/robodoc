use strict;
package ROBOTest;

my $ok = 1;
my $name = "unknown";

sub start {
    $name = shift;
#    printf("%-50s", $name);
}

sub assertNotDir {
    my $filename = shift;
    assert( !( -d $filename ), "Directory $filename does not exists"); 
}

sub assertDir {
    my $filename = shift;
    assert( -d $filename, "Directory $filename exists"); 
}

sub assertNotFile {
    my $filename = shift;
    assert( !( -f $filename ), "File $filename does not exists"); 
}

sub assertFile {
    my $filename = shift;
    assert( -f $filename, "File $filename exists"); 
}

sub assert {
    my $arg_ok = shift;
    my $title = shift;
    printf("%-32s", $name);
    if ($title) {
        printf("%-40s", $title);
    } else {
        printf("%-40s", "--");
    }
    if ($arg_ok) {
        print "  OK\n";
    } else {
        print "  FAIL\n";
    }
}

sub finish {
#    if ($ok) {
#        print "OK\n";
#    } else {
#        print "FAIL\n";
#    }
}

1;

