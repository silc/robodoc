#!perl
# vi: spell ff=unix
use strict;
use warnings;
use ROBOTestFrame;
use Test::More 'no_plan';
use XML::Simple;

#****h* ROBODoc System Tests/Header Test
# FUNCTION
#   Tests the parsing of ROBODoc headers.
#
#*****

#****x* Header Test/Happy Path
# FUNCTION
#   Happy Path Simple plain header. This definitely should work
# SOURCE
#
{
    my $source = <<'EOF';
/****f* Test/test
 * NAME
 *   Test
 * FUNCTION
 *   Test2
 ******
 */
EOF

    add_source( "test.c", $source );
    my ($out, $err) = runrobo( qw(--src Src --doc Doc --multidoc --test) );
    is( $out, '', 'no output' );
    is( $err, '', 'and no error' );
    clean();
}
#*******


#****x* Header Test/Names with Spaces
# FUNCTION
#   Try a header name with spaces and some '*' at
#   the end.  The '*' should be ignored.
# SOURCE
{
    my $source = <<'EOF';
/****f* Test Foo Bar/Name With Spaces ****
 * NAME
 *   Test
 * FUNCTION
 *   Test2
 ******
 */
EOF

    add_source( "test.c", $source );
    my ($out, $err) = runrobo( qw(--src Src --doc Doc --multidoc --test) );
    is( $out, '', 'no output' );
    is( $err, '', 'and no error' );
    my $documentation = XMLin( 'Doc/test_c.xml' );
    my $header = $documentation->{'header'};
    is ( $header->{'name'}, 'Test Foo Bar/Name With Spaces', 'Header name' );

    clean();
}

#*****

#****x* Header Test/Multiple Names with Spaces
# FUNCTION
#   Try several header with names that contain spaces.
#   These should be accepted.
# SOURCE
{
    my $source = <<'EOF';
/****f* Test Foo Bar/Name With Spaces, And Anotherone,
 *                   And One More, More
 * NAME
 *   Test
 * FUNCTION
 *   Test2
 ******
 */
EOF

    add_source( "test.c", $source );
    my ($out, $err) = runrobo( qw(--src Src --doc Doc --multidoc --test) );
    is( $out, '', 'no output' );
    is( $err, '', 'and no error' );
    my $documentation = XMLin( 'Doc/test_c.xml' );
    my $header = $documentation->{'header'};
    is ( $header->{'name'}, 'Test Foo Bar/Name With Spaces', 'Header name' );

    clean();
}

#*****

#****x* Header Test/Broken header
# FUNCTION
#  Try several header with names that contain spaces.
#  These should be accepted.
# SOURCE
{
    my $source = <<'EOF';
{****f* xxxxxx/x_xxx_xxxxxxxxxxxxxxxxxxxxxxxx
*
*OMSCHRIJVING
*xxxx xxxxxxx xxxxxxxxx xxxxxxxxxx xxxxxxx xxxxxxxxxxxx xx xx
xxxxxxxxxxxxxxx
*xxxxxxxxx x_xxx_xxxxxxxxxxxxxxxxxx xxxxxxx
*
*INVOER
*xxxxxxx : xxx xxxxxxx xxxx xxxxxx xxxxxxxxx xxxxxxxxxxxx xxxxx xx xxx
xx
* xxxxxxxxx xxxxxxxxx xxxxx xxxxxxxxxxxx.
*xxxxxxxxxxx : xxx xxxxxxxxx xxxxx xxxxx xxx xx xxxxx xxxxxx xx xxxxxxxxxx
* xxxxxxxxx xxxxxxxx xx
*RETURNWAARDE
*xxxx__xxxxxxx, x_xxx_xxxxxxxxx, xxxx__xxxxxxxx, x_xxx_xxxxxxxx,
*x_xxx_xxxxxxxxx, x_xxx_xxxxxxxxxxxxxx xx x_xxxx_xxxxxx_xxx
xxxxxx xxxxx.
*
*VOORBEELD
*x_xxx_xxxxxxxxxxxxxxxxxxxxxxxx (xxxxxxx := 5000,
* xxxxxxxxxxx := xx_xxxxxxxxxxx);
*DECLARATIE
*}

{*****}
EOF


    my $config = <<'EOF';
items:
    OMSCHRIJVING
    WIJZIGINGSOVERZICHT
    DECLARATIE
    INVOER
    UITVOER
    IN-UITVOER
    PARAMETERS
    BOUNDARIES
    RETURNWAARDE
    ATTRIBUTEN
    GEBRUIKTE GEGEVENS
    VOORBEELD
    ZIE VERDER
    OPMERKINGEN
    PRECONDITIE
    POSTCONDITIE 

item order:
    OMSCHRIJVING
    DECLARATIE

source items:
    DECLARATIE
    SOURCE
    
preformatted items:
    WIJZIGINGSOVERZICHT
    INVOER
    UITVOER   
    IN-UITVOER
    PARAMETERS
    RETURNWAARDE
    ATTRIBUTEN
    VOORBEELD

headertypes:
    h   "Modules"        vptlib_modules
    f   "Functies"       vptlib_functies
    v   "Variabelen"     vptlib_variabelen
    s   "Structuren"     vptlib_structuren
    e   "Enumeraties"    vptlib_enumeraties
    c   "Constanten"     vptlib_constanten
    u   "Unittesten"     vptlib_unittesten
    t   "Typedefinities" vptlib_typedefs
    m   "Macros"         vptlib_macros
    d   "Definities"     vptlib_definities

options:
    --documenttitle "Xxxxxxxxxxxxxxxxxxx"
    --tabsize 8
    --index 
    --sections
    --sectionnameonly  
    --nopre
    --multidoc
 
header markers:
    /****
    #****
    !****
    {****

remark markers:
    *
    #
    !
    
end markers:
    ****
    #****
    !****
    {****

remark begin markers:
    /*
    {*

remark end markers:
    */
    *}

source line comments:
    //
    !
    *
EOF

    add_source( "test.c", $source );
    add_configuration( "test.rc", $config );
    my ($out, $err) = runrobo( qw(--src Src --doc Doc --rc Config/test.rc --test) );
    is( $out, '', 'no output' );
    is( $err, '', 'and no error' );

    clean();
}

#*****



#****x* Header Test/Circular header
# FUNCTION
#   The 3rd header points to the first header, 
#   completing a circle.  ROBODoc should complain
#   about this.
# 
# SOURCE
TODO: {
    local $TODO = "checking circular headers is not implemented yet.";
    my $source = <<'EOF';

/****f* Foo/Bar
* NAME
*   Bar
****/

/****f* Bar/Fii
 * NAME
 *   Foo
 *****/

/****f* Fii/Bar
 * NAME
 *   Foo
 *****/
EOF

    add_source( "test.c", $source );
    my ($out, $err) = runrobo( qw(
        --src Src
        --doc Doc
        --multidoc
        --html
        --toc
        --sections
        ) );
    # ROBODoc should complain about circular 
    # headers.
    isnt( $err, '', 'there should be an error' );
#    clean();
}

#*****
