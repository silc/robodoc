#****h* ROBODoc/SystemTest
# DESCRIPTION
#   The systemtest is a series of tests that test the
#   behaviour of robodoc and robohdrs.
#
#   Most tests consists of:
#   * One or more data files (.dat)
#   * One or more result files (.html etc).  The result files are generated
#     by running robodoc on the .dat files.  Or sometimes on whole 
#     directories with source files.
#   * A perl script that checks the results and prints either OK or FAIL
#   For instance there is a test that checks if robodoc correctly
#   recognizes all Item names. The data files for this is
#   item_test.dat. It contains all item names with in between
#      testmark dd
#   where dd is a number from 1 to 43
#   
#   Robodoc is run on this data file and a file
#   called item_test.html is generated.  A script called item_test.pl
#   scans this .html file finds all the "testmark dd"s  and check if
#   all number from 1 to 43 occur.  If so it prints OK if not it 
#   print FAIL.
#   
#   To run the test do a
#      make
#   
#   To cleanup all the generated files do a
#      make clean
#
#*****
# $Id: makefile,v 1.54 2007/01/29 22:23:53 gumpu Exp $
#


# The programs to be tested.
#
ROBODOC  = ../robodoc
ROBOHDRS = ../robohdrs

# No unnecessary output.
.SILENT :

all: permissions clean test 

# TODO    header_test4 
# TODO    header_test5 

test : item_test \
    header_test \
    header_test2 \
    header_test3 \
    url_test \
    header_size_test  \
    cmode_test \
    link_test \
    html_specialchar_test \
    internalheader_test \
    internalheader_test2 \
    latex_specialchar_test \
    remarkmarker_test \
    multidoc_test1 \
    encoding_test \
    tabtest \
    pipe_test \
    lock_test \
    user_specified_css_file_test \
    master_index_test \
    robohdrs_test \
    filter_test_1 \
    filter_test_2 \
    sort_test \
    nosource_test \
    ignore_test \
    nosort_test \
    forth_test \
    doc_dir_filter_test

#  temporarily excluded:  parameter_test 

#
# TODO
#    outputformat_test 
# These test error handling, but they are not
# finished yet.
#    error_missing_header_end_test 
#    error_missing_header_end_test_2 


permissions:
	chmod 755 *.pl

clean: doc1_clean doc2_clean
	-rm -f *.res *.html *.tex *.rtf *.xml *.toc *.log *.idx *.dvi *.aux *.pdf
	-rm -f *.tst
	-rm -rf outputformat_test.txt
	-rm -rf *.stderr
	-rm -rf RoboHeaders/*.c
	-rm -rf robohdrs_test.hdrs
	-rm -rf cmode_test1.css
	-rm -rf header_size_test.css
	-rm -rf header_test2.css
	-rm -rf header_test3.css
	-rm -rf header_test4.css
	-rm -rf header_test.css
	-rm -rf html_specialchar_test2.css
	-rm -rf html_specialchar_test.css
	-rm -rf internalheader_test2.css
	-rm -rf internalheader_test.css
	-rm -rf item_test.css
	-rm -rf link_test.css
	-rm -rf lock_test.css
	-rm -rf outputformat_test.css
	-rm -rf parameter_test.css
	-rm -rf pipe_test.css
	-rm -rf remarkmarker_test.css
	-rm -rf tabtest.css
	-rm -rf url_test.css
	-rm -rf forth_test.css
	-rm -rf error_test.css
	-rm -rf ignore_test.css
	-rm -rf nosource_test.css

#
#
# Test the handling of HTML reserver characters.
#
html_specialchar_test : html_specialchar_test.html html_specialchar_test2.html
	./$(@F).pl < html_specialchar_test.html
	./$(@F).pl < html_specialchar_test2.html

html_specialchar_test.html : html_specialchar_test.dat
	$(ROBODOC) --src html_specialchar_test.dat --doc html_specialchar_test --html --singlefile

html_specialchar_test2.html : html_specialchar_test.dat
	$(ROBODOC) --src html_specialchar_test.dat --doc html_specialchar_test2 --html --singlefile --sections --toc

#****e* SystemTest/latex_specialchar_test
# FUNCTION
#   Create input for testing the handling of latex reserved characters 
# SOURCE
#
latex_specialchar_test : latex_specialchar_test.tex latex_specialchar_test2.tex
	./$(@F).pl < latex_specialchar_test.tex
	./$(@F).pl < latex_specialchar_test2.tex

latex_specialchar_test.tex : latex_specialchar_test.dat
	$(ROBODOC) --src latex_specialchar_test.dat --doc latex_specialchar_test --latex --singlefile

latex_specialchar_test2.tex : latex_specialchar_test.dat
	$(ROBODOC) --src latex_specialchar_test.dat --doc latex_specialchar_test2 --latex --singlefile --sections --toc

#******


#****e* SystemTest/header_size_test
# FUNCTION
#   Create the input file for header_size_test_pl.
# SOURCE
#
header_size_test : header_size_test.html
	./$(@F).pl < header_size_test.html

header_size_test.html : header_size_test.dat
	$(ROBODOC) --src $< --doc header_size_test --html --singlefile

#*****


#****e* SystemTest/internalheader_test, internalheader_test2
# FUNCTION
#   Create the input for the internalheader_test.
# SOURCE
#
internalheader_test : internalheader_test.html
	./$(@F).pl < internalheader_test.html

internalheader_test.html : internalheader_test.dat
	$(ROBODOC) --src internalheader_test.dat --doc internalheader_test --html --singlefile --index --toc --internal

#
internalheader_test2 : internalheader_test2.html
	./$(@F).pl < internalheader_test2.html

internalheader_test2.html : internalheader_test.dat
	$(ROBODOC) --src internalheader_test.dat --doc internalheader_test2 --html --singlefile --index --toc

#**********


#
#
outputformat_test : outputformat_test.html \
                    outputformat_test.txt \
                    outputformat_test.rtf 
#                    outputformat_test_dbsgml.res \
#                    outputformat_test_troff.res 
	./$(@F).pl


outputformat_test.html   : outputformat_test.dat
	$(ROBODOC) --src $< --doc outputformat_test --singlefile --html

outputformat_test.txt  : outputformat_test.dat
	$(ROBODOC) --src $< --doc outputformat_test --singlefile --ascii

outputformat_test.rtf    : outputformat_test.dat
	$(ROBODOC) --src $< --doc outputformat_test --singlefile --rtf

# outputformat_test.dbsgml : outputformat_test.dat
# 	$(ROBODOC) --src $< --doc $@ DBSGML
# 
# outputformat_test_troff.res  : outputformat_test.dat
# 	$(ROBODOC) --src $< --doc $@ TROFF


#
# Test if we recognize all predefined items.
#
item_test : item_test.html
	./$(@F).pl < item_test.html

item_test.html : item_test.dat
	$(ROBODOC) --src item_test.dat --doc item_test --html --singlefile

#
# Test the linking of keywords to headers.
#
link_test : link_test.html
	./$(@F).pl < link_test.html

link_test.html : link_test.dat
	$(ROBODOC) --src link_test.dat --doc link_test --html --singlefile

#****e* SystemTest/header_test, header_test2, header_test3, header_test4, header_test5
# FUNCTION
#   Create the input file for header_test_pl.
# SOURCE
#
header_test : header_test.html
	./$(@F).pl < header_test.html

header_test.html : header_test.dat
	$(ROBODOC) --src header_test.dat --doc header_test --html --toc --singlefile


#
# indented header test case
#
header_test2 : header_test2.html
	./header_test2.pl < header_test2.html

header_test2.html : header_test2.dat
	$(ROBODOC) --src header_test2.dat --doc header_test2 --html --toc --singlefile

#
# indented header test case
#
header_test3 : header_test3.html
	./header_test3.pl < header_test3.html

header_test3.html : header_test3.dat
	$(ROBODOC) --src header_test3.dat --doc header_test3 --html --toc --singlefile

header_test4 : header_test4.tst
	./$(@F).pl < header_test4.tst

header_test4.tst : header_test4.dat
	$(ROBODOC) --src header_test4.dat --doc header_test4 --test --toc --singlefile

header_test5 : header_test5.tst
	./$(@F).pl < header_test5.tst

header_test5.tst : header_test5.dat
	$(ROBODOC) --rc header_test5.rc --src header_test5.dat --doc header_test5 --test --toc --singlefile

#*************

#
# Test if we can recognize all the different remark markers for
# all the languages we defined.
#
remarkmarker_test : remarkmarker_test.html
	./$(@F).pl < remarkmarker_test.html

remarkmarker_test.html : remarkmarker_test.dat
	$(ROBODOC) --src remarkmarker_test.dat --doc remarkmarker_test --html --singlefile

#
# Test the automatic recognition of urls
#
url_test : url_test.html
	./$(@F).pl < url_test.html

url_test.html : url_test.dat
	$(ROBODOC) --src url_test.dat --doc url_test --html --singlefile

#
# Test the syntax colouring of C code.
#
cmode_test : cmode_test1.html
	./cmode_test1.pl < cmode_test1.html

cmode_test1.html : cmode_test.dat
	$(ROBODOC) --src cmode_test.dat --doc cmode_test1 --html --cmode --singlefile

#
# Test the --multidoc mode
#
#
multidoc_test1 : multidoc_test1.html
	./multidoc_test1.pl

multidoc_test1.html : 
	$(ROBODOC) --src ./Scr1 --doc ./Doc1 --html --multidoc --index --sections --toc
	touch multidoc_test1.html


#
# This tests if specifying the tabsize with --tabsize works.
#
tabtest : tabtest.html
	./$(@F).pl < tabtest.html

tabtest.html : tabtest.dat
	$(ROBODOC) --src tabtest.dat --doc tabtest --html --singlefile  --tabsize 4

#
# This test if we can specify a full path to the source file
# when we use --singlefile.  (This borrows the code from tabtest)
#
parameter_test : parameter_test.html
	./$(@F).pl

parameter_test.html : parameter_test.dat
	$(ROBODOC) --src /home/robodoc/robo/Source/Test/parameter_test.dat --doc /home/robodoc/robo/Source/Test/parameter_test --html --singlefile


# The xml file uses UTF-8 encoding. Although xmlto seems not to _write_
# UTF-8, it does _read_ that correctly in input and complains if that is 
# not proper UTF-8 format.

encoding_test: encoding_test.html
	@ if [ -x "`which xmlto`" ] ; then \
		xmlto html-nochunks encoding_test.xml ; \
    else \
        echo "xmlto missing, can not perform test"; \
	fi ;
#rm -f encoding_test.html encoding_test.xml encoding_test.pdf

# Source file uses Latin-1 i.e. iso-8859-1 encoding
encoding_test.html: encoding_test.dat
	$(ROBODOC) --src encoding_test.dat --doc encoding_test --singlefile --dbxml


#
# Test if we can specify an alternative robodoc.rc file using
# the --rc option.
#

option_rc_test: option_rc_test.html
	./$(@F).pl < option_rc_test.html

option_rc_test.html: alt_rc_file.rc
	$(ROBODOC) --rc alt_rc_file.rc --html


#
# Test the error generated for a header end messing from a header
# that is not the last header in a file.
#

error_missing_header_end_test: error_missing_header_end_test.stderr
	echo "TODO"

error_missing_header_end_test.stderr : error_missing_header_end_test.dat
	-$(ROBODOC) --src error_missing_header_end_test.dat --doc error_test --singlefile --html 2> error_missing_header_end_test.stderr

#
# Test the error generated for a header end missing from a header
# that _is_ the last header in a file.
#

error_missing_header_end_test_2: error_missing_header_end_test_2.stderr
	echo "TODO"

error_missing_header_end_test_2.stderr : error_missing_header_end_test_2.dat
	-$(ROBODOC) --src error_missing_header_end_test_2.dat --doc error_test --singlefile --html 2> error_missing_header_end_test_2.stderr


#
# The if a user can specify its own css file.
#

user_specified_css_file_test : user_specified_css_file_test.html
	./$(@F).pl < ./Doc1/robodoc.css

user_specified_css_file_test.html : user_css.css
	$(ROBODOC) --src ./Scr1 --doc ./Doc1 --html --multidoc --index --sections --toc --css user_css.css
#	touch user_specified_css_file_test.html 


lock_test : lock_test.html
	./$(@F).pl < lock_test.html

lock_test.html: lock_test.dat
	$(ROBODOC) --src lock_test.dat --doc lock_test --singlefile --lock --html

#
# Test the forth headers
#

forth_test: forth_test.html

forth_test.html:
	$(ROBODOC) --src ../../Headers/forth.sample --doc forth_test --singlefile --html --toc

#
#
#

pipe_test : 
	$(ROBODOC) --src pipe_test.dat --doc pipe_test --singlefile --html
	./pipe_test.pl 1 0 < pipe_test.html
	./pipe_test.pl 2 1 < pipe_test.html
	./pipe_test.pl 3 0 < pipe_test.html
	$(ROBODOC) --src pipe_test.dat --doc pipe_test --singlefile --latex
	@ if [ -x "`which latex`" ] ; then \
		latex pipe_test.tex > /dev/null 2>&1 ; rm -f pipe_test/dvi ; \
    else \
        echo "latex missing, can not perform test"; \
	fi ;	
	./pipe_test.pl 2 0 < pipe_test.tex
	./pipe_test.pl 1 1 < pipe_test.tex

#
# 
#
master_index_test : Doc2/masterindex.html
	./$(@F).pl 

Doc2/masterindex.html : Scr2/master_index_test.dat
	$(ROBODOC) --src Scr2 --doc Doc2 --html --multidoc  --index --internal


#
#
#
#
RoboHeaders/rbh_test1.c : RoboHeaders/rbh_test1.dat
	cp RoboHeaders/rbh_test1.dat RoboHeaders/rbh_test1.c 

robohdrs_test.hdrs : RoboHeaders/rbh_test1.c
	cd RoboHeaders; ../$(ROBOHDRS) -p HDRS rbh_test1.c ; cd ..
	touch robohdrs_test.hdrs 


#
#
#
#
robohdrs_test.doc : robohdrs_test.hdrs 
	-rm -rf Doc1/*.*
	$(ROBODOC) --src RoboHeaders --doc Doc1 --html --multidoc --index

robohdrs_test : robohdrs_test.doc
	./$(@F).pl 


doc_dir_filter_test.doc : doc_dir_filter_test.rc
	$(ROBODOC) --rc doc_dir_filter_test.rc
	$(ROBODOC) --rc doc_dir_filter_test.rc

doc_dir_filter_test : doc_dir_filter_test.doc
	./$(@F).pl
	-rm -rf DocNot



#
#
#
filter_test_2.doc : 
	-rm -rf Doc3/*
	$(ROBODOC) --src FileFilterSrc_2 --doc Doc3 --html --multidoc --index --rc filter_test_2.rc

filter_test_2 : filter_test_2.doc
	./$(@F).pl

#
#
#
filter_test_1.doc : 
	-rm -rf Doc1/*
	$(ROBODOC) --src FileFilterSrc --doc Doc1 --html --multidoc --index --rc filter_test_1.rc

filter_test_1 : filter_test_1.doc
	./$(@F).pl


#
#
#
sort_test.doc :
	-rm -rf Doc1/*.*
	$(ROBODOC) --src SortSource --doc Doc1 --html --multidoc --index --toc

sort_test : sort_test.doc
	./$(@F).pl

#
#
#
nosort_test.doc :
	-rm -rf Doc1/*.*
	$(ROBODOC) --src SortSource --doc Doc1 --html --multidoc --index --toc --nosort

nosort_test : nosort_test.doc
	./$(@F).pl


nosource_test : nosource_test.html
	./$(@F).pl < nosource_test.html

nosource_test.html : nosource_test.dat
	$(ROBODOC) --src nosource_test.dat --doc nosource_test --singlefile --nosource --html

ignore_test : ignore_test.html
	./$(@F).pl < ignore_test.html

ignore_test.html : ignore_test.dat
	$(ROBODOC) --src ignore_test.dat --doc ignore_test --singlefile --html --rc ignore_test.rc


doc1_clean :
	rm -rf Doc1/Subdir
	rm -rf Doc1/ToBeAccepted
	rm -rf Doc1/*.*

doc2_clean :
	rm -rf Doc2/*.*
