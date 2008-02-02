#****h* ROBODoc/rpm.mk
# NAME
#   rpm.mk
# SYNOPSIS
#   make -f rpm.mk
#   make -f rpm.mk osxpkg
# PURPOSE
#   Easy way to make RPM package. Contains rules also for building a package
#   for Mac OS X.
# MODIFICATION HISTORY
#   2003-03-23/PetteriK: robodoc.spec.in template
#   2003-02-10/PetteriK: RPM build using RH8.0, remote build dropped
# SEE ALSO
#   http://www.rpm.org/RPM-HOWTO/build.html
# SOURCE
#

# rpm-related parameters
PROJECT_NAME    = robodoc
PROJECT_VERSION = 4.99.36
PROJECT_RELEASE = 1
PROJECT         = $(PROJECT_NAME)-$(PROJECT_VERSION)
SPECFILE        = $(PROJECT_NAME).spec
TARBALL         = $(PROJECT).tar.gz
SRPM            = $(PROJECT)-$(PROJECT_RELEASE).src.rpm
RPM             = $(PROJECT)-$(PROJECT_RELEASE).i386.rpm
RHDIR           = $(HOME)/redhat

all: robodoc.spec rpm

#****** rpm.mk/robodoc.spec
# NAME
#   robodoc.spec
# FUNCTION
#   Fill in version and release info to .spec file template.
# SOURCE

robodoc.spec: robodoc.spec.in rpm.mk
	rm -f robodoc.spec
	sed -e 's/PROJECT_VERSION/$(PROJECT_VERSION)/g' \
	    -e 's/PROJECT_RELEASE/$(PROJECT_RELEASE)/g' \
	    robodoc.spec.in > robodoc.spec

#****

#****** rpm.mk/srcpkg
# NAME
#   srcpkg --
# FUNCTION
#   Make pretty tarball of sources in this directory tree.
# PREQUISITIES
#   make_rhdir
# SOURCE

.PHONY: srcpkg
srcpkg: make_rhdir
	cp -R . /tmp/$(PROJECT)
	find /tmp/$(PROJECT) -type d -name CVS | xargs rm -fr
	find /tmp/$(PROJECT) -type d -name .gone | xargs rm -fr
	(cd /tmp; tar cf - $(PROJECT) | gzip -c > $(RHDIR)/SOURCES/$(TARBALL))
	rm -fr /tmp/$(PROJECT)

#****

#****** rpm.mk/rpm
# NAME
#   rpm --
# FUNCTION
#   Make RPM; both binary and source packages.
# PREQUISITIES
#   make_rhdir, srcpkg
# SOURCE

.PHONY: rpm
rpm: srcpkg
	cp $(SPECFILE) $(RHDIR)/SPECS/$(SPECFILE)
	rpmbuild -ba $(RHDIR)/SPECS/$(SPECFILE)
	@echo "RPM packages are now:"
	@ls -l $(RHDIR)/RPMS/i386/$(RPM) 
	@ls -l $(RHDIR)/SRPMS/$(SRPM) 

#****

#****** rpm.mk/make_rhdir
# NAME
#   make_rhdir --
# FUNCTION
#   Create directories for RPM build. Topdir parameter in ~/.rpmmacros 
#   has to point to $(HOME)/redhat (default but users may change that). 
# SOURCE

.PHONY: make_rhdir
make_rhdir:
	for i in $(RHDIR) $(RHDIR)/RPMS $(RHDIR)/SOURCES $(RHDIR)/SPECS $(RHDIR)/SRPMS $(RHDIR)/BUILD; do \
	    if [ ! -d $$i ] ; then \
		mkdir $$i; \
	    fi; \
	    done;

#****

#****** rpm.mk/osxpkg
# NAME
#   osxpkg
# FUNCTION
#   Create Mac OS X binary package.
# SEE ALSO
#   dmg.sh
# SOURCE

MACPKG=$(PROJECT).pkg
PKGINF=$(MACPKG)/Contents/Resources/English.lproj/$(PROJECT).info

.PHONY: osxpkg
osxpkg:
	rm -f osx/License.rtf osx/ReadMe.rtf
	sed -e 's/PROJECT_VERSION/$(PROJECT_VERSION)/g' \
	    -e 's/PROJECT_RELEASE/$(PROJECT_RELEASE)/g' \
	    osx/License.rtf.in > osx/License.rtf
	sed -e 's/PROJECT_VERSION/$(PROJECT_VERSION)/g' \
	    -e 's/PROJECT_RELEASE/$(PROJECT_RELEASE)/g' \
	    osx/ReadMe.rtf.in > osx/ReadMe.rtf
	aclocal
	automake -a
	autoconf
	./configure
	$(MAKE)
	rm -fr Distribution_Folder $(MACPKG)
	mkdir -p Distribution_Folder/Package_Root/private/etc
	mkdir -p Distribution_Folder/Package_Root/Applications
	mkdir -p Distribution_Folder/Package_Root/usr/share/doc/$(PROJECT)/Headers
	mkdir -p Distribution_Folder/Package_Root/usr/bin
	mkdir -p Distribution_Folder/Package_Root/usr/share/man/man1
	mkdir -p Distribution_Folder/Resources/PreFlight
	mkdir -p Distribution_Folder/Resources/PostFlight
	-chmod a+rx Distribution_Folder/Resources/PreFlight/* Distribution_Folder/Resources/PostFlight/* 
	cp Source/robodoc Distribution_Folder/Package_Root/usr/bin
	cp Source/robohdrs Distribution_Folder/Package_Root/usr/bin
	cp Docs/robodoc.1 Distribution_Folder/Package_Root/usr/share/man/man1
	cp Docs/robohdrs.1 Distribution_Folder/Package_Root/usr/share/man/man1
	chmod 755 Distribution_Folder/Package_Root/usr/bin/*
	chmod 644 Distribution_Folder/Package_Root/usr/share/man/man1/*
	cp AUTHORS ChangeLog COPYING DEVELOPERS INSTALL NEWS README TODO UPGRADE Distribution_Folder/Package_Root/usr/share/doc/$(PROJECT)
	cp Headers/*.sample Distribution_Folder/Package_Root/usr/share/doc/$(PROJECT)/Headers
	mkdir -p $(MACPKG)/Contents/Resources/PostFlight
	mkdir -p $(MACPKG)/Contents/Resources/PreFlight
	mkdir -p $(MACPKG)/Contents/Resources/English.lproj
	cp osx/*.rtf $(MACPKG)/Contents/Resources
	(cd Distribution_Folder; mkbom Package_Root ../$(MACPKG)/Contents/Resources/$(PROJECT).bom)
	(cd Distribution_Folder/Package_Root; pax -w -f ../../$(MACPKG)/Contents/Resources/$(PROJECT).pax .)
	(cd $(MACPKG)/Contents/Resources; gzip $(PROJECT).pax)
	echo "Numfiles 20" > $(MACPKG)/Contents/Resources/$(PROJECT).sizes
	echo "InstalledSize 352" >> $(MACPKG)/Contents/Resources/$(PROJECT).sizes
	echo "CompressedSize 352" >> $(MACPKG)/Contents/Resources/$(PROJECT).sizes
	echo "Title ROBODoc" > $(PKGINF)
	echo "Version 4.0.0" >> $(PKGINF)
	echo "Description Autdocs formatter" >> $(PKGINF)
	echo "DefaultLocation /" >> $(PKGINF)
	echo "DeleteWarning" >> $(PKGINF)
	echo "" >> $(PKGINF)
	echo "### Package Flags" >> $(PKGINF)
	echo "" >> $(PKGINF)
	echo "NeedsAuthorization YES" >> $(PKGINF)
	echo "Relocatable NO" >> $(PKGINF)
	echo "RequiresReboot NO" >> $(PKGINF)
	echo "UseUserMask NO" >> $(PKGINF)
	echo "OverwritePermissions NO" >> $(PKGINF)
	echo "InstallFat NO" >> $(PKGINF)
	echo -n pmkrpkg1 > $(MACPKG)/Contents/PkgInfo
	sh osx/dmg.sh $(PROJECT_NAME) $(PROJECT_VERSION) $(PROJECT_RELEASE) 
	rm -fr Distribution_Folder $(MACPKG)

#****

# date format for spec file
.PHONY: logdate
logdate:
	echo "`date +'* %a %b %d %Y'` `whoami`"

.PHONY: chkpkg
chkpkg:
	rpm -qpi $(RHDIR)/RPMS/i386/$(RPM)
	rpm -qpl $(RHDIR)/RPMS/i386/$(RPM)

.PHONY: chksys
chksys:
	rpm -qa | grep $(PROJECT_NAME)

.PHONY: test
test: install chksys uninstall

.PHONY: install
install:
	sudo rpm -i $(RHDIR)/RPMS/i386/$(RPM)

.PHONY: uninstall
uninstall:
	sudo rpm -e $(PROJECT_NAME)

#****
