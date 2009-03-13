V=2.0_alpha2
P=alpine-conf
PV=$(P)-$(V)
APKF=$(PV).apk
TARBZ2=$(PV).tar.bz2
PREFIX?=
TMP=$(PV)

LIB_FILES=libalpine.sh
SBIN_FILES=albootstrap\
	lbu\
	setup-ads\
	setup-alpine\
	setup-alpine-web\
	setup-cryptswap\
	setup-dns\
	setup-hostname\
	setup-interfaces\
	setup-keymap\
	setup-mta\
	setup-sendbug\
	setup-webconf\
	update-conf

ETC_LBU_FILES=lbu.conf
EXTRA_DIST=Makefile README

DIST_FILES=$(LIB_FILES) $(SBIN_FILES) $(ETC_LBU_FILES) $(EXTRA_DIST)

DESC="Alpine configuration scripts"
WWW="http://alpinelinux.org/alpine-conf"

TAR=tar
DB=$(TMP)/var/db/apk/$(PV)

.PHONY:	all apk clean dist install uninstall
all:	
	sed -i 's|^PREFIX=.*|PREFIX=$(PREFIX)|' $(SBIN_FILES)

apk:	$(APKF)

dist:	$(TARBZ2)

$(APKF): $(SBIN_FILES)
	rm -rf $(TMP)
	make all PREFIX=
	make install DESTDIR=$(TMP) PREFIX=
	mkdir -p $(DB)
	echo $(DESC) > $(DB)/DESC
	cd $(TMP) && $(TAR) -czf ../$@ .
	rm -rf $(TMP)

$(TARBZ2): $(DIST_FILES)
	rm -rf $(TMP)
	mkdir -p $(TMP)
	cp $(DIST_FILES) $(TMP)
	$(TAR) -cjf $@ $(TMP)
	rm -rf $(TMP)
	
install:
	install -m 755 -d $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 $(SBIN_FILES) $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 -d $(DESTDIR)/$(PREFIX)/lib
	install -m 755 $(LIB_FILES) $(DESTDIR)/$(PREFIX)/lib
	install -m 755 -d $(DESTDIR)/etc/lbu
	install -m 755 $(ETC_LBU_FILES) $(DESTDIR)/etc/lbu

uninstall:
	for i in $(SBIN_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/sbin/$$i";\
	done
	for i in $(LIB_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/lib/$$i";\
	done
	
clean:
	rm -rf $(APKF) $(TMP) $(TARBZ2)

