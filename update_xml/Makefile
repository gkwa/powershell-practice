include ../common-settings.mk

full:
	$(MAKE) clean
	$(MAKE) t2

t2:
	cp ts.xml ts.xml.tmp
	tidy $(TIDY_SW) ts.xml.tmp
	cp ts.xml.tmp ts.xml.orig
	powershell $(PS_SW) -file t2.ps1
	tidy $(TIDY_SW) ts.xml.tmp
	-diff -U 5 -uw ts.xml.orig ts.xml.tmp

clean:
	rm -f ts.xml.orig

