PS_SW += -version 1
PS_SW += -inputformat none
PS_SW += -executionpolicy bypass
PS_SW += -noprofile
PS_SW += -noninteractive

t: test.txt.tmp
	powershell $(PS_SW) -file t.ps1
	-diff -uw test.txt test.txt.tmp

t2: test.txt.tmp
	powershell $(PS_SW) -file t2.ps1
	-diff -uw test.txt test.txt.tmp

test.txt.tmp:
	cp test.txt $@

clean:
	rm -f test.txt.tmp
