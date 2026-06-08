VERSION		:= 3.22.0_rc3

sysconfdir	?= /etc/lbu

PREFIX		?=

MAN8		:= \
		doc/copy-modloop.8 \
		doc/genfstab.8 \
		doc/lbu.8 \
		doc/setup-acf.8 \
		doc/setup-alpine.8 \
		doc/setup-apkcache.8 \
		doc/setup-apkrepos.8 \
		doc/setup-bootable.8 \
		doc/setup-desktop.8 \
		doc/setup-devd.8 \
		doc/setup-disk.8 \
		doc/setup-dns.8 \
		doc/setup-hostname.8 \
		doc/setup-interfaces.8 \
		doc/setup-keymap.8 \
		doc/setup-lbu.8 \
		doc/setup-mta.8 \
		doc/setup-ntp.8 \
		doc/setup-proxy.8 \
		doc/setup-sshd.8 \
		doc/setup-timezone.8 \
		doc/setup-user.8 \
		doc/setup-wayland-base.8 \
		doc/setup-xen-dom0.8 \
		doc/setup-xorg-base.8 \
		doc/update-conf.8 \
		doc/update-kernel.8

LIB_FILES	:= libalpine.sh dasd-functions.sh
SBIN_FILES	:= copy-modloop\
		genfstab\
		lbu\
		setup-acf\
		setup-alpine\
		setup-apkcache\
		setup-apkrepos\
		setup-bootable\
		setup-desktop\
		setup-devd\
		setup-disk\
		setup-dns\
		setup-hostname\
		setup-interfaces\
		setup-keymap\
		setup-lbu\
		setup-mta\
		setup-ntp\
		setup-proxy\
		setup-sshd\
		setup-timezone\
		setup-user\
		setup-wayland-base\
		setup-xen-dom0\
		setup-xorg-base\
		update-conf\
		update-kernel

BIN_FILES	:= uniso

SCRIPTS		:= $(LIB_FILES) $(SBIN_FILES)

ETC_LBU_FILES	:= lbu.conf

GIT_REV		:= $(shell test -d .git && git describe || echo exported)
ifneq ($(GIT_REV), exported)
FULL_VERSION	:= $(patsubst $(PACKAGE)-%,%,$(GIT_REV))
FULL_VERSION	:= $(patsubst v%,%,$(FULL_VERSION))
else
FULL_VERSION	:= $(VERSION)
endif


DESC="Alpine configuration scripts"
WWW="http://git.alpinelinux.org/cgit/alpine-conf/"


SED		:= sed

SED_REPLACE	:= -e 's:@VERSION@:$(FULL_VERSION):g' \
			-e 's:@PREFIX@:$(PREFIX):g' \
			-e 's:@sysconfdir@:$(sysconfdir):g'

.SUFFIXES:	.sh.in .in
%.sh: %.sh.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

%: %.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@ && chmod +x $@

.PHONY:	all apk clean install uninstall iso
all:	$(SCRIPTS) $(BIN_FILES) Kyuafile tests/Kyuafile $(MAN8)

uniso:	uniso.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

apk:	$(APKF)

doc/%.8: doc/%.8.scd
	scdoc < $< > $@

install: $(BIN_FILES) $(SBIN_FILES) $(LIB_FILES) $(ETC_LBU_FILES) $(MAN8)
	install -m 755 -d $(DESTDIR)/$(PREFIX)/bin
	install -m 755 $(BIN_FILES) $(DESTDIR)$(PREFIX)/bin
	install -m 755 -d $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 $(SBIN_FILES) $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 -d $(DESTDIR)/$(PREFIX)/lib
	install -m 644 $(LIB_FILES) $(DESTDIR)/$(PREFIX)/lib
	install -m 755 -d $(DESTDIR)/$(sysconfdir)
	install -m 644 $(ETC_LBU_FILES) $(DESTDIR)/$(sysconfdir)
	install -m 755 -d $(DESTDIR)/$(PREFIX)/share/man/man8
	install -m 644 $(MAN8) $(DESTDIR)/$(PREFIX)/share/man/man8

uninstall:
	for i in $(BIN_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/bin/$$i";\
	done
	for i in $(SBIN_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/sbin/$$i";\
	done
	for i in $(LIB_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/lib/$$i";\
	done
	for i in $(ETC_LBU_FILES); do \
		rm -f "$(DESTDIR)/$(sysconfdir)/$$i";\
	done
	for i in $(MAN8); do \
		rm -f "$(DESTDIR)/$(PREFIX)/share/man/man8/$${i##*/}";\
	done

clean:
	rm -rf $(SCRIPTS) $(BIN_FILES) alpine-conf.iso tests/Kyuafile Kyuafile $(MAN8)

alpine-conf.iso: $(SCRIPTS) $(BIN_FILES)
	$(MAKE) install PREFIX=/ DESTDIR=tmp/
	xorriso -as mkisofs -r -V 'ALPINECONF' -J -o $@ tmp/ && rm -rf tmp

iso: alpine-conf.iso

tests/Kyuafile: $(wildcard tests/*_test)
	echo "syntax(2)" > $@
	echo 'test_suite("alpine-conf")' >> $@
	for i in $(notdir $(wildcard tests/*_test)); do \
		echo "atf_test_program{name='$$i',timeout=30}" >> $@ ; \
	done

Kyuafile:
	echo "syntax(2)" > $@
	echo "test_suite('alpine-conf')" >> $@
	echo "include('tests/Kyuafile')" >> $@

check: $(SCRIPTS) $(BIN_FILES) tests/Kyuafile Kyuafile
	kyua --variable parallelism=$(shell nproc) test || (kyua report --verbose && exit 1)
