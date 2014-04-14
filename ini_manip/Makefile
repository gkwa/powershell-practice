t1:
	powershell  -version 4 -inputformat none -executionpolicy bypass -file test1.ps1
	-diff -uw cs1.ini cs2.ini

clean:
	rm -f cs1.ini
	rm -f cs2.ini
