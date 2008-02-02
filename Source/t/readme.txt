#****h* ROBODoc/ROBODoc System Tests
# FUNCTION
#   A set of perl scripts that test ROBODoc functionallity.
#   Each script contains one of more system tests.  Each test
#   starts ROBODoc with a specific input and then asserts that
#   ROBODoc produces the correct output.
#
#   The tests use the Perl unittest framework, that is the 
#   modules:
#   * Test::More, See http://perldoc.perl.org/Test/More.html 
#   * Test::File
#
#   There is also a custom module ROBOTestFrame that contains a
#   set of useful functions that are common to all tests.
#
#   You can run the tests with
#      prove -l
#
#   Tests go into files with the extension .t. You can
#   run an individual set of tests with
#     prove <testfile>
#
#   A 'prove' should always result in a 100% score.  No test
#   should fail.
#
#*****
#

