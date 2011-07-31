VERSION		:= 2.8.1

sysconfdir      ?= /etc/lbu

P		:= alpine-conf
PV		:= $(P)-$(VERSION)
TARBZ2		:= $(PV).tar.bz2
PREFIX		?=
TMP		:= $(PV)

LIB_FILES	:= libalpine.sh
SBIN_FILES	:= lbu\
		setup-ads\
		setup-alpine\
		setup-alpine-web\
		setup-apklbu\
		setup-apkrepos\
		setup-ntp\
		setup-cryptswap\
		setup-disk\
		setup-dns\
		setup-hostname\
		setup-interfaces\
		setup-keymap\
		setup-mta\
		setup-acf\
		setup-bootable\
		setup-sshd\
		setup-timezone\
		setup-xorg-base\
		setup-gparted-desktop\
		update-conf

BIN_FILES	:= uniso

SCRIPTS		:= $(LIB_FILES) $(SBIN_FILES)
SCRIPT_SOURCES	:= $(addsuffix .in,$(SCRIPTS))


ETC_LBU_FILES	:= lbu.conf
EXTRA_DIST	:= Makefile README
DIST_FILES	:= $(SCRIPT_SOURCES) $(ETC_LBU_FILES) $(EXTRA_DIST)

GIT_REV		:= $(shell test -d .git && git describe || echo exported)
ifneq ($(GIT_REV), exported)
FULL_VERSION    := $(patsubst $(PACKAGE)-%,%,$(GIT_REV))
FULL_VERSION    := $(patsubst v%,%,$(FULL_VERSION))
else
FULL_VERSION    := $(VERSION)
endif


DESC="Alpine configuration scripts"
WWW="http://alpinelinux.org/alpine-conf"


SED		:= sed
TAR		:= tar

SED_REPLACE	:= -e 's:@VERSION@:$(FULL_VERSION):g' \
			-e 's:@PREFIX@:$(PREFIX):g' \
			-e 's:@sysconfdir@:$(sysconfdir):g'

.SUFFIXES:	.sh.in .in
.sh.in.sh:
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

.in:
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

.PHONY:	all apk clean dist install uninstall
all:	$(SCRIPTS) $(BIN_FILES)

uniso:	uniso.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

apk:	$(APKF)

dist:	$(TARBZ2)


$(TARBZ2): $(DIST_FILES)
	rm -rf $(TMP)
	mkdir -p $(TMP)
	cp $(DIST_FILES) $(TMP)
	$(TAR) -cjf $@ $(TMP)
	rm -rf $(TMP)
	
install: $(BIN_FILES) $(SBIN_FILES) $(LIB_FILES) $(ETC_LBU_FILES)
	install -m 755 -d $(DESTDIR)/$(PREFIX)/bin
	install -m 755 $(BIN_FILES) $(DESTDIR)$(PREFIX)/bin
	install -m 755 -d $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 $(SBIN_FILES) $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 -d $(DESTDIR)/$(PREFIX)/lib
	install -m 755 $(LIB_FILES) $(DESTDIR)/$(PREFIX)/lib
	install -m 755 -d $(DESTDIR)/$(sysconfdir)
	install -m 755 $(ETC_LBU_FILES) $(DESTDIR)/$(sysconfdir)

uninstall:
	for i in $(SBIN_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/sbin/$$i";\
	done
	for i in $(LIB_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/lib/$$i";\
	done
	
clean:
	rm -rf $(SCRIPTS) $(BIN_FILES) $(TMP) $(TARBZ2)

