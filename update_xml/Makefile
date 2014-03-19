PS_SW  =
PS_SW += -inputformat none
PS_SW += -executionpolicy bypass

t2:
	cp ts.xml ts.xml.tmp
	tidy --tidy-mark no --doctype strict --vertical-space true --indent-attributes true --wrap-attributes true -quiet -xml -indent -wrap 72 -clean -modify ts.xml.tmp
	cp ts.xml.tmp ts.xml.orig
	powershell $(PS_SW) -file t2.ps1
	tidy --tidy-mark no --doctype strict --vertical-space true --indent-attributes true --wrap-attributes true -quiet -xml -indent -wrap 72 -clean -modify ts.xml.tmp
	-diff -uw ts.xml.orig ts.xml.tmp

clean:
	rm -f ts.xml.orig

