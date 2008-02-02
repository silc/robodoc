#!/bin/bash
# vi: ff=unix spell
# $Id: do.sh,v 1.19 2007/02/06 23:25:34 gumpu Exp $

# If a ./do.sh under cygwin gives
#  : command not found
#  : command not found
#  : command not foundclocal
#
# Then this file has wrong line-endings (cr/lf).
# To fix it unzip the archive under cygwin with the
# option -a, so
#   unzip -a robodoc-xx-xx-xx.zip
#

rm -f *~
rm -f makefile.in
rm -f *.tar.gz *.zip
rm -f *.log aclocal.m4 config.cache
rm -fr autom4te.cache
rm -f install-sh
rm -f mkinstalldirs
rm -f missing makefile
rm -f configure config.status

aclocal
automake -a
autoconf
#CFLAGS="-g -Wall -DDMALLOC -DMALLOC_FUNC_CHECK" LDFLAGS="-ldmalloc" ./configure
#CFLAGS="-g -Wall -Wshadow -Wbad-function-cast -Wconversion -Wredundant-decls" ./configure
CFLAGS="-g -Wall" ./configure
make dist
make dist-zip
make clean
make

# cross-compile if all tools are found
(cd Source && make -f makefile.plain xcompiler-test) > /dev/null 2>&1
if [ "$?" = "0" ] ; then
	set -e
	rm -fr ./tmp$$
	cp -R ./Source ./tmp$$
	cd ./tmp$$
	make -f makefile.plain xcompile
	cp -f *.zip ../
	cd ..
	rm -fr ./tmp$$
	set +e
fi

# Mac OS X package

if [ "`uname`" = "Darwin" ] ; then
	make -f rpm.mk osxpkg
fi

exit 0
