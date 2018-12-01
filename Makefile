MANDIR=/usr/share/man
SBINDIR=/usr/sbin

all: make_ca man

make_ca:
	chmod 755 make-ca

man: make_ca
	chmod 755 help2man
	./help2man -s 8 -N ./make-ca -i include.h2m -o make-ca.8

clean: clean_make_ca clean_man

clean_make_ca:
	chmod 0644 make-ca

clean_man:
	rm -f make-ca.8
	chmod 0644 help2man

install: all install_bin install_man install_systemd

install_bin:
	/usr/bin/install -vdm755 $(DESTDIR)$(SBINDIR)
	install -vm755 make-ca $(DESTDIR)$(SBINDIR)

install_systemd:
	if test -d /usr/lib/systemd/system; then \
	    install -vdm755 ${DESTDIR}/usr/lib/systemd/system; \
	    install -vm644 systemd/* $(DESTDIR)/usr/lib/systemd/system; \
	elif test -d /lib/systemd/system; then \
	    install -vdm755 ${DESTDIR}/lib/systemd/system; \
	    install -vm644 systemd/* ${DESTDIR}/lib/systemd/system; \
	fi

install_man:
	/usr/bin/install -vdm755 $(DESTDIR)$(MANDIR)/man8
	install -vm644 make-ca.8 $(DESTDIR)$(MANDIR)/man8

uninstall:
	rm -f $(DESTDIR)$(SBINDIR)/make-ca
	rm -f $(DESTDIR)$(MANDIR)/man8/make-ca.8

.PHONY: all install

